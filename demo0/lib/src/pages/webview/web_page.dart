import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse("https://pospos.co")),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(),
          ),
          onLoadStart: (controller, url) {
            print("Page started loading: $url");
          },
          onLoadStop: (controller, url) {
            print("Page finished loading: $url");
          },
        ),
      ),
    );
  }
}
