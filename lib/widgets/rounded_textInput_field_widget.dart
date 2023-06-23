import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:royalcruiser/constants/common_constance.dart';


class RoundedTextInputFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Icon prefixIcon;
  final TextInputType textInputType;
  final int? maxLength;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final double? borderRadius;

  const RoundedTextInputFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.maxLength,
    this.onChanged,
    this.textInputAction,
    this.borderRadius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
          border: Border.all(color: Colors.grey, width: 1.5),
        ),
        child: TextFormField(
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: TextStyle(
            fontSize: 16,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
          controller: textEditingController,
          inputFormatters: maxLength != null
              ? [LengthLimitingTextInputFormatter(maxLength)]
              : null,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
