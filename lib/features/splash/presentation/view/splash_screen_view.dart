import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../../auth/presentation/view/login_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  Widget build(BuildContext context) {
    Color customColor =
        const Color.fromARGB(255, 224, 235, 240); // Hex color: #97C8A8

    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/logo.png'),
      splashIconSize: 200, // Replace with your image path
      duration: 3000,
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: customColor,
      nextScreen: const LoginView(),
    );
  }
}
