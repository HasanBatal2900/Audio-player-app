import 'dart:ui';

import 'package:flutter/material.dart';

class MiniGlassPlayer extends StatelessWidget {
  const MiniGlassPlayer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
  });
  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.18),
                ),
                borderRadius: BorderRadius.circular(7.0),
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0.1),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
