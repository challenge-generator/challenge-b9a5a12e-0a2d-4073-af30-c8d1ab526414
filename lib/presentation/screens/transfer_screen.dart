import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/presentation/viewmodels/transfer_viewmodel.dart';
import 'package:mobile_banking_app/core/design_patterns/strategy/biometric_auth_strategy.dart';
import 'package:mobile_banking_app/core/design_patterns/strategy/pin_auth_strategy.dart';
import 'package:mobile_banking_app/core/design_patterns/command/transfer_command.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
  
  String _selectedCurrency = 'USD';
  bool _requiresBiometric = false;
  Account? _selectedAccount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<TransferViewModel>();
      viewModel.loadAccounts();
    });
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _executeTransfer() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione una cuenta de origen')),
      );
      return;
    }

    final viewModel = context.read<TransferViewModel>();
    final amount = double.tryParse(_amountController.text) ?? 0;
    
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El monto debe ser mayor a cero')),
      );
      return;
    }

    if (amount > _selectedAccount!.balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saldo insuficiente. Máximo: ${_currencyFormatter.format(_selectedAccount!.balance)}')),
      );
      return;
    }

    final transferRequest = TransferRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fromAccountId: _selectedAccount!.id,
      toAccountId: _accountNumberController.text,
      amount: amount,
      currency: _selectedCurrency,
      description: _descriptionController.text.isEmpty 
          ? 'Transferencia' 
          : _descriptionController.text,
      channel: 'mobile_app',
      referenceNumber: _generateReference(),
      timestamp: DateTime.now(),
      requiresBiometric: _requiresBiometric,
    );

    if (_requiresBiometric) {
      final authenticated = await _authenticateWithBiometric();
      if (!authenticated) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Autenticación biométrica fallida')),
          );
        }
        return;
      }
    }

    final command = TransferCommand(
      transferRequest: transferRequest,
      transferFundsUseCase: viewModel.transferFundsUseCase,
    );

    await command.execute();
    
    if (mounted) {
      final result = command.getResult();
      result.when(
        success: (transaction) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Transferencia exitosa: ${_currencyFormatter.format(amount)}'),
              backgroundColor: Colors.green,
            ),
          );
          _clearForm();
          viewModel.loadAccounts();
        },
        failure: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    }
  }

  Future<bool> _authenticateWithBiometric() async {
    final biometricStrategy = BiometricAuthStrategy();
    return await biometricStrategy.authenticate(
      reason: 'Autenticación requerida para realizar la transferencia',
    );
  }

  String _generateReference() {
    return 'TXN${DateTime.now().millisecondsSinceEpoch}';
  }

  void _clearForm() {
    _accountNumberController.clear();
    _amountController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCurrency = 'USD';
      _requiresBiometric = false;
      _selectedAccount = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferir Fondos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<TransferViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuenta de Origen',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<Account>(
                            value: _selectedAccount,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Seleccione cuenta',
                            ),
                            items: viewModel.accounts.map((account) {
                              return DropdownMenuItem<Account>(
                                value: account,
                                child: Text(
                                  '${account.accountNumber} - ${_currencyFormatter.format(account.balance)}',
                                ),
                              );
                            }).toList(),
                            onChanged: (account) {
                              setState(() {
                                _selectedAccount = account;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Seleccione una cuenta';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detalles de Transferencia',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _accountNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Número de Cuenta Destino',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.account_balance),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el número de cuenta';
                              }
                              if (value.length < 8) {
                                return 'Número de cuenta inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: _amountController,
                                  decoration: const InputDecoration(
                                    labelText: 'Monto',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.attach_money),
                                  ),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese monto';
                                    }
                                    final amount = double.tryParse(value);
                                    if (amount == null || amount <= 0) {
                                      return 'Monto inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedCurrency,
                                  decoration: const InputDecoration(
                                    labelText: 'Moneda',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                                    DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                                  ],
                                  onChanged: (currency) {
                                    setState(() {
                                      _selectedCurrency = currency ?? 'USD';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Descripción (opcional)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.description),
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seguridad',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            title: const Text('Requiere autenticación biométrica'),
                            subtitle: const Text('Activar para transferencias de alto valor'),
                            value: _requiresBiometric,
                            onChanged: (value) {
                              setState(() {
                                _requiresBiometric = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: viewModel.isLoading ? null : _executeTransfer,
                    icon: const Icon(Icons.send),
                    label: const Text('Realizar Transferencia'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  if (viewModel.error != null) ...[
                    const SizedBox(height: 16),
                    Card(
                      color: Colors.red.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                viewModel.error!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}