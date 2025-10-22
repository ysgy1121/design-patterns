import 'package:decorator/beverage.dart';
import 'package:decorator/condiment_decorator.dart';

class Soy extends CondimentDecorator {
  final Beverage beverage;
  Soy(this.beverage);

  @override
  String getDescription() {
    return '${beverage.getDescription()}두유';
  }

  @override
  double cost() {
    return 0.15 + beverage.cost();
  }
}
