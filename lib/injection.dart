import 'package:get_it/get_it.dart';
import 'package:grammar_app/data/datasources/quotes_local_datasource.dart';
import 'package:grammar_app/data/repositories/quotes_repo_impl.dart';
import 'package:grammar_app/domain/repositories/quotes_repository.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';
import 'package:grammar_app/presentation/pages/all_themes/cubit/cubit/all_themes_cubit.dart';
import 'package:grammar_app/presentation/pages/greeting/cubit/quotes_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
// ! application Layer
  // Factory = every time a new/fresh instance of that class

  sl.registerFactory(() => QuotesCubit(
        quoteUseCases: sl(),
      ));
  sl.registerFactory(() => AllThemesCubit());

// ! domain Layer
  sl.registerFactory(() => QuotesUseCases(quotesRepo: sl()));

// ! data Layer
  sl.registerFactory<QuotesRepository>(
      () => QuotesRepoImpl(quotesLocalDatasource: sl()));
  sl.registerFactory<QuotesLocalDatasource>(() => QuotesLocalDatasourceImpl());

// ! externs
  sl.registerFactory(() => http.Client());
}
