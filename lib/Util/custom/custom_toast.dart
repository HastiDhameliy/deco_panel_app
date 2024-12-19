import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum ToastType { success, error, warning }

void customToast(BuildContext context, String msg, ToastType type) {
  // Determine the icon based on the ToastType
  Icon icon;

  switch (type) {
    case ToastType.success:
      icon = const Icon(Icons.check_circle, color: Colors.white, size: 28);
      break;
    case ToastType.error:
      icon = const Icon(Icons.error, color: Colors.white, size: 28);
      break;
    case ToastType.warning:
      icon = const Icon(Icons.warning, color: Colors.white, size: 28);
      break;
  }

  showToastWidget(
    Container(
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        // Semi-transparent black background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 14),
          Flexible(
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white, // White text
                fontSize: 16.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
    context: context,
    duration: const Duration(seconds: 2),
    // Short duration for simple toasts
    animation: StyledToastAnimation.fade,
    // Simple fade animation
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.bottom,
    // Toast appears at the bottom
    animDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeOut,
  );
}
