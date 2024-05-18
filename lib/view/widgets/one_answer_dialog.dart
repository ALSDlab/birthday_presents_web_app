//버튼 1개 다이얼로그 : 결제완료/실패

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../styles/app_text_style.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String imagePath;
  final String title;
  final String subtitle;
  final String firstButton;

  const OneAnswerDialog(
      {super.key,
        required this.onTap,
        required this.title,
        required this.subtitle,
        required this.firstButton, required this.imagePath});

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
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16)
            ),
            SizedBox(height: 15),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 100,
              height: 32,
              child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BC6CC)),
                  child: Text(firstButton,
                      style: TextStyle(fontSize: 14))),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}