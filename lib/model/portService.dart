import 'package:http/http.dart' as http;
import 'package:openiothub_grpc_api/pb/service.pb.dart';
import 'package:openiothub_grpc_api/pb/service.pbgrpc.dart';

class PortService {
//  基础url，如：http://127.0.0.1:3679,不带根/
//  String baseUrl;
  String ip;
  int port;

//  是否是在本内外的设备
  bool isLocal = false;

//  设备的端口信息
  PortConfig portConfig;

//  设备的注册信息
  Map<String, dynamic> info;

  PortService({this.portConfig, this.info, this.isLocal, this.ip, this.port});

  Map toJson() {
    Map map = Map();
    map['info'] = this.info;
    map['isLocal'] = this.isLocal;
    map['ip'] = this.ip;
    map['port'] = this.port;
    return map;
  }

  static PortService fromJson(Map<String, dynamic> map) {
    PortService portService = PortService();
    Map<String, String> newinfo = {
      "name": map['info']['name'].toString(),
      "model": map['info']['model'].toString(),
      "mac": map['info']['mac'].toString(),
      "id": map['info']['id'].toString(),
      "author": map['info']['author'].toString(),
      "email": map['info']['email'].toString(),
      "home-page": map['info']['home-page'].toString(),
      "firmware-respository": map['info']['firmware-respository'].toString(),
      "firmware-version": map['info']['firmware-version'].toString(),
    };

    portService.info = newinfo;
    portService.isLocal = map['isLocal'];
    portService.ip = map['ip'];
    portService.port = map['port'];
    return portService;
  }
}
