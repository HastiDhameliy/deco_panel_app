import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum ToastType { success, error, warning }

void customToast(BuildContext context, String msg, ToastType type) {
  // Determine properties based on the ToastType
  Color backgroundColor;
  Icon icon;

  switch (type) {
    case ToastType.success:
      backgroundColor = Colors.white; // Green for success
      icon = const Icon(Icons.check_circle, color: Colors.black, size: 28);
      break;
    case ToastType.error:
      backgroundColor = Colors.red.withOpacity(0.9); // Red for error
      icon = const Icon(Icons.error, color: Colors.white, size: 28);
      break;
    case ToastType.warning:
      backgroundColor = Colors.amber.withOpacity(0.9); // Amber for warning
      icon = const Icon(Icons.warning, color: Colors.white, size: 28);
      break;
  }

  showToastWidget(
    Container(
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(defaultRadius / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 14),
          Flexible(
            child: Text(
              msg,
              style: TextStyle(
                color: type == ToastType.success ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
    context: context,
    duration: const Duration(seconds: 4),
    // Increased duration for better visibility
    animation: StyledToastAnimation.slideFromBottomFade,
    // A stronger animation
    reverseAnimation: StyledToastAnimation.slideToBottomFade,
    position: StyledToastPosition.bottom,
    // Bottom position for better UX
    animDuration: const Duration(milliseconds: 500),
    // Longer animation duration
    curve: Curves.fastOutSlowIn,
    reverseCurve: Curves.easeOut,
  );
}
