import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

String getOneUUID() {
  var uuid = new Uuid();
  return uuid.v4();
}
