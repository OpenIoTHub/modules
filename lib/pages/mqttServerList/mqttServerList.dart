import 'package:flutter/material.dart';
import 'package:modules/constants/Config.dart';
import 'package:modules/constants/Constants.dart';
import 'package:modules/model/portService.dart';
import 'package:modules/pages/mdnsService/components.dart';

import 'package:multicast_dns/multicast_dns.dart';

class MqttServerListPage extends StatefulWidget {
  MqttServerListPage({Key key}) : super(key: key);

  @override
  _MqttServerListPageState createState() => _MqttServerListPageState();
}

class _MqttServerListPageState extends State<MqttServerListPage> {
  static const double IMAGE_ICON_WIDTH = 30.0;

  Map<String, PortService> _ServiceMap = {};
  final MDnsClient _mdns = MDnsClient();

  @override
  void initState() {
    super.initState();
    _findClientListBymDNS();
  }

  @override
  void dispose() {
    super.dispose();
    _mdns.stop();
  }

  @override
  Widget build(BuildContext context) {
    final tiles = _ServiceMap.values.map(
      (pair) {
        var listItemContent = Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Icon(Icons.devices),
              ),
              Expanded(
                  child: Text(
                '${pair.ip}:${pair.port}',
                style: Constants.titleTextStyle,
              )),
              Constants.rightArrowIcon
            ],
          ),
        );
        return InkWell(
          onTap: () {
            //直接打开内置web浏览器浏览页面
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//              return Text("${pair.iP}:${pair.port}");
              return Gateway(serviceInfo: pair);
            }));
          },
          child: listItemContent,
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("发现本地网关列表"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                _findClientListBymDNS();
              }),
        ],
      ),
      body: ListView(children: divided),
    );
  }

  void _findClientListBymDNS() async {
    print("====_findClientListBymDNS");
    await _mdns.stop();
    await _mdns.start();
    _ServiceMap.clear();
    try {
      await for (PtrResourceRecord ptr in _mdns.lookup<PtrResourceRecord>(
          ResourceRecordQuery.serverPointer(Config.mdnsGatewayService))) {
        await for (SrvResourceRecord srv in _mdns.lookup<SrvResourceRecord>(
            ResourceRecordQuery.service(ptr.domainName))) {
          print(srv);
          PortService _portService = PortService(
              isLocal: true,
              info: {
                "name": "网关",
                "model": Gateway.modelName,
                "mac": "mac",
                "id": "id",
                "author": "Farry",
                "email": "newfarry@126.com",
                "home-page": "https://github.com/OpenIoTHub",
                "firmware-respository":
                    "https://github.com/OpenIoTHub/gateway-go",
                "firmware-version": "version",
              },
              ip: "127.0.0.1",
              port: 80);
          await _mdns
              .lookup<TxtResourceRecord>(
                  ResourceRecordQuery.text(ptr.domainName))
              .forEach((TxtResourceRecord text) {
            List<String> _txts = text.text.split("\n");
            print(_txts.length);
            print(_txts);
            _txts.forEach((String txt) {
              List<String> _kv = txt.split("=");
              print("_kv:");
              print(_kv);
              _portService.info[_kv.first] = _kv.last;
              //  TODO value 为空是否需要添加？
            });
          });
          await for (IPAddressResourceRecord ip
              in _mdns.lookup<IPAddressResourceRecord>(
                  ResourceRecordQuery.addressIPv4(srv.target))) {
            print(ip);
            print('Service instance found at '
                '${srv.target}:${srv.port} with ${ip.address}.');
            _portService.ip = ip.address.address;
            _portService.port = srv.port;
            _portService.isLocal = true;
            break;
          }
          print("_portService:");
          print(_portService);
          if (!_ServiceMap.containsKey(_portService.info["id"])) {
            setState(() {
              _ServiceMap[_portService.info["id"]] = _portService;
            });
          }
        }
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                  title: Text("从本地获取网关列表失败："),
                  content: Text("失败原因：$e"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("确认"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]));
    }
    await _mdns.stop();
  }
}
