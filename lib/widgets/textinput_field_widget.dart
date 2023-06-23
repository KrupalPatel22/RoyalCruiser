import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/common_constance.dart';


class TextInputFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String upperText;
  final Widget prefixIcon;

  const TextInputFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.upperText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  _TextInputFieldWidgetState createState() => _TextInputFieldWidgetState();
}

class _TextInputFieldWidgetState extends State<TextInputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Container(
        height: 35,
        child: AbsorbPointer(
          child: TextFormField(
            readOnly: true,
            style: TextStyle(
              fontSize: 18,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
              color: Colors.black,
            ),
            controller: widget.textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 18,
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
