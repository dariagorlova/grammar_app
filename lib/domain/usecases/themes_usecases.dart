import 'package:dartz/dartz.dart';
import 'package:grammar_app/domain/entities/theme_entity.dart';
import 'package:grammar_app/domain/failuries/failures.dart';
import 'package:grammar_app/domain/repositories/themes_repository.dart';

class ThemesUseCases {
  final ThemesRepository themesRepo;
  ThemesUseCases({required this.themesRepo});

  Either<Failure, List<ThemeEntity>> getThemesByGroup(int groupId) {
    return themesRepo.getThemesFromDatasourceByGroup(groupId);
    // space for business logic
  }
}
