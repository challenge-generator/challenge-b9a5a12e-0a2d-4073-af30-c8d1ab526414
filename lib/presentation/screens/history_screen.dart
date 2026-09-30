import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/presentation/viewmodels/history_viewmodel.dart';
import 'package:mobile_banking_app/core/design_patterns/observer/transaction_observer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> implements TransactionObserver {
  final _dateFormatter = DateFormat('dd/MM/yyyy HH:mm');
  final _currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
  final ScrollController _scrollController = ScrollController();
  
  String _selectedFilter = 'all';
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<HistoryViewModel>();
      viewModel.addObserver(this);
      viewModel.loadTransactions();
    });
  }

  @override
  void dispose() {
    final viewModel = context.read<HistoryViewModel>();
    viewModel.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void onTransactionAdded(Transaction transaction) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nueva transacción: ${_currencyFormatter.format(transaction.amount)}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void onTransactionUpdated(Transaction transaction) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transacción actualizada: ${transaction.id}'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );
    
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _applyFilters();
    }
  }

  void _applyFilters() {
    final viewModel = context.read<HistoryViewModel>();
    viewModel.setDateRange(_startDate, _endDate);
    viewModel.setTypeFilter(_selectedFilter);
  }

  void _clearFilters() {
    setState(() {
      _selectedFilter = 'all';
      _startDate = null;
      _endDate = null;
    });
    _applyFilters();
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return Colors.green;
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.failed:
        return Colors.red;
      case TransactionStatus.reversed:
        return Colors.grey;
    }
  }

  IconData _getTransactionIcon(TransactionType type) {
    return type == TransactionType.credit 
        ? Icons.arrow_downward 
        : Icons.arrow_upward;
  }

  Color _getTransactionColor(TransactionType type) {
    return type == TransactionType.credit 
        ? Colors.green 
        : Colors.red;
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return 'Completada';
      case TransactionStatus.pending:
        return 'Pendiente';
      case TransactionStatus.failed:
        return 'Fallida';
      case TransactionStatus.reversed:
        return 'Reversada';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Transacciones'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HistoryViewModel>().loadTransactions();
            },
          ),
        ],
      ),
      body: Consumer<HistoryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.transactions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredTransactions = viewModel.getFilteredTransactions();

          if (filteredTransactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay transacciones',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Las transacciones aparecerán aquí',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              if (_startDate != null || _endDate != null || _selectedFilter != 'all')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getFilterSummary(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      TextButton(
                        onPressed: _clearFilters,
                        child: const Text('Limpiar'),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filteredTransactions.length} transacciones',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Total: ${_currencyFormatter.format(viewModel.getTotalAmount())}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = filteredTransactions[index];
                    return _TransactionListItem(
                      transaction: transaction,
                      dateFormatter: _dateFormatter,
                      currencyFormatter: _currencyFormatter,
                      getStatusColor: _getStatusColor,
                      getTransactionIcon: _getTransactionIcon,
                      getTransactionColor: _getTransactionColor,
                      getStatusText: _getStatusText,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getFilterSummary() {
    final parts = <String>[];
    
    if (_selectedFilter != 'all') {
      parts.add('Tipo: ${_selectedFilter == 'credit' ? "Crédito" : "Débito"}');
    }
    
    if (_startDate != null && _endDate != null) {
      parts.add('Fecha: ${DateFormat('dd/MM').format(_startDate!)} - ${DateFormat('dd/MM').format(_endDate!)}');
    }
    
    return parts.join(' | ');
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Filtrar Transacciones',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Text(
                'Tipo de Transacción',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'all', label: Text('Todas')),
                  ButtonSegment(value: 'credit', label: Text('Crédito')),
                  ButtonSegment(value: 'debit', label: Text('Débito')),
                ],
                selected: {_selectedFilter},
                onSelectionChanged: (selection) {
                  setModalState(() {
                    _selectedFilter = selection.first;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Rango de Fechas',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _selectDateRange,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _startDate != null && _endDate != null
                            ? '${DateFormat('dd/MM').format(_startDate!)} - ${DateFormat('dd/MM').format(_endDate!)}'
                            : 'Seleccionar fechas',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  setState(() {});
                  _applyFilters();
                  Navigator.pop(context);
                },
                child: const Text('Aplicar Filtros'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final DateFormat dateFormatter;
  final NumberFormat currencyFormatter;
  final Color Function(TransactionStatus) getStatusColor;
  final IconData Function(TransactionType) getTransactionIcon;
  final Color Function(TransactionType) getTransactionColor;
  final String Function(TransactionStatus) getStatusText;

  const _TransactionListItem({
    required this.transaction,
    required this.dateFormatter,
    required this.currencyFormatter,
    required this.getStatusColor,
    required this.getTransactionIcon,
    required this.getTransactionColor,
    required this.getStatusText,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.type == TransactionType.credit;
    final amountPrefix = isCredit ? '+' : '-';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => _showTransactionDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: getTransactionColor(transaction.type).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  getTransactionIcon(transaction.type),
                  color: getTransactionColor(transaction.type),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          dateFormatter.format(transaction.timestamp),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: getStatusColor(transaction.status).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            getStatusText(transaction.status),
                            style: TextStyle(
                              fontSize: 10,
                              color: getStatusColor(transaction.status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (transaction.referenceNumber != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Ref: ${transaction.referenceNumber}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                '$amountPrefix${currencyFormatter.format(transaction.amount)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: getTransactionColor(transaction.type),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Detalle de Transacción',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              _DetailRow(label: 'ID', value: transaction.id),
              _DetailRow(label: 'Descripción', value: transaction.description),
              _DetailRow(
                label: 'Monto', 
                value: '${transaction.type == TransactionType.credit ? '+' : '-'}${currencyFormatter.format(transaction.amount)}',
              ),
              _DetailRow(label: 'Moneda', value: transaction.currency),
              _DetailRow(label: 'Fecha', value: dateFormatter.format(transaction.timestamp)),
              _DetailRow(label: 'Estado', value: getStatusText(transaction.status)),
              if (transaction.referenceNumber != null)
                _DetailRow(label: 'Referencia', value: transaction.referenceNumber!),
              if (transaction.relatedTransactionId != null)
                _DetailRow(label: 'Transacción Relacionada', value: transaction.relatedTransactionId!),
              _DetailRow(
                label: 'Canales Permitidos', 
                value: transaction.allowedChannels.join(', '),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}