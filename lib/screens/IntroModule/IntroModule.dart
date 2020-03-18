import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroModule extends StatelessWidget {
  static String route = "/intro";

  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> _pages = [
      PageViewModel(
          body: "HELLO WORLD",
          titleWidget: AppBar(
            title: Text("Something"),
          )),
      PageViewModel(
        body: "HELLO WORLD",
        title: "Welcome",
        footer: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back"),
        ),
      )
    ];
    return IntroductionScreen(
      pages: _pages,
      onDone: () {
        Navigator.pop(context);
      },
      showSkipButton: true,
      next: const Icon(Icons.arrow_forward),
      skip: const Text("Skip"),
      done: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
