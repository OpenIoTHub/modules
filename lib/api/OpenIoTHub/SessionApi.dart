import 'package:modules/api/OpenIoTHub/OpenIoTHubChannel.dart';
import 'package:openiothub_grpc_api/pb/service.pb.dart';
import 'package:openiothub_grpc_api/pb/service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionApi {
  static Future<void> saveSessions() async {
    SessionList sessionList = await getAllSession();
    List<String> scl = sessionList.sessionConfigs.map((SessionConfig sc) {
      return jsonEncode(sc);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('sessions', scl);
    List<String> newscl = await prefs.getStringList('sessions');
    print("newscl:$newscl");
  }

  static Future<void> loadSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> newscl = await prefs.getStringList('sessions');
    print("newscl:$newscl");
  }

//  TODO 可以选择grpc所执行的主机，可以是安卓本机也可以是pc，也可以是服务器
  static Future createOneSession(SessionConfig config) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.createOneSession(config);
    print('Greeter client received: ${response}');
    channel.shutdown();
    saveSessions();
  }

  static Future deleteOneSession(SessionConfig config) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    await stub.deleteOneSession(config);
    channel.shutdown();
    saveSessions();
  }

  static Future<SessionList> getAllSession() async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.getAllSession(new Empty());
    print('Greeter client received: ${response.sessionConfigs}');
    channel.shutdown();
    return response;
  }

  static Future<PortList> getAllTCP(SessionConfig sessionConfig) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.getAllTCP(sessionConfig);
    print('Greeter client received: ${response.portConfigs}');
    channel.shutdown();
    return response;
  }

  static Future<Empty> refreshmDNSServices(SessionConfig sessionConfig) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.refreshmDNSProxyList(sessionConfig);
    print('Greeter client received: ${response}');
    channel.shutdown();
    saveSessions();
    return response;
  }
}
