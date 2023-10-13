import 'package:audio_query/audio_query.dart';
import 'package:audio_test/core/util/loadAudioFiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllSongsNotifier extends StateNotifier<List<SongInfo>> {
  AllSongsNotifier()
      : super(
          [],
        );
//  Add or Remove or etc...
  void setAllSong() async {
    var songs = await loadAudioFiles();
    state = [...songs];
  }

  sortSongListInc() {
    List<SongInfo> sortedList = state;
    sortedList.sort(
      (a, b) => a.title.compareTo(b.title),
    );
    state = [...sortedList];
  }

  sortSongListDesc() {
    List<SongInfo> sortedList = state;
    sortedList.sort(
      (a, b) => b.title.compareTo(a.title),
    );
    state = [...sortedList];
  }

  sortSongListByArtistName() {
    List<SongInfo> sortedList = state;
    sortedList.sort(
      (a, b) => a.artist.compareTo(b.artist),
    );
    state = [...sortedList];
  }

  shuffleSongList() {
    List<SongInfo> temp = state;
    temp.shuffle();
    state = temp;
  }

  removeSong(SongInfo songInfo) {
    bool isHere = state.contains(songInfo);

    if (isHere) {
      state = state.where((song) => song.id != songInfo.id).toList();
    } else {
      throw Exception("Sorry The Song is'not found to be removed ):");
    }
  }
}

final allSongsProvider =
    StateNotifierProvider<AllSongsNotifier, List<SongInfo>>(
  (ref) => AllSongsNotifier(),
);


    // for (var i = 0; i <sortedList.length-1; i++) {
    //   if(sortedList[i].title>sortedList[i+1].title){

    //   }

    // }
