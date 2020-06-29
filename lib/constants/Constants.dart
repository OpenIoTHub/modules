import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class Constants {
// SharedPreferences  KEY
//设备和服务的别名
  static final String DEVICE_CNAME_KEY = "device_cname";
//  golang的后台服务需要的配置
  static final String OPENIOTHUB_GO_AAR_CONFIG_KEY = "allconfig";
//  mqtt服务器的配置，用于从mqtt服务器中获取和操控设备
  static final String Mqtt_Server_List_CONFIG_KEY = "Mqtt_Server_List_CONFIG_KEY";
//  手动添加的设备和服务列表
  static final String Device_AND_Service_Added_List_KEY = "Device_AND_Service_Added_List_KEY";

  static final double ARROW_ICON_WIDTH = 16.0;
  static final titleTextStyle = const TextStyle(fontSize: 16.0);
  static final rightArrowIcon = Image.asset(
    'assets/images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  static final EventBus eventBus = new EventBus();
}
