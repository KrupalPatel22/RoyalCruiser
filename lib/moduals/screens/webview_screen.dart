import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  String pdfUrl;
  bool pdfView;

  WebviewScreen({required this.pdfUrl, this.pdfView = true});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  Widget build(BuildContext context) {
    final String pdfUrl = widget.pdfUrl;
    final googleDocsUrl =
        widget.pdfView?
        "https://docs.google.com/viewer?url=$pdfUrl&embedded=true":pdfUrl;
    bool _isLoading = true;
    double _progressValue = 0.0;

    ValueNotifier loadingProgress = ValueNotifier(0);

    return Scaffold(
      appBar: AppBar(title: Text(widget.pdfView?"Terms And Condition":"Ticket Print")),
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: loadingProgress,
              builder: (ctx, val, _) {
                return _isLoading
                    ? LinearProgressIndicator(
                        value: _progressValue,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 5,
                      )
                    : SizedBox.shrink();
              }),
          Expanded(
            child: WebView(
              initialUrl: googleDocsUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url) {
                setState(() {
                  print("Progress :- finishprogress");
                  _isLoading =
                      false; // Hide loading indicator when the page finishes loading
                });
              },
              onProgress: (int progress) {
                print("Progress :- $progress");

                _progressValue = progress / 100; // Update the progress value

                loadingProgress.value = Random().nextInt(9999999);
              },
            ),
          ),
        ],
      ),
    );
  }
}
