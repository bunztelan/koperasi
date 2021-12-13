import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/ui/widgets/custom_header.dart';
import 'package:k2ms_v2/ui/widgets/loading_dialog.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String webId;
  WebViewPage({this.webId});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  String _setTitle(String title) {
    if (title.length > 11) {
      title = title.substring(0, 11) + '...';
    }
    return title;
  }

  String _setUrl(String url) {
    if (url.length > 11) {
      url = url.substring(0, 11) + '...';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: WebView(
                  initialUrl: Beamer.of(context).state.data['url'].toString(),
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: CustomHeader(
                  title: _setTitle(
                      Beamer.of(context).state.data['title'].toString()),
                  subTitle:
                      _setUrl(Beamer.of(context).state.data['url'].toString()),
                  backFunction: () => Navigator.pop(context),
                  isBackIcon: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
