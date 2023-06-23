import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/gallery_photo_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';
import 'package:xml/xml.dart';

class GalleryAppScreen extends StatefulWidget {
  static const String routeName = '/gallery_frg';

  const GalleryAppScreen({Key? key}) : super(key: key);

  @override
  State<GalleryAppScreen> createState() => _GalleryAppScreenState();
}

class _GalleryAppScreenState extends State<GalleryAppScreen> {
  String? currentDate;
  String? height_photo;
  String? width_photo;
  DateTime now = DateTime.now();

  @override
  void initState() {
    currentDate = DateFormat('yyyy-MM-dd').format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'Gallery Screen',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Stack(
        children: [
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/bannerbg.png"),
                opacity: 80.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: FutureBuilder<XmlDocument>(
                future: ApiImplementer.applicationSplashScreenListApiImplementer(
                    currentDate: currentDate!, height: "1080", width: "2200"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AppDialogs.screenAppShowDiloag(context);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  List photos = [];
                  List<XmlElement> data =
                      snapshot.data!.findAllElements('SplashScreenList').toList();
                  for (int i = 0; i < data.length; i++) {
                    if (data[i].getElement('Type')!.text.compareTo("3") == 0) {
                      photos.add(
                          data[i].getElement('Details')!.text.trim().toString());
                    }
                  }
                  return photos.isNotEmpty
                      ?ListView.builder(
                          itemCount: photos.length,
                          itemBuilder: (context, item) {
                            return Container(
                              height:250,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    GalleryPhotoScreen.routeName,
                                    arguments: photos[item],
                                  );
                                },
                                child: Card(
                                  elevation: 2.0,
                                  child: Container(
                                    //padding: EdgeInsets.all(8),
                                    height: MediaQuery.of(context).size.height,
                                    width: size.width,
                                    child: Image.network(photos[item], fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            );
                          })
                      : NoDataFoundWidget(
                          msg: 'No Photos!',
                        );
                }),
          ),
        ],
      ),
    );
  }
}
