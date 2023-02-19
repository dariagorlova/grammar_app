import 'package:get_it/get_it.dart';
import 'package:grammar_app/core/services/navigator.dart';
import 'package:grammar_app/data/datasources/groups_local_datasource.dart';
import 'package:grammar_app/data/datasources/quotes_local_datasource.dart';
import 'package:grammar_app/data/datasources/themes_local_datasource.dart';
import 'package:grammar_app/data/repositories/groups_repo_impl.dart';
import 'package:grammar_app/data/repositories/quotes_repo_impl.dart';
import 'package:grammar_app/data/repositories/themes_repo_impl.dart';
import 'package:grammar_app/domain/repositories/groups_repository.dart';
import 'package:grammar_app/domain/repositories/quotes_repository.dart';
import 'package:grammar_app/domain/repositories/themes_repository.dart';
import 'package:grammar_app/domain/usecases/groups_usecases.dart';
import 'package:grammar_app/domain/usecases/quotes_usecases.dart';
import 'package:grammar_app/domain/usecases/themes_usecases.dart';
import 'package:grammar_app/navigation.dart';

import 'presentation/pages/all_themes/cubit/cubit/all_themes_cubit.dart';
import 'presentation/pages/greeting/cubit/quotes_cubit.dart';

final instance = GetIt.instance;

Future<void> initDI() async {
  //Logic (BLoC/Cubit)
  instance.registerLazySingleton(() => QuotesCubit(
        quoteUseCases: instance(),
      ));
  instance.registerLazySingleton(() => AllThemesCubit(
        groupsUseCases: instance(),
        themeUseCases: instance(),
      ));

  //Repository
  instance.registerLazySingleton<QuotesRepository>(() => QuotesRepoImpl(
        quotesLocalDatasource: instance(),
      ));
  instance.registerLazySingleton<GroupsRepository>(() => GroupsRepoImpl(
        groupsLocalDatasource: instance(),
      ));
  instance.registerLazySingleton<ThemesRepository>(() => ThemesRepoImpl(
        themesLocalDatasource: instance(),
      ));

  //Usecase
  instance.registerLazySingleton(() => QuotesUseCases(quotesRepo: instance()));
  instance.registerLazySingleton(() => GroupsUseCases(groupsRepo: instance()));
  instance.registerLazySingleton(() => ThemesUseCases(themesRepo: instance()));

  // DataSource
  instance.registerLazySingleton<QuotesLocalDatasource>(
      () => QuotesLocalDatasourceImpl());
  //instance.registerLazySingleton<QuotesLocalDatasource>(
  //    () => QuotesRemoteDatasourceImpl(client: instance()));
  instance.registerLazySingleton<GroupsLocalDatasource>(
      () => GroupsLocalDatasourceImpl());
  instance.registerLazySingleton<ThemesLocalDatasource>(
      () => ThemesLocalDatasourceImpl());

  //Core
  instance.registerSingleton<AppNavigation>(NavigationImpl());

  //External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // instance.registerLazySingleton(() => sharedPreferences);
}
