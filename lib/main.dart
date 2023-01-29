import 'package:chat_gpt/presenations/constants/color.dart';
import 'package:chat_gpt/presenations/constants/string.dart';
import 'package:chat_gpt/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: AppColor.primaryColor),
        scaffoldBackgroundColor: AppColor.primaryColor,
        primaryColor: AppColor.primaryColor,
      ),
      initialRoute: AppString.initialRoute,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
