# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `lib/domain/usecases/get_transaction_history_usecase.dart` — `TransactionRepository.getTransactions`: Se invoca `getTransactions` sobre `TransactionRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/repositories/account_repository_impl.dart` — `AccountRemoteDataSource.fetchAccount`: Se invoca `fetchAccount` sobre `AccountRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/repositories/account_repository_impl.dart` — `AccountRemoteDataSource.fetchAllAccounts`: Se invoca `fetchAllAccounts` sobre `AccountRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/repositories/account_repository_impl.dart` — `AccountRemoteDataSource.updateAccount`: Se invoca `updateAccount` sobre `AccountRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/repositories/transaction_repository_impl.dart` — `TransactionRemoteDataSource.fetchTransaction`: Se invoca `fetchTransaction` sobre `TransactionRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/repositories/transaction_repository_impl.dart` — `TransactionRemoteDataSource.fetchTransactionsByAccount`: Se invoca `fetchTransactionsByAccount` sobre `TransactionRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/data/repositories/transaction_repository_impl.dart` — `TransactionRemoteDataSource.updateTransaction`: Se invoca `updateTransaction` sobre `TransactionRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/viewmodels/history_viewmodel.dart` — `GetTransactionHistoryUseCase.execute`: Se invoca `execute` sobre `GetTransactionHistoryUseCase`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
flutter pub get && flutter analyze
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior

### Brecha de conocimiento
Identifica todos los patrones necesarios para una solución. Implementa código respetando los patrones de diseño o patrones de software. Aplica el patrón de diseño según la circunstancia a resolver

### Misión / candidato
Candidato Senior con experiencia en desarrollo mobile

### Reto
- Tema: Técnicas de patrones de diseño mobile
- Seniority: senior-l2
- Tipo: practical
- Título: Implementación de patrones de diseño en una aplicación móvil
- Tiempo estimado: 40 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Identificación de patrones de diseño necesarios — objetivo: Determinar los patrones de diseño adecuados para la solución del problema. — entregable (NO resolver): Lista de patrones de diseño con una breve descripción de cómo se aplicarán en el sistema.
- Fase 2: Implementación de patrones de diseño en el código — objetivo: Aplicar los patrones de diseño identificados en la implementación del código. — entregable (NO resolver): Código fuente de la aplicación de banca móvil con los patrones de diseño implementados.
- Fase 3: Evaluación y mejora del código — objetivo: Evaluar la implementación de los patrones de diseño y realizar mejoras necesarias. — entregable (NO resolver): Código fuente mejorado de la aplicación de banca móvil con documentación de las mejoras realizadas.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pubspec.yaml ===
name: mobile_banking_app
description: Aplicación de banca móvil con patrones de diseño GoF
version: 1.0.0+1
environment:
  sdk: '>=3.6.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  dio: ^5.7.0
  get_it: ^8.0.3
  equatable: ^2.0.7
  flutter_secure_storage: ^9.2.4
  local_auth: ^2.3.0
  intl: ^0.20.2
  uuid: ^4.5.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.14

flutter:
  uses-material-design: true
  assets:
    - assets/fonts/
    - assets/images/

// === ARCHIVO: lib/main.dart ===
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

// === ARCHIVO: lib/domain/entities/account.dart ===
part of '../../core/utils/result.dart';

class Account with EquatableMixin {
  final String id;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final bool isActive;
  final List<String> allowedChannels;

  Account({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    this.isActive = true,
    this.allowedChannels = const ['MOBILE', 'WEB', 'ATM'],
  });

  Account copyWith({
    String? id,
    String? accountNumber,
    String? accountHolderName,
    double? balance,
    String? currency,
    DateTime? lastUpdated,
    bool? isActive,
    List<String>? allowedChannels,
  }) {
    return Account(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
      allowedChannels: allowedChannels ?? this.allowedChannels,
    );
  }

  Result<Account> applyTransaction(Transaction transaction) {
    if (!isActive) {
      return Result.error('Account is not active');
    }

    if (transaction.type == TransactionType.debit && balance < transaction.amount) {
      return Result.error('Insufficient funds');
    }

    final newBalance = transaction.type == TransactionType.credit
        ? balance + transaction.amount
        : balance - transaction.amount;

    return Result.success(copyWith(
      balance: newBalance,
      lastUpdated: transaction.timestamp,
    ));
  }

  bool canPerformTransfer(String channel) {
    return allowedChannels.contains(channel);
  }

  @override
  List<Object?> get props => [
    id,
    accountNumber,
    accountHolderName,
    balance,
    currency,
    lastUpdated,
    isActive,
    allowedChannels,
  ];
}

// === ARCHIVO: lib/domain/entities/transaction.dart ===
enum TransactionType { credit, debit }

enum TransactionStatus { pending, completed, failed, reversed }

class Transaction with EquatableMixin {
  final String id;
  final String accountId;
  final double amount;
  final TransactionType type;
  final String description;
  final DateTime timestamp;
  final TransactionStatus status;
  final String? referenceNumber;
  final String? relatedTransactionId;

  Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
    this.status = TransactionStatus.pending,
    this.referenceNumber,
    this.relatedTransactionId,
  });

  Transaction copyWith({
    String? id,
    String? accountId,
    double? amount,
    TransactionType? type,
    String? description,
    DateTime? timestamp,
    TransactionStatus? status,
    String? referenceNumber,
    String? relatedTransactionId,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      relatedTransactionId: relatedTransactionId ?? this.relatedTransactionId,
    );
  }

  bool isIdempotentMatch(String referenceNumber, String channel) {
    return this.referenceNumber == referenceNumber &&
           allowedChannels.contains(channel);
  }

  bool get isSuccessful => status == TransactionStatus.completed;

  List<String> get allowedChannels => ['MOBILE', 'WEB', 'ATM'];

  @override
  List<Object?> get props => [
    id,
    accountId,
    amount,
    type,
    description,
    timestamp,
    status,
    referenceNumber,
    relatedTransactionId,
  ];
}

// === ARCHIVO: lib/domain/entities/transfer_request.dart ===
class TransferRequest with EquatableMixin {
  final String id;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String currency;
  final String description;
  final String channel;
  final String? referenceNumber;
  final DateTime timestamp;
  final bool requiresBiometric;

  TransferRequest({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.currency,
    required this.description,
    required this.channel,
    this.referenceNumber,
    DateTime? timestamp,
    this.requiresBiometric = false,
  }) : timestamp = timestamp ?? DateTime.now();

  TransferRequest copyWith({
    String? id,
    String? fromAccountId,
    String? toAccountId,
    double? amount,
    String? currency,
    String? description,
    String? channel,
    String? referenceNumber,
    DateTime? timestamp,
    bool? requiresBiometric,
  }) {
    return TransferRequest(
      id: id ?? this.id,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      channel: channel ?? this.channel,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      timestamp: timestamp ?? this.timestamp,
      requiresBiometric: requiresBiometric ?? this.requiresBiometric,
    );
  }

  bool get isValid {
    return amount > 0 &&
           currency.isNotEmpty &&
           fromAccountId.isNotEmpty &&
           toAccountId.isNotEmpty &&
           channel.isNotEmpty;
  }

  String generateReferenceNumber() {
    return referenceNumber ?? 'TRF-${DateTime.now().millisecondsSinceEpoch}-${id.substring(0, 8)}';
  }

  @override
  List<Object?> get props => [
    id,
    fromAccountId,
    toAccountId,
    amount,
    currency,
    description,
    channel,
    referenceNumber,
    timestamp,
    requiresBiometric,
  ];
}

// === ARCHIVO: lib/domain/repositories/account_repository.dart ===
import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';

abstract class AccountRepository extends Equatable {
  const AccountRepository();

  Future<Result<Account>> getAccountById(String accountId);

  Future<Result<Account>> getAccountByNumber(String accountNumber);

  Future<Result<double>> getBalance(String accountId);

  Future<Result<Account>> updateBalance(
    String accountId,
    double newBalance,
  );

  Future<Result<Account>> applyTransaction(
    String accountId,
    Transaction transaction,
  );

  Future<Result<List<Account>>> getAccountsByHolder(String holderId);

  Future<Result<bool>> validateAccountStatus(String accountId);

  Future<Result<Account>> refreshAccountData(String accountId);
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  const AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Account>> getAccountById(String accountId) async {
    try {
      final accountModel = await remoteDataSource.getAccountById(accountId);
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener cuenta: $e'));
    }
  }

  @override
  Future<Result<Account>> getAccountByNumber(String accountNumber) async {
    try {
      final accountModel = await remoteDataSource.getAccountByNumber(accountNumber);
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al buscar cuenta: $e'));
    }
  }

  @override
  Future<Result<double>> getBalance(String accountId) async {
    final stopwatch = Stopwatch()..start();
    try {
      final accountResult = await getAccountById(accountId);
      stopwatch.stop();
      
      if (stopwatch.elapsed.inSeconds > 2) {
        return Result.failure(
          TimeoutException('La consulta excedió el límite de 2 segundos'),
        );
      }
      
      return accountResult.when(
        success: (account) => Result.success(account.balance),
        failure: (error) => Result.failure(error),
      );
    } catch (e) {
      stopwatch.stop();
      return Result.failure(UnexpectedException('Error al obtener saldo: $e'));
    }
  }

  @override
  Future<Result<Account>> updateBalance(
    String accountId,
    double newBalance,
  ) async {
    try {
      final accountModel = await remoteDataSource.updateBalance(
        accountId,
        newBalance,
      );
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al actualizar saldo: $e'));
    }
  }

  @override
  Future<Result<Account>> applyTransaction(
    String accountId,
    Transaction transaction,
  ) async {
    final accountResult = await getAccountById(accountId);
    return accountResult.when(
      success: (account) {
        final updatedAccount = account.applyTransaction(transaction);
        return updateBalance(accountId, updatedAccount.balance);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<List<Account>>> getAccountsByHolder(String holderId) async {
    try {
      final accounts = await remoteDataSource.getAccountsByHolder(holderId);
      return Result.success(accounts.map((m) => m.toEntity()).toList());
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener cuentas: $e'));
    }
  }

  @override
  Future<Result<bool>> validateAccountStatus(String accountId) async {
    final accountResult = await getAccountById(accountId);
    return accountResult.when(
      success: (account) => Result.success(account.isActive),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<Account>> refreshAccountData(String accountId) async {
    try {
      final accountModel = await remoteDataSource.refreshAccount(accountId);
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al refrescar cuenta: $e'));
    }
  }

  @override
  List<Object?> get props => [remoteDataSource];
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});
  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException(this.message);
  @override
  String toString() => 'TimeoutException: $message';
}

class UnexpectedException implements Exception {
  final String message;
  const UnexpectedException(this.message);
  @override
  String toString() => 'UnexpectedException: $message';
}

abstract class AccountRemoteDataSource {
  Future<AccountModel> getAccountById(String accountId);
  Future<AccountModel> getAccountByNumber(String accountNumber);
  Future<AccountModel> updateBalance(String accountId, double newBalance);
  Future<List<AccountModel>> getAccountsByHolder(String holderId);
  Future<AccountModel> refreshAccount(String accountId);
}

class AccountModel {
  final String id;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final bool isActive;
  final List<String> allowedChannels;

  const AccountModel({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    required this.isActive,
    required this.allowedChannels,
  });

  Account toEntity() {
    return Account(
      id: id,
      accountNumber: accountNumber,
      accountHolderName: accountHolderName,
      balance: balance,
      currency: currency,
      lastUpdated: lastUpdated,
      isActive: isActive,
      allowedChannels: allowedChannels,
    );
  }
}

// === ARCHIVO: lib/domain/repositories/transaction_repository.dart ===
import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository extends Equatable {
  const TransactionRepository();

  Future<Result<Transaction>> getTransactionById(String transactionId);

  Future<Result<List<Transaction>>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  });

  Future<Result<Transaction>> createTransaction(Transaction transaction);

  Future<Result<Transaction>> updateTransactionStatus(
    String transactionId,
    TransactionStatus newStatus,
  );

  Future<Result<bool>> validateIdempotency(
    String referenceNumber,
    String channel,
  );

  Future<Result<Transaction?>> findByReferenceNumber(
    String referenceNumber,
    String channel,
  );

  Future<Result<List<Transaction>>> getPendingTransactions(String accountId);

  Future<Result<Transaction>> reverseTransaction(
    String transactionId,
    String reason,
  );
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  const TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Transaction>> getTransactionById(String transactionId) async {
    try {
      final transactionModel = await remoteDataSource.getTransactionById(transactionId);
      final transaction = transactionModel.toEntity();
      return Result.success(transaction);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener transacción: $e'));
    }
  }

  @override
  Future<Result<List<Transaction>>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  }) async {
    try {
      final transactions = await remoteDataSource.getTransactionsByAccount(
        accountId,
        startDate: startDate,
        endDate: endDate,
        limit: limit,
        offset: offset,
      );
      return Result.success(transactions.map((m) => m.toEntity()).toList());
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener transacciones: $e'));
    }
  }

  @override
  Future<Result<Transaction>> createTransaction(Transaction transaction) async {
    try {
      final transactionModel = TransactionModel.fromEntity(transaction);
      final createdModel = await remoteDataSource.createTransaction(transactionModel);
      final created = createdModel.toEntity();
      return Result.success(created);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al crear transacción: $e'));
    }
  }

  @override
  Future<Result<Transaction>> updateTransactionStatus(
    String transactionId,
    TransactionStatus newStatus,
  ) async {
    try {
      final updatedModel = await remoteDataSource.updateTransactionStatus(
        transactionId,
        newStatus.name,
      );
      final updated = updatedModel.toEntity();
      return Result.success(updated);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al actualizar estado: $e'));
    }
  }

  @override
  Future<Result<bool>> validateIdempotency(
    String referenceNumber,
    String channel,
  ) async {
    try {
      final existing = await remoteDataSource.findByReferenceAndChannel(
        referenceNumber,
        channel,
      );
      return Result.success(existing != null);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al validar idempotencia: $e'));
    }
  }

  @override
  Future<Result<Transaction?>> findByReferenceNumber(
    String referenceNumber,
    String channel,
  ) async {
    try {
      final transactionModel = await remoteDataSource.findByReferenceAndChannel(
        referenceNumber,
        channel,
      );
      if (transactionModel == null) {
        return Result.success(null);
      }
      return Result.success(transactionModel.toEntity());
    } catch (e) {
      return Result.failure(UnexpectedException('Error al buscar por referencia: $e'));
    }
  }

  @override
  Future<Result<List<Transaction>>> getPendingTransactions(String accountId) async {
    final allTransactions = await getTransactionsByAccount(accountId);
    return allTransactions.when(
      success: (transactions) {
        final pending = transactions
            .where((t) => t.status == TransactionStatus.pending)
            .toList();
        return Result.success(pending);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<Transaction>> reverseTransaction(
    String transactionId,
    String reason,
  ) async {
    final transactionResult = await getTransactionById(transactionId);
    return transactionResult.when(
      success: (transaction) async {
        if (!transaction.isSuccessful) {
          return Result.failure(
            const UnexpectedException('Solo se pueden revertir transacciones exitosas'),
          );
        }
        try {
          final reversedModel = await remoteDataSource.reverseTransaction(
            transactionId,
            reason,
          );
          return Result.success(reversedModel.toEntity());
        } catch (e) {
          return Result.failure(UnexpectedException('Error al revertir transacción: $e'));
        }
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  List<Object?> get props => [remoteDataSource];
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});
  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class UnexpectedException implements Exception {
  final String message;
  const UnexpectedException(this.message);
  @override
  String toString() => 'UnexpectedException: $message';
}

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> getTransactionById(String transactionId);
  Future<List<TransactionModel>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  });
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransactionStatus(
    String transactionId,
    String newStatus,
  );
  Future<TransactionModel?> findByReferenceAndChannel(
    String referenceNumber,
    String channel,
  );
  Future<TransactionModel> reverseTransaction(
    String transactionId,
    String reason,
  );
}

class TransactionModel {
  final String id;
  final String accountId;
  final double amount;
  final String type;
  final String description;
  final DateTime timestamp;
  final String status;
  final String? referenceNumber;
  final String? relatedTransactionId;

  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
    required this.status,
    this.referenceNumber,
    this.relatedTransactionId,
  });

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      accountId: transaction.accountId,
      amount: transaction.amount,
      type: transaction.type.name,
      description: transaction.description,
      timestamp: transaction.timestamp,
      status: transaction.status.name,
      referenceNumber: transaction.referenceNumber,
      relatedTransactionId: transaction.relatedTransactionId,
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      accountId: accountId,
      amount: amount,
      type: TransactionType.values.firstWhere((e) => e.name == type),
      description: description,
      timestamp: timestamp,
      status: TransactionStatus.values.firstWhere((e) => e.name == status),
      referenceNumber: referenceNumber,
      relatedTransactionId: relatedTransactionId,
    );
  }
}

// === ARCHIVO: lib/domain/usecases/get_balance_usecase.dart ===
import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class GetBalanceUseCase extends Equatable {
  final AccountRepository accountRepository;

  const GetBalanceUseCase({required this.accountRepository});

  Future<Result<BalanceResponse>> execute(String accountId) async {
    final stopwatch = Stopwatch()..start();
    
    final accountResult = await accountRepository.getAccountById(accountId);
    
    stopwatch.stop();
    final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
    final elapsedSeconds = stopwatch.elapsed.inSeconds;

    return accountResult.when(
      success: (account) {
        if (elapsedSeconds >= 2) {
          return Result.failure(
            const BalanceTimeoutException(
              'La consulta de saldo excedió el límite de latencia de 2 segundos',
            ),
          );
        }
        
        final response = BalanceResponse(
          accountId: account.id,
          balance: account.balance,
          currency: account.currency,
          lastUpdated: account.lastUpdated,
          latencyMs: elapsedMilliseconds,
          meetsSla: elapsedSeconds < 2,
        );
        
        return Result.success(response);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }

  Future<Result<Account>> getAccountDetails(String accountId) async {
    return accountRepository.getAccountById(accountId);
  }

  Future<Result<bool>> validateAccountAccess(String accountId, String channel) async {
    final accountResult = await accountRepository.getAccountById(accountId);
    return accountResult.when(
      success: (account) {
        final hasAccess = account.canPerformTransfer(channel);
        return Result.success(hasAccess);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  List<Object?> get props => [accountRepository];
}

class BalanceResponse extends Equatable {
  final String accountId;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final int latencyMs;
  final bool meetsSla;

  const BalanceResponse({
    required this.accountId,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    required this.latencyMs,
    required this.meetsSla,
  });

  String get formattedBalance {
    return '$currency ${balance.toStringAsFixed(2)}';
  }

  @override
  List<Object?> get props => [
        accountId,
        balance,
        currency,
        lastUpdated,
        latencyMs,
        meetsSla,
      ];
}

class BalanceTimeoutException implements Exception {
  final String message;
  const BalanceTimeoutException(this.message);
  @override
  String toString() => 'BalanceTimeoutException: $message';
}

// === ARCHIVO: lib/domain/usecases/transfer_funds_usecase.dart ===
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../core/utils/result.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';
import '../entities/transfer_request.dart';
import '../repositories/account_repository.dart';
import '../repositories/transaction_repository.dart';

class TransferFundsUseCase extends Equatable {
  final AccountRepository accountRepository;
  final TransactionRepository transactionRepository;
  final Uuid uuid;

  const TransferFundsUseCase({
    required this.accountRepository,
    required this.transactionRepository,
    Uuid? uuid,
  }) : uuid = uuid ?? const Uuid();

  Future<Result<TransferResult>> execute(TransferRequest request) async {
    if (request.referenceNumber != null) {
      final idempotencyCheck = await _checkIdempotency(request);
      if (idempotencyCheck != null) return idempotencyCheck;
    }

    final sourceAccountResult = await accountRepository.getAccountById(
      request.fromAccountId,
    );
    final targetAccountResult = await accountRepository.getAccountById(
      request.toAccountId,
    );

    final accountValidation = _validateAccounts(
      sourceAccountResult,
      targetAccountResult,
      request,
    );
    if (accountValidation != null) return accountValidation;

    final sourceAccount = sourceAccountResult.getOrThrow();
    final targetAccount = targetAccountResult.getOrThrow();

    if (sourceAccount.balance < request.amount) {
      return Result.failure(
        const InsufficientFundsException('Saldo insuficiente para la transferencia'),
      );
    }

    final referenceNumber = request.referenceNumber ??
        request.generateReferenceNumber();

    final transaction = _createDebitTransaction(
      sourceAccount.id,
      request.amount,
      request.description,
      referenceNumber,
      request.channel,
    );

    final transactionResult = await transactionRepository.createTransaction(transaction);
    
    final updatedSourceResult = await accountRepository.applyTransaction(
      sourceAccount.id,
      transaction,
    );

    final creditTransaction = _createCreditTransaction(
      targetAccount.id,
      request.amount,
      request.description,
      referenceNumber,
      request.channel,
      transaction.id,
    );

    await transactionRepository.createTransaction(creditTransaction);
    
    final updatedTargetResult = await accountRepository.applyTransaction(
      targetAccount.id,
      creditTransaction,
    );

    return updatedSourceResult.when(
      success: (updatedSource) {
        return updatedTargetResult.when(
          success: (updatedTarget) {
            final result = TransferResult(
              transactionId: transaction.id,
              referenceNumber: referenceNumber,
              fromAccountId: request.fromAccountId,
              toAccountId: request.toAccountId,
              amount: request.amount,
              currency: request.currency,
              status: TransferStatus.completed,
              timestamp: DateTime.now(),
              newSourceBalance: updatedSource.balance,
              newTargetBalance: updatedTarget.balance,
            );
            return Result.success(result);
          },
          failure: (error) => Result.failure(error),
        );
      },
      failure: (error) => Result.failure(error),
    );
  }

  Future<Result<TransferResult>?> _checkIdempotency(TransferRequest request) async {
    final existingResult = await transactionRepository.findByReferenceNumber(
      request.referenceNumber!,
      request.channel,
    );
    
    return existingResult.when(
      success: (existingTransaction) {
        if (existingTransaction != null) {
          return Result.success(
            TransferResult(
              transactionId: existingTransaction.id,
              referenceNumber: request.referenceNumber!,
              fromAccountId: request.fromAccountId,
              toAccountId: request.toAccountId,
              amount: request.amount,
              currency: request.currency,
              status: TransferStatus.duplicated,
              timestamp: existingTransaction.timestamp,
              newSourceBalance: 0,
              newTargetBalance: 0,
              isIdempotentResult: true,
            ),
          );
        }
        return null;
      },
      failure: (error) => Result.failure(error),
    );
  }

  Result<TransferResult>? _validateAccounts(
    Result<Account> sourceResult,
    Result<Account> targetResult,
    TransferRequest request,
  ) {
    return sourceResult.when(
      success: (source) {
        return targetResult.when(
          success: (target) {
            if (!source.isActive) {
              return Result.failure(
                const AccountInactiveException('La cuenta de origen está inactiva'),
              );
            }
            if (!target.isActive) {
              return Result.failure(
                const AccountInactiveException('La cuenta de destino está inactiva'),
              );
            }
            if (!source.canPerformTransfer(request.channel)) {
              return Result.failure(
                ChannelNotAllowedException(
                  'El canal ${request.channel} no está permitido para esta cuenta',
                ),
              );
            }
            return null;
          },
          failure: (error) => Result.failure(error),
        );
      },
      failure: (error) => Result.failure(error),
    );
  }

  Transaction _createDebitTransaction(
    String accountId,
    double amount,
    String description,
    String referenceNumber,
    String channel,
  ) {
    return Transaction(
      id: uuid.v4(),
      accountId: accountId,
      amount: amount,
      type: TransactionType.debit,
      description: description,
      timestamp: DateTime.now(),
      status: TransactionStatus.completed,
      referenceNumber: referenceNumber,
    );
  }

  Transaction _createCreditTransaction(
    String accountId,
    double amount,
    String description,
    String referenceNumber,
    String channel,
    String relatedTransactionId,
  ) {
    return Transaction(
      id: uuid.v4(),
      accountId: accountId,
      amount: amount,
      type: TransactionType.credit,
      description: description,
      timestamp: DateTime.now(),
      status: TransactionStatus.completed,
      referenceNumber: referenceNumber,
      relatedTransactionId: relatedTransactionId,
    );
  }

  @override
  List<Object?> get props => [accountRepository, transactionRepository, uuid];
}

class TransferResult extends Equatable {
  final String transactionId;
  final String referenceNumber;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String currency;
  final TransferStatus status;
  final DateTime timestamp;
  final double newSourceBalance;
  final double newTargetBalance;
  final bool isIdempotentResult;

  const TransferResult({
    required this.transactionId,
    required this.referenceNumber,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.timestamp,
    required this.newSourceBalance,
    required this.newTargetBalance,
    this.isIdempotentResult = false,
  });

  @override
  List<Object?> get props => [
        transactionId,
        referenceNumber,
        fromAccountId,
        toAccountId,
        amount,
        currency,
        status,
        timestamp,
        newSourceBalance,
        newTargetBalance,
        isIdempotentResult,
      ];
}

enum TransferStatus {
  pending,
  completed,
  failed,
  duplicated,
  reversed,
}

class InsufficientFundsException implements Exception {
  final String message;
  const InsufficientFundsException(this.message);
  @override
  String toString() => 'InsufficientFundsException: $message';
}

class AccountInactiveException implements Exception {
  final String message;
  const AccountInactiveException(this.message);
  @override
  String toString() => 'AccountInactiveException: $message';
}

class ChannelNotAllowedException implements Exception {
  final String message;
  const ChannelNotAllowedException(this.message);
  @override
  String toString() => 'ChannelNotAllowedException: $message';
}

// === ARCHIVO: lib/domain/usecases/get_transaction_history_usecase.dart ===
import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionHistoryParams extends Equatable {
  final String accountId;
  final DateTime? startDate;
  final DateTime? endDate;
  final TransactionType? type;
  final TransactionStatus? status;
  final int? limit;
  final int? offset;

  const GetTransactionHistoryParams({
    required this.accountId,
    this.startDate,
    this.endDate,
    this.type,
    this.status,
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => [
        accountId,
        startDate,
        endDate,
        type,
        status,
        limit,
        offset,
      ];
}

class TransactionHistoryResult extends Equatable {
  final List<Transaction> transactions;
  final int totalCount;
  final bool hasMore;
  final DateTime? oldestTransactionDate;
  final DateTime? newestTransactionDate;

  const TransactionHistoryResult({
    required this.transactions,
    required this.totalCount,
    required this.hasMore,
    this.oldestTransactionDate,
    this.newestTransactionDate,
  });

  @override
  List<Object?> get props => [
        transactions,
        totalCount,
        hasMore,
        oldestTransactionDate,
        newestTransactionDate,
      ];
}

class GetTransactionHistoryUseCase {
  final TransactionRepository _transactionRepository;
  static const int defaultLimit = 20;
  static const int maxLimit = 100;

  GetTransactionHistoryUseCase({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;

  Future<Result<TransactionHistoryResult>> call(
    GetTransactionHistoryParams params,
  ) async {
    if (params.accountId.isEmpty) {
      return Result.failure(
        const ValidationError('El ID de cuenta no puede estar vacío'),
      );
    }

    if (params.startDate != null &&
        params.endDate != null &&
        params.startDate!.isAfter(params.endDate!)) {
      return Result.failure(
        const ValidationError(
          'La fecha de inicio no puede ser posterior a la fecha fin',
        ),
      );
    }

    final effectiveLimit = _calculateEffectiveLimit(params.limit);
    final effectiveOffset = params.offset ?? 0;

    try {
      final fetchResult = await _transactionRepository.getTransactions(
        accountId: params.accountId,
        startDate: params.startDate,
        endDate: params.endDate,
        type: params.type,
        status: params.status,
        limit: effectiveLimit,
        offset: effectiveOffset,
      );

      return fetchResult.when(
        success: (transactions) {
          final sortedTransactions = List<Transaction>.from(transactions)
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

          final hasMore = sortedTransactions.length >= effectiveLimit;
          final resultTransactions = hasMore
              ? sortedTransactions.sublist(0, effectiveLimit)
              : sortedTransactions;

          final oldestDate = resultTransactions.isNotEmpty
              ? resultTransactions.last.timestamp
              : null;
          final newestDate = resultTransactions.isNotEmpty
              ? resultTransactions.first.timestamp
              : null;

          return Result.success(
            TransactionHistoryResult(
              transactions: resultTransactions,
              totalCount: resultTransactions.length,
              hasMore: hasMore,
              oldestTransactionDate: oldestDate,
              newestTransactionDate: newestDate,
            ),
          );
        },
        failure: (error) => Result.failure(error),
      );
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedError('Error inesperado al obtener historial: $e'),
      );
    }
  }

  int _calculateEffectiveLimit(int? requestedLimit) {
    if (requestedLimit == null || requestedLimit <= 0) {
      return defaultLimit;
    }
    return requestedLimit > maxLimit ? maxLimit : requestedLimit;
  }

  Future<Result<List<Transaction>>> getRecentTransactions(
    String accountId, {
    int count = 5,
  }) async {
    final params = GetTransactionHistoryParams(
      accountId: accountId,
      limit: count,
      status: TransactionStatus.completed,
    );

    final result = await call(params);
    return result.when(
      success: (history) => Result.success(history.transactions),
      failure: (error) => Result.failure(error),
    );
  }

  Future<Result<Map<TransactionType, double>>> getTotalByType(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final params = GetTransactionHistoryParams(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      status: TransactionStatus.completed,
    );

    final result = await call(params);
    return result.when(
      success: (history) {
        final totals = <TransactionType, double>{};
        for (final transaction in history.transactions) {
          totals[transaction.type] =
              (totals[transaction.type] ?? 0) + transaction.amount;
        }
        return Result.success(totals);
      },
      failure: (error) => Result.failure(error),
    );
  }
}

class ValidationError implements Exception {
  final String message;
  const ValidationError(this.message);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  const NetworkException(this.message, {this.statusCode});

  @override
  String toString() => 'NetworkException: $message (status: $statusCode)';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class UnexpectedError implements Exception {
  final String message;
  const UnexpectedError(this.message);

  @override
  String toString() => message;
}

// === ARCHIVO: lib/data/models/account_model.dart ===
package mobile_banking_app.data.models;

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final bool isActive;
  final List<String> allowedChannels;

  const AccountModel({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    required this.isActive,
    required this.allowedChannels,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      accountNumber: json['account_number'] as String,
      accountHolderName: json['account_holder_name'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      isActive: json['is_active'] as bool,
      allowedChannels: (json['allowed_channels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber,
      'account_holder_name': accountHolderName,
      'balance': balance,
      'currency': currency,
      'last_updated': lastUpdated.toIso8601String(),
      'is_active': isActive,
      'allowed_channels': allowedChannels,
    };
  }

  AccountModel copyWith({
    String? id,
    String? accountNumber,
    String? accountHolderName,
    double? balance,
    String? currency,
    DateTime? lastUpdated,
    bool? isActive,
    List<String>? allowedChannels,
  }) {
    return AccountModel(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
      allowedChannels: allowedChannels ?? this.allowedChannels,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountNumber,
        accountHolderName,
        balance,
        currency,
        lastUpdated,
        isActive,
        allowedChannels,
      ];
}

// === ARCHIVO: lib/data/models/transaction_model.dart ===
package mobile_banking_app.data.models;

import 'package:equatable/equatable.dart';

enum TransactionTypeModel { credit, debit }

enum TransactionStatusModel { pending, completed, failed, reversed }

class TransactionModel extends Equatable {
  final String id;
  final String accountId;
  final double amount;
  final TransactionTypeModel type;
  final String description;
  final DateTime timestamp;
  final TransactionStatusModel status;
  final String? referenceNumber;
  final String? relatedTransactionId;

  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
    required this.status,
    this.referenceNumber,
    this.relatedTransactionId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: TransactionTypeModel.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionTypeModel.debit,
      ),
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: TransactionStatusModel.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatusModel.pending,
      ),
      referenceNumber: json['reference_number'] as String?,
      relatedTransactionId: json['related_transaction_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'type': type.name,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'status': status.name,
      'reference_number': referenceNumber,
      'related_transaction_id': relatedTransactionId,
    };
  }

  TransactionModel copyWith({
    String? id,
    String? accountId,
    double? amount,
    TransactionTypeModel? type,
    String? description,
    DateTime? timestamp,
    TransactionStatusModel? status,
    String? referenceNumber,
    String? relatedTransactionId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      relatedTransactionId: relatedTransactionId ?? this.relatedTransactionId,
    );
  }

  bool get isSuccessful =>
      status == TransactionStatusModel.completed ||
      status == TransactionStatusModel.credit;

  List<String> get allowedChannels => ['mobile', 'web', 'atm', 'branch'];

  @override
  List<Object?> get props => [
        id,
        accountId,
        amount,
        type,
        description,
        timestamp,
        status,
        referenceNumber,
        relatedTransactionId,
      ];
}

// === ARCHIVO: lib/data/repositories/account_repository_impl.dart ===
package mobile_banking_app.data.repositories;

import 'package:mobile_banking_app/data/datasources/remote/account_remote_datasource.dart';
import 'package:mobile_banking_app/data/models/account_model.dart';
import 'package:mobile_banking_app/domain/repositories/account_repository.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<AccountModel>> getAccountById(String accountId) async {
    try {
      final accountData = await remoteDataSource.fetchAccount(accountId);
      if (accountData == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(accountData);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<AccountModel>>> getAllAccounts() async {
    try {
      final accounts = await remoteDataSource.fetchAllAccounts();
      return Result.success(accounts);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<AccountModel>> getAccountBalance(String accountId) async {
    try {
      final accountData = await remoteDataSource.fetchAccount(accountId);
      if (accountData == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(accountData);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<AccountModel>> updateAccount(AccountModel account) async {
    try {
      final updatedAccount = await remoteDataSource.updateAccount(account);
      return Result.success(updatedAccount);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<AccountModel>> applyTransaction(
    String accountId,
    Transaction transaction,
  ) async {
    try {
      final accountData = await remoteDataSource.fetchAccount(accountId);
      if (accountData == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }

      final updatedAccount = _applyTransactionToAccount(accountData, transaction);
      final result = await remoteDataSource.updateAccount(updatedAccount);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  AccountModel _applyTransactionToAccount(
    AccountModel account,
    Transaction transaction,
  ) {
    double newBalance = account.balance;

    if (transaction.type == TransactionType.credit) {
      newBalance += transaction.amount;
    } else if (transaction.type == TransactionType.debit) {
      newBalance -= transaction.amount;
    }

    return account.copyWith(
      balance: newBalance,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<Result<bool>> validateAccountStatus(String accountId) async {
    try {
      final account = await remoteDataSource.fetchAccount(accountId);
      if (account == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(account.isActive);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<String>>> getAllowedChannels(String accountId) async {
    try {
      final account = await remoteDataSource.fetchAccount(accountId);
      if (account == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(account.allowedChannels);
    } catch (e) {
      return Result.failure(e);
    }
  }
}

// === ARCHIVO: lib/data/repositories/transaction_repository_impl.dart ===
package mobile_banking_app.data.repositories;

import 'package:mobile_banking_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:mobile_banking_app/data/models/transaction_model.dart';
import 'package:mobile_banking_app/domain/repositories/transaction_repository.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<TransactionModel>> getTransactionById(String transactionId) async {
    try {
      final transaction = await remoteDataSource.fetchTransaction(transactionId);
      if (transaction == null) {
        return Result.failure(Exception('Transacción no encontrada'));
      }
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getTransactionsByAccountId(
    String accountId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: limit,
        offset: offset,
      );
      return Result.success(transactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getTransactionHistory(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    TransactionStatusModel? status,
  }) async {
    try {
      var transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: 100,
        offset: 0,
      );

      if (startDate != null) {
        transactions = transactions
            .where((t) => t.timestamp.isAfter(startDate))
            .toList();
      }

      if (endDate != null) {
        transactions = transactions
            .where((t) => t.timestamp.isBefore(endDate))
            .toList();
      }

      if (status != null) {
        transactions = transactions
            .where((t) => t.status == status)
            .toList();
      }

      transactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return Result.success(transactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TransactionModel>> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final createdTransaction = await remoteDataSource.createTransaction(transaction);
      return Result.success(createdTransaction);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TransactionModel>> updateTransactionStatus(
    String transactionId,
    TransactionStatusModel newStatus,
  ) async {
    try {
      final transaction = await remoteDataSource.fetchTransaction(transactionId);
      if (transaction == null) {
        return Result.failure(Exception('Transacción no encontrada'));
      }

      final updatedTransaction = transaction.copyWith(status: newStatus);
      final result = await remoteDataSource.updateTransaction(updatedTransaction);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> checkIdempotency(
    String accountId,
    String referenceNumber,
    String channel,
  ) async {
    try {
      final transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: 100,
        offset: 0,
      );

      final existingTransaction = transactions.where(
        (t) =>
            t.referenceNumber == referenceNumber &&
            t.allowedChannels.contains(channel),
      );

      return Result.success(existingTransaction.isNotEmpty);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getPendingTransactions(
    String accountId,
  ) async {
    try {
      final transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: 50,
        offset: 0,
      );

      final pendingTransactions = transactions
          .where((t) => t.status == TransactionStatusModel.pending)
          .toList();

      return Result.success(pendingTransactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TransactionModel>> reverseTransaction(
    String transactionId,
    String reason,
  ) async {
    try {
      final originalTransaction = await remoteDataSource.fetchTransaction(transactionId);
      if (originalTransaction == null) {
        return Result.failure(Exception('Transacción no encontrada'));
      }

      if (originalTransaction.status != TransactionStatusModel.completed) {
        return Result.failure(
          Exception('Solo se pueden revertir transacciones completadas'),
        );
      }

      final reversedTransaction = TransactionModel(
        id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
        accountId: originalTransaction.accountId,
        amount: originalTransaction.amount,
        type: originalTransaction.type == TransactionTypeModel.credit
            ? TransactionTypeModel.debit
            : TransactionTypeModel.credit,
        description: 'Reversión: $reason',
        timestamp: DateTime.now(),
        status: TransactionStatusModel.reversed,
        referenceNumber: 'REV_${originalTransaction.referenceNumber}',
        relatedTransactionId: transactionId,
      );

      final created = await remoteDataSource.createTransaction(reversedTransaction);
      return Result.success(created);
    } catch (e) {
      return Result.failure(e);
    }
  }
}

// === ARCHIVO: lib/data/services/api_service.dart ===
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/api_constants.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  String? _authToken;

  ApiService({
    Dio? dio,
    FlutterSecureStorage? secureStorage,
  })  : _dio = dio ?? Dio(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_authToken != null) {
      options.headers['Authorization'] = 'Bearer $_authToken';
    }

    final idempotencyKey = options.headers['X-Idempotency-Key'];
    if (idempotencyKey != null) {
      await _secureStorage.write(
        key: 'idempotency_$idempotencyKey',
        value: DateTime.now().toIso8601String(),
      );
    }

    handler.next(options);
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  void _onError(DioException err, ErrorInterceptorHandler handler) {
    String message;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Tiempo de conexión agotado';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Tiempo de envío agotado';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Tiempo de recepción agotado';
        break;
      case DioExceptionType.badResponse:
        message = _handleBadResponse(err.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        message = 'Solicitud cancelada';
        break;
      case DioExceptionType.connectionError:
        message = 'Error de conexión';
        break;
      default:
        message = 'Error de red desconocido';
    }

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        error: message,
        type: err.type,
        response: err.response,
      ),
    );
  }

  String _handleBadResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Solicitud incorrecta';
      case 401:
        return 'No autorizado';
      case 403:
        return 'Acceso prohibido';
      case 404:
        return 'Recurso no encontrado';
      case 422:
        return 'Datos de solicitud inválidos';
      case 429:
        return 'Demasiadas solicitudes';
      case 500:
        return 'Error interno del servidor';
      case 502:
        return 'Puerta de enlace incorrecta';
      case 503:
        return 'Servicio no disponible';
      default:
        return 'Error del servidor: $statusCode';
    }
  }

  Future<void> setAuthToken(String token) async {
    _authToken = token;
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> loadAuthToken() async {
    _authToken = await _secureStorage.read(key: 'auth_token');
  }

  Future<void> clearAuthToken() async {
    _authToken = null;
    await _secureStorage.delete(key: 'auth_token');
  }

  Future<bool> validateIdempotencyKey(String key) async {
    final stored = await _secureStorage.read(key: 'idempotency_$key');
    return stored != null;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

// === ARCHIVO: lib/data/datasources/remote/account_remote_datasource.dart ===
import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/result.dart';
import '../../models/account_model.dart';
import '../api_service.dart';

abstract class AccountRemoteDataSource {
  Future<Result<AccountModel>> getAccountById(String accountId);
  Future<Result<AccountModel>> getAccountByNumber(String accountNumber);
  Future<Result<List<AccountModel>>> getAccountsByHolder(String holderId);
  Future<Result<AccountModel>> updateAccountBalance(
    String accountId,
    double newBalance,
  );
  Future<Result<bool>> validateAccountStatus(String accountId);
  Future<Result<List<String>>> getAllowedChannels(String accountId);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiService _apiService;

  AccountRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<AccountModel>> getAccountById(String accountId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId',
      );

      if (response.statusCode == 200 && response.data != null) {
        final account = AccountModel.fromJson(response.data!);
        return Result.success(account);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener la cuenta',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<AccountModel>> getAccountByNumber(String accountNumber) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        ApiConstants.accountsEndpoint,
        queryParameters: {'accountNumber': accountNumber},
      );

      if (response.statusCode == 200 && response.data != null) {
        final account = AccountModel.fromJson(response.data!);
        return Result.success(account);
      }

      return Result.failure(
        ApiException(
          message: 'Cuenta no encontrada',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<List<AccountModel>>> getAccountsByHolder(
    String holderId,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.holdersEndpoint}/$holderId/accounts',
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> accountsJson = response.data!['accounts'] ?? [];
        final accounts =
            accountsJson.map((json) => AccountModel.fromJson(json)).toList();
        return Result.success(accounts);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener las cuentas del titular',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<AccountModel>> updateAccountBalance(
    String accountId,
    double newBalance,
  ) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId/balance',
        data: {'balance': newBalance},
      );

      if (response.statusCode == 200 && response.data != null) {
        final account = AccountModel.fromJson(response.data!);
        return Result.success(account);
      }

      return Result.failure(
        ApiException(
          message: 'Error al actualizar el saldo',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<bool>> validateAccountStatus(String accountId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId/status',
      );

      if (response.statusCode == 200 && response.data != null) {
        final isActive = response.data!['isActive'] as bool? ?? false;
        return Result.success(isActive);
      }

      return Result.failure(
        ApiException(
          message: 'Error al validar el estado de la cuenta',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<List<String>>> getAllowedChannels(String accountId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId/channels',
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> channelsJson =
            response.data!['allowedChannels'] ?? [];
        final channels = channelsJson.cast<String>();
        return Result.success(channels);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener los canales permitidos',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}

// === ARCHIVO: lib/data/datasources/remote/transaction_remote_datasource.dart ===
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/result.dart';
import '../../models/transaction_model.dart';
import '../api_service.dart';

abstract class TransactionRemoteDataSource {
  Future<Result<TransactionModel>> createTransaction(
    TransactionModel transaction,
  );
  Future<Result<TransactionModel>> getTransactionById(String transactionId);
  Future<Result<List<TransactionModel>>> getTransactionsByAccount(
    String accountId, {
    int? limit,
    int? offset,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Result<TransactionModel>> updateTransactionStatus(
    String transactionId,
    String status,
  );
  Future<Result<bool>> validateTransactionIdempotency(
    String referenceNumber,
    String channel,
  );
  Future<Result<List<TransactionModel>>> getPendingTransactions(
    String accountId,
  );
  Future<Result<TransactionModel>> reverseTransaction(
    String transactionId,
    String reason,
  );
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final ApiService _apiService;
  final Uuid _uuid;

  TransactionRemoteDataSourceImpl({
    required ApiService apiService,
    Uuid? uuid,
  })  : _apiService = apiService,
        _uuid = uuid ?? const Uuid();

  @override
  Future<Result<TransactionModel>> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final idempotencyKey = transaction.referenceNumber ?? _uuid.v4();

      final isIdempotent = await validateTransactionIdempotency(
        idempotencyKey,
        'mobile',
      );

      if (isIdempotent.isSuccess && isIdempotent.data == true) {
        return Result.failure(
          ApiException(
            message: 'Transacción duplicada detectada',
            statusCode: 409,
          ),
        );
      }

      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConstants.transactionsEndpoint,
        data: transaction.toJson(),
        options: Options(
          headers: {'X-Idempotency-Key': idempotencyKey},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final createdTransaction = TransactionModel.fromJson(response.data!);
        return Result.success(createdTransaction);
      }

      return Result.failure(
        ApiException(
          message: 'Error al crear la transacción',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<TransactionModel>> getTransactionById(
    String transactionId,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/$transactionId',
      );

      if (response.statusCode == 200 && response.data != null) {
        final transaction = TransactionModel.fromJson(response.data!);
        return Result.success(transaction);
      }

      return Result.failure(
        ApiException(
          message: 'Transacción no encontrada',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getTransactionsByAccount(
    String accountId, {
    int? limit,
    int? offset,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'accountId': accountId,
      };

      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;
      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      final response = await _apiService.get<Map<String, dynamic>>(
        ApiConstants.transactionsEndpoint,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> transactionsJson =
            response.data!['transactions'] ?? [];
        final transactions = transactionsJson
            .map((json) => TransactionModel.fromJson(json))
            .toList();
        return Result.success(transactions);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener las transacciones',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<TransactionModel>> updateTransactionStatus(
    String transactionId,
    String status,
  ) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/$transactionId/status',
        data: {'status': status},
      );

      if (response.statusCode == 200 && response.data != null) {
        final transaction = TransactionModel.fromJson(response.data!);
        return Result.success(transaction);
      }

      return Result.failure(
        ApiException(
          message: 'Error al actualizar el estado de la transacción',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<bool>> validateTransactionIdempotency(
    String referenceNumber,
    String channel,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.idempotencyEndpoint}/validate',
        queryParameters: {
          'referenceNumber': referenceNumber,
          'channel': channel,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final isIdempotent = response.data!['isIdempotent'] as bool? ?? false;
        return Result.success(isIdempotent);
      }

      return Result.failure(
        ApiException(
          message: 'Error al validar idempotencia',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getPendingTransactions(
    String accountId,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/pending',
        queryParameters: {'accountId': accountId},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> transactionsJson =
            response.data!['transactions'] ?? [];
        final transactions = transactionsJson
            .map((json) => TransactionModel.fromJson(json))
            .toList();
        return Result.success(transactions);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener las transacciones pendientes',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<TransactionModel>> reverseTransaction(
    String transactionId,
    String reason,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/$transactionId/reverse',
        data: {'reason': reason},
      );

      if (response.statusCode == 200 && response.data != null) {
        final reversedTransaction = TransactionModel.fromJson(response.data!);
        return Result.success(reversedTransaction);
      }

      return Result.failure(
        ApiException(
          message: 'Error al revertir la transacción',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }
}

// === ARCHIVO: lib/core/design_patterns/singleton/secure_storage.dart ===
package mobile_banking_app.core.design_patterns.singleton;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorage {
  static SecureStorage? _instance;
  final FlutterSecureStorage _storage;
  final Uuid _uuid = const Uuid();
  
  SecureStorage._internal()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        );
  
  static SecureStorage get instance {
    _instance ??= SecureStorage._internal();
    return _instance!;
  }
  
  Future<void> saveCredentials(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  Future<String?> getCredentials(String key) async {
    return await _storage.read(key: key);
  }
  
  Future<void> deleteCredentials(String key) async {
    await _storage.delete(key: key);
  }
  
  Future<void> saveAuthToken(String token) async {
    await saveCredentials('auth_token', token);
    await saveCredentials('token_timestamp', DateTime.now().toIso8601String());
  }
  
  Future<String?> getAuthToken() async {
    final token = await getCredentials('auth_token');
    if (token == null) return null;
    
    final timestampStr = await getCredentials('token_timestamp');
    if (timestampStr != null) {
      final timestamp = DateTime.parse(timestampStr);
      final expiry = timestamp.add(const Duration(hours: 24));
      if (DateTime.now().isAfter(expiry)) {
        await deleteCredentials('auth_token');
        await deleteCredentials('token_timestamp');
        return null;
      }
    }
    return token;
  }
  
  Future<void> clearAllCredentials() async {
    await _storage.deleteAll();
  }
  
  Future<void> saveUserCredentials(String userId, String pin) async {
    final salt = _uuid.v4();
    final hashedPin = _hashPin(pin, salt);
    await saveCredentials('user_$userId_pin', hashedPin);
    await saveCredentials('user_$userId_salt', salt);
  }
  
  Future<bool> validateUserPin(String userId, String pin) async {
    final storedHash = await getCredentials('user_$userId_pin');
    final storedSalt = await getCredentials('user_$userId_salt');
    
    if (storedHash == null || storedSalt == null) return false;
    
    final inputHash = _hashPin(pin, storedSalt);
    return storedHash == inputHash;
  }
  
  String _hashPin(String pin, String salt) {
    var combined = '$salt$pin$salt';
    var hash = 0;
    for (var i = 0; i < combined.length; i++) {
      hash = ((hash << 5) - hash) + combined.codeUnitAt(i);
      hash = hash & 0xFFFFFFFF;
    }
    return hash.toRadixString(16);
  }
  
  Future<void> saveBiometricKey(String userId, String biometricData) async {
    await saveCredentials('biometric_$userId', biometricData);
  }
  
  Future<String?> getBiometricKey(String userId) async {
    return await getCredentials('biometric_$userId');
  }
  
  Future<bool> hasBiometricSetup(String userId) async {
    final key = await getBiometricKey(userId);
    return key != null && key.isNotEmpty;
  }
  
  Future<void> saveLastLogin(String userId) async {
    await saveCredentials('last_login_$userId', DateTime.now().toIso8601String());
  }
  
  Future<DateTime?> getLastLogin(String userId) async {
    final timestamp = await getCredentials('last_login_$userId');
    if (timestamp == null) return null;
    return DateTime.tryParse(timestamp);
  }
  
  Future<void> saveAccountCredentials(String accountId, String credentials) async {
    await saveCredentials('account_$accountId_credentials', credentials);
  }
  
  Future<String?> getAccountCredentials(String accountId) async {
    return await getCredentials('account_$accountId_credentials');
  }
}

// === ARCHIVO: lib/core/design_patterns/singleton/api_client.dart ===
package mobile_banking_app.core.design_patterns.singleton;

import 'package:dio/dio.dart';
import 'package:mobile_banking_app/core/constants/api_constants.dart';
import 'package:mobile_banking_app.core.design_patterns.singleton.secure_storage.dart';

class ApiClient {
  static ApiClient? _instance;
  late final Dio _dio;
  final SecureStorage _secureStorage = SecureStorage.instance;
  
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _setupInterceptors();
  }
  
  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['X-Request-ID'] = DateTime.now().millisecondsSinceEpoch.toString();
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
    
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print('[API_CLIENT] $obj'),
      ),
    );
  }
  
  Dio get dio => _dio;
  
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }
  
  void addCustomHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }
  
  void removeCustomHeader(String key) {
    _dio.options.headers.remove(key);
  }
  
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
  
  void setRequestTimeout(Duration timeout) {
    _dio.options.connectTimeout = timeout;
    _dio.options.receiveTimeout = timeout;
    _dio.options.sendTimeout = timeout;
  }
  
  void resetToDefaults() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _setupInterceptors();
  }
}

// === ARCHIVO: lib/core/design_patterns/factory/transaction_factory.dart ===
package mobile_banking_app.core.design_patterns.factory;

import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:uuid/uuid.dart';

class TransactionFactory {
  static final TransactionFactory _instance = TransactionFactory._internal();
  final Uuid _uuid = const Uuid();
  
  TransactionFactory._internal();
  
  static TransactionFactory get instance {
    return _instance;
  }
  
  Result<Transaction> createCreditTransaction({
    required String accountId,
    required double amount,
    required String description,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: TransactionType.credit,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createDebitTransaction({
    required String accountId,
    required double amount,
    required String description,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: TransactionType.debit,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createTransferTransaction({
    required String accountId,
    required double amount,
    required String description,
    required String relatedTransactionId,
    required TransactionType type,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      if (type != TransactionType.credit && type != TransactionType.debit) {
        return Result.failure(
          ArgumentError('Tipo de transacción inválido para transferencia'),
        );
      }
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: type,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        relatedTransactionId: relatedTransactionId,
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createPendingTransaction({
    required String accountId,
    required double amount,
    required TransactionType type,
    required String description,
    String? referenceNumber,
  }) {
    try {
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: type,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createReversedTransaction(Transaction originalTransaction) {
    try {
      final reversedType = originalTransaction.type == TransactionType.credit
          ? TransactionType.debit
          : TransactionType.credit;
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: originalTransaction.accountId,
        amount: originalTransaction.amount,
        type: reversedType,
        description: 'Reversión de: ${originalTransaction.description}',
        timestamp: DateTime.now(),
        status: TransactionStatus.reversed,
        referenceNumber: _generateReferenceNumber(),
        relatedTransactionId: originalTransaction.id,
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  String _generateReferenceNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uuidShort = _uuid.v4().substring(0, 8);
    return 'TXN-$timestamp-$uuidShort';
  }
  
  Transaction createFailedTransaction(Transaction originalTransaction) {
    return originalTransaction.copyWith(
      status: TransactionStatus.failed,
    );
  }
  
  Transaction createCompletedTransaction(Transaction pendingTransaction) {
    return pendingTransaction.copyWith(
      status: TransactionStatus.completed,
    );
  }
  
  bool isValidTransactionType(String type) {
    return type == 'credit' || type == 'debit';
  }
  
  TransactionType parseTransactionType(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return TransactionType.credit;
      case 'debit':
        return TransactionType.debit;
      default:
        throw ArgumentError('Tipo de transacción desconocido: $type');
    }
  }
  
  TransactionStatus parseTransactionStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return TransactionStatus.pending;
      case 'completed':
        return TransactionStatus.completed;
      case 'failed':
        return TransactionStatus.failed;
      case 'reversed':
        return TransactionStatus.reversed;
      default:
        throw ArgumentError('Estado de transacción desconocido: $status');
    }
  }
}

// === ARCHIVO: lib/core/design_patterns/factory/transfer_factory.dart ===
package mobile_banking_app.core.design_patterns.factory;

import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:uuid/uuid.dart';

class TransferFactory {
  static final TransferFactory _instance = TransferFactory._internal();
  final Uuid _uuid = const Uuid();
  
  TransferFactory._internal();
  
  static TransferFactory get instance {
    return _instance;
  }
  
  Result<TransferRequest> createInternalTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    bool requiresBiometric = false,
    String? referenceNumber,
  }) {
    try {
      if (fromAccountId == toAccountId) {
        return Result.failure(
          ArgumentError('No se puede transferir a la misma cuenta'),
        );
      }
      
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      if (!_isValidCurrency(currency)) {
        return Result.failure(
          ArgumentError('Moneda no soportada: $currency'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: description,
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createExternalTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    required String bankCode,
    required String bankName,
    bool requiresBiometric = true,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      if (amount > 10000) {
        return Result.failure(
          ArgumentError('Monto excede el límite para transferencias externas'),
        );
      }
      
      if (bankCode.isEmpty || bankName.isEmpty) {
        return Result.failure(
          ArgumentError('Código y nombre del banco son requeridos'),
        );
      }
      
      final fullDescription = '$description - Banco: $bankName ($bankCode)';
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: fullDescription,
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createScheduledTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    required DateTime scheduledDate,
    bool requiresBiometric = true,
    String? referenceNumber,
  }) {
    try {
      if (scheduledDate.isBefore(DateTime.now())) {
        return Result.failure(
          ArgumentError('La fecha programada debe ser futura'),
        );
      }
      
      if (scheduledDate.isAfter(DateTime.now().add(const Duration(days: 365)))) {
        return Result.failure(
          ArgumentError('No se puede programar más de un año ahead'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: 'Programada: $description',
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: scheduledDate,
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createRecurringTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    required int frequencyDays,
    required DateTime endDate,
    bool requiresBiometric = true,
    String? referenceNumber,
  }) {
    try {
      if (frequencyDays < 1 || frequencyDays > 90) {
        return Result.failure(
          ArgumentError('Frecuencia debe estar entre 1 y 90 días'),
        );
      }
      
      if (endDate.isBefore(DateTime.now())) {
        return Result.failure(
          ArgumentError('La fecha de fin debe ser futura'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: 'Recurrente ($frequencyDays días): $description',
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createBulkTransfer({
    required String fromAccountId,
    required List<Map<String, dynamic>> transfers,
    required String currency,
    required String channel,
    bool requiresBiometric = true,
  }) {
    try {
      if (transfers.isEmpty) {
        return Result.failure(
          ArgumentError('La lista de transferencias no puede estar vacía'),
        );
      }
      
      if (transfers.length > 50) {
        return Result.failure(
          ArgumentError('Máximo 50 transferencias por lote'),
        );
      }
      
      double totalAmount = 0;
      for (final t in transfers) {
        final amount = (t['amount'] as num).toDouble();
        if (amount <= 0) {
          return Result.failure(
            ArgumentError('Todos los montos deben ser mayores a cero'),
          );
        }
        totalAmount += amount;
      }
      
      if (totalAmount > 50000) {
        return Result.failure(
          ArgumentError('Monto total excede el límite de lote'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: 'BULK',
        amount: totalAmount,
        currency: currency,
        description: 'Transferencia masiva de ${transfers.length} operaciones',
        channel: channel,
        referenceNumber: _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  String _generateReferenceNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uuidShort = _uuid.v4().substring(0, 8);
    return 'TRF-$timestamp-$uuidShort';
  }
  
  bool _isValidCurrency(String currency) {
    const supportedCurrencies = ['USD', 'EUR', 'GBP', 'MXN', 'COP', 'PEN'];
    return supportedCurrencies.contains(currency.toUpperCase());
  }
  
  bool validateTransferLimit(double amount, String accountType) {
    const limits = {
      'standard': 5000.0,
      'premium': 25000.0,
      'business': 100000.0,
    };
    
    final limit = limits[accountType] ?? 5000.0;
    return amount <= limit;
  }
  
  String getTransferTypeDescription(TransferRequest transfer) {
    if (transfer.toAccountId == 'BULK') {
      return 'Transferencia Masiva';
    }
    if (transfer.description.contains('Programada')) {
      return 'Transferencia Programada';
    }
    if (transfer.description.contains('Recurrente')) {
      return 'Transferencia Recurrente';
    }
    return 'Transferencia Estándar';
  }
}

// === ARCHIVO: lib/core/design_patterns/observer/account_balance_observer.dart ===
import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

abstract class AccountBalanceObserver {
  void onBalanceChanged(Account account, double oldBalance, double newBalance);
  void onLowBalanceWarning(Account account, double threshold);
  void onHighValueTransaction(Account account, Transaction transaction);
}

class AccountBalanceObserverImpl implements AccountBalanceObserver {
  final List<void Function(Account, double, double)> _balanceChangeCallbacks = [];
  final List<void Function(Account, double)> _lowBalanceCallbacks = [];
  final List<void Function(Account, Transaction)> _highValueCallbacks = [];
  final double _lowBalanceThreshold;
  final double _highValueThreshold;

  AccountBalanceObserverImpl({
    double lowBalanceThreshold = 100.0,
    double highValueThreshold = 5000.0,
  })  : _lowBalanceThreshold = lowBalanceThreshold,
        _highValueThreshold = highValueThreshold;

  void registerBalanceChangeCallback(void Function(Account, double, double) callback) {
    _balanceChangeCallbacks.add(callback);
  }

  void registerLowBalanceCallback(void Function(Account, double) callback) {
    _lowBalanceCallbacks.add(callback);
  }

  void registerHighValueCallback(void Function(Account, Transaction) callback) {
    _highValueCallbacks.add(callback);
  }

  void unregisterBalanceChangeCallback(void Function(Account, double, double) callback) {
    _balanceChangeCallbacks.remove(callback);
  }

  void unregisterLowBalanceCallback(void Function(Account, double) callback) {
    _lowBalanceCallbacks.remove(callback);
  }

  void unregisterHighValueCallback(void Function(Account, Transaction) callback) {
    _highValueCallbacks.remove(callback);
  }

  @override
  void onBalanceChanged(Account account, double oldBalance, double newBalance) {
    for (final callback in _balanceChangeCallbacks) {
      callback(account, oldBalance, newBalance);
    }
    if (newBalance < _lowBalanceThreshold && oldBalance >= _lowBalanceThreshold) {
      onLowBalanceWarning(account, _lowBalanceThreshold);
    }
  }

  @override
  void onLowBalanceWarning(Account account, double threshold) {
    for (final callback in _lowBalanceCallbacks) {
      callback(account, threshold);
    }
  }

  @override
  void onHighValueTransaction(Account account, Transaction transaction) {
    if (transaction.amount.abs() >= _highValueThreshold) {
      for (final callback in _highValueCallbacks) {
        callback(account, transaction);
      }
    }
  }

  void notifyBalanceFromTransaction(Account account, Transaction transaction) {
    final oldBalance = account.balance;
    final result = account.applyTransaction(transaction);
    if (result is Success<Account>) {
      final newAccount = result.data;
      onBalanceChanged(newAccount, oldBalance, newAccount.balance);
      onHighValueTransaction(newAccount, transaction);
    }
  }

  void dispose() {
    _balanceChangeCallbacks.clear();
    _lowBalanceCallbacks.clear();
    _highValueCallbacks.clear();
  }
}

class CompositeAccountBalanceObserver implements AccountBalanceObserver {
  final List<AccountBalanceObserver> _observers = [];

  void addObserver(AccountBalanceObserver observer) {
    _observers.add(observer);
  }

  void removeObserver(AccountBalanceObserver observer) {
    _observers.remove(observer);
  }

  @override
  void onBalanceChanged(Account account, double oldBalance, double newBalance) {
    for (final observer in _observers) {
      observer.onBalanceChanged(account, oldBalance, newBalance);
    }
  }

  @override
  void onLowBalanceWarning(Account account, double threshold) {
    for (final observer in _observers) {
      observer.onLowBalanceWarning(account, threshold);
    }
  }

  @override
  void onHighValueTransaction(Account account, Transaction transaction) {
    for (final observer in _observers) {
      observer.onHighValueTransaction(account, transaction);
    }
  }
}

// === ARCHIVO: lib/core/design_patterns/observer/transaction_observer.dart ===
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

abstract class TransactionObserver {
  void onTransactionCreated(Transaction transaction);
  void onTransactionCompleted(Transaction transaction);
  void onTransactionFailed(Transaction transaction, String reason);
  void onTransactionReversed(Transaction transaction, String reversalReason);
}

class TransactionObserverImpl implements TransactionObserver {
  final List<void Function(Transaction)> _createdCallbacks = [];
  final List<void Function(Transaction)> _completedCallbacks = [];
  final List<void Function(Transaction, String)> _failedCallbacks = [];
  final List<void Function(Transaction, String)> _reversedCallbacks = [];
  final Map<String, Transaction> _transactionCache = {};

  void registerCreatedCallback(void Function(Transaction) callback) {
    _createdCallbacks.add(callback);
  }

  void registerCompletedCallback(void Function(Transaction) callback) {
    _completedCallbacks.add(callback);
  }

  void registerFailedCallback(void Function(Transaction, String) callback) {
    _failedCallbacks.add(callback);
  }

  void registerReversedCallback(void Function(Transaction, String) callback) {
    _reversedCallbacks.add(callback);
  }

  @override
  void onTransactionCreated(Transaction transaction) {
    _transactionCache[transaction.id] = transaction;
    for (final callback in _createdCallbacks) {
      callback(transaction);
    }
  }

  @override
  void onTransactionCompleted(Transaction transaction) {
    final cached = _transactionCache[transaction.id];
    if (cached != null) {
      final completed = cached.copyWith(status: TransactionStatus.completed);
      _transactionCache[transaction.id] = completed;
    }
    for (final callback in _completedCallbacks) {
      callback(transaction);
    }
  }

  @override
  void onTransactionFailed(Transaction transaction, String reason) {
    final cached = _transactionCache[transaction.id];
    if (cached != null) {
      final failed = cached.copyWith(status: TransactionStatus.failed);
      _transactionCache[transaction.id] = failed;
    }
    for (final callback in _failedCallbacks) {
      callback(transaction, reason);
    }
  }

  @override
  void onTransactionReversed(Transaction transaction, String reversalReason) {
    final cached = _transactionCache[transaction.id];
    if (cached != null) {
      final reversed = cached.copyWith(status: TransactionStatus.reversed);
      _transactionCache[transaction.id] = reversed;
    }
    for (final callback in _reversedCallbacks) {
      callback(transaction, reversalReason);
    }
  }

  Transaction? getTransactionById(String id) {
    return _transactionCache[id];
  }

  List<Transaction> getRecentTransactions({int limit = 10}) {
    final sorted = _transactionCache.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(limit).toList();
  }

  List<Transaction> getTransactionsByAccount(String accountId) {
    return _transactionCache.values
        .where((t) => t.accountId == accountId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void clearCache() {
    _transactionCache.clear();
  }

  void dispose() {
    _createdCallbacks.clear();
    _completedCallbacks.clear();
    _failedCallbacks.clear();
    _reversedCallbacks.clear();
    _transactionCache.clear();
  }
}

class TransactionAnalyticsObserver implements TransactionObserver {
  int _totalTransactions = 0;
  int _successfulTransactions = 0;
  int _failedTransactions = 0;
  double _totalAmount = 0.0;
  final Map<TransactionType, int> _countByType = {};

  @override
  void onTransactionCreated(Transaction transaction) {
    _totalTransactions++;
    _countByType[transaction.type] = (_countByType[transaction.type] ?? 0) + 1;
  }

  @override
  void onTransactionCompleted(Transaction transaction) {
    _successfulTransactions++;
    _totalAmount += transaction.amount;
  }

  @override
  void onTransactionFailed(Transaction transaction, String reason) {
    _failedTransactions++;
  }

  @override
  void onTransactionReversed(Transaction transaction, String reversalReason) {
    _successfulTransactions--;
    _totalAmount -= transaction.amount;
  }

  double get successRate {
    if (_totalTransactions == 0) return 0.0;
    return (_successfulTransactions / _totalTransactions) * 100;
  }

  double get averageTransactionAmount {
    if (_successfulTransactions == 0) return 0.0;
    return _totalAmount / _successfulTransactions;
  }

  int get totalTransactions => _totalTransactions;
  int get successfulTransactions => _successfulTransactions;
  int get failedTransactions => _failedTransactions;
  Map<TransactionType, int> get countByType => Map.unmodifiable(_countByType);
}

// === ARCHIVO: lib/core/design_patterns/strategy/authentication_strategy.dart ===
import 'package:mobile_banking_app/core/utils/result.dart';

abstract class AuthenticationStrategy {
  Future<Result<AuthenticationResult>> authenticate(AuthenticationContext context);
  bool supportsBiometric();
  String get strategyName;
  AuthenticationType get authenticationType;
}

class AuthenticationContext {
  final String userId;
  final String deviceId;
  final Map<String, dynamic> metadata;
  final DateTime timestamp;

  AuthenticationContext({
    required this.userId,
    required this.deviceId,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
  })  : metadata = metadata ?? {},
        timestamp = timestamp ?? DateTime.now();

  AuthenticationContext copyWith({
    String? userId,
    String? deviceId,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
  }) {
    return AuthenticationContext(
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      metadata: metadata ?? Map.from(this.metadata),
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class AuthenticationResult {
  final bool isAuthenticated;
  final String? userId;
  final String? sessionToken;
  final DateTime? expiresAt;
  final String? failureReason;
  final AuthenticationType authenticationType;

  AuthenticationResult({
    required this.isAuthenticated,
    this.userId,
    this.sessionToken,
    this.expiresAt,
    this.failureReason,
    required this.authenticationType,
  });

  factory AuthenticationResult.success({
    required String userId,
    required String sessionToken,
    required DateTime expiresAt,
    required AuthenticationType type,
  }) {
    return AuthenticationResult(
      isAuthenticated: true,
      userId: userId,
      sessionToken: sessionToken,
      expiresAt: expiresAt,
      authenticationType: type,
    );
  }

  factory AuthenticationResult.failure({
    required String reason,
    required AuthenticationType type,
  }) {
    return AuthenticationResult(
      isAuthenticated: false,
      failureReason: reason,
      authenticationType: type,
    );
  }
}

enum AuthenticationType {
  pin,
  biometric,
  otp,
  combined,
}

class AuthenticationStrategyContext {
  AuthenticationStrategy? _strategy;
  final List<AuthenticationStrategy> _availableStrategies = [];

  void setStrategy(AuthenticationStrategy strategy) {
    _strategy = strategy;
  }

  void registerStrategy(AuthenticationStrategy strategy) {
    _availableStrategies.add(strategy);
  }

  void unregisterStrategy(AuthenticationStrategy strategy) {
    _availableStrategies.remove(strategy);
  }

  Future<Result<AuthenticationResult>> authenticate(AuthenticationContext context) async {
    if (_strategy == null) {
      return Result.failure(AuthenticationException('No authentication strategy set'));
    }
    return _strategy!.authenticate(context);
  }

  AuthenticationStrategy? get currentStrategy => _strategy;

  List<AuthenticationStrategy> get availableStrategies => List.unmodifiable(_availableStrategies);

  AuthenticationStrategy? getStrategyByType(AuthenticationType type) {
    try {
      return _availableStrategies.firstWhere((s) => s.authenticationType == type);
    } catch (_) {
      return null;
    }
  }

  bool isStrategyAvailable(AuthenticationType type) {
    return _availableStrategies.any((s) => s.authenticationType == type);
  }

  void selectOptimalStrategy(AuthenticationContext context) {
    if (_availableStrategies.isEmpty) return;

    for (final strategy in _availableStrategies) {
      if (strategy.supportsBiometric() && _isBiometricAvailable(context)) {
        setStrategy(strategy);
        return;
      }
    }

    if (_availableStrategies.isNotEmpty) {
      setStrategy(_availableStrategies.first);
    }
  }

  bool _isBiometricAvailable(AuthenticationContext context) {
    final biometricMetadata = context.metadata['biometricAvailable'];
    return biometricMetadata == true;
  }
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

// === ARCHIVO: lib/core/design_patterns/strategy/biometric_auth_strategy.dart ===
import 'package:mobile_banking_app/core/design_patterns/strategy/authentication_strategy.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class BiometricAuthStrategy implements AuthenticationStrategy {
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;
  final BiometricType _preferredBiometricType;
  final bool _allowLegacyFallback;

  BiometricAuthStrategy({
    LocalAuthentication? localAuth,
    FlutterSecureStorage? secureStorage,
    BiometricType preferredBiometricType = BiometricType.fingerprint,
    bool allowLegacyFallback = true,
  })  : _localAuth = localAuth ?? LocalAuthentication(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _preferredBiometricType = preferredBiometricType,
        _allowLegacyFallback = allowLegacyFallback;

  @override
  String get strategyName => 'BiometricAuthentication';

  @override
  AuthenticationType get authenticationType => AuthenticationType.biometric;

  @override
  bool supportsBiometric() => true;

  @override
  Future<Result<AuthenticationResult>> authenticate(AuthenticationContext context) async {
    try {
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        return Result.failure(BiometricNotAvailableException(
          'Biometric authentication is not available on this device',
        ));
      }

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return Result.failure(BiometricNotEnrolledException(
          'No biometric credentials enrolled on this device',
        ));
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access your banking app',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: !_allowLegacyFallback,
          useErrorDialogs: true,
        ),
      );

      if (authenticated) {
        final sessionToken = await _generateSessionToken(context.userId);
        final expiresAt = DateTime.now().add(const Duration(hours: 24));

        await _secureStorage.write(
          key: 'biometric_session_${context.userId}',
          value: sessionToken,
        );

        return Result.success(AuthenticationResult.success(
          userId: context.userId,
          sessionToken: sessionToken,
          expiresAt: expiresAt,
          type: AuthenticationType.biometric,
        ));
      } else {
        return Result.failure(AuthenticationResult.failure(
          reason: 'Biometric authentication failed',
          type: AuthenticationType.biometric,
        ));
      }
    } on BiometricNotAvailableException catch (e) {
      return Result.failure(e);
    } on BiometricNotEnrolledException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(BiometricAuthenticationException(
        'Unexpected error during biometric authentication: ${e.toString()}',
      ));
    }
  }

  Future<String> _generateSessionToken(String userId) async {
    final uuid = const Uuid();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${userId}_${uuid.v4()}_$timestamp';
  }

  Future<bool> validateExistingSession(String userId, String sessionToken) async {
    final storedToken = await _secureStorage.read(key: 'biometric_session_$userId');
    return storedToken == sessionToken;
  }

  Future<void> revokeSession(String userId) async {
    await _secureStorage.delete(key: 'biometric_session_$userId');
  }

  Future<List<BiometricType>> getAvailableBiometricTypes() async {
    return await _localAuth.getAvailableBiometrics();
  }

  Future<bool> isDeviceSupported() async {
    return await _localAuth.isDeviceSupported();
  }

  Future<bool> canCheckBiometrics() async {
    return await _localAuth.canCheckBiometrics;
  }
}

class BiometricNotAvailableException implements Exception {
  final String message;
  BiometricNotAvailableException(this.message);

  @override
  String toString() => 'BiometricNotAvailableException: $message';
}

class BiometricNotEnrolledException implements Exception {
  final String message;
  BiometricNotEnrolledException(this.message);

  @override
  String toString() => 'BiometricNotEnrolledException: $message';
}

class BiometricAuthenticationException implements Exception {
  final String message;
  BiometricAuthenticationException(this.message);

  @override
  String toString() => 'BiometricAuthenticationException: $message';
}

enum BiometricType {
  fingerprint,
  face,
  iris,
}

// === ARCHIVO: lib/core/design_patterns/strategy/pin_auth_strategy.dart ===
import 'package:mobile_banking_app/core/design_patterns/strategy/authentication_strategy.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class PinAuthStrategy implements AuthenticationStrategy {
  static const String _pinKey = 'user_pin_hash';
  static const String _failedAttemptsKey = 'failed_pin_attempts';
  static const int _maxAttempts = 3;
  static const Duration _lockoutDuration = Duration(minutes: 5);

  final FlutterSecureStorage _secureStorage;
  DateTime? _lockoutUntil;

  PinAuthStrategy({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? GetIt.instance<FlutterSecureStorage>();

  @override
  Future<Result<Account>> authenticate(Account account) async {
    if (_isLockedOut()) {
      final remainingTime = _lockoutUntil!.difference(DateTime.now());
      return Result.failure(
        'Cuenta bloqueada. Intenta de nuevo en ${remainingTime.inMinutes} minutos',
      );
    }

    return Result.success(account);
  }

  @override
  Future<bool> validateCredentials(String pin) async {
    if (_isLockedOut()) {
      return false;
    }

    final storedHash = await _secureStorage.read(key: _pinKey);
    if (storedHash == null) {
      return false;
    }

    final isValid = _verifyPin(pin, storedHash);
    
    if (!isValid) {
      await _incrementFailedAttempts();
    } else {
      await _resetFailedAttempts();
    }

    return isValid;
  }

  @override
  Future<Result<void>> setupAuthentication(Account account) async {
    try {
      final pin = _generateInitialPin();
      final hash = _hashPin(pin);
      await _secureStorage.write(key: _pinKey, value: hash);
      await _resetFailedAttempts();
      return Result.success(null);
    } catch (e) {
      return Result.failure('Error al configurar PIN: $e');
    }
  }

  @override
  Future<Result<void>> changePin(String currentPin, String newPin) async {
    final isValid = await validateCredentials(currentPin);
    if (!isValid) {
      return Result.failure('PIN actual incorrecto');
    }

    final newHash = _hashPin(newPin);
    await _secureStorage.write(key: _pinKey, value: newHash);
    return Result.success(null);
  }

  @override
  bool get requiresBiometric => false;

  @override
  String get authType => 'PIN';

  bool _isLockedOut() {
    if (_lockoutUntil == null) return false;
    if (DateTime.now().isAfter(_lockoutUntil!)) {
      _lockoutUntil = null;
      return false;
    }
    return true;
  }

  Future<void> _incrementFailedAttempts() async {
    final currentAttempts = await _secureStorage.read(key: _failedAttemptsKey);
    final attempts = int.tryParse(currentAttempts ?? '0') ?? 0;
    final newAttempts = attempts + 1;
    await _secureStorage.write(key: _failedAttemptsKey, value: newAttempts.toString());

    if (newAttempts >= _maxAttempts) {
      _lockoutUntil = DateTime.now().add(_lockoutDuration);
    }
  }

  Future<void> _resetFailedAttempts() async {
    await _secureStorage.delete(key: _failedAttemptsKey);
    _lockoutUntil = null;
  }

  String _hashPin(String pin) {
    var hash = 0;
    for (var i = 0; i < pin.length; i++) {
      hash = ((hash << 5) - hash) + pin.codeUnitAt(i);
      hash = hash & 0xFFFFFFFF;
    }
    return hash.toRadixString(16);
  }

  bool _verifyPin(String pin, String storedHash) {
    return _hashPin(pin) == storedHash;
  }

  String _generateInitialPin() {
    return '1234';
  }

  Future<bool> hasPinConfigured() async {
    final storedHash = await _secureStorage.read(key: _pinKey);
    return storedHash != null;
  }

  Future<int> getFailedAttempts() async {
    final attempts = await _secureStorage.read(key: _failedAttemptsKey);
    return int.tryParse(attempts ?? '0') ?? 0;
  }
}

// === ARCHIVO: lib/core/design_patterns/command/transfer_command.dart ===
import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:mobile_banking_app/domain/usecases/transfer_funds_usecase.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:equatable/equatable.dart';

enum TransferCommandStatus {
  pending,
  executing,
  completed,
  failed,
  cancelled,
}

class TransferCommandResult {
  final Transaction? transaction;
  final String? errorMessage;
  final TransferCommandStatus status;
  final Duration executionTime;

  TransferCommandResult({
    this.transaction,
    this.errorMessage,
    required this.status,
    required this.executionTime,
  });

  bool get isSuccessful => status == TransferCommandStatus.completed && transaction != null;
}

abstract class TransferCommand extends Equatable {
  final String id;
  final TransferRequest request;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final TransferCommandStatus status;

  TransferCommand({
    required this.id,
    required this.request,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.status = TransferCommandStatus.pending,
  });

  Future<TransferCommandResult> execute(TransferFundsUseCase transferFundsUseCase);

  TransferCommand copyWith({
    String? id,
    TransferRequest? request,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    TransferCommandStatus? status,
  });

  @override
  List<Object?> get props => [id, request, createdAt, startedAt, completedAt, status];
}

class ExecuteTransferCommand extends TransferCommand {
  final bool checkIdempotency;
  final bool verifyBalance;
  final int maxRetries;

  ExecuteTransferCommand({
    required super.id,
    required super.request,
    required super.createdAt,
    super.startedAt,
    super.completedAt,
    super.status,
    this.checkIdempotency = true,
    this.verifyBalance = true,
    this.maxRetries = 3,
  });

  @override
  Future<TransferCommandResult> execute(TransferFundsUseCase transferFundsUseCase) async {
    final startTime = DateTime.now();
    
    try {
      final updatedThis = copyWith(
        startedAt: DateTime.now(),
        status: TransferCommandStatus.executing,
      );

      final result = await transferFundsUseCase.execute(
        fromAccountId: request.fromAccountId,
        toAccountId: request.toAccountId,
        amount: request.amount,
        description: request.description,
        channel: request.channel,
        referenceNumber: request.referenceNumber,
      );

      final endTime = DateTime.now();
      final executionTime = endTime.difference(startTime);

      if (result.isSuccess) {
        return TransferCommandResult(
          transaction: result.data,
          status: TransferCommandStatus.completed,
          executionTime: executionTime,
        );
      } else {
        return TransferCommandResult(
          errorMessage: result.error,
          status: TransferCommandStatus.failed,
          executionTime: executionTime,
        );
      }
    } catch (e) {
      final endTime = DateTime.now();
      return TransferCommandResult(
        errorMessage: 'Error executing transfer: $e',
        status: TransferCommandStatus.failed,
        executionTime: endTime.difference(startTime),
      );
    }
  }

  @override
  ExecuteTransferCommand copyWith({
    String? id,
    TransferRequest? request,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    TransferCommandStatus? status,
  }) {
    return ExecuteTransferCommand(
      id: id ?? this.id,
      request: request ?? this.request,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      checkIdempotency: checkIdempotency,
      verifyBalance: verifyBalance,
      maxRetries: maxRetries,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        checkIdempotency,
        verifyBalance,
        maxRetries,
      ];
}

class CancelTransferCommand extends TransferCommand {
  ExecuteTransferCommand? _targetCommand;

  CancelTransferCommand({
    required super.id,
    required super.request,
    required super.createdAt,
    ExecuteTransferCommand? targetCommand,
  }) : _targetCommand = targetCommand;

  @override
  Future<TransferCommandResult> execute(TransferFundsUseCase transferFundsUseCase) async {
    final startTime = DateTime.now();

    if (_targetCommand != null && 
        _targetCommand!.status == TransferCommandStatus.pending) {
      _targetCommand = _targetCommand!.copyWith(
        status: TransferCommandStatus.cancelled,
        completedAt: DateTime.now(),
      );

      return TransferCommandResult(
        status: TransferCommandStatus.completed,
        executionTime: DateTime.now().difference(startTime),
      );
    }

    return TransferCommandResult(
      errorMessage: 'No se puede cancelar: comando no encontrado o ya en ejecución',
      status: TransferCommandStatus.failed,
      executionTime: DateTime.now().difference(startTime),
    );
  }

  @override
  CancelTransferCommand copyWith({
    String? id,
    TransferRequest? request,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    TransferCommandStatus? status,
  }) {
    return CancelTransferCommand(
      id: id ?? this.id,
      request: request ?? this.request,
      createdAt: createdAt ?? this.createdAt,
      targetCommand: _targetCommand,
    );
  }
}

// === ARCHIVO: lib/core/design_patterns/command/command_queue.dart ===
import 'dart:async';
import 'package:mobile_banking_app/core/design_patterns/command/transfer_command.dart';
import 'package:mobile_banking_app/domain/usecases/transfer_funds_usecase.dart';
import 'package:equatable/equatable.dart';

enum CommandQueueStatus {
  idle,
  processing,
  paused,
  stopped,
}

class CommandQueueStats {
  final int totalCommands;
  final int pendingCommands;
  final int completedCommands;
  final int failedCommands;
  final Duration totalProcessingTime;

  CommandQueueStats({
    required this.totalCommands,
    required this.pendingCommands,
    required this.completedCommands,
    required this.failedCommands,
    required this.totalProcessingTime,
  });
}

class CommandQueueEvent {
  final String commandId;
  final TransferCommandStatus previousStatus;
  final TransferCommandStatus newStatus;
  final DateTime timestamp;
  final String? errorMessage;

  CommandQueueEvent({
    required this.commandId,
    required this.previousStatus,
    required this.newStatus,
    required this.timestamp,
    this.errorMessage,
  });
}

typedef CommandQueueListener = void Function(CommandQueueEvent event);

class CommandQueue extends Equatable {
  final String id;
  final int maxConcurrent;
  final Duration commandTimeout;
  final bool autoRetry;
  final int maxRetries;

  final List<TransferCommand> _commands = [];
  final List<TransferCommand> _completedCommands = [];
  final List<TransferCommand> _failedCommands = [];
  final Map<String, TransferCommandResult> _results = {};
  final List<CommandQueueListener> _listeners = [];
  
  CommandQueueStatus _status = CommandQueueStatus.idle;
  int _runningCount = 0;
  Duration _totalProcessingTime = Duration.zero;
  TransferFundsUseCase? _transferFundsUseCase;

  CommandQueue({
    required this.id,
    this.maxConcurrent = 3,
    this.commandTimeout = const Duration(seconds: 30),
    this.autoRetry = true,
    this.maxRetries = 3,
  });

  CommandQueueStatus get status => _status;
  List<TransferCommand> get pendingCommands => List.unmodifiable(_commands);
  List<TransferCommand> get completedCommands => List.unmodifiable(_completedCommands);
  List<TransferCommand> get failedCommands => List.unmodifiable(_failedCommands);
  int get pendingCount => _commands.length;
  int get runningCount => _runningCount;

  void setTransferFundsUseCase(TransferFundsUseCase useCase) {
    _transferFundsUseCase = useCase;
  }

  void addListener(CommandQueueListener listener) {
    _listeners.add(listener);
  }

  void removeListener(CommandQueueListener listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(CommandQueueEvent event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }

  Future<void> enqueue(TransferCommand command) async {
    _commands.add(command);
    _notifyListeners(CommandQueueEvent(
      commandId: command.id,
      previousStatus: TransferCommandStatus.pending,
      newStatus: command.status,
      timestamp: DateTime.now(),
    ));

    if (_status == CommandQueueStatus.idle) {
      await _processQueue();
    }
  }

  Future<void> enqueueAll(List<TransferCommand> commands) async {
    _commands.addAll(commands);
    
    if (_status == CommandQueueStatus.idle) {
      await _processQueue();
    }
  }

  Future<void> pause() async {
    _status = CommandQueueStatus.paused;
  }

  Future<void> resume() async {
    if (_status == CommandQueueStatus.paused) {
      _status = CommandQueueStatus.idle;
      await _processQueue();
    }
  }

  Future<void> stop() async {
    _status = CommandQueueStatus.stopped;
  }

  Future<void> clear() async {
    _commands.clear();
    _completedCommands.clear();
    _failedCommands.clear();
    _results.clear();
  }

  CommandQueueStats getStats() {
    return CommandQueueStats(
      totalCommands: _completedCommands.length + _failedCommands.length + _commands.length,
      pendingCommands: _commands.length,
      completedCommands: _completedCommands.length,
      failedCommands: _failedCommands.length,
      totalProcessingTime: _totalProcessingTime,
    );
  }

  TransferCommandResult? getResult(String commandId) {
    return _results[commandId];
  }

  Future<void> _processQueue() async {
    if (_transferFundsUseCase == null) {
      throw StateError('TransferFundsUseCase not set. Call setTransferFundsUseCase first.');
    }

    _status = CommandQueueStatus.processing;

    while (_commands.isNotEmpty && _status != CommandQueueStatus.stopped) {
      if (_status == CommandQueueStatus.paused) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }

      if (_runningCount >= maxConcurrent) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }

      final command = _commands.removeAt(0);
      _runningCount++;
      _executeCommand(command);
    }

    if (_commands.isEmpty) {
      _status = CommandQueueStatus.idle;
    }
  }

  Future<void> _executeCommand(TransferCommand command) async {
    final previousStatus = command.status;
    
    try {
      final result = await _executeWithTimeout(command);
      _results[command.id] = result;

      if (result.isSuccessful) {
        _completedCommands.add(command.copyWith(
          status: TransferCommandStatus.completed,
          completedAt: DateTime.now(),
        ));
        _notifyListeners(CommandQueueEvent(
          commandId: command.id,
          previousStatus: previousStatus,
          newStatus: TransferCommandStatus.completed,
          timestamp: DateTime.now(),
        ));
      } else {
        _failedCommands.add(command.copyWith(
          status: TransferCommandStatus.failed,
          completedAt: DateTime.now(),
        ));
        _notifyListeners(CommandQueueEvent(
          commandId: command.id,
          previousStatus: previousStatus,
          newStatus: TransferCommandStatus.failed,
          timestamp: DateTime.now(),
          errorMessage: result.errorMessage,
        ));

        if (autoRetry && command is ExecuteTransferCommand) {
          await _retryCommand(command);
        }
      }

      _totalProcessingTime += result.executionTime;
    } catch (e) {
      _failedCommands.add(command.copyWith(
        status: TransferCommandStatus.failed,
        completedAt: DateTime.now(),
      ));
      _notifyListeners(CommandQueueEvent(
        commandId: command.id,
        previousStatus: previousStatus,
        newStatus: TransferCommandStatus.failed,
        timestamp: DateTime.now(),
        errorMessage: e.toString(),
      ));
    } finally {
      _runningCount--;
    }
  }

  Future<TransferCommandResult> _executeWithTimeout(TransferCommand command) async {
    final completer = Completer<TransferCommandResult>();

    final timeout = Timer(commandTimeout, () {
      if (!completer.isCompleted) {
        completer.complete(TransferCommandResult(
          errorMessage: 'Command timed out after ${commandTimeout.inSeconds} seconds',
          status: TransferCommandStatus.failed,
          executionTime: commandTimeout,
        ));
      }
    });

    try {
      final result = await command.execute(_transferFundsUseCase!);
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(TransferCommandResult(
          errorMessage: e.toString(),
          status: TransferCommandStatus.failed,
          executionTime: Duration.zero,
        ));
      }
    } finally {
      timeout.cancel();
    }

    return completer.future;
  }

  Future<void> _retryCommand(ExecuteTransferCommand command) async {
    if (command.maxRetries > 0) {
      final retryCommand = ExecuteTransferCommand(
        id: '${command.id}_retry_${DateTime.now().millisecondsSinceEpoch}',
        request: command.request,
        createdAt: DateTime.now(),
        maxRetries: command.maxRetries - 1,
        checkIdempotency: command.checkIdempotency,
        verifyBalance: command.verifyBalance,
      );

      await Future.delayed(const Duration(seconds: 1));
      await enqueue(retryCommand);
    }
  }

  @override
  List<Object?> get props => [
        id,
        maxConcurrent,
        commandTimeout,
        autoRetry,
        maxRetries,
        _status,
        _runningCount,
      ];
}

// === ARCHIVO: lib/core/constants/api_constants.dart ===
class ApiConstants {
  static const String baseUrl = 'https://api.bancomovil.com/v1';
  static const String apiVersion = 'v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static const String accountsEndpoint = '/accounts';
  static const String transactionsEndpoint = '/transactions';
  static const String transferEndpoint = '/transfer';
  static const String balanceEndpoint = '/balance';
  static const String historyEndpoint = '/history';
  static const String authEndpoint = '/auth';
  static const String biometricEndpoint = '/auth/biometric';
  static const String pinEndpoint = '/auth/pin';

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-API-Version': apiVersion,
    'X-Client-Version': '1.0.0',
    'X-Platform': 'mobile',
  };

  static const List<int> successStatusCodes = [200, 201, 202, 204];
  static const int unauthorizedCode = 401;
  static const int forbiddenCode = 403;
  static const int notFoundCode = 404;
  static const int tooManyRequestsCode = 429;
  static const int serverErrorCode = 500;

  static const double minTransferAmount = 0.01;
  static const double maxTransferAmount = 100000.00;
  static const String defaultCurrency = 'USD';
  static const int maxDescriptionLength = 200;
  static const int maxReferenceNumberLength = 50;

  static const List<String> supportedCurrencies = ['USD', 'EUR', 'GBP', 'MXN', 'COP'];
  static const List<String> supportedChannels = ['mobile', 'web', 'atm', 'branch'];

  static const Map<String, String> channelDisplayNames = {
    'mobile': 'Aplicación Móvil',
    'web': 'Portal Web',
    'atm': 'Cajero Automático',
    'branch': 'Sucursal',
  };

  static const Map<String, String> errorMessages = {
    'network_error': 'Error de conexión. Verifica tu conexión a internet.',
    'timeout_error': 'La solicitud tardó demasiado. Intenta de nuevo.',
    'server_error': 'Error del servidor. Intenta más tarde.',
    'unauthorized': 'Sesión expirada. Inicia sesión nuevamente.',
    'insufficient_funds': 'Saldo insuficiente para esta operación.',
    'invalid_account': 'La cuenta destinataria no es válida.',
    'duplicate_transaction': 'Esta transacción ya fue procesada.',
    'limit_exceeded': 'Has excedido el límite de transferencia.',
  };

  static String getErrorMessage(String errorCode) {
    return errorMessages[errorCode] ?? 'Ocurrió un error inesperado.';
  }

  static bool isRetryableError(int statusCode) {
    return statusCode == 429 || 
           (statusCode >= 500 && statusCode < 600);
  }

  static bool isAuthError(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }
}

class CacheConstants {
  static const Duration accountCacheDuration = Duration(minutes: 5);
  static const Duration balanceCacheDuration = Duration(seconds: 30);
  static const Duration transactionCacheDuration = Duration(minutes: 2);
  static const int maxCacheSize = 100;
  static const String accountCacheKey = 'cached_accounts';
  static const String balanceCacheKey = 'cached_balance';
  static const String transactionCacheKey = 'cached_transactions';
}

class ValidationConstants {
  static const int minPinLength = 4;
  static const int maxPinLength = 6;
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static const RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
  static const RegExp accountNumberRegex = RegExp(r'^\d{10,20}$');
}

// === ARCHIVO: lib/core/constants/app_constants.dart ===
library;

class AppConstants {
  AppConstants._();

  static const String appName = 'Mobile Banking App';
  static const String appVersion = '1.0.0';

  static const int defaultTimeoutSeconds = 30;
  static const int balanceQueryTimeoutSeconds = 2;
  static const int transferTimeoutSeconds = 60;

  static const double maxTransferAmount = 50000.0;
  static const double minTransferAmount = 0.01;
  static const double defaultMinBalance = 100.0;

  static const int maxTransactionHistoryDays = 90;
  static const int maxTransactionsPerPage = 50;
  static const int transactionCacheValidityMinutes = 5;

  static const int maxPinAttempts = 3;
  static const int lockoutDurationMinutes = 15;
  static const int sessionTimeoutMinutes = 5;

  static const String defaultCurrency = 'USD';
  static const List<String> supportedCurrencies = ['USD', 'EUR', 'GBP', 'MXN'];

  static const List<String> allowedChannels = [
    'mobile_app',
    'web',
    'atm',
    'branch',
    'api',
  ];

  static const String defaultChannel = 'mobile_app';
  static const String biometricChannel = 'biometric';

  static const int retryAttempts = 3;
  static const int retryDelayMilliseconds = 1000;

  static const String apiBaseUrl = 'https://api.bank.example.com/v1';
  static const String apiHealthEndpoint = '/health';
  static const String apiAccountsEndpoint = '/accounts';
  static const String apiTransactionsEndpoint = '/transactions';
  static const String apiTransferEndpoint = '/transfers';
  static const String apiAuthEndpoint = '/auth';

  static const String secureStorageKeyPin = 'user_pin_hash';
  static const String secureStorageKeyBiometricEnabled = 'biometric_enabled';
  static const String secureStorageKeySessionToken = 'session_token';
  static const String secureStorageKeyLastSync = 'last_sync_timestamp';
  static const String secureStorageKeyUserId = 'user_id';

  static const String errorNetwork = 'Error de conexión. Verifica tu conexión a internet.';
  static const String errorTimeout = 'La operación tardó demasiado. Intenta de nuevo.';
  static const String errorServer = 'Error del servidor. Intenta más tarde.';
  static const String errorInvalidAmount = 'Monto inválido. Ingresa un valor entre 0.01 y 50000.00';
  static const String errorInsufficientFunds = 'Saldo insuficiente para esta operación.';
  static const String errorAccountNotFound = 'Cuenta no encontrada.';
  static const String errorBiometricNotAvailable = 'Biometría no disponible en este dispositivo.';
  static const String errorBiometricFailed = 'Autenticación biométrica fallida.';
  static const String errorPinLocked = 'Demasiados intentos. Cuenta bloqueada por 15 minutos.';
  static const String errorSessionExpired = 'Sesión expirada. Inicia sesión nuevamente.';

  static const String successTransfer = 'Transferencia realizada exitosamente.';
  static const String successBalanceUpdate = 'Saldo actualizado correctamente.';

  static const double availabilityTarget = 99.9;
  static const int maxLatencyMs = 2000;
}

class StorageKeys {
  StorageKeys._();

  static const String pinHash = 'pin_hash';
  static const String biometricEnabled = 'biometric_enabled';
  static const String sessionToken = 'session_token';
  static const String lastSync = 'last_sync';
  static const String userId = 'user_id';
  static const String accountCache = 'account_cache';
  static const String transactionCache = 'transaction_cache';
}

class ApiEndpoints {
  ApiEndpoints._();

  static const String health = '/health';
  static const String accounts = '/accounts';
  static const String accountById = '/accounts/{id}';
  static const String accountBalance = '/accounts/{id}/balance';
  static const String transactions = '/transactions';
  static const String transactionById = '/transactions/{id}';
  static const String transactionHistory = '/accounts/{id}/transactions';
  static const String transfers = '/transfers';
  static const String transferById = '/transfers/{id}';
  static const String authLogin = '/auth/login';
  static const String authVerify = '/auth/verify';
  static const String authBiometric = '/auth/biometric';
}

class CacheConfig {
  CacheConfig._();

  static const int accountCacheMinutes = 5;
  static const int balanceCacheSeconds = 30;
  static const int transactionCacheMinutes = 3;
  static const int maxCacheEntries = 100;
}

class ValidationRules {
  ValidationRules._();

  static const int minPinLength = 4;
  static const int maxPinLength = 6;
  static const int accountNumberLength = 10;
  static const int minDescriptionLength = 1;
  static const int maxDescriptionLength = 200;
  static final RegExp accountNumberPattern = RegExp(r'^[0-9]{10}$');
  static final RegExp amountPattern = RegExp(r'^\d+(\.\d{1,2})?$');
}

// === ARCHIVO: lib/core/utils/result.dart ===
library;

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => this is Success<T> ? (this as Success<T>).value : null;
  AppException? get error => this is Failure<T> ? (this as Failure<T>).exception : null;

  R when<R>({
    required R Function(T value) success,
    required R Function(AppException exception) failure,
  }) {
    return switch (this) {
      Success<T>(:final value) => success(value),
      Failure<T>(:final exception) => failure(exception),
    };
  }

  R? whenOrNull<R>({
    R Function(T value)? success,
    R Function(AppException exception)? failure,
  }) {
    return switch (this) {
      Success<T>(:final value) => success?.call(value),
      Failure<T>(:final exception) => failure?.call(exception),
    };
  }

  Result<R> map<R>(R Function(T value) mapper) {
    return switch (this) {
      Success<T>(:final value) => Success(mapper(value)),
      Failure<T>(:final exception) => Failure(exception),
    };
  }

  Result<R> flatMap<R>(Result<R> Function(T value) mapper) {
    return switch (this) {
      Success<T>(:final value) => mapper(value),
      Failure<T>(:final exception) => Failure(exception),
    };
  }

  T getOrElse(T defaultValue) {
    return switch (this) {
      Success<T>(:final value) => value,
      Failure<T>() => defaultValue,
    };
  }

  T getOrThrow() {
    return switch (this) {
      Success<T>(:final value) => value,
      Failure<T>(:final exception) => throw exception,
    };
  }
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

final class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;

  @override
  String toString() => 'Failure($exception)';
}

sealed class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

final class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.statusCode,
  });

  @override
  String toString() => 'NetworkException: $message (status: $statusCode)';
}

final class ServerException extends AppException {
  final int statusCode;

  const ServerException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    required this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

final class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() => 'CacheException: $message';
}

final class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.fieldErrors,
  });

  @override
  String toString() => 'ValidationException: $message';
}

final class AuthenticationException extends AppException {
  final bool isLocked;
  final DateTime? lockedUntil;

  const AuthenticationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.isLocked = false,
    this.lockedUntil,
  });

  @override
  String toString() => 'AuthenticationException: $message (locked: $isLocked)';
}

final class BiometricException extends AppException {
  final BiometricErrorType errorType;

  const BiometricException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    required this.errorType,
  });

  @override
  String toString() => 'BiometricException: $message (type: $errorType)';
}

enum BiometricErrorType {
  notAvailable,
  notEnrolled,
  lockout,
  failed,
  cancelled,
}

final class TimeoutException extends AppException {
  final Duration timeout;

  const TimeoutException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    required this.timeout,
  });

  @override
  String toString() => 'TimeoutException: $message (timeout: $timeout)';
}

final class BusinessException extends AppException {
  final String? businessCode;

  const BusinessException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.businessCode,
  });

  @override
  String toString() => 'BusinessException: $message (code: $businessCode)';
}

extension ResultExtensions<T> on Result<T> {
  Result<R> then<R>(R Function(T) action) {
    return map(action);
  }

  Future<Result<R>> thenAsync<R>(Future<R> Function(T) action) async {
    return map((value) => action(value));
  }

  Future<Result<R>> flatMapAsync<R>(Future<Result<R>> Function(T) action) async {
    return switch (this) {
      Success<T>(:final value) => await action(value),
      Failure<T>(:final exception) => Failure(exception),
    };
  }
}

// === ARCHIVO: android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.USE_BIOMETRIC" />
    <uses-permission android:name="android.permission.USE_FINGERPRINT" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    
    <application
        android:label="Mobile Banking App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:allowBackup="false"
        android:fullBackupContent="false"
        android:hardwareAccelerated="true"
        android:largeHeap="true"
        android:networkSecurityConfig="@xml/network_security_config"
        android:theme="@style/LaunchTheme"
        android:usesCleartextTraffic="false">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
            
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
        
    </application>
    
    <queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="http" />
        </intent>
    </queries>
    
</manifest>

// === ARCHIVO: lib/presentation/screens/home_screen.dart ===
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../../core/utils/result.dart';
import '../viewmodels/account_viewmodel.dart';
import '../viewmodels/transfer_viewmodel.dart';
import '../viewmodels/history_viewmodel.dart';
import 'account_screen.dart';
import 'transfer_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    final accountViewModel = context.read<AccountViewModel>();
    accountViewModel.loadAccount();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banca Móvil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInitialData,
            tooltip: 'Actualizar datos',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AccountViewModel()),
          ChangeNotifierProvider(create: (_) => TransferViewModel()),
          ChangeNotifierProvider(create: (_) => HistoryViewModel()),
        ],
        child: _buildBody(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Cuenta',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transferir',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const AccountScreen();
      case 2:
        return const TransferScreen();
      case 3:
        return const HistoryScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Consumer<AccountViewModel>(
      builder: (context, viewModel, child) {
        return RefreshIndicator(
          onRefresh: () async {
            viewModel.loadAccount();
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeCard(),
                const SizedBox(height: 20),
                _buildAccountSummaryCard(viewModel),
                const SizedBox(height: 20),
                _buildQuickActions(),
                const SizedBox(height: 20),
                _buildRecentTransactionsPreview(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido a tu Banca Móvil',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Gestiona tus finanzas de forma segura y rápida',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSummaryCard(AccountViewModel viewModel) {
    final state = viewModel.state;
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resumen de Cuenta',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (state is AccountLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const Divider(),
            if (state is AccountLoaded)
              _buildAccountDetails(state.account)
            else if (state is AccountError)
              _buildErrorState(state.message)
            else
              _buildInitialState(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountDetails(Account account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Titular', account.accountHolderName),
        _buildDetailRow('Número de Cuenta', _formatAccountNumber(account.accountNumber)),
        _buildDetailRow('Moneda', account.currency),
        _buildDetailRow('Estado', account.isActive ? 'Activa' : 'Inactiva'),
        _buildDetailRow('Última Actualización', _formatDateTime(account.lastUpdated)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saldo Disponible',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            icon: const Icon(Icons.visibility),
            label: const Text('Ver Detalles Completos'),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: Colors.red[700], size: 48),
          const SizedBox(height: 8),
          Text(
            'Error al cargar cuenta',
            style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(color: Colors.red[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              context.read<AccountViewModel>().loadAccount();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Cargando información de tu cuenta...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acciones Rápidas',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.swap_horiz,
                label: 'Transferir',
                color: Colors.blue,
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.history,
                label: 'Historial',
                color: Colors.green,
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.account_balance,
                label: 'Mi Cuenta',
                color: Colors.purple,
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactionsPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transacciones Recientes',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: const Text('Ver Todas'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTransactionPreviewItem(
                  icon: Icons.arrow_downward,
                  title: 'Depósito Recibido',
                  amount: '+500.00',
                  date: 'Hoy',
                  color: Colors.green,
                ),
                const Divider(),
                _buildTransactionPreviewItem(
                  icon: Icons.arrow_upward,
                  title: 'Transferencia Enviada',
                  amount: '-150.00',
                  date: 'Ayer',
                  color: Colors.orange,
                ),
                const Divider(),
                _buildTransactionPreviewItem(
                  icon: Icons.arrow_downward,
                  title: 'Pago Recibido',
                  amount: '+1,200.00',
                  date: 'Hace 2 días',
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionPreviewItem({
    required IconData icon,
    required String title,
    required String amount,
    required String date,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  String _formatAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    final masked = '****' + accountNumber.substring(accountNumber.length - 4);
    return masked;
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Hace un momento';
    } else if (difference.inHours < 1) {
      return 'Hace ${difference.inMinutes} minutos';
    } else if (difference.inDays < 1) {
      return 'Hace ${difference.inHours} horas';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/screens/account_screen.dart ===
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

// === ARCHIVO: lib/presentation/screens/transfer_screen.dart ===
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

// === ARCHIVO: lib/presentation/screens/history_screen.dart ===
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

// === ARCHIVO: lib/presentation/viewmodels/account_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_balance_usecase.dart';
import '../../core/utils/result.dart';
import '../../core/design_patterns/observer/account_balance_observer.dart';

enum AccountViewState { initial, loading, loaded, error }

class AccountViewModel extends ChangeNotifier implements AccountBalanceObserver {
  final GetBalanceUseCase _getBalanceUseCase;
  
  AccountViewState _state = AccountViewState.initial;
  Account? _account;
  String? _errorMessage;
  DateTime? _lastRefresh;
  bool _isRefreshing = false;

  AccountViewModel({GetBalanceUseCase? getBalanceUseCase})
      : _getBalanceUseCase = getBalanceUseCase ?? GetIt.I<GetBalanceUseCase>() {
    AccountBalanceObserver.register(this);
  }

  AccountViewState get state => _state;
  Account? get account => _account;
  String? get errorMessage => _errorMessage;
  DateTime? get lastRefresh => _lastRefresh;
  bool get isRefreshing => _isRefreshing;
  bool get hasAccount => _account != null;
  bool get canRefresh => _state != AccountViewState.loading && !_isRefreshing;

  String get formattedBalance {
    if (_account == null) return '—';
    return '${_account!.currency} ${_account!.balance.toStringAsFixed(2)}';
  }

  Future<void> loadAccount({String? accountId}) async {
    if (_state == AccountViewState.loading) return;
    
    _state = AccountViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final accountIdToFetch = accountId ?? _account?.id ?? 'ACC-001';
      final result = await _getBalanceUseCase.execute(accountIdToFetch);
      
      result.when(
        success: (account) {
          _account = account;
          _lastRefresh = DateTime.now();
          _state = AccountViewState.loaded;
        },
        failure: (error) {
          _errorMessage = _mapErrorToMessage(error);
          _state = AccountViewState.error;
        }
      );
    } catch (e) {
      _errorMessage = 'Error inesperado al cargar la cuenta';
      _state = AccountViewState.error;
    }
    
    notifyListeners();
  }

  Future<void> refreshAccount() async {
    if (!canRefresh) return;
    
    _isRefreshing = true;
    notifyListeners();

    await loadAccount();
    
    _isRefreshing = false;
    notifyListeners();
  }

  bool canPerformTransfer(String channel) {
    return _account?.canPerformTransfer(channel) ?? false;
  }

  Result<Account> applyTransaction(Transaction transaction) {
    if (_account == null) {
      return Result.failure('No hay cuenta cargada');
    }
    final result = _account!.applyTransaction(transaction);
    notifyListeners();
    return result;
  }

  @override
  void onBalanceChanged(Account account, double oldBalance, double newBalance) {
    _account = account;
    notifyListeners();
  }

  @override
  void onTransactionApplied(Transaction transaction) {
    if (_account != null && transaction.accountId == _account!.id) {
      final result = _account!.applyTransaction(transaction);
      result.when(
        success: (updatedAccount) {
          _account = updatedAccount;
          notifyListeners();
        },
        failure: (_) {}
      );
    }
  }

  @override
  void dispose() {
    AccountBalanceObserver.unregister(this);
    super.dispose();
  }

  String _mapErrorToMessage(String error) {
    if (error.contains('network') || error.contains('conexión')) {
      return 'Error de conexión. Verifica tu red e intenta nuevamente.';
    }
    if (error.contains('timeout') || error.contains('tiempo')) {
      return 'La operación tardó demasiado. Intenta en unos segundos.';
    }
    if (error.contains('not found') || error.contains('no encontrada')) {
      return 'Cuenta no encontrada.';
    }
    return 'Error al cargar la cuenta: $error';
  }
}

class AccountViewModelState extends Equatable {
  final AccountViewState state;
  final Account? account;
  final String? errorMessage;
  final DateTime? lastRefresh;
  final bool isRefreshing;

  const AccountViewModelState({
    required this.state,
    this.account,
    this.errorMessage,
    this.lastRefresh,
    this.isRefreshing = false,
  });

  @override
  List<Object?> get props => [state, account, errorMessage, lastRefresh, isRefreshing];
}

// === ARCHIVO: lib/presentation/viewmodels/transfer_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/transfer_request.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/transfer_funds_usecase.dart';
import '../../core/utils/result.dart';
import '../../core/design_patterns/command/transfer_command.dart';
import '../../core/design_patterns/command/command_queue.dart';
import '../../core/design_patterns/strategy/authentication_strategy.dart';
import '../../core/design_patterns/strategy/biometric_auth_strategy.dart';
import '../../core/design_patterns/strategy/pin_auth_strategy.dart';

enum TransferViewState { initial, validating, authenticating, processing, success, error }

class TransferViewModel extends ChangeNotifier {
  final TransferFundsUseCase _transferFundsUseCase;
  final CommandQueue _commandQueue;
  final BiometricAuthStrategy _biometricStrategy;
  final PinAuthStrategy _pinStrategy;
  
  TransferViewState _state = TransferViewState.initial;
  TransferRequest? _pendingRequest;
  Transaction? _completedTransaction;
  String? _errorMessage;
  List<TransferCommand> _commandHistory = [];
  String _selectedAuthMethod = 'biometric';
  double _currentAmount = 0.0;
  String _targetAccountId = '';
  String _transferDescription = '';

  TransferViewModel({
    TransferFundsUseCase? transferFundsUseCase,
    CommandQueue? commandQueue,
    BiometricAuthStrategy? biometricStrategy,
    PinAuthStrategy? pinStrategy,
  })  : _transferFundsUseCase = transferFundsUseCase ?? GetIt.I<TransferFundsUseCase>(),
        _commandQueue = commandQueue ?? CommandQueue(),
        _biometricStrategy = biometricStrategy ?? BiometricAuthStrategy(),
        _pinStrategy = pinStrategy ?? PinAuthStrategy();

  TransferViewState get state => _state;
  TransferRequest? get pendingRequest => _pendingRequest;
  Transaction? get completedTransaction => _completedTransaction;
  String? get errorMessage => _errorMessage;
  List<TransferCommand> get commandHistory => List.unmodifiable(_commandHistory);
  String get selectedAuthMethod => _selectedAuthMethod;
  bool get isProcessing => _state == TransferViewState.processing;
  bool get canSubmit => _isFormValid() && _state != TransferViewState.processing;

  void updateAmount(double amount) {
    _currentAmount = amount;
    _validateForm();
  }

  void updateTargetAccount(String accountId) {
    _targetAccountId = accountId;
    _validateForm();
  }

  void updateDescription(String description) {
    _transferDescription = description;
  }

  void setAuthMethod(String method) {
    _selectedAuthMethod = method;
    notifyListeners();
  }

  void _validateForm() {
    if (_currentAmount > 0 && _targetAccountId.isNotEmpty) {
      _generatePendingRequest();
    } else {
      _pendingRequest = null;
    }
    notifyListeners();
  }

  bool _isFormValid() {
    return _currentAmount > 0 && 
           _targetAccountId.isNotEmpty && 
           _targetAccountId != 'ACC-001';
  }

  void _generatePendingRequest() {
    _pendingRequest = TransferRequest(
      id: 'TRF-${DateTime.now().millisecondsSinceEpoch}',
      fromAccountId: 'ACC-001',
      toAccountId: _targetAccountId,
      amount: _currentAmount,
      currency: 'USD',
      description: _transferDescription,
      channel: 'mobile_app',
      referenceNumber: null,
      timestamp: DateTime.now(),
      requiresBiometric: _selectedAuthMethod == 'biometric',
    );
  }

  Future<void> initiateTransfer() async {
    if (!canSubmit || _pendingRequest == null) return;

    _state = TransferViewState.validating;
    _errorMessage = null;
    notifyListeners();

    try {
      final validationResult = await _validateTransferLimits(_pendingRequest!);
      if (validationResult.isFailure) {
        _state = TransferViewState.error;
        _errorMessage = validationResult.error;
        notifyListeners();
        return;
      }

      _state = TransferViewState.authenticating;
      notifyListeners();

      final authResult = await _authenticateUser();
      if (authResult.isFailure) {
        _state = TransferViewState.error;
        _errorMessage = authResult.error;
        notifyListeners();
        return;
      }

      await _executeTransfer();
    } catch (e) {
      _state = TransferViewState.error;
      _errorMessage = 'Error inesperado durante la transferencia';
      notifyListeners();
    }
  }

  Future<Result<void>> _validateTransferLimits(TransferRequest request) async {
    const double maxSingleTransfer = 10000.0;
    const double dailyLimit = 25000.0;

    if (request.amount > maxSingleTransfer) {
      return Result.failure('El monto excede el límite máximo de \$$maxSingleTransfer');
    }

    final dailyTotal = _calculateDailyTotal();
    if (dailyTotal + request.amount > dailyLimit) {
      return Result.failure('La transferencia excede el límite diario de \$$dailyLimit');
    }

    if (request.amount <= 0) {
      return Result.failure('El monto debe ser mayor a cero');
    }

    return Result.success(null);
  }

  double _calculateDailyTotal() {
    final today = DateTime.now();
    return _commandHistory
        .where((cmd) => cmd.timestamp.day == today.day && 
                        cmd.timestamp.month == today.month &&
                        cmd.timestamp.year == today.year)
        .fold(0.0, (sum, cmd) => sum + cmd.amount);
  }

  Future<Result<bool>> _authenticateUser() async {
    final AuthenticationStrategy strategy = _selectedAuthMethod == 'biometric'
        ? _biometricStrategy
        : _pinStrategy;

    final authenticated = await strategy.authenticate(
      reason: 'Autentícate para confirmar la transferencia de \$$_currentAmount'
    );

    if (!authenticated) {
      return Result.failure('Autenticación fallida. Intenta nuevamente.');
    }

    return Result.success(true);
  }

  Future<void> _executeTransfer() async {
    _state = TransferViewState.processing;
    notifyListeners();

    final command = TransferCommand(
      transferRequest: _pendingRequest!,
      onExecute: () => _transferFundsUseCase.execute(_pendingRequest!),
    );

    await _commandQueue.enqueue(command);
    _commandHistory.add(command);

    final result = await command.execute();

    result.when(
      success: (transaction) {
        _completedTransaction = transaction;
        _state = TransferViewState.success;
      },
      failure: (error) {
        _errorMessage = _mapErrorToMessage(error);
        _state = TransferViewState.error;
      }
    );

    notifyListeners();
  }

  void reset() {
    _state = TransferViewState.initial;
    _pendingRequest = null;
    _completedTransaction = null;
    _errorMessage = null;
    _currentAmount = 0.0;
    _targetAccountId = '';
    _transferDescription = '';
    notifyListeners();
  }

  String _mapErrorToMessage(String error) {
    if (error.contains('insufficient') || error.contains('saldo')) {
      return 'Saldo insuficiente para realizar la transferencia.';
    }
    if (error.contains('account') || error.contains('cuenta')) {
      return 'La cuenta de destino no es válida.';
    }
    if (error.contains('duplicate') || error.contains('duplicada')) {
      return 'Esta transferencia ya fue procesada.';
    }
    return 'Error al procesar la transferencia: $error';
  }
}

class TransferFormState extends Equatable {
  final double amount;
  final String targetAccountId;
  final String description;
  final bool isValid;

  const TransferFormState({
    this.amount = 0.0,
    this.targetAccountId = '',
    this.description = '',
    this.isValid = false,
  });

  TransferFormState copyWith({
    double? amount,
    String? targetAccountId,
    String? description,
    bool? isValid,
  }) {
    return TransferFormState(
      amount: amount ?? this.amount,
      targetAccountId: targetAccountId ?? this.targetAccountId,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [amount, targetAccountId, description, isValid];
}

// === ARCHIVO: lib/presentation/viewmodels/history_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_transaction_history_usecase.dart';
import '../../core/utils/result.dart';
import '../../core/design_patterns/observer/transaction_observer.dart';

enum HistoryViewState { initial, loading, loaded, error }
enum TransactionFilter { all, credit, debit }
enum DateRangeFilter { all, today, week, month }

class HistoryViewModel extends ChangeNotifier implements TransactionObserver {
  final GetTransactionHistoryUseCase _getTransactionHistoryUseCase;
  
  HistoryViewState _state = HistoryViewState.initial;
  List<Transaction> _transactions = [];
  List<Transaction> _filteredTransactions = [];
  String? _errorMessage;
  TransactionFilter _currentFilter = TransactionFilter.all;
  DateRangeFilter _dateRangeFilter = DateRangeFilter.all;
  String _searchQuery = '';
  bool _isLoadingMore = false;
  int _currentPage = 0;
  static const int _pageSize = 20;

  HistoryViewModel({GetTransactionHistoryUseCase? getTransactionHistoryUseCase})
      : _getTransactionHistoryUseCase = getTransactionHistoryUseCase ?? 
          GetIt.I<GetTransactionHistoryUseCase>() {
    TransactionObserver.register(this);
  }

  HistoryViewState get state => _state;
  List<Transaction> get transactions => _filteredTransactions;
  List<Transaction> get allTransactions => _transactions;
  String? get errorMessage => _errorMessage;
  TransactionFilter get currentFilter => _currentFilter;
  DateRangeFilter get dateRangeFilter => _dateRangeFilter;
  String get searchQuery => _searchQuery;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreTransactions => _filteredTransactions.length >= _currentPage * _pageSize;
  bool get isEmpty => _transactions.isEmpty && _state == HistoryViewState.loaded;

  double get totalCredits {
    return _transactions
        .where((t) => t.type == TransactionType.credit && t.isSuccessful)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalDebits {
    return _transactions
        .where((t) => t.type == TransactionType.debit && t.isSuccessful)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  Map<DateTime, List<Transaction>> get transactionsByDate {
    final Map<DateTime, List<Transaction>> grouped = {};
    for (final transaction in _filteredTransactions) {
      final dateKey = DateTime(
        transaction.timestamp.year,
        transaction.timestamp.month,
        transaction.timestamp.day,
      );
      grouped.putIfAbsent(dateKey, () => []).add(transaction);
    }
    return grouped;
  }

  Future<void> loadTransactions({String? accountId, bool refresh = false}) async {
    if (_state == HistoryViewState.loading && !refresh) return;

    if (refresh) {
      _currentPage = 0;
      _transactions = [];
    }

    _state = HistoryViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final accountIdToFetch = accountId ?? 'ACC-001';
      final result = await _getTransactionHistoryUseCase.execute(
        accountId: accountIdToFetch,
        page: _currentPage,
        pageSize: _pageSize,
      );
      
      result.when(
        success: (transactions) {
          if (refresh) {
            _transactions = transactions;
          } else {
            _transactions = [..._transactions, ...transactions];
          }
          _applyFilters();
          _state = HistoryViewState.loaded;
        },
        failure: (error) {
          _errorMessage = _mapErrorToMessage(error);
          _state = HistoryViewState.error;
        }
      );
    } catch (e) {
      _errorMessage = 'Error inesperado al cargar el historial';
      _state = HistoryViewState.error;
    }
    
    notifyListeners();
  }

  Future<void> loadMoreTransactions({String? accountId}) async {
    if (_isLoadingMore || !hasMoreTransactions) return;
    
    _isLoadingMore = true;
    notifyListeners();

    _currentPage++;
    await loadTransactions(accountId: accountId);

    _isLoadingMore = false;
    notifyListeners();
  }

  void setFilter(TransactionFilter filter) {
    _currentFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void setDateRangeFilter(DateRangeFilter filter) {
    _dateRangeFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    var filtered = List<Transaction>.from(_transactions);

    if (_currentFilter != TransactionFilter.all) {
      final targetType = _currentFilter == TransactionFilter.credit
          ? TransactionType.credit
          : TransactionType.debit;
      filtered = filtered.where((t) => t.type == targetType).toList();
    }

    if (_dateRangeFilter != DateRangeFilter.all) {
      final now = DateTime.now();
      final DateTime startDate;
      
      switch (_dateRangeFilter) {
        case DateRangeFilter.today:
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case DateRangeFilter.week:
          startDate = now.subtract(const Duration(days: 7));
          break;
        case DateRangeFilter.month:
          startDate = DateTime(now.year, now.month - 1, now.day);
          break;
        default:
          startDate = DateTime(1970);
      }
      
      filtered = filtered.where((t) => t.timestamp.isAfter(startDate)).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((t) =>
          t.description.toLowerCase().contains(_searchQuery) ||
          (t.referenceNumber?.toLowerCase().contains(_searchQuery) ?? false) ||
          t.id.toLowerCase().contains(_searchQuery)).toList();
    }

    filtered.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    _filteredTransactions = filtered;
  }

  void clearFilters() {
    _currentFilter = TransactionFilter.all;
    _dateRangeFilter = DateRangeFilter.all;
    _searchQuery = '';
    _applyFilters();
    notifyListeners();
  }

  @override
  void onTransactionCreated(Transaction transaction) {
    _transactions.insert(0, transaction);
    _applyFilters();
    notifyListeners();
  }

  @override
  void onTransactionUpdated(Transaction transaction) {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
      _applyFilters();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    TransactionObserver.unregister(this);
    super.dispose();
  }

  String _mapErrorToMessage(String error) {
    if (error.contains('network') || error.contains('conexión')) {
      return 'Error de conexión. Verifica tu red e intenta nuevamente.';
    }
    if (error.contains('timeout') || error.contains('tiempo')) {
      return 'La operación tardó demasiado. Intenta en unos segundos.';
    }
    return 'Error al cargar el historial: $error';
  }
}

class HistoryViewModelState extends Equatable {
  final HistoryViewState state;
  final List<Transaction> transactions;
  final String? errorMessage;
  final TransactionFilter filter;
  final DateRangeFilter dateRange;
  final bool isLoadingMore;

  const HistoryViewModelState({
    required this.state,
    this.transactions = const [],
    this.errorMessage,
    this.filter = TransactionFilter.all,
    this.dateRange = DateRangeFilter.all,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [state, transactions, errorMessage, filter, dateRange, isLoadingMore];
}
```
