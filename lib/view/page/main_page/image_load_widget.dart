import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadWidget extends StatelessWidget {
  ImageLoadWidget({
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
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
