import 'dart:io';

import 'package:audio_query/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AudioCard extends StatefulWidget {
  const AudioCard({super.key, required this.songInfo});

  final SongInfo songInfo;

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  File? selectedImage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:const CircleAvatar(
        radius: 22,
        backgroundColor: Colors.black,
        child: Icon(
          FontAwesomeIcons.compactDisc,
          color: Colors.amber,
          size: 24,
        ),
      ),
      title: Text(
        widget.songInfo.title,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          widget.songInfo.artist,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.play_arrow,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
