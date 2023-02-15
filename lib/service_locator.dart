import 'package:get_it/get_it.dart';
import 'package:grammar_app/core/services/navigator.dart';
import 'package:grammar_app/data/datasources/quotes_local_datasource.dart';
import 'package:grammar_app/data/repositories/quotes_repo_impl.dart';
import 'package:grammar_app/domain/repositories/quotes_repository.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';
import 'package:grammar_app/navigation.dart';

import 'presentation/pages/greeting/cubit/quotes_cubit.dart';

final instance = GetIt.instance;

Future<void> initDI() async {
  //Logic (BLoC/Cubit)

  instance.registerLazySingleton(() => QuotesCubit(
        quoteUseCases: instance(),
      ));

  //Repository
  instance.registerLazySingleton<QuotesRepository>(() => QuotesRepoImpl(
        quotesLocalDatasource: instance(),
      ));
  //Usecase
  instance.registerLazySingleton(() => QuotesUseCases(quotesRepo: instance()));

  instance.registerLazySingleton<QuotesLocalDatasource>(
      () => QuotesLocalDatasourceImpl());

  //instance.registerLazySingleton<QuotesLocalDatasource>(
  //    () => QuotesRemoteDatasourceImpl(client: instance()));

  //Core
  instance.registerSingleton<AppNavigation>(NavigationImpl());

  //External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // instance.registerLazySingleton(() => sharedPreferences);
}
