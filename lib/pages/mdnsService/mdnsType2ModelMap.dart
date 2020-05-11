import 'package:modules/constants/Config.dart';
import 'package:modules/model/portService.dart';
import './components.dart';
//兼容的mdns类型，最终的落地点都在ModelsMap里
class MDNS2ModelsMap {
  final Map<String, String> baseInfo = {
    "name": "OpenIoTHub Entity",
    "model": WebPage.modelName,
    "mac": "mac",
    "id": "id",
    "author": "Farry",
    "email": "newfarry@126.com",
    "home-page": "https://github.com/iotdevice",
    "firmware-respository": "https://github.com/iotdevice/*",
    "firmware-version": "version",
  };
  static Map<String, dynamic> modelsMap = Map.from({
    //    web UI,http使用web方式打开服务的模型
    "_http._tcp": PortService(
        portConfig: null,
        isLocal: true,
        info: {
          "name": "Http服务",
          "model": WebPage.modelName,
          "mac": "mac",
          "id": "id",
          "author": "Farry",
          "email": "newfarry@126.com",
          "home-page": "https://github.com/OpenIoTHub",
          "firmware-respository": "https://github.com/OpenIoTHub",
          "firmware-version": "version",
        },
        ip: "127.0.0.1",
        port: 80),
    //    web UI,homeassistant使用web方式打开服务的模型
    "_home-assistant._tcp": PortService(
        portConfig: null,
        isLocal: true,
        info: {
          "name": "HomeAssistant",
          "model": WebPage.modelName,
          "mac": "mac",
          "id": "id",
          "author": "Farry",
          "email": "newfarry@126.com",
          "home-page": "https://www.home-assistant.io",
          "firmware-respository": "https://github.com/home-assistant/home-assistant",
          "firmware-version": "version",
        },
        ip: "127.0.0.1",
        port: 80),
    //    web UI,使用web方式打开服务的模型
    Config.mdnsGatewayService: PortService(
        portConfig: null,
        isLocal: true,
        info: {
          "name": "网关",
          "model": Gateway.modelName,
          "mac": "mac",
          "id": "id",
          "author": "Farry",
          "email": "newfarry@126.com",
          "home-page": "https://github.com/OpenIoTHub",
          "firmware-respository": "https://github.com/OpenIoTHub/gateway-go",
          "firmware-version": "version",
        },
        ip: "127.0.0.1",
        port: 80),
  });
}
