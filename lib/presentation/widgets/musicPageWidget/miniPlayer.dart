import 'package:audio_test/presentation/widgets/musicPageWidget/glass_card.dart';
import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key,});


  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        MiniGlassPlayer(
          height: 70,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Music Name"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Songer Name"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.skip_next, color: Colors.white, size: 24),
                      SizedBox(width: 10),
                      Icon(Icons.play_arrow, color: Colors.white, size: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: LinearProgressIndicator(
            value: 0.2, //Give it the currentDuration of the audio
            minHeight: 3,

            color: Colors.red,
          ),
        )
      ],
    );
  }
}
