import 'package:grammar_app/domain/entities/theme_entity.dart';

abstract class ThemesLocalDatasource {
  List<ThemeEntity> getThemesFromRepoByGroup(int groupId);
}

class ThemesLocalDatasourceImpl implements ThemesLocalDatasource {
  ThemesLocalDatasourceImpl();

  final List<ThemeEntity> _allThemes = const [
    ThemeEntity(
      id: 0,
      groupId: 0,
      title: 'Past Simple',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 1,
      groupId: 0,
      title: 'Past Continuous',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 2,
      groupId: 0,
      title: 'Past Perfect',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 3,
      groupId: 0,
      title: 'Past Perfect Continuous',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 4,
      groupId: 1,
      title: 'Present Simple',
      pathToContent: 'assets/present_simple.md',
    ),
    ThemeEntity(
      id: 5,
      groupId: 1,
      title: 'Present Continuous',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 6,
      groupId: 1,
      title: 'Present Perfect',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 7,
      groupId: 1,
      title: 'Present Perfect Continuous',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 8,
      groupId: 2,
      title: 'Future Simple',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 9,
      groupId: 2,
      title: 'Future Continuous',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 10,
      groupId: 2,
      title: 'Future Perfect',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 11,
      groupId: 2,
      title: 'Future Perfect Continuous',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 12,
      groupId: 3,
      title: 'Zero Conditionals',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 13,
      groupId: 3,
      title: 'First Conditionals',
      pathToContent: '',
    ),
    ThemeEntity(
      id: 14,
      groupId: 3,
      title: 'Second Conditionals',
      pathToContent: '',
    ),
  ];

  List<ThemeEntity> get allThemes => _allThemes;

  @override
  List<ThemeEntity> getThemesFromRepoByGroup(int groupId) {
    final List<ThemeEntity> result = allThemes.map((element) {
      element.groupId == groupId;
    }).toList() as List<ThemeEntity>;

    return result;
  }
}
