import 'package:decorator/beverage.dart';

class Decaf extends Beverage {
  @override
  String getDescription() {
    return '디카페인';
  }

  @override
  double cost() {
    return 1.05;
  }
}
