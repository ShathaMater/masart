import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants.dart';

class CustomDropDown extends StatelessWidget {
  final String? value;
  final String? hint;
  final String? errorText;
  final List<DropdownMenuItem>? items;
  final Function(String)? onChanged;
  final double? width;
  final double height;

  const CustomDropDown({
    super.key,
    this.value,
    this.hint = '',
    this.items,
    this.onChanged,
    this.errorText = '',
    this.width,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width,
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField(
        value: value,
        items: items,
        onChanged: (dynamic item) => onChanged!(item.toString()),
        dropdownColor: Colors.grey.shade100,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        hint: Text(
          hint!,
          style: const TextStyle(color: Colors.black38),
        ),
        isExpanded: true,
        validator: (dynamic value) {
          String msg = 'مطلوب';
          return (value == null) ? msg : null;
        },
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: Colors.black38, width: 0.5.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: Colors.black38, width: 0.5.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: kPrimColor, width: 1.w),
          ),
        ),
        //
      ),
    );
  }
}
//