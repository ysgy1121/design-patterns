import 'package:decorator/beverage.dart';
import 'package:decorator/condiment_decorator.dart';

class Milk extends CondimentDecorator {
  final Beverage beverage;
  Milk(this.beverage);

  @override
  String getDescription() {
    return '${beverage.getDescription()}라떼';
  }

  @override
  double cost() {
    return 0.10 + beverage.cost();
  }
}
