import 'package:composite/organization_component.dart';

class Company extends OrganizationComponent {
  final String name;
  final List<OrganizationComponent> _components;

  Company(this.name) : _components = [];

  @override
  void add(OrganizationComponent component) {
    _components.add(component);
  }

  @override
  void remove(OrganizationComponent component) {
    _components.remove(component);
  }

  @override
  OrganizationComponent getChild(int index) {
    return _components[index];
  }

  @override
  void display() {
    print('** 회사: $name **');
    for (var component in _components) {
      component.display();
    }
  }
}
