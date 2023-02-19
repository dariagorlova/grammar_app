import 'package:dartz/dartz.dart';
import 'package:grammar_app/data/datasources/themes_local_datasource.dart';
import 'package:grammar_app/data/exceptions/exceptions.dart';
import 'package:grammar_app/domain/entities/theme_entity.dart';
import 'package:grammar_app/domain/repositories/themes_repository.dart';
import '../../domain/failuries/failures.dart';

class ThemesRepoImpl implements ThemesRepository {
  final ThemesLocalDatasource themesLocalDatasource;
  ThemesRepoImpl({required this.themesLocalDatasource});

  @override
  Either<Failure, List<ThemeEntity>> getThemesFromDatasourceByGroup(
      int groupId) {
    // try {
    //   final result = themesLocalDatasource.getThemesFromRepoByGroup(groupId);
    //   return right(result);
    // } on ServerException catch (_) {
    //   return left(ServerFailure());
    // } catch (e) {
    //   return left(GeneralFailure());
    // }
    try {
      final result = themesLocalDatasource.getThemesFromRepoByGroup(groupId);
      return right(result);
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Either<Failure, ThemeEntity> getThemeFromDatasourceById(int themeId) {
    try {
      final result = themesLocalDatasource.getThemeFromRepoById(themeId);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
