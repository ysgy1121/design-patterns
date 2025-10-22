import 'package:decorator/beverage/decaf.dart';
import 'package:decorator/condiment/milk.dart';
import 'package:decorator/condiment/mocha.dart';

void main(List<String> arguments) {
  var beverage = Milk(Mocha(Decaf()));
  print('${beverage.getDescription()} ${beverage.cost()}');
}
