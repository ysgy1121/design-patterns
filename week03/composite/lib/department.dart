import 'package:composite/organization_component.dart';

class Department extends OrganizationComponent {
  final String name;
  final List<OrganizationComponent> _components;

  Department(this.name) : _components = [];

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
    print('\n[ $name팀 ]');
    for (var component in _components) {
      component.display();
    }
  }
}
