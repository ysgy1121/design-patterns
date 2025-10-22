import 'package:decorator/beverage.dart';

class Espresso extends Beverage {
  @override
  String getDescription() {
    return '에스프레소';
  }

  @override
  double cost() {
    return 1.99;
  }
}
