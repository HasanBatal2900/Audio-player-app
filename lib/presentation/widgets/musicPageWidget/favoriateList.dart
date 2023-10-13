import 'package:audio_test/core/util/Navigation/Navigations.dart';
import 'package:audio_test/presentation/providers/favoriateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../audioCard.dart';

class FavoraiteSonsList extends ConsumerStatefulWidget {
  const FavoraiteSonsList({super.key});

  @override
  ConsumerState<FavoraiteSonsList> createState() => _FavoraiteSonsList();
}

class _FavoraiteSonsList extends ConsumerState<FavoraiteSonsList>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var favoriateSongs = ref.watch(favoraiteProvider);

    Widget content = favoriateSongs.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "images/lotties/fav1.json",
                height: 300,
              ),
              FadeTransition(
                opacity: animation,
                child: const Text(
                  "There is no Favoraite Songs Add some of it!!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        : ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CustomAudioNav(currentIndex: index, isFavoriate: true),
                );
              },
              child: AudioCard(
                songInfo: favoriateSongs[index],
              ),
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            itemCount: favoriateSongs.length,
          );
    return content;
  }
}
