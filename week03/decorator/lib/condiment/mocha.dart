import 'package:decorator/beverage.dart';
import 'package:decorator/condiment_decorator.dart';

class Mocha extends CondimentDecorator {
  final Beverage beverage;
  Mocha(this.beverage);

  @override
  String getDescription() {
    return '모카${beverage.getDescription()}';
  }

  @override
  double cost() {
    return 0.20 + beverage.cost();
  }
}
