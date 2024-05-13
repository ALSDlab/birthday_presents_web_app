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
        width: 300.w,
        height: 300.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 100.w,
              height: 100.h,
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: AppTextStyle.body18R(),
            ),
            SizedBox(height: 24.h),
            Text(
              subtitle,
              style: AppTextStyle.body14R(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: 100.w,
              height: 32.h,
              child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BC6CC)),
                  child: Text(firstButton,
                      style: AppTextStyle.body12R(color: Colors.white))),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}