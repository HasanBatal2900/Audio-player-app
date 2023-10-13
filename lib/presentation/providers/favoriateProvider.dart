import 'package:audio_query/audio_query.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriateSongNotifier extends StateNotifier<List<SongInfo>> {
  FavoriateSongNotifier() : super([]);

  bool addToFavoriate(SongInfo songInfo) {
    final isHere = state.contains(songInfo);

    if (!isHere) {
      state = [...state, songInfo];
      return true;
    } else {
      state = state.where((song) => song.id != songInfo.id).toList();
      return false;
    }
  }

  removeFromFavoriate(SongInfo songInfo) {
    state = state.where((song) => song.id != songInfo.id).toList();
  }
}

final favoraiteProvider =
    StateNotifierProvider<FavoriateSongNotifier, List<SongInfo>>((ref) {
  return FavoriateSongNotifier();
});
