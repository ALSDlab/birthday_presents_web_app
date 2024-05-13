import 'package:flutter/material.dart';

class GifProgressBar extends StatelessWidget {
  const GifProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage("assets/gifs/loading_animation.gif"),
      ),
    );
  }
}
