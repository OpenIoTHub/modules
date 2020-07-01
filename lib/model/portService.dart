import 'dart:convert';

class PortService {
//  基础url，如：http://127.0.0.1:3679,不带根/
//  String baseUrl;
  String ip;
  int port;

//  是否是在本内外的设备
  bool isLocal = false;

//  设备的端口信息
//  PortConfig portConfig;

//  设备的注册信息
  Map<String, dynamic> info;

  PortService({this.info, this.isLocal, this.ip, this.port});

  PortService copy() {
    String jsonStr = jsonEncode(this);
    return PortService.fromJson(jsonStr);
  }

  Map toJson() {
    Map map = Map();
    map['info'] = this.info;
    map['isLocal'] = this.isLocal;
    map['ip'] = this.ip;
    map['port'] = this.port;
    return map;
  }

  static PortService fromJson(String jsonStr) {
    Map map = jsonDecode(jsonStr);
    PortService portService = PortService();
    portService.info = {
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
    portService.isLocal = map['isLocal'];
    portService.ip = map['ip'];
    portService.port = map['port'];
    return portService;
  }
}
