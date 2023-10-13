import 'package:audio_test/presentation/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
        
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),

      ),
    );
  }
}
