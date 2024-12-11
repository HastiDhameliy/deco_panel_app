import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyle {
  static TextStyle textStyleBold30({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 30.0,
      fontWeight: FontWeight.w700,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold20({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold12({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleBold20({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleBold24({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold24({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold18({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold14({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold10({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleBold14({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleBold16({Color? fontColor}) => GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleMedium12({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleMedium10({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleMediumT14({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleMedium16({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleMedium18({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleSemiBold16({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleMedium20({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleRegular14({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleRegular12({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleRegular11({Color? fontColor}) =>
      GoogleFonts.poppins(
          fontSize: 11.0,
          fontWeight: FontWeight.w400,
          color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleBoldT12({Color? fontColor}) => GoogleFonts.poppins(
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
      color: fontColor ?? AppColors.textBlack);

  static TextStyle textStyleBold12 = GoogleFonts.poppins(
      fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white);
  static TextStyle textStyleMedium14 = GoogleFonts.poppins(
      fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.textBlack);
  static TextStyle hintTextMedium12 = GoogleFonts.poppins(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: AppColors.textHint.withOpacity(0.5));
  static TextStyle textFieldSemiBold14 = GoogleFonts.poppins(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.textHint);
  static TextStyle textFieldRegular14 = GoogleFonts.poppins(
      fontSize: 14.0, fontWeight: FontWeight.w400, color: AppColors.textHint);
  static TextStyle textFieldBold16 = GoogleFonts.poppins(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.textHint);

  static TextStyle textRegular10 = GoogleFonts.poppins(
      fontSize: 10.0, fontWeight: FontWeight.w400, color: AppColors.textGrey);
}
