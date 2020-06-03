import 'package:modules/api/OpenIoTHub/OpenIoTHubChannel.dart';
import 'package:modules/api/OpenIoTHub/Utils.dart';
import 'package:openiothub_grpc_api/pb/service.pb.dart';
import 'package:openiothub_grpc_api/pb/service.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class SessionApi {
//  TODO 可以选择grpc所执行的主机，可以是安卓本机也可以是pc，也可以是服务器
  static Future createOneSession(SessionConfig config) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.createOneSession(config);
    print('createOneSession: ${response}');
    channel.shutdown();
    UtilApi.saveAllConfig();
  }

  static Future deleteOneSession(SessionConfig config) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    await stub.deleteOneSession(config);
    channel.shutdown();
    UtilApi.saveAllConfig();
  }

  static Future<SessionList> getAllSession() async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.getAllSession(new Empty());
    print('getAllSession received: ${response.sessionConfigs}');
    channel.shutdown();
    return response;
  }

  static Future<PortList> getAllTCP(SessionConfig sessionConfig) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.getAllTCP(sessionConfig);
    print('getAllTCP received: ${response.portConfigs}');
    channel.shutdown();
    return response;
  }

  static Future<Empty> refreshmDNSServices(SessionConfig sessionConfig) async {
    final channel = await Channel.getOpenIoTHubChannel();
    final stub = SessionManagerClient(channel);
    final response = await stub.refreshmDNSProxyList(sessionConfig);
    print('refreshmDNSServices received: ${response}');
    channel.shutdown();
    return response;
  }
}
