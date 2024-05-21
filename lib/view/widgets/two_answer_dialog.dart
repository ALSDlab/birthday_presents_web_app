//기본 다이얼로그

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_text_style.dart';

class TwoAnswerDialog extends StatelessWidget {
  final Function() onFirstTap;
  final Function() onSecondTap;
  final String title;
  final String? subtitle;
  final String imagePath;
  final String firstButton;
  final String secondButton;

  const TwoAnswerDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.firstButton,
    required this.secondButton,
    required this.imagePath,
    required this.onFirstTap,
    required this.onSecondTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        width: 300,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16)),
            Visibility(
                visible: (subtitle != null), child: const SizedBox(height: 10)),
            Visibility(
              visible: (subtitle != null),
              child: Text(
                subtitle ?? '',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 32,
                  child: ElevatedButton(
                      onPressed: onFirstTap,
                      style: OutlinedButton.styleFrom(
                          // shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.zero),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor: const Color(0xFF2F362F)),
                      child: Text(firstButton,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white))),
                ),
                const SizedBox(width: 14),
                SizedBox(
                  width: 100,
                  height: 32,
                  child: ElevatedButton(
                      onPressed: onSecondTap,
                      style: OutlinedButton.styleFrom(
                          // shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.zero),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor: Colors.grey.shade200),
                      child: Text(secondButton,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black))),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
