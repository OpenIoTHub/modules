//这个模型是用来使用WebDAV的文件服务器来操作文件的
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modules/model/portService.dart';
import 'package:modules/pages/mdnsService/commWidgets/info.dart';
import 'package:webdav/webdav.dart';

class WebPage extends StatefulWidget {
  WebPage({Key key, this.serviceInfo}) : super(key: key);

  static final String modelName = "com.iotserv.services.web";
  final PortService serviceInfo;

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
//    解决退出没有断连的问题
    return Scaffold(
        appBar: new AppBar(title: new Text("网页浏览器"), actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                _info();
              }),
          IconButton(
              icon: Icon(
                Icons.open_in_browser,
                color: Colors.white,
              ),
              onPressed: () {
                _launchURL(
                    "http://${widget.serviceInfo.ip}:${widget.serviceInfo.port}");
              })
        ]),
        body: Builder(builder: (BuildContext context) {
          return WebView(
              initialUrl:
                  "http://${widget.serviceInfo.ip}:${widget.serviceInfo.port}",
              javascriptMode: JavascriptMode.unrestricted);
        }));
  }

  _info() async {
    await Navigator.of(context).pop();
    // TODO 设备信息
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return InfoPage(
            portService: widget.serviceInfo,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      Navigator.of(context).pop();
      _launchURL('http://${widget.serviceInfo.ip}:${widget.serviceInfo.port}');
    } else {
      _launchURL('http://${widget.serviceInfo.ip}:${widget.serviceInfo.port}');
    }
  }

  _launchURL(String url) async {
//    await intent.launch();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
