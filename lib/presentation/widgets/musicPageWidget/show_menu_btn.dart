import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/allSongsProvider.dart';

class ShowMenuButton extends ConsumerWidget {
  const ShowMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        showMenu(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              7.0,
            ),
          ),
          context: context,
          position: const RelativeRect.fromLTRB(20, 50, 100, 120),
          items: [
            PopupMenuItem(
              onTap: () =>
                  ref.read(allSongsProvider.notifier).sortSongListInc(),
              child: const Text(
                "Sort Increasly",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            PopupMenuItem(
              onTap: () =>
                  ref.read(allSongsProvider.notifier).sortSongListDesc(),
              child: const Text(
                "Sort Decreasly",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            PopupMenuItem(
              onTap: () => ref
                  .read(allSongsProvider.notifier)
                  .sortSongListByArtistName(),
              child: const Text(
                "Sort By Songer Name",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
          color: const Color.fromARGB(255, 20, 20, 28),
        );
      },
      icon: Image.asset(
        "images/dots_light.png",
      ),
    );
  }
}
