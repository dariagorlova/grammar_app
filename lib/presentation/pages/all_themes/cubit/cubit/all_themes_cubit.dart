import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grammar_app/data/exceptions/exceptions_constants.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';
import 'package:grammar_app/domain/entities/theme_entity.dart';
import 'package:grammar_app/domain/usecases/groups_usecases.dart';
import 'package:grammar_app/domain/usecases/themes_usecases.dart';

part 'all_themes_state.dart';

class AllThemesCubit extends Cubit<AllThemesState> {
  AllThemesCubit({
    required this.groupsUseCases,
    required this.themeUseCases,
  }) : super(const AllThemesInitial()) {
    init();
  }

  final GroupsUseCases groupsUseCases;
  final ThemesUseCases themeUseCases;

  void init() {
    emit(const AllThemesStateLoading());

    final failureOrQuote = groupsUseCases.getGroups();
    failureOrQuote.fold(
        (failure) =>
            emit(AllThemesStateError(message: mapFailureToMessage(failure))),
        (groups) => emit(AllThemesStateLoaded(groups: groups)));
  }

  List<ThemeEntity> getThemeByGroup(int groupId) {
    // emit(const OneThemeStateLoading());

    var result = <ThemeEntity>[];
    final failureOrList = themeUseCases.getThemesByGroup(groupId);

    failureOrList.fold(
        (failure) =>
            emit(AllThemesStateError(message: mapFailureToMessage(failure))),
        (themes) {
      result = themes;
    });

    return result;
  }

  void getThemeInfo(int themeId) {
    final failureOrQuote = themeUseCases.getThemesById(themeId);
    failureOrQuote.fold(
        (failure) =>
            emit(AllThemesStateError(message: mapFailureToMessage(failure))),
        (theme) {
      //emit(OneThemeStateInfo(theme: theme));
    });
  }

  ThemeEntity getThemeInfoByTitle(String title, int groupId) {
    var result = const ThemeEntity(
        groupId: -1, id: -1, title: 'not found', pathToContent: '');
    final allThemes = themeUseCases.getThemesByGroup(groupId);
    allThemes.fold(
        (l) => emit(AllThemesStateError(message: mapFailureToMessage(l))),
        (group) => {
              result = group.firstWhere((element) => element.title == title),
            });

    return result;
  }
}
