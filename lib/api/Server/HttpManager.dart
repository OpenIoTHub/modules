import 'package:modules/api/OpenIoTHub/SessionApi.dart';
import 'package:modules/api/OpenIoTHub/Utils.dart';
import 'package:openiothub_grpc_api/pb/service.pb.dart';
import 'package:server_grpc_api/pb/service.pb.dart';
import 'package:server_grpc_api/pb/service.pbgrpc.dart' as server;
import 'package:grpc/grpc.dart';
import 'package:modules/api/Server/ServerChannel.dart';

class HttpManager {
//  rpc CreateOneHTTP (HTTPConfig) returns (HTTPConfig) {}
  static Future<HTTPConfig> CreateOneHTTP(HTTPConfig httpConfig) async {
    final channel = await Channel.getServerChannel(httpConfig.runId);
    final stub = server.HttpManagerClient(channel);
    HTTPConfig httpConfigResponse = await stub.createOneHTTP(httpConfig);
    print('httpConfigResponse: ${httpConfigResponse}');
    channel.shutdown();
    return httpConfigResponse;
  }
//  rpc DeleteOneHTTP (HTTPConfig) returns (Empty) {}
  static Future<void> DeleteOneHTTP(HTTPConfig httpConfig) async {
    final channel = await Channel.getServerChannel(httpConfig.runId);
    final stub = server.HttpManagerClient(channel);
    await stub.deleteOneHTTP(httpConfig);
    channel.shutdown();
  }
//  rpc GetOneHTTP (HTTPConfig) returns (HTTPConfig) {}
  static Future<HTTPConfig> GetOneHTTP(HTTPConfig httpConfig) async {
    final channel = await Channel.getServerChannel(httpConfig.runId);
    final stub = server.HttpManagerClient(channel);
    HTTPConfig newHttpConfig = await stub.getOneHTTP(httpConfig);
    channel.shutdown();
    return newHttpConfig;
  }
//  rpc GetAllHTTP (Empty) returns (HTTPList) {}
  static Future<HTTPList> GetAllHTTP(Device device) async {
    final channel = await Channel.getServerChannel(device.runId);
    final stub = server.HttpManagerClient(channel);
    HTTPList httpList = await stub.getAllHTTP(new server.Empty());
    channel.shutdown();
    return httpList;
  }
}
