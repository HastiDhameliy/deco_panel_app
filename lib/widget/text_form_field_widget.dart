import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Util/Constant/app_colors.dart';
import '../Util/Constant/app_style.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final BorderRadius? borderRadius;

  const CommonTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onTap,
    this.textStyle,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.contentPadding,
    this.fillColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      style: textStyle ??
          AppStyle.textStyleMedium16(fontColor: AppColors.hintColor),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counter: null,
        counterText: "",
        fillColor: fillColor ?? AppColors.colorF91.withOpacity(0.15),
        filled: true,
        hintStyle: hintStyle ??
            AppStyle.textStyleMedium16(fontColor: AppColors.hintColor),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorF91),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 3)),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorF91),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 3)),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 3)),
            ),
        border: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorF91),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 3)),
            ),
      ),
    );
  }
}

class CommonDropdownField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final BorderRadius? borderRadius;
  final Color? fillColor;

  const CommonDropdownField({
    super.key,
    this.items,
    this.value,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.borderRadius,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items,
      value: value,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor ?? AppColors.color2F2,
        filled: true,
        hintStyle: hintStyle ??
            GoogleFonts.ptSans(
              fontSize: Get.height / 55,
              fontWeight: FontWeight.w400,
              color: AppColors.colorCBC,
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorDDD),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius / 1.2)),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorDDD),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius / 1.2)),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius / 1.2)),
            ),
        border: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorDDD),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius / 1.2)),
            ),
      ),
      style: textStyle ??
          GoogleFonts.ptSans(
            fontSize: Get.height / 55,
            fontWeight: FontWeight.w500,
            color: AppColors.color333,
          ),
    );
  }
}

class CustomRoundedTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? isObscure;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? enabled;
  final int? maxLength;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final TextInputAction? textInputAction;

  const CustomRoundedTextField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.isObscure = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.enabled,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.onTap,
    this.textStyle,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.contentPadding,
    this.fillColor,
    this.borderRadius,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscure ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        counterText: "",
        labelStyle: GoogleFonts.poppins(
          fontSize: Get.height / 45,
          fontWeight: FontWeight.w400,
          color: AppColors.color333,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: fillColor ?? AppColors.colorF91.withOpacity(0.15),
        filled: false,
        hintStyle: hintStyle ??
            GoogleFonts.poppins(
              fontSize: Get.height / 55,
              fontWeight: FontWeight.w300,
              color: AppColors.colorF91,
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding * 1.1),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.colorF45, width: 1.3),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 5)),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.colorF45, width: 1.3),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 5)),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.3),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 5)),
            ),
        border: enabledBorder ??
            OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.colorF45, width: 1.3),
              borderRadius: borderRadius ??
                  const BorderRadius.all(Radius.circular(defaultRadius * 5)),
            ),
      ),
      style: textStyle ??
          AppStyle.textStyleSemiBold16(fontColor: AppColors.darkHintColor),
    );
  }
}
