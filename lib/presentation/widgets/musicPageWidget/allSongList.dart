
import 'package:audio_query/audio_query.dart';
import 'package:audio_test/presentation/providers/allSongsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/Navigation/Navigations.dart';
import '../audioCard.dart';

class AllSongList extends ConsumerWidget {
  const AllSongList({super.key, required this.allSongs});

  final List<SongInfo> allSongs;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(
          context,
          CustomAudioNav(
            isFavoriate: false,
            currentIndex: index,
          ),
        ),
        child: Dismissible(
          resizeDuration: const Duration(
            milliseconds: 300,
          ),
          background: Container(
            color: Colors.red,
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm'),
                  content:const Text('Are you sure you want to remove this song?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.black),
                      child: const Text(
                        'Remove',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          key: ValueKey(allSongs[index].id),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            ref.watch(allSongsProvider.notifier).removeSong(allSongs[index]);
          },
          child: AudioCard(
            songInfo: allSongs[index],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 0.5,
        color: Colors.grey,
      ),
      itemCount: allSongs.length,
    );
  }
}
