import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/utils/gif_progress_bar.dart';

class ImageLoadWidget extends StatelessWidget {
  const ImageLoadWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.widthHeightRatio,
  });

  final String imageUrl;
  final double width;
  final double widthHeightRatio;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: width * widthHeightRatio,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(
        child: GifProgressBar(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
