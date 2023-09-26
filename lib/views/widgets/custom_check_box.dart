import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/config/constants.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onChanged?.call(_value);
        });
      },
      child: Container(
        width: 18.sp,
        height: 19.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: kPrimColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: _value
            ? const Icon(
                Icons.check,
                color: kPrimColor,
                size: 20.0,
              )
            : null,
      ),
    );
  }
}
