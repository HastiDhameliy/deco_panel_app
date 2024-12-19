import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Util/Constant/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool showRippleEffect;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color enabledColor;
  final Color? disabledColor;
  final Color? boxShadowColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const CommonButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.isEnabled = true,
    this.showRippleEffect = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.enabledColor = AppColors.colorF45,
    this.disabledColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.boxShadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: boxShadowColor ?? Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
                offset: const Offset(0, 4.0),
              ),
            ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
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
              borderRadius: borderRadius ?? BorderRadius.circular(8.0),
            ),
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Center(
              child: isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: height != null ? height! * 0.4 : 20, // Scaled size
                    )
                  : child ??
                      Text(
                        text ?? "",
                        style: textStyle ??
                            GoogleFonts.poppins(
                              fontSize: Get.height / 60,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
