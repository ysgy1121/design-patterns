import 'package:decorator/beverage.dart';

class DartRoast extends Beverage {
  @override
  String getDescription() {
    return '다크 로스트';
  }

  @override
  double cost() {
    return 0.99;
  }
}
