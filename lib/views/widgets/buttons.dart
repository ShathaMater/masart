import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 45,
    this.bgColor = kPrimColor,
    this.border,
    this.isBorder = false,
    this.gradient = const LinearGradient(
      end: Alignment.centerRight,
      colors: [kPrimColor, Color(0xFFFBE76A)],
    ),
  }) : super(key: key);
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient? gradient;
  final Color? bgColor;
  final VoidCallback? onPressed;
  final Widget child;
  final BoxBorder? border;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    var bborder = border ?? Border.all(color: kPrimColor);
    final borderRadius = this.borderRadius ?? BorderRadius.circular(5.r);
    return Container(
      width: width?.w ?? double.infinity,
      height: height.h,
      decoration: BoxDecoration(
        color: bgColor,
        gradient: bgColor == null ? gradient : null,
        borderRadius: borderRadius,
        border: isBorder ? bborder : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.all(5.r),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
