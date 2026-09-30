import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/account.dart';
import '../../core/utils/result.dart';
import '../viewmodels/account_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<AccountViewModel>();
      if (viewModel.state is! AccountLoaded) {
        viewModel.loadAccount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<AccountViewModel>().loadAccount(),
            tooltip: 'Actualizar saldo',
          ),
        ],
      ),
      body: Consumer<AccountViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.loadAccount();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBalanceCard(viewModel),
                  const SizedBox(height: 24),
                  _buildAccountInfoSection(viewModel),
                  const SizedBox(height: 24),
                  _buildAccountDetailsSection(viewModel),
                  const SizedBox(height: 24),
                  _buildChannelsSection(viewModel),
                  const SizedBox(height: 24),
                  _buildSecurityInfo(viewModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBalanceCard(AccountViewModel viewModel) {
    final state = viewModel.state;
    
    return Card(
      elevation: 8,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saldo Disponible',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                if (state is AccountLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (state is AccountLoaded)
              Text(
                '${state.account.currency} ${_formatBalance(state.account.balance)}',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
              )
            else if (state is AccountError)
              Text(
                'Error',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              )
            else
              const Text(
                'Cargando...',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    state is AccountLoaded && state.account.isActive
                        ? Icons.verified_user
                        : Icons.warning,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    state is AccountLoaded && state.account.isActive
                        ? 'Cuenta Activa'
                        : 'Cuenta Inactiva',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfoSection(AccountViewModel viewModel) {
    final state = viewModel.state;
    
    if (state is! AccountLoaded) {
      return const SizedBox.shrink();
    }

    final account = state.account;
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Información de la Cuenta',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              'Número de Cuenta',
              _formatFullAccountNumber(account.accountNumber),
              Icons.numbers,
            ),
            _buildInfoRow(
              context,
              'Titular',
              account.accountHolderName,
              Icons.person,
            ),
            _buildInfoRow(
              context,
              'Moneda',
              account.currency,
              Icons.attach_money,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountDetailsSection(AccountViewModel viewModel) {
    final state = viewModel.state;
    
    if (state is! AccountLoaded) {
      return const SizedBox.shrink();
    }

    final account = state.account;
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.details,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Detalles Adicionales',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              'ID de Cuenta',
              account.id,
              Icons.tag,
            ),
            _buildInfoRow(
              context,
              'Última Actualización',
              _formatDateTime(account.lastUpdated),
              Icons.update,
            ),
            _buildInfoRow(
              context,
              'Estado',
              account.isActive ? 'Activa' : 'Inactiva',
              account.isActive ? Icons.check_circle : Icons.cancel,
              valueColor: account.isActive ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelsSection(AccountViewModel viewModel) {
    final state = viewModel.state;
    
    if (state is! AccountLoaded) {
      return const SizedBox.shrink();
    }

    final account = state.account;
    final channels = account.allowedChannels;
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.devices,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Canales Disponibles',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            if (channels.isEmpty)
              const Text('No hay canales disponibles')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: channels.map((channel) {
                  return Chip(
                    avatar: Icon(
                      _getChannelIcon(channel),
                      size: 18,
                    ),
                    label: Text(_formatChannelName(channel)),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfo(AccountViewModel viewModel) {
    final state = viewModel.state;
    
    if (state is! AccountLoaded) {
      return const SizedBox.shrink();
    }

    final account = state.account;
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.security,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Información de Seguridad',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              'Autenticación Requerida',
              account.requiresBiometric ? 'Biométrica' : 'PIN',
              Icons.fingerprint,
            ),
            _buildInfoRow(
              context,
              'Tipo de Cuenta',
              account.isActive ? 'Premium' : 'Estándar',
              Icons.workspace_premium,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tu cuenta está protegida con los más altos estándares de seguridad.',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: valueColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatBalance(double balance) {
    if (balance >= 1000000) {
      return '${(balance / 1000000).toStringAsFixed(2)} M';
    } else if (balance >= 1000) {
      return '${(balance / 1000).toStringAsFixed(2)} K';
    }
    return balance.toStringAsFixed(2);
  }

  String _formatFullAccountNumber(String accountNumber) {
    final buffer = StringBuffer();
    for (int i = 0; i < accountNumber.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(accountNumber[i]);
    }
    return buffer.toString();
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    
    return '${dateTime.day} de ${months[dateTime.month - 1]} de ${dateTime.year}, '
        '${_formatTime(dateTime.hour)}:${_formatTime(dateTime.minute)}';
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  IconData _getChannelIcon(String channel) {
    switch (channel.toLowerCase()) {
      case 'mobile':
        return Icons.phone_android;
      case 'web':
        return Icons.web;
      case 'atm':
        return Icons.atm;
      case 'branch':
        return Icons.store;
      case 'phone':
        return Icons.phone;
      default:
        return Icons.device_hub;
    }
  }

  String _formatChannelName(String channel) {
    switch (channel.toLowerCase()) {
      case 'mobile':
        return 'Móvil';
      case 'web':
        return 'Web';
      case 'atm':
        return 'CAJERO';
      case 'branch':
        return 'Sucursal';
      case 'phone':
        return 'Teléfono';
      default:
        return channel;
    }
  }
}