import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/config/constants.dart';

class CustomRadioButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function? onTap;

  const CustomRadioButton(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {widget.onTap},
      child: Row(
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  widget.isSelected ? Colors.transparent : Colors.transparent,
              border: Border.all(
                color: kPrimColor,
                width: 0.9,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            widget.text,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
