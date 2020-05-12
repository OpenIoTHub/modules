import 'package:modules/api/GateWay/GateWayChannel.dart';
import 'package:gateway_grpc_api/pb/service.pb.dart';
import 'package:gateway_grpc_api/pb/service.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class GatewayLoginManager {
  static Future<LoginResponse> LoginServerByServerInfo(ServerInfo serverInfo, String gatewayIp, int gatewayPort) async {
    final channel = await Channel.getGateWayChannel(gatewayIp, gatewayPort);
    final stub = GatewayLoginManagerClient(channel);
    LoginResponse loginResponse = await stub.loginServerByServerInfo(serverInfo);
    print('LoginServerByServerInfo: ${loginResponse}');
    channel.shutdown();
    return loginResponse;
  }

  static Future<Token> GetOpenIoTHubToken(String gatewayIp, int gatewayPort) async {
    final channel = await Channel.getGateWayChannel(gatewayIp, gatewayPort);
    final stub = GatewayLoginManagerClient(channel);
    Token token = await stub.getOpenIoTHubToken(Empty());
    print('GetOpenIoTHubToken: ${token}');
    channel.shutdown();
    return token;
  }

}
