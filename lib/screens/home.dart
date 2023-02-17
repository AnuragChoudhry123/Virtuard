import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtuard/main.dart';
import 'package:virtuard/screens/networkcheck.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  var connectedornot;

  Homepage({super.key});

  // var connectedornot;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    var connectedornot;
    return Scaffold(
      body: StreamProvider<NetworkStatus>(
        // initialData: ,
        initialData: widget.connectedornot,
        create: (context) =>
            NetworkStatusService().networkStatusController.stream,
        child: NetworkCheck(
          onlineScreen: WebView(
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
            initialUrl: 'https://www.virtuard.com/membri/me/listings/',
            javascriptMode: JavascriptMode.unrestricted,
          ),
          offlineScreen: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/internt.gif",
                              // fit: BoxFit.contain,
                              filterQuality: FilterQuality.medium,
                              height: MediaQuery.of(context).size.height * 5.7,
                              width: MediaQuery.of(context).size.width * 5.7,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      /********************** Refresh Button *******************/
                      //
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //         backgroundColor:
                      //             MaterialStateProperty.all(const Color(0xffFE9126))),
                      //     onPressed: UiUpdate,
                      //     child: const Text("Retry"),
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 55.0),
                        child: Center(
                          child: Text(
                            "Please! Check Your Internet Connection.",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NetworkStatusService {
  ///*** Creating Controller For Network Status***///
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    if (status == ConnectivityResult.wifi) {
      return NetworkStatus.online;
    } else if (status == ConnectivityResult.mobile) {
      return NetworkStatus.online;
    } else if (status == ConnectivityResult.none) {
      return NetworkStatus.offline;
    }
    return NetworkStatus.offline;
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
