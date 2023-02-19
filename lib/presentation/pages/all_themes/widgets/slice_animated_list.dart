import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grammar_app/domain/entities/group_entity.dart';
import 'package:grammar_app/presentation/pages/all_themes/cubit/cubit/all_themes_cubit.dart';
import '../widgets/lesson_card.dart';

class AllThemesPage extends StatefulWidget {
  const AllThemesPage({Key? key, required this.themes}) : super(key: key);

  final List<GroupEntity> themes;

  @override
  State<AllThemesPage> createState() => _AllThemesPageState();
}

class _AllThemesPageState extends State<AllThemesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  var listItems = <Widget>[];

  final today = DateTime.now();
  var selectedDay = 0;
  var weekDays = <int>[];

  @override
  void initState() {
    super.initState();
    selectedDay = today.day;
    for (int i = 1; i < 8; i++) {
      weekDays.add(today.add(Duration(days: i - today.weekday)).day);
    }
  }

  _loadData() {
    _clearAnimatedList();

    final fetchedList = _buildSelectedDayLessons(widget.themes);

    var future = Future(() {});
    for (var i = 0; i < fetchedList.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          listItems.add(fetchedList[i]);
          _listKey.currentState?.insertItem(listItems.length - 1);
        });
      });
    }
  }

  void _clearAnimatedList() {
    for (var i = listItems.length - 1; i >= 0; i--) {
      final deletedItem = listItems.removeAt(0);
      _listKey.currentState
          ?.removeItem(0, duration: const Duration(milliseconds: 10),
              (BuildContext context, Animation<double> animation) {
        return SlideTransition(
          position: CurvedAnimation(
            curve: Curves.easeOut,
            parent: animation,
          ).drive((Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ))),
          child: deletedItem,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllThemesCubit, AllThemesState>(
        builder: (context, state) {
      if (state is AllThemesStateLoaded) {
        context.read<AllThemesCubit>().getThemeByGroup(state.groups[0].id);
        _loadData();
        return _bodyWidget();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _bodyWidget() {
    return Stack(
      children: [
        Positioned(
          top: 5,
          child: Container(
            height: MediaQuery.of(context).size.height - 160,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: AnimatedList(
              key: _listKey,
              physics: const BouncingScrollPhysics(),
              initialItemCount: listItems.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: CurvedAnimation(
                    curve: Curves.easeOut,
                    parent: animation,
                  ).drive((Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  ))),
                  child: listItems[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSelectedDayLessons(
    List<GroupEntity> themes,
  ) {
    var result = <Widget>[];
    for (var element in themes) {
      result.add(LessonDataEx(
        themes: element,
      ));
    }

    return result;
  }
}

class LessonDataEx extends StatelessWidget {
  const LessonDataEx({
    Key? key,
    required this.themes,
  }) : super(key: key);
  final GroupEntity themes;

  @override
  Widget build(BuildContext context) {
    final subThemesList =
        context.read<AllThemesCubit>().getThemeByGroup(themes.id);
    final subThemesTitleList = <String>[];
    for (var element in subThemesList) {
      subThemesTitleList.add(element.title);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: LessonCard(
        groupData: themes,
        subThemes: subThemesTitleList,
      ),
    );
  }
}
