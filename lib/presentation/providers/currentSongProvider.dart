import 'package:audio_test/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentSongNotifier extends StateNotifier<SongDetails?> {
  CurrentSongNotifier() : super(null);

  setSong(SongDetails songDetails) {
    var currentSong = songDetails;
    state = currentSong;
  }
  
}

final currentSongProvider =
    StateNotifierProvider<CurrentSongNotifier, SongDetails?>(
  (ref) => CurrentSongNotifier(),
);
