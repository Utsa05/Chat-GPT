import 'package:chat_gpt/presenations/constants/string.dart';
import 'package:chat_gpt/presenations/pages/home/home.dart';
import 'package:chat_gpt/presenations/pages/splash/splash.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppString.initialRoute:
        return pageRoute(const SplashPage());
      case AppString.homeRoute:
        return pageRoute(const HomePage());
      default:
        return pageRoute(const ErrorRoutePage());
    }
  }
}

MaterialPageRoute pageRoute(Widget page) {
  return MaterialPageRoute(builder: (b) => page);
}

class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Route page"),
      ),
    );
  }
}
