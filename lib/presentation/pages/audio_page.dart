import 'dart:developer';

import 'package:audio_query/audio_query.dart';
import 'package:audio_test/core/util/snakBars/snakBar.dart';
import 'package:audio_test/presentation/providers/allSongsProvider.dart';
import 'package:audio_test/presentation/providers/favoriateProvider.dart';
import 'package:audio_test/presentation/widgets/musicCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import '../../core/constants/dropItem_List.dart';
import '../widgets/progreesBar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../core/constants/audio_control.dart';

class AudioPage extends ConsumerStatefulWidget {
  const AudioPage(
      {super.key, required this.isFavoriate, required this.currentIndex});
  final bool isFavoriate;
  final int currentIndex;
  @override
  ConsumerState<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends ConsumerState<AudioPage>
    with TickerProviderStateMixin {
  late AnimationController rotateController;
  late Animation<double> rotateAnimation;

  late AnimationController slideController;
  late Animation<Offset> slideAnimation;

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late List<SongInfo> songList;

  late int currentIndex;
  void changePlayerStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    fadeController.dispose();
    rotateController.dispose();
    slideController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    songList = !widget.isFavoriate
        ? ref.read(allSongsProvider)
        : ref.read(favoraiteProvider);

    currentIndex = widget.currentIndex;
    initAudio(songList[widget.currentIndex].filePath);
    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    ///
    rotateAnimation =
        CurvedAnimation(curve: Curves.linear, parent: rotateController);

    ///

    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    slideAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(slideController);

    ///
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(fadeController);

    ///

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        audioDuration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        currentDurationProgress = event;
      });
    });
    audioPlayer.onPlayerStateChanged.listen(
      (event) async {
        if (event == PlayerState.completed && loop) {
          audioPlayer.play(
            DeviceFileSource(songList[widget.currentIndex].filePath),
          );
        } else if (event == PlayerState.completed) {
          setState(
            () {
              currentIndex++;
              getTotalDuration();
              audioPlayer.play(
                DeviceFileSource(songList[widget.currentIndex].filePath),
              );
            },
          );
        } else if (event == PlayerState.playing) {
          rotateController.repeat();
          slideController.forward();
          fadeController.forward();
        } else if (event == PlayerState.paused ||
            event == PlayerState.stopped) {
          if (mounted) {
            rotateController.stop();
            slideController.reverse(from: 1);
            fadeController.reverse(from: 1);
          }
        }
      },
    );
  }

  bool loop = false;
  bool randomSelection = false;
  @override
  Widget build(BuildContext context) {
    SongInfo songInfo = songList[currentIndex];
    bool addedOrRemoveFav = ref.read(favoraiteProvider).contains(songInfo);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 38, 56),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Now Playing",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          widget.isFavoriate
              ? IconButton(
                  onPressed: () {
                    showMenu(
                      context: context,
                      elevation: 10.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      color: const Color.fromARGB(255, 20, 20, 28),
                      position: const RelativeRect.fromLTRB(200, 40, 220, 150),
                      items: [
                        PopupMenuItem(
                          onTap: () {
                            ref
                                .read(favoraiteProvider.notifier)
                                .removeFromFavoriate(songInfo);

                            Navigator.pop(context);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Remove",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.compactDisc,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Equalzier",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  icon: Image.asset(
                    "images/dots_light.png",
                  ))
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    margin: const EdgeInsets.only(
                        top: 10.0, bottom: 20, left: 20, right: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFb06ab3),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Text(
                      "Click The Button To Start!",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SlideTransition(
                  position: slideAnimation,
                  child: RotationTransition(
                    turns: rotateAnimation,
                    child: const MusicCard(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                songInfo.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                songInfo.artist,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    if (currentIndex - 1 > 0) {
                      setState(() {
                        currentIndex--;
                        log("Current index is $currentIndex");
                        setNextSettings();
                      });
                    } else {
                      setState(() {
                        currentIndex = songList.length - 1;
                        currentDurationProgress = Duration.zero;
                        setNextSettings();
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                ),
                LikeButton(
                  size: 30,
                  likeCountAnimationType: LikeCountAnimationType.all,
                  isLiked: addedOrRemoveFav,
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.red,
                    dotSecondaryColor: Colors.purple,
                  ),
                  circleColor: const CircleColor(
                    start: Colors.purple,
                    end: Colors.cyan,
                  ),
                  onTap: (isPressed) async {
                    setState(() {
                      addedOrRemoveFav = ref
                          .read(favoraiteProvider.notifier)
                          .addToFavoriate(songInfo);
                      buildSnakBar(addedOrRemoveFav, context, () {
                        setState(() {
                          addedOrRemoveFav = ref
                              .read(favoraiteProvider.notifier)
                              .addToFavoriate(songInfo);
                        });
                      });
                    });
                    return !isPressed;
                  },
                ),
                IconButton(
                  onPressed: () async {
                    if (currentIndex + 1 < songList.length - 1) {
                      setState(() {
                        currentIndex++;
                        log("Current index is $currentIndex");
                        currentDurationProgress = Duration.zero;
                        setNextSettings();
                      });
                    } else {
                      setState(() {
                        currentIndex = 0;
                        currentDurationProgress = Duration.zero;
                        setNextSettings();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFb06ab3),
                        Color(0xFF4568dc),
                      ],
                    ),
                  ),
                  width: 80,
                  child: DropdownButton(
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(10.0),
                    icon: const Icon(
                      Icons.slow_motion_video,
                      color: Colors.white,
                      size: 16,
                    ),
                    elevation: 0,
                    underline: const Divider(color: Colors.transparent),
                    isDense: false,
                    value: currentSpeedSelected,
                    dropdownColor: Colors.deepPurple.shade200,
                    items: drops,
                    onChanged: (value) {
                      setState(
                        () {
                          currentSpeedRate = speedRate[value]!;
                          currentSpeedSelected = value;
                          audioPlayer.play(
                            DeviceFileSource(
                              songInfo.filePath,
                            ),
                          );
                          isPlaying = true;
                          setSpeed(currentSpeedRate);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            AudioProgreesBar(
                audioTotalDuration: audioDuration,
                currentDurationProgress: currentDurationProgress,
                onSeek: (value) async {
                  setState(() {
                    currentDurationProgress = value;
                  });
                  await audioPlayer.seek(value);
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  tooltip: "Stop",
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.stop();
                      setState(() {
                        isPlaying = !isPlaying;
                        currentDurationProgress = Duration.zero;
                      });
                    }
                  },
                  icon: isPlaying
                      ? const Icon(
                          Icons.stop,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    if (isPlaying) {
                      decreaseDurationPlayer();
                    }
                  },
                  icon: const Icon(
                    Icons.keyboard_double_arrow_left,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                MaterialButton(
                  enableFeedback: true,
                  animationDuration: const Duration(milliseconds: 400),
                  minWidth: 70,
                  shape: const CircleBorder(),
                  onPressed: () async {
                    if (!isPlaying) {
                      await audioPlayer.play(
                        DeviceFileSource(songInfo.filePath),
                        volume: 1,
                        mode: PlayerMode.mediaPlayer,
                      );

                      changePlayerStatus();
                    } else {
                      await audioPlayer.pause();
                      changePlayerStatus();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFb06ab3),
                          Color(0xFF4568dc),
                        ],
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Icon(
                      !isPlaying ? Icons.play_arrow : Icons.pause,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Play",
                  onPressed: () {
                    if (isPlaying) {
                      increasDurationPlayer();
                    }
                  },
                  icon: const Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                InkWell(
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enableFeedback: false,
                    onDoubleTap: () {
                      songList.shuffle();
                      setState(() {
                        loop = false;
                        randomSelection = !randomSelection;

                        setNextSettings();
                      });
                    },
                    onTap: () {
                      setState(() {
                        loop = !loop;
                      });
                    },
                    child: !randomSelection
                        ? Icon(
                            Icons.loop,
                            color: !loop ? Colors.white : Colors.deepPurple,
                          )
                        : Icon(
                            Icons.shuffle_outlined,
                            color: !randomSelection
                                ? Colors.white
                                : Colors.deepPurple,
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
