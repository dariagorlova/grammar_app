import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grammar_app/injection.dart';
import 'package:grammar_app/core/services/theme_service.dart';
import 'package:grammar_app/navigation.dart';
import 'package:grammar_app/presentation/pages/all_themes/all_themes_screen.dart';
import 'package:grammar_app/presentation/pages/greeting/cubit/quotes_cubit.dart';
import 'package:grammar_app/presentation/pages/widgets/custom_button.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/error_message.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/quote_field.dart';
import 'package:provider/provider.dart';

class GreetingScreenWrapperProvider extends StatelessWidget {
  const GreetingScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuotesCubit>(),
      child: const GreetingScreen(),
    );
  }
}

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Quote for today',
            style: themeData.textTheme.headline1,
          ),
          centerTitle: true,
          actions: [
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                  child: Center(child: BlocBuilder<QuotesCubit, QuotesState>(
                builder: (context, state) {
                  if (state is QuotesInitial) {
                    return Text(
                      'Your Quote is waiting for you!',
                      style: themeData.textTheme.headline1,
                    );
                  } else if (state is QuotesStateLoading) {
                    return CircularProgressIndicator(
                      color: themeData.colorScheme.secondary,
                    );
                  } else if (state is QuotesStateLoaded) {
                    return QuoteField(
                      quote: state.quote,
                    );
                  } else if (state is QuotesStateError) {
                    return ErrorMessage(message: state.message);
                  }
                  return const SizedBox();
                },
              ))),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                    title: "Let's get started",
                    onTap: () {
                      NavigationActions.instance.showAllTheme();
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  child: const Text('another button'),
                  onPressed: () =>
                      //BlocProvider.of<QuotesCubit>(context).goToLearning(),
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (context) =>
                              const AllThemesScreenWrapperProvider()))),
            ],
          ),
        ));
  }
}

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: onTap?.call(),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: themeData.colorScheme.secondary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              title, //'Get Quote',
              style: themeData.textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}
