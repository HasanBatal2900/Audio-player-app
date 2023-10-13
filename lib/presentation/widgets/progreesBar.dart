// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class AudioProgreesBar extends StatelessWidget {
  const AudioProgreesBar({
    Key? key,
    required this.audioTotalDuration,
    required this.currentDurationProgress,
    required this.onSeek,
  }) : super(key: key);
  final Duration audioTotalDuration;
  final Duration currentDurationProgress;
  final Function(Duration) onSeek;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ProgressBar(
        buffered: audioTotalDuration,
        timeLabelType: TimeLabelType.remainingTime,
        timeLabelTextStyle: const TextStyle(
          color: Colors.white,
        ),
        timeLabelPadding: 10,
        thumbCanPaintOutsideBar: true,
        timeLabelLocation: TimeLabelLocation.below,
        progress: currentDurationProgress,
        total:audioTotalDuration,
        baseBarColor: Colors.grey,
        thumbColor: Colors.deepPurpleAccent,
        thumbRadius: 10,
        thumbGlowColor: Colors.deepPurple.withOpacity(0.5),
        thumbGlowRadius: 20,
        progressBarColor: Colors.deepPurple.shade500,
        onSeek:onSeek,
      ),
    );
  }
}
