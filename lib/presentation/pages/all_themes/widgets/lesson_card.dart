import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';
import 'package:grammar_app/navigation.dart';
import 'package:grammar_app/presentation/pages/all_themes/cubit/cubit/all_themes_cubit.dart';

class LessonCard extends StatelessWidget {
  final GroupEntity groupData;
  final List<String> subThemes;

  const LessonCard({
    super.key,
    required this.groupData,
    required this.subThemes,
  });

  @override
  Widget build(BuildContext context) {
    final group = context.read<AllThemesCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        collapsedIconColor: Theme.of(context).disabledColor,
        backgroundColor: Colors.red, //groupData.colorBackground,
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.only(left: 19, right: 20),
        title: Text(
          groupData.title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.red),
        ),
        subtitle: Text(groupData.description),
        children: subThemes
            .map((e) => GestureDetector(
                onTap: () {
                  final curTheme = group.getThemeInfoByTitle(e, groupData.id);
                  NavigationActions.instance.showOneTheme(curTheme);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                )))
            .toList(),
      ),
    );
  }
}
