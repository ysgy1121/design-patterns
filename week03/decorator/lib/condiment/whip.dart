import 'package:decorator/beverage.dart';
import 'package:decorator/condiment_decorator.dart';

class Whip extends CondimentDecorator {
  final Beverage beverage;
  Whip(this.beverage);

  @override
  String getDescription() {
    return '크림${beverage.getDescription()}';
  }

  @override
  double cost() {
    return 0.10 + beverage.cost();
  }
}
