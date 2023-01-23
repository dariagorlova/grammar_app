import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grammar_app/injection.dart';
import 'package:grammar_app/presentation/core/services/theme_service.dart';
import 'package:grammar_app/presentation/pages/greeting/cubit/quotes_cubit.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/custom_button.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/error_message.dart';
import 'package:grammar_app/presentation/pages/greeting/widgets/quote_field.dart';
import 'package:provider/provider.dart';

class GreetingScreenWrapperProvider extends StatelessWidget {
  const GreetingScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //create: (context) => GreetingBloc(), //QuotesCubit(),
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
                  //child: Center(child: BlocBuilder<GreetingBloc, GreetingState>(

                  // builder: (context, state) {
                  //   if (state is GreetingInitial) {
                  //     return Text(
                  //       'Your Quote is waiting for you!',
                  //       style: themeData.textTheme.headline1,
                  //     );
                  //   } else if (state is GreetingStateLoading) {
                  //     return CircularProgressIndicator(
                  //       color: themeData.colorScheme.secondary,
                  //     );
                  //   } else if (state is GreetingStateLoaded) {
                  //     return QuoteField(
                  //       quote: state.quote,
                  //     );
                  //   } else if (state is GreetingStateError) {
                  //     return ErrorMessage(message: state.message);
                  //   }
                  //   return const SizedBox();
                  // },
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
                    onTap: () =>
                        BlocProvider.of<QuotesCubit>(context).quoteRequested,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
