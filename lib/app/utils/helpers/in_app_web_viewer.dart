// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewer extends StatefulWidget {
  final String url;
  const InAppWebViewer({
    Key? key,
    required this.url,
  }) : super(key: key);
  @override
  _InAppWebViewerState createState() => _InAppWebViewerState();
}

class _InAppWebViewerState extends State<InAppWebViewer> {
  InAppWebViewController? webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0.0),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
