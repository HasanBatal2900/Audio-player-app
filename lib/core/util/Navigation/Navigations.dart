import 'package:audio_test/presentation/pages/home.dart';
import 'package:audio_test/presentation/pages/musics.dart';
import 'package:audio_test/presentation/pages/audio_page.dart';
import 'package:flutter/material.dart';

class CustomAudioNav extends PageRouteBuilder {
  final bool isFavoriate;
  final int currentIndex;
  CustomAudioNav({
    required this.isFavoriate,
    required this.currentIndex,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return AudioPage(
              currentIndex: currentIndex,
              isFavoriate:isFavoriate,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
          barrierColor: Colors.deepPurpleAccent.withOpacity(0.6),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastOutSlowIn,
              parent: animation,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          },
        );
}

class CustomHomeNav extends PageRouteBuilder {
  CustomHomeNav()
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const HomePage();
          },
          transitionDuration: const Duration(milliseconds: 1000),
          barrierColor: Colors.deepPurpleAccent.withOpacity(0.6),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastOutSlowIn,
              parent: animation,
            );
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        );
}

class CustomSongListNav extends PageRouteBuilder {
  CustomSongListNav()
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const SongListScreen();
          },
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastOutSlowIn,
              parent: animation,
            );
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        );
}
