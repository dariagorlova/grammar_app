import 'package:flutter/material.dart';
import 'package:grammar_app/presentation/pages/grammar_theme/theme_screen.dart';

class AllThemesScreen extends StatelessWidget {
  const AllThemesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose theme for learning'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ThemeScreen()));
                },
                child: const Text('Present Simple')),
          ),
        ],
      ),
    );
  }
}
