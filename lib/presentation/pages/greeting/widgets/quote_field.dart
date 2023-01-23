import 'package:flutter/material.dart';
import 'package:grammar_app/domain/entities/quote_entity.dart';

class QuoteField extends StatelessWidget {
  static String emptyQuote = 'What should i do with an empty quote?!';
  final QuoteEntity quote;
  const QuoteField({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeData.colorScheme.onPrimary),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    quote.quote.isNotEmpty
                        ? '''" ${quote.quote}" '''
                        : emptyQuote,
                    style: themeData.textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '@${quote.author}',
                      style: themeData.textTheme.bodyText1!
                          .copyWith(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
