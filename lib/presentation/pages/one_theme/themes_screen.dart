import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:grammar_app/domain/entities/theme_entity.dart';
import 'package:flutter/services.dart';

class ThemeScreenWrapperProvider extends StatelessWidget {
  const ThemeScreenWrapperProvider({super.key, required this.group});

  final ThemeEntity group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          group.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: rootBundle.loadString(group.pathToContent),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(data: snapshot.data!);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
