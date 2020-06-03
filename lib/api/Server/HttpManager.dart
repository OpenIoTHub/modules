import 'package:server_grpc_api/pb/service.pb.dart';
import 'package:server_grpc_api/pb/service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:modules/api/Server/ServerChannel.dart';

class HttpManager {
//  rpc CreateOneHTTP (HTTPConfig) returns (HTTPConfig) {}
  static Future<HTTPConfig> CreateOneHTTP(HTTPConfig httpConfig, String serverIp, int serverPort) async {
    final channel = await Channel.getServerChannel(serverIp, serverPort);
    final stub = HttpManagerClient(channel);
    HTTPConfig httpConfigResponse = await stub.createOneHTTP(httpConfig);
    print('httpConfigResponse: ${httpConfigResponse}');
    channel.shutdown();
    return httpConfigResponse;
  }
//  rpc DeleteOneHTTP (HTTPConfig) returns (Empty) {}
  static Future<void> DeleteOneHTTP(HTTPConfig httpConfig, String serverIp, int serverPort) async {
    final channel = await Channel.getServerChannel(serverIp, serverPort);
    final stub = HttpManagerClient(channel);
    await stub.deleteOneHTTP(httpConfig);
    channel.shutdown();
  }
//  rpc GetOneHTTP (HTTPConfig) returns (HTTPConfig) {}
  static Future<HTTPConfig> GetOneHTTP(HTTPConfig httpConfig, String serverIp, int serverPort) async {
    final channel = await Channel.getServerChannel(serverIp, serverPort);
    final stub = HttpManagerClient(channel);
    HTTPConfig newHttpConfig = await stub.getOneHTTP(httpConfig);
    channel.shutdown();
    return newHttpConfig;
  }
//  rpc GetAllHTTP (Empty) returns (HTTPList) {}
  static Future<HTTPList> GetAllHTTP(HTTPConfig httpConfig, String serverIp, int serverPort) async {
    final channel = await Channel.getServerChannel(serverIp, serverPort);
    final stub = HttpManagerClient(channel);
    HTTPList httpList = await stub.getAllHTTP(Empty());
    channel.shutdown();
    return httpList;
  }
}
