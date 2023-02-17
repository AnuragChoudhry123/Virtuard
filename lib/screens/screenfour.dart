import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenFour extends StatefulWidget {
  const ScreenFour({super.key});

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("mailto:") ||
              request.url.startsWith("tel:") ||
              request.url.startsWith("whatsapp:")) {
            _launchURL(request.url);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        onWebViewCreated: (WebViewController webViewController) {
          _controllerCompleter.future.then((value) => _controller = value);
          _controllerCompleter.complete(webViewController);
        },
        initialUrl: 'https://www.virtuard.com/membri/me/profile/edit/group/1/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
