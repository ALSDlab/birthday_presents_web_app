//버튼 1개 다이얼로그 : 비밀번호 찾기, 회원가입 실패, 로그인 실패, 그룹관리변경/추가

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../styles/app_text_style.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  final String firstButton;

  const OneAnswerDialog(
      {super.key,
        required this.onTap,
        required this.title,
        required this.subtitle,
        required this.firstButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        width: 270.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/dialog_cookie.gif',
              width: 70.w,
              height: 70.h,
            ),
            Text(
              title,
              style: AppTextStyle.body18R(),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              style: AppTextStyle.body12R(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 75.w,
              height: 28.h,
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