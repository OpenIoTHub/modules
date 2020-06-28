import 'package:http/http.dart' as http;
import 'package:openiothub_grpc_api/pb/service.pb.dart';
import 'package:openiothub_grpc_api/pb/service.pbgrpc.dart';

class MqttServerConfig {
  String host;
  int port;
  String username;
  String password;
  MqttServerConfig({this.host, this.port, this.username, this.password});

  Map toJson() {
    Map map = Map();
    map['host'] = this.host;
    map['port'] = this.port;
    map['username'] = this.username;
    map['password'] = this.password;
    return map;
  }
}
