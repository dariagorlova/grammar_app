import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: onTap?.call(),
      //() =>
      //BlocProvider.of<GreetingBloc>(context).add(GreetingRequestedEvent()),
      //BlocProvider.of<QuotesCubit>(context).quoteRequested(),
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
              'Get Quote',
              style: themeData.textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}
