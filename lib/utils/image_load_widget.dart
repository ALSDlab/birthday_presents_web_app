import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myk_market_app/utils/gif_progress_bar.dart';

class ImageLoadWidget extends StatefulWidget {
  const ImageLoadWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.fit,
    this.height,
  });

  final String imageUrl;
  final double width;
  final double? height;
  final BoxFit fit;

  @override
  _ImageLoadWidgetState createState() => _ImageLoadWidgetState();
}

class _ImageLoadWidgetState extends State<ImageLoadWidget> {
  double? _calculatedHeight;

  @override
  void initState() {
    super.initState();
    _fetchImageSize();
  }

  void _fetchImageSize() {
    final image = Image.network(widget.imageUrl);
    final ImageStream stream = image.image.resolve(const ImageConfiguration());
    stream.addListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {
        final double aspectRatio = info.image.width / info.image.height;
        setState(() {
          _calculatedHeight = widget.width / aspectRatio;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double? height = widget.height ?? _calculatedHeight;
    return _calculatedHeight == null
        ? const Center(
            child: GifProgressBar(),
          )
        : CachedNetworkImage(
      width: widget.width,
      height: height,
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: widget.fit,
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
