import 'package:audioplayers/audioplayers.dart';

import 'dropItem_List.dart';

late AudioPlayer audioPlayer;

Duration audioDuration = const Duration();
bool isPlaying = false;
var currentSpeedSelected = drops[1].value;
Duration currentDurationProgress = Duration.zero;
double currentSpeedRate = 1;
void initAudio(String musicPath) async {
  audioPlayer = AudioPlayer();
  await audioPlayer.setSource(
    DeviceFileSource(musicPath),
  );
  audioDuration = await audioPlayer.getDuration() as Duration;
  audioPlayer.setPlaybackRate(currentSpeedRate);
}

void increasDurationPlayer() async {
  final currentPosition = await audioPlayer.getCurrentPosition();
  await audioPlayer.seek(
    currentPosition! + const Duration(milliseconds: 10000),
  );
}

 getTotalDuration() async {
  audioDuration = await audioPlayer.getDuration() as Duration;
}

void decreaseDurationPlayer() async {
  final currentPosition = await audioPlayer.getCurrentPosition();

  await audioPlayer.seek(
    currentPosition! - const Duration(milliseconds: 10000),
  );
}

void setSpeed(double speedRate) {
  audioPlayer.setPlaybackRate(speedRate);
}

setNextSettings() {
  currentDurationProgress = Duration.zero;
  if (isPlaying) {
    isPlaying = !isPlaying;
    audioPlayer.stop();
  }
}
