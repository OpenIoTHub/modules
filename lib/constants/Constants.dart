import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class Constants {
//  KEY
  static final String DEVICE_CNAME = "device_cname";
  static final String GO_AAR_CONFIG = "allconfig";

  static final double ARROW_ICON_WIDTH = 16.0;
  static final titleTextStyle = const TextStyle(fontSize: 16.0);
  static final rightArrowIcon = Image.asset(
    'assets/images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  static final EventBus eventBus = new EventBus();
}
