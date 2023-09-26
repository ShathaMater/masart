import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintTxt,
    this.maxLines,
    this.minLines,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.isValidate = true,
    this.isScureField = false,
    this.isDigits = false,
    this.isEnabled = true,
    this.height = 50,
    this.width,
    this.prefixIcon,
    this.onChanged,
  });

  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isValidate;
  final bool? isScureField;
  final bool isEnabled;
  final String? hintTxt;
  final bool isDigits;
  final double? height;
  final double? width;
  final Widget? prefixIcon;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width?.w,
      height: widget.height!.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: kPrimColor,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        keyboardType: widget.inputType,
        textInputAction: widget.inputAction,
        obscureText: widget.isScureField! ? !_showPassword : false,
        obscuringCharacter: '*',
        onChanged: widget.onChanged,
        validator: (value) {
          String? msg;
          if (value == null || value.isEmpty) {
            msg = 'Required';
          }
          return (widget.isValidate!) ? msg : null;
        },
        decoration: InputDecoration(
          enabled: widget.isEnabled,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          hintText: widget.hintTxt,
          hintStyle: TextStyle(color: Colors.black38, fontSize: 12.sp),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isScureField!
              ? IconButton(
                  onPressed: () =>
                      setState(() => _showPassword = !_showPassword),
                  icon: _showPassword
                      ? const Icon(Icons.visibility, color: kPrimColor)
                      : const Icon(Icons.visibility_off, color: Colors.grey),
                )
              : null,
        ),
        inputFormatters:
            (widget.isDigits) ? [FilteringTextInputFormatter.digitsOnly] : null,
      ),
    );
  }
}
