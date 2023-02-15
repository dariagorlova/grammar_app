import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grammar_app/injection.dart';
import 'package:grammar_app/presentation/pages/all_themes/cubit/cubit/all_themes_cubit.dart';

class AllThemesScreenWrapperProvider extends StatelessWidget {
  const AllThemesScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AllThemesCubit>(),
      child: const AllThemesScreen(),
    );
  }
}

class Tense {
  final String title;
  final String description;

  Tense(this.title, this.description);
}

class AllThemesScreen extends StatelessWidget {
  const AllThemesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tense> tenses = [
      Tense('Past', 'Поговоримо про минуле'),
      Tense('Present', 'Поговоримо про теперешнє'),
      Tense('Future', 'Поговоримо про майбутнє'),
      Tense('Conditionals', 'Умовні речення'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose theme for learning',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
            itemCount: tenses.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //NavigationActions.instance.showOneTheme(tenses[index]);
                },
                child: LessonCard(data: tenses[index]),
              );
            }),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final Tense data;
  const LessonCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  data.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  data.description,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
