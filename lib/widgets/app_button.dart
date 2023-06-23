import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/color_constance.dart';

class AppButton extends StatelessWidget {
  VoidCallback? onPress;
  String text;
  Color textColor;
  Color buttonColor;
  double round;

  AppButton(this.onPress,
      {this.text = '          Yay!!          ',
       this.textColor = Colors.white,
       this.buttonColor = CustomeColor.main_bg,
       this.round=20});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(round),
          )
      )),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
