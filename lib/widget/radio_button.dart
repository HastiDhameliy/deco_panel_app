import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Util/Constant/app_colors.dart';

class RadioButtonWithSplash extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final String label;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyPolicyTap;

  const RadioButtonWithSplash({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.label,
    required this.onTermsTap,
    required this.onPrivacyPolicyTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      splashColor: Colors.blue.withOpacity(0.2),
      //onTap: () => onChanged(!isSelected),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MshCheckbox(
            isChecked: isSelected,
            onChanged: (value) => onChanged(value),
            checkedColor: AppColors.colorADB,
            uncheckedColor: AppColors.colorADB,
            checkedIconColor: AppColors.buttonColor,
            uncheckedIconColor: AppColors.whiteColor,
            size: 25.0,
          ),
          SizedBox(
            width: AppSize.displayWidth(context) * 0.05,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "I accept the ",
                  style: GoogleFonts.ptSans(
                    fontSize: Get.height / 52,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorA6D,
                  ),
                ),
                TextSpan(
                  text: "terms & condition",
                  style: GoogleFonts.ptSans(
                    fontSize: Get.height / 52,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color449,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MshCheckbox extends StatefulWidget {
  final bool isChecked; // Current checkbox state
  final ValueChanged<bool> onChanged; // Function to handle changes
  final Color? checkedColor; // Color when checked
  final Color? uncheckedColor; // Color when unchecked
  final Color? checkedIconColor; // Color when checked
  final Color? uncheckedIconColor; // Color when unchecked
  final double size; // Size of the checkbox

  const MshCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.checkedColor,
    this.uncheckedColor = Colors.grey,
    this.size = 24.0,
    this.checkedIconColor,
    this.uncheckedIconColor,
  });

  @override
  MshCheckboxState createState() => MshCheckboxState();
}

class MshCheckboxState extends State<MshCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkSparkle.splashFactory,
      splashColor: Colors.blue.withOpacity(0.2),
      // Customize splash color
      onTap: () {
        // Toggle the checkbox state on tap
        widget.onChanged(!widget.isChecked);
      },
      borderRadius: BorderRadius.circular(widget.size / 2),
      // Make the splash circular

      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.isChecked ? widget.checkedColor : widget.uncheckedColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_outlined,
          color: widget.isChecked
              ? widget.checkedIconColor
              : widget.uncheckedIconColor,
          size: widget.size * 0.7, // Adjust icon size
        ),
      ),
    );
  }
}
