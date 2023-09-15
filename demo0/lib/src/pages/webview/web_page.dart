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
        actions: [
          IconButton(
              onPressed: () {
                _webViewController.reload();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            _webViewController.reload(); // Reload the web page
          },
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse("https://pospos.co")),
            onWebViewCreated: (controller) {
              // Store the controller for later use
              _webViewController = controller;
            },
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
      ),
    );
  }
}
