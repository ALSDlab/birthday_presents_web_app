import 'package:flutter/material.dart';
import 'package:vitality/vitality.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';



class BackImage extends StatelessWidget {
  const BackImage({super.key});


  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

 @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: loadImage('assets/images/myk_market_logo.png'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Vitality.randomly(
            whenOutOfScreenMode: WhenOutOfScreenMode.Reflect,
            randomItemsColors: const [Color(0xFF2F362F)],
            randomItemsBehaviours: [
              ItemBehaviour(
                shape: ShapeType.Image,
                image: snapshot.data!,
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
