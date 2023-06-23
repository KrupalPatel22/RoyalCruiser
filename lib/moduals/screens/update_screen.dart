import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateApplicationScreen extends StatelessWidget {
  static const routeName = '/update_app_screen';
  String? appUpdateType;
  bool? isForceUpdate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appUpdateInfo = ModalRoute.of(context)!.settings.arguments as Map;

    appUpdateType = appUpdateInfo[NavigatorConstants.APP_UPDATE_TYPE];
    isForceUpdate = appUpdateInfo[NavigatorConstants.IS_FORCE_UPDATE];

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(

                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.22),
                color: Colors.white,
                child: Image(
                  image: AssetImage('assets/images/ic_launcher.png'),

                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 12.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'We\'re better than ever',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontFamily:
                            CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      'We added lots of new features and \nfix some bugs to make your experience as \nsoon as possible',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily:
                            CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        StoreRedirect.redirect(
                            androidAppId: "com.infinityinfoway.royalcruiser",
                            iOSAppId: "id6443929868");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'UPDATE APP',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (!(isForceUpdate as bool) ||
                        (appUpdateType!.toLowerCase() ==
                            CommonConstants.OPTIONAL_UPDATE.toLowerCase()))
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(DashboardAppScreen.routeName);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Not Now',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                              fontFamily:
                                  CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                              fontSize: 18,
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
}
