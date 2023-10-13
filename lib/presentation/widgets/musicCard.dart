import 'package:flutter/material.dart';

class MusicCard extends StatefulWidget {
  const MusicCard({
    super.key,
  });
  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 3600,
      ),
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "images/disk.png",
        height: 300,
      ),
    );
  }
}



// Container(
//       width: double.infinity,
//       height: 300,
//       margin: const EdgeInsets.all(20.0),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           color: Colors.deepPurple, borderRadius: BorderRadius.circular(30.0)),
//       child: const Text(
//         "Click The Button To Start!",
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//     );