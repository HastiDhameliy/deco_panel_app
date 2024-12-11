import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Util/Constant/app_colors.dart';
import '../Util/Constant/app_size.dart';

class QuantityPicker extends StatefulWidget {
  final int initialQuantity;
  final int minQuantity;
  final int maxQuantity;
  final String? labelText;
  final void Function(int)? onQuantityChanged;

  const QuantityPicker({
    super.key,
    this.initialQuantity = 1,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    this.labelText,
    this.onQuantityChanged,
  });

  @override
  QuantityPickerState createState() => QuantityPickerState();
}

class QuantityPickerState extends State<QuantityPicker> {
  late int _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    if (_currentQuantity < widget.maxQuantity) {
      setState(() {
        _currentQuantity++;
      });
      widget.onQuantityChanged?.call(_currentQuantity);
    }
  }

  void _decrementQuantity() {
    if (_currentQuantity > widget.minQuantity) {
      setState(() {
        _currentQuantity--;
      });
      widget.onQuantityChanged?.call(_currentQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: GoogleFonts.ptSans(
                  fontSize: AppSize.displayHeight(context) * 0.017,
                  fontWeight: FontWeight.w700,
                  color: AppColors.colorB5B),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          decoration: BoxDecoration(
            color: AppColors.color2F2,
            borderRadius:
                BorderRadius.circular(defaultRadius * 1), // Matches Dropdown
            border: Border.all(color: AppColors.colorDDD),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: AppColors.colorCBC,
                  size: AppSize.displayHeight(context) * 0.02,
                ),
                onPressed: _decrementQuantity,
              ),
              Expanded(
                child: Text(
                  '$_currentQuantity',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ptSans(
                    fontSize: Get.height / 55,
                    fontWeight: FontWeight.w500,
                    color: AppColors.color333,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: AppColors.colorCBC,
                  size: AppSize.displayHeight(context) * 0.02,
                ),
                onPressed: _incrementQuantity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
