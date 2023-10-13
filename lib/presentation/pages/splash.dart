import 'package:audio_test/core/util/Navigation/Navigations.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late AnimationController controller;
late AnimationController turnController;

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1600,
      ),
      value: 0.5,
      lowerBound: 0.5,
      upperBound: 1,
    )..repeat(
        reverse: true,
      );
    turnController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    );
    turnController.forward();

    turnController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,CustomHomeNav(),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    turnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 38, 56),
      body: RotationTransition(
        alignment: Alignment.center,
        turns: Tween<double>(begin: 0, end: 1).animate(turnController),
        child: ScaleTransition(
          scale: controller,
          child: Center(
            child: Image.asset(
              "images/splash.png",
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}
