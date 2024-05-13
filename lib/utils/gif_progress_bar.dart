import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class GifProgressBar extends StatefulWidget {
  const GifProgressBar({super.key});

  @override
  State<GifProgressBar> createState() => _GifProgressBarState();
}

class _GifProgressBarState extends State<GifProgressBar>
    with TickerProviderStateMixin {
  late final GifController _controller;

  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Gif(
      image: const AssetImage("assets/gifs/loading_animation.gif"),
      width: 50,
      height: 50,
      controller: _controller,
      // if duration and fps is null, original gif fps will be used.
      //fps: 30,
      //duration: const Duration(seconds: 3),
      autostart: Autostart.no,
      onFetchCompleted: () {
        _controller.reset();
        _controller.forward();
      },
    );
  }
}
