import 'package:adapter/agora_adapter.dart';
import 'package:adapter/turkey_adapter.dart';

void main(List<String> arguments) {
  print("=== Adapter 패턴 데모 ===\n");

  print("1. Turkey Adapter 예제");
  testTurkeyAdapter();

  print("2. Agora Adapter 예제");
  testAgoraAdapter();
}
