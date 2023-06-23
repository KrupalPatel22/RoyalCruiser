import 'package:cached_network_image/cached_network_image.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class GalleryPhotoScreen extends StatefulWidget {
  static const routeName = '/gallery_photo_screen';

  const GalleryPhotoScreen({Key? key}) : super(key: key);

  @override
  _GalleryPhotoScreenState createState() => _GalleryPhotoScreenState();
}

class _GalleryPhotoScreenState extends State<GalleryPhotoScreen>
    with TickerProviderStateMixin {
  String? photo_url;

  @override
  void didChangeDependencies() {
    final rcvData = ModalRoute.of(context)!.settings.arguments;
    photo_url = rcvData as String?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'Photo Screen',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Center(
        child: PhotoView(
          enableRotation: true,
          loadingBuilder: (context, event) => Center(
            child: Container(
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                    event.expectedTotalBytes!.toInt(),
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          imageProvider: CachedNetworkImageProvider(photo_url!.toString()),
        ),
      ),
    );
  }
}
