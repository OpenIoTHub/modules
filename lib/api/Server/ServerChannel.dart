import 'package:modules/api/OpenIoTHub/SessionApi.dart';
import 'package:modules/api/OpenIoTHub/Utils.dart';
import 'package:grpc/grpc.dart';
import 'package:openiothub_grpc_api/pb/service.pb.dart';

class Channel {
  static Future<ClientChannel> getServerChannel(String runId) async {
    SessionConfig sessionConfig = await SessionApi.getOneSession(runId);
    TokenModel tokenModel = await UtilApi.getTokenModel(sessionConfig.token);
    final channel = ClientChannel(tokenModel.host,
        port: tokenModel.grpcPort,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
    return channel;
  }
}
