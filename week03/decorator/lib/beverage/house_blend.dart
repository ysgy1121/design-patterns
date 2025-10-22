import 'package:decorator/beverage.dart';

class HouseBlend extends Beverage {
  @override
  String getDescription() {
    return '하우스 블렌디드';
  }

  @override
  double cost() {
    return 0.89;
  }
}
