// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// import '../../core/constants/audios.dart';

// class PlayBtn extends StatefulWidget {
//   const PlayBtn({
//     super.key,
//     required this.isPlaying
//   });
//   final bool isPlaying;
//   final Function(void )
//   @override
//   State<PlayBtn> createState() => _PlayBtnState();
// }

// class _PlayBtnState extends State<PlayBtn> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       height: 60,
//       minWidth: 60,
//       color: Colors.red,
//       animationDuration: const Duration(milliseconds: 400),
//       elevation: 6.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//       onPressed: () async {
//         if (!widget.isPlaying) {
//           await audioPlayer.play(
//             AssetSource("1.mp3"),
//             volume: 1,
//             mode: PlayerMode.mediaPlayer,
//           );

//           changePlayerStatus();
//         } else {
//           await audioPlayer.pause();
//           changePlayerStatus();
//         }
//       },
//       splashColor: Colors.pinkAccent,
//       child: Icon(
//         !isPlaying ? Icons.play_arrow : Icons.pause,
//         color: Colors.white,
//       ),
//     );
//   }
// }
