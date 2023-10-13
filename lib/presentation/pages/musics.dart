import 'dart:developer';

import 'package:audio_query/audio_query.dart';
import 'package:audio_test/presentation/providers/allSongsProvider.dart';
import 'package:audio_test/presentation/widgets/musicPageWidget/allSongList.dart';
import 'package:audio_test/presentation/widgets/musicPageWidget/favoriateList.dart';
import 'package:audio_test/presentation/widgets/musicPageWidget/show_menu_btn.dart';
import 'package:audio_test/presentation/widgets/musicPageWidget/tabBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../widgets/musicPageWidget/miniPlayer.dart';

class SongListScreen extends ConsumerStatefulWidget {
  const SongListScreen({super.key});

  @override
  ConsumerState<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends ConsumerState<SongListScreen>
    with TickerProviderStateMixin {
  String? keySeacrch;
  bool isSearching = false;
  List<SongInfo> mySongs = [];
  List<SongInfo> filtredMusic = [];

  late TabController _tabController;
  late TextEditingController _textEditingController;
  late AnimationController fadeController;

  late AnimationController upController;
  late Animation<double> upAnimation;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _textEditingController = TextEditingController();

    fadeController = AnimationController(
      vsync: this,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(
        milliseconds: 500,
      ),
    )..addStatusListener(
        (state) {
          if (state == AnimationStatus.completed) {
            fadeController.forward();
          }
        },
      );
    ref.read(allSongsProvider.notifier).setAllSong();

    upController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));
    upAnimation = CurvedAnimation(curve: Curves.bounceIn, parent: upController);
    upController.forward();
  }

  void getFilteredSongs() {
    setState(() {
      filtredMusic = mySongs.where((song) {
        return song.title.startsWith(keySeacrch!) ||
            song.title.contains(keySeacrch!);
      }).toList();
    });
  }

  @override
  void dispose() {
    fadeController.dispose();
    upController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SongInfo> mySongs = ref.watch(allSongsProvider);
    var filteredEmpty = filtredMusic.isEmpty;
    Widget allSongOrFiltered = isSearching && !filteredEmpty
        ? AllSongList(allSongs: filtredMusic)
        : isSearching && filteredEmpty && keySeacrch != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("images/lotties/sorry.json"),
                  const Center(
                    child: Text(
                      "Sorry There is no music  ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : isSearching && filteredEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        "images/lotties/fav.json",
                        height: 300,
                      ),
                      const Center(
                        child: Text(
                          "Type The music name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : AllSongList(allSongs: mySongs);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 33, 67),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                const ShowMenuButton(),
                TabBarWidget(
                  tabController: _tabController,
                ),
                !isSearching
                    ? IconButton(
                        onPressed: () {
                          fadeController.forward();
                          setState(
                            () {
                              isSearching = !isSearching;
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          weight: 50,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            ScaleTransition(
              scale: fadeController,
              child: isSearching
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 40,
                          width: 260,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                keySeacrch = value;

                                getFilteredSongs();
                              });
                            },
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: "Enter Music name !",
                              hintStyle: const TextStyle(fontSize: 12),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              log(
                                filtredMusic.length.toString(),
                              );
                              fadeController.reverse(
                                from: 1,
                              );
                              await Future.delayed(
                                  const Duration(milliseconds: 300), () {
                                setState(() {
                                  isSearching = false;
                                });
                              });
                              _textEditingController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                              minimumSize: const Size(40, 40),
                            ),
                            child: const Text("Close"),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            Expanded(
              child: TabBarView(
                physics: const ClampingScrollPhysics(),
                controller: _tabController,
                children: [
                  AnimatedBuilder(
                    animation: upAnimation,
                    child: allSongOrFiltered,
                    builder: (context, child) => Padding(
                      padding: EdgeInsets.only(
                        top: 300 - 300 * upAnimation.value,
                      ),
                      child: child,
                    ),
                  ),
                  const FavoraiteSonsList(),
                ],
              ),
            ),
           const  MiniPlayer(),
          ],
        ),
      ),
    );
  }
}



            // const Stack(
            //   children: [
            //     MiniGlassPlayer(
            //       height: 70,
            //       width: double.infinity,
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text("Music Name"),
            //                 SizedBox(
            //                   height: 5,
            //                 ),
            //                 Text("Songer Name"),
            //               ],
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(right: 8.0),
            //               child: Row(
            //                 children: [
            //                   Icon(Icons.skip_next,
            //                       color: Colors.white, size: 24),
            //                   SizedBox(width: 10),
            //                   Icon(Icons.play_arrow,
            //                       color: Colors.white, size: 24),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 2),
            //       child: LinearProgressIndicator(
            //         value: 0.2, //Give it the currentDuration of the audio
            //         minHeight: 3,

            //         color: Colors.red,
            //       ),
            //     )
            //   ],
            // ),
