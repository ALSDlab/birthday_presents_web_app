//버튼 1개 다이얼로그 : 결제완료/실패

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../styles/app_text_style.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String imagePath;
  final String title;
  final String? subtitle;
  final String firstButton;

  OneAnswerDialog(
      {super.key,
        required this.onTap,
        required this.title,
        required this.firstButton, required this.imagePath, this.subtitle});

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
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16)
            ),
            Visibility(
                visible: (subtitle !=  null),
                child: SizedBox(height: 10)),
            Visibility(
              visible: (subtitle != null),
              child: Text(
                subtitle ?? '',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: 100,
              height: 32,
              child: ElevatedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    // shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.zero),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: const Color(0xFF2F362F)),
                  child: Text(firstButton,
                      style: TextStyle(fontSize: 14, color: Colors.white))),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}