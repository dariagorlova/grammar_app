import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grammar_app/injection.dart';
import 'package:grammar_app/presentation/pages/all_themes/cubit/cubit/all_themes_cubit.dart';
import 'package:grammar_app/presentation/pages/all_themes/widgets/slice_animated_list.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/error_message.dart';

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

class AllThemesScreen extends StatelessWidget {
  const AllThemesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Choose theme for learning',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(child: BlocBuilder<AllThemesCubit, AllThemesState>(
            builder: (context, state) {
              if (state is AllThemesInitial) {
                return const Text('Initial...');
              } else if (state is AllThemesStateLoading) {
                return CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                );
              } else if (state is AllThemesStateLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: AllThemesPage(themes: state.groups),
                );
              } else if (state is AllThemesStateError) {
                return ErrorMessage(message: state.message);
              }
              return const SizedBox();
            },
          )),
        ));
  }
}
