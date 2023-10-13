import 'dart:io';

import 'package:audio_query/audio_query.dart';
import 'package:audio_test/core/util/premission.dart';
import 'package:path_provider/path_provider.dart';

Future<List<SongInfo>> loadAudioFiles() async {
  List<SongInfo> songs = [];

  // Get the external storage directory
  Directory? storageDirectory = await getExternalStorageDirectory();

  if (storageDirectory != null) {
    // Initialize the FlutterAudioQuery instance
    FlutterAudioQuery audioQuery = FlutterAudioQuery();
    requstPremission();
    // Get all the songs from the external storage directory
    songs = await audioQuery.getSongs(sortType: SongSortType.RECENT_YEAR);
  
  }

  return songs;
}
