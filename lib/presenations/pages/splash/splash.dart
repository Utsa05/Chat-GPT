import 'dart:async';

import 'package:chat_gpt/presenations/constants/color.dart';
import 'package:chat_gpt/presenations/constants/string.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  @override
  void initState() {
    _changePage();
    super.initState();
  }

  _changePage() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushReplacementNamed(context, AppString.homeRoute);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/no_bg_icon.png',
              height: 100.0,
            ),
            const SizedBox(
              height: 4.0,
            ),
            const Text(
              AppString.appName,
              style: TextStyle(fontSize: 25.0, color: AppColor.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
