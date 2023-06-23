import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static void showAboutUsDialog({required BuildContext context}) {
    showAboutDialog(
        context: context,
        applicationVersion: '1.0.0',
        applicationLegalese: 'Change Description As Per Requirements');
  }

  static Future showProgressDialog(
      {required BuildContext context,
      String msg = 'Please wait....',
      bool isDismissible = false}) {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (ctx) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 75,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 18.0,
            ),
            child: Container(
              child: Row(
                children: [
                  SpinKitChasingDots(
                    size: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven ? Colors.red : Colors.blue,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Material(
                    child: FittedBox(
                      child: Text(
                        msg,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showErrorDialog(
      {required BuildContext context,
      required String errorMsg,
      required String title,
      required Function onOkBtnClickListener}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '$title',
          style: TextStyle(
            color: Colors.black,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          ),
        ),
        content: Text(errorMsg),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Theme.of(context).primaryColor;
                },
              ),
            ),
            onPressed: () => onOkBtnClickListener(),
            child: Text(
              'Okay',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget screenAppShowDiloag(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 75,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 18.0,
              ),
              child: Container(
                child: Row(
                  children: [
                    SpinKitChasingDots(
                      size: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index.isEven ? Colors.red : Colors.blue,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Material(
                      child: FittedBox(
                        child: Text(
                          'please wait....',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showCommonDialog(
      {required BuildContext context,
        required String title,
        required String positiveButtonText,
        required String nagativeButtonTexts,
        bool barrierDismissible = true,
        required Function onOkBtnClickListener,
        required Function onCancelBtnClickListener}) async {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: Text(
          '${title}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: () {
              onOkBtnClickListener();
            },
            child: Text(
              '${positiveButtonText}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onCancelBtnClickListener();
            },
            child: Text(
              '${nagativeButtonTexts}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
