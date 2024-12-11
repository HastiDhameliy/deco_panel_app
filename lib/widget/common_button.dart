import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Util/Constant/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool showRippleEffect; // Ripple effect control
  final bool isLoading; // Flag to control loading state
  final double? width; // Optional width for flexibility
  final double? height; // Optional height for flexibility
  final Color enabledColor;
  final Color? disabledColor;
  final Color? boxShadowColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.showRippleEffect = false, // Default to no ripple
    this.isLoading = false, // Default to not loading
    this.width,
    this.height,
    this.enabledColor = AppColors.colorF45,
    this.disabledColor,
    this.textStyle,
    this.padding,
    this.boxShadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          splashColor: showRippleEffect && isEnabled
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          onTap: isEnabled && !isLoading ? onPressed : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isEnabled
                  ? enabledColor
                  : disabledColor ?? AppColors.buttonSplashColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: boxShadowColor ?? Colors.black.withOpacity(0.2),
                  blurRadius: 6.0,
                  offset: const Offset(0, 6.0),
                ),
              ],
            ),
            padding: padding ??
                const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding * 2),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      text,
                      style: textStyle ??
                          GoogleFonts.poppins(
                            fontSize: Get.height / 65,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
