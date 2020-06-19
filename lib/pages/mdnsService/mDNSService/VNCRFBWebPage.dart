import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:modules/constants/Config.dart';
import 'package:modules/model/portService.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VNCWebPage extends StatefulWidget {
  VNCWebPage({Key key, this.serviceInfo})
      : super(key: key);

  static final String modelName = "com.iotserv.services.vnc";
  final PortService serviceInfo;

  @override
  State<StatefulWidget> createState() => VNCWebPageState();
}

class VNCWebPageState extends State<VNCWebPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: WebView(
        initialUrl:
        "http://${Config.webStaticIp}:${Config.webStaticPort}/web/open/vnc/index.html?host=${Config.webgRpcIp}&port=${Config.webRestfulPort}&path=proxy%2fws%2fconnect%2fwebsockify%3fip%3d${widget.serviceInfo.ip}%26port%3d${widget.serviceInfo.port}&encrypt=0",
        javascriptMode : JavascriptMode.unrestricted
      ),
    );
  }
}
