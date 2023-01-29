// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebsitePage extends StatefulWidget {
  const WebsitePage({super.key});

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await _webViewController.canGoBack()) {
            await _webViewController.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: Scaffold(
              body: Column(
            children: [
              progress < 1.0
                  ? Container(
                      child: progress < 1.0
                          ? LinearProgressIndicator(
                              value: progress,
                              color: Colors.teal,
                            )
                          : Container())
                  : Container(),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse('https://chat.openai.com/auth/login')),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions()),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (var controller, var url) {
                    setState(() {
                      this.url = url!.path;
                      print(this.url);
                    });
                  },
                  onLoadStop: (var controller, var url) async {
                    setState(() {
                      this.url = url!.path;
                    });
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
