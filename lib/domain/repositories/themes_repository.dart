import 'package:dartz/dartz.dart';
import 'package:grammar_app/domain/entities/theme_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';

abstract class ThemesRepository {
  Either<Failure, List<ThemeEntity>> getThemesFromDatasourceByGroup(
      int groupId);

  Either<Failure, ThemeEntity> getThemeFromDatasourceById(int themeId);
}
