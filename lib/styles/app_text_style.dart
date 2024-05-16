import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text_colors.dart';

class AppTextStyle {
  static const _regular =
      TextStyle(fontFamily: 'KoPub', fontWeight: FontWeight.w400);
  static const _medium =
      TextStyle(fontFamily: 'KoPub', fontWeight: FontWeight.w500);
  static const _bold =
      TextStyle(fontFamily: 'KoPub', fontWeight: FontWeight.w700);

  // header
  static TextStyle header40({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 40.sp, color: color);

  static TextStyle header32({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 32.sp, color: color);

  static TextStyle header28({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 28.sp, color: color);

  static TextStyle header24({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 24.sp, color: color);

  static TextStyle header22({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 22.sp, color: color);

  static TextStyle header20({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 20.sp, color: color);

  // body
  static TextStyle body20B({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 20.sp, color: color);

  static TextStyle body20M({Color color = AppColors.mainText}) =>
      _medium.copyWith(fontSize: 20.sp, color: color);

  static TextStyle body20R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 20.sp, color: color);

  static TextStyle body18B({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 18.sp, color: color);

  static TextStyle body18M({Color color = AppColors.mainText}) =>
      _medium.copyWith(fontSize: 18.sp, color: color);

  static TextStyle body18R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 18.sp, color: color);

  static TextStyle body16B({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 16.sp, color: color);

  static TextStyle body16M({Color color = AppColors.mainText}) =>
      _medium.copyWith(fontSize: 16.sp, color: color);

  static TextStyle body16R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 16.sp, color: color);

  static TextStyle body15B({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 15.sp, color: color);

  static TextStyle body15M({Color color = AppColors.mainText}) =>
      _medium.copyWith(fontSize: 15.sp, color: color);

  static TextStyle body15R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 15.sp, color: color);

  static TextStyle body14B({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 14.sp, color: color);

  static TextStyle body14M({Color color = AppColors.mainText}) =>
      _medium.copyWith(fontSize: 14.sp, color: color);

  static TextStyle body14R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 14.sp, color: color);

  static TextStyle body12B({Color color = AppColors.mainText}) =>
      _bold.copyWith(fontSize: 12.sp, color: color);

  static TextStyle body12M({Color color = AppColors.mainText}) =>
      _medium.copyWith(fontSize: 12.sp, color: color);

  static TextStyle body12R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 12.sp, color: color);

  static TextStyle body8R({Color color = AppColors.mainText}) =>
      _regular.copyWith(fontSize: 8.sp, color: color);
}
