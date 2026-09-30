import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_banking_app/core/design_patterns/singleton/api_client.dart';
import 'package:mobile_banking_app/core/design_patterns/singleton/secure_storage.dart';
import 'package:mobile_banking_app/core/constants/api_constants.dart';
import 'package:mobile_banking_app/core/constants/app_constants.dart';
import 'package:mobile_banking_app/domain/repositories/account_repository.dart';
import 'package:mobile_banking_app/domain/repositories/transaction_repository.dart';
import 'package:mobile_banking_app/data/repositories/account_repository_impl.dart';
import 'package:mobile_banking_app/data/repositories/transaction_repository_impl.dart';
import 'package:mobile_banking_app/data/datasources/remote/account_remote_datasource.dart';
import 'package:mobile_banking_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:mobile_banking_app/data/services/api_service.dart';
import 'package:mobile_banking_app/domain/usecases/get_balance_usecase.dart';
import 'package:mobile_banking_app/domain/usecases/transfer_funds_usecase.dart';
import 'package:mobile_banking_app/domain/usecases/get_transaction_history_usecase.dart';
import 'package:mobile_banking_app/presentation/viewmodels/account_viewmodel.dart';
import 'package:mobile_banking_app/presentation/viewmodels/transfer_viewmodel.dart';
import 'package:mobile_banking_app/presentation/viewmodels/history_viewmodel.dart';
import 'package:mobile_banking_app/presentation/screens/home_screen.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Singleton instances
  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt.registerSingleton<SecureStorage>(SecureStorage());

  // API Service
  getIt.registerSingleton<ApiService>(ApiService(
    dio: getIt<ApiClient>().dio,
    baseUrl: ApiConstants.baseUrl,
  ));

  // Data sources
  getIt.registerSingleton<AccountRemoteDataSource>(
    AccountRemoteDataSource(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<TransactionRemoteDataSource>(
    TransactionRemoteDataSource(apiService: getIt<ApiService>()),
  );

  // Repositories
  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(remoteDataSource: getIt<AccountRemoteDataSource>()),
  );
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(remoteDataSource: getIt<TransactionRemoteDataSource>()),
  );

  // Use cases
  getIt.registerSingleton<GetBalanceUseCase>(
    GetBalanceUseCase(accountRepository: getIt<AccountRepository>()),
  );
  getIt.registerSingleton<TransferFundsUseCase>(
    TransferFundsUseCase(
      accountRepository: getIt<AccountRepository>(),
      transactionRepository: getIt<TransactionRepository>(),
    ),
  );
  getIt.registerSingleton<GetTransactionHistoryUseCase>(
    GetTransactionHistoryUseCase(transactionRepository: getIt<TransactionRepository>()),
  );

  // ViewModels
  getIt.registerFactory<AccountViewModel>(
    () => AccountViewModel(getBalanceUseCase: getIt<GetBalanceUseCase>()),
  );
  getIt.registerFactory<TransferViewModel>(
    () => TransferViewModel(
      transferFundsUseCase: getIt<TransferFundsUseCase>(),
      getBalanceUseCase: getIt<GetBalanceUseCase>(),
    ),
  );
  getIt.registerFactory<HistoryViewModel>(
    () => HistoryViewModel(getTransactionHistoryUseCase: getIt<GetTransactionHistoryUseCase>()),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AccountViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<TransferViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<HistoryViewModel>()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}