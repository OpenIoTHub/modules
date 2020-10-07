import 'package:uuid/uuid.dart';

void main() {
  //For test usage
  var msg = "Hello, World!";
  print(msg); //msg value: Hello, World!
  var uuid = new Uuid();
  print(uuid.v5(Uuid.NAMESPACE_URL, 'uuid.iotserv.com'));
  print(uuid.v4());
}
