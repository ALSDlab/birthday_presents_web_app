import 'package:flutter/material.dart';

class RoundedImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final double width;
  final double height;

  const RoundedImageButton(
      {super.key,
      required this.imagePath,
      required this.onTap,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), // 둥근 모서리 반경 설정
        child: Container(
          width: width, // 너비 설정
          height: height, // 높이 설정
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
