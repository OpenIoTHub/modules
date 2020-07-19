import 'package:modules/api/OpenIoTHub/SessionApi.dart';
import 'package:modules/api/OpenIoTHub/Utils.dart';
import 'package:openiothub_grpc_api/pb/service.pb.dart' as openiothub;
import 'package:openiothub_grpc_api/pb/service.pb.dart';
import 'package:server_grpc_api/pb/service.pb.dart';
import 'package:server_grpc_api/pb/service.pbgrpc.dart' as server;
import 'package:grpc/grpc.dart';
import 'package:modules/api/Server/ServerChannel.dart';

class HttpManager {
//  rpc CreateOneHTTP (HTTPConfig) returns (HTTPConfig) {}
  static Future<HTTPConfig> CreateOneHTTP(HTTPConfig httpConfig) async {
    final channel = await Channel.getServerChannel(httpConfig.runId);
    SessionConfig sessionConfig = await SessionApi.getOneSession(httpConfig.runId);
    final stub = server.HttpManagerClient(channel, options: CallOptions(metadata: {'jwt': sessionConfig.token}));

    HTTPConfig httpConfigResponse = await stub.createOneHTTP(httpConfig);
    print('httpConfigResponse: ${httpConfigResponse}');
    channel.shutdown();
    return httpConfigResponse;
  }
//  rpc DeleteOneHTTP (HTTPConfig) returns (Empty) {}
  static Future<void> DeleteOneHTTP(HTTPConfig httpConfig) async {
    final channel = await Channel.getServerChannel(httpConfig.runId);
    SessionConfig sessionConfig = await SessionApi.getOneSession(httpConfig.runId);
    final stub = server.HttpManagerClient(channel, options: CallOptions(metadata: {'jwt': sessionConfig.token}));

    await stub.deleteOneHTTP(httpConfig);
    channel.shutdown();
  }
//  rpc GetOneHTTP (HTTPConfig) returns (HTTPConfig) {}
  static Future<HTTPConfig> GetOneHTTP(HTTPConfig httpConfig) async {
    final channel = await Channel.getServerChannel(httpConfig.runId);
    SessionConfig sessionConfig = await SessionApi.getOneSession(httpConfig.runId);
    final stub = server.HttpManagerClient(channel, options: CallOptions(metadata: {'jwt': sessionConfig.token}));

    HTTPConfig newHttpConfig = await stub.getOneHTTP(httpConfig);
    channel.shutdown();
    return newHttpConfig;
  }
//  rpc GetAllHTTP (Empty) returns (HTTPList) {}
  static Future<HTTPList> GetAllHTTP(openiothub.Device device) async {
    final channel = await Channel.getServerChannel(device.runId);
    SessionConfig sessionConfig = await SessionApi.getOneSession(device.runId);
    final stub = server.HttpManagerClient(channel, options: CallOptions(metadata: {'jwt': sessionConfig.token}));

    server.Device sdevice = server.Device();
    sdevice.runId = device.runId;
    sdevice.addr = device.addr;
    sdevice.mac = device.mac;
    sdevice.description = device.description;
    HTTPList httpList = await stub.getAllHTTP(sdevice);
    channel.shutdown();
    return httpList;
  }
}
