import 'package:modules/constants/Config.dart';
import 'package:grpc/grpc.dart';

class Channel {
  static Future<ClientChannel> getOpenIoTHubChannel() async {
    final channel = ClientChannel(Config.webgRpcIp,
        port: Config.webgRpcPort,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
    return channel;
  }
}
