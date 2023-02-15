import 'package:equatable/equatable.dart';

class ThemeEntity extends Equatable {
  final int id;
  final int groupId;
  final String title;
  final String pathToContent;

  const ThemeEntity({
    required this.groupId,
    required this.id,
    required this.title,
    required this.pathToContent,
  });

  @override
  List<Object?> get props => [groupId, id, title, pathToContent];
}
