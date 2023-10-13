// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_query/audio_query.dart';

class SongDetails {
  SongInfo songInfo;
  Duration currentDuration;
  Duration totalDuration;
  SongDetails({
    required this.songInfo,
    required this.currentDuration,
    required this.totalDuration,
  });
}
