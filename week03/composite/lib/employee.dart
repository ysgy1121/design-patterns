import 'package:composite/organization_component.dart';

class Employee extends OrganizationComponent {
  final String name;
  final String title;

  Employee(this.name, this.title);

  @override
  void display() {
    print('- $name ($title)');
  }

  @override
  void add(OrganizationComponent component) {
    throw UnimplementedError();
  }

  @override
  void remove(OrganizationComponent component) {
    throw UnimplementedError();
  }

  @override
  OrganizationComponent getChild(int index) {
    throw UnimplementedError();
  }
}
