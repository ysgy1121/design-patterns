abstract class Duck {
  void quack();
  void fly();
}

abstract class Turkey {
  void gobble();
  void fly();
}

class MallardDuck implements Duck {
  @override
  void quack() {
    print("Quack");
  }

  @override
  void fly() {
    print("I'm flying");
  }
}

class WildTurkey implements Turkey {
  @override
  void gobble() {
    print("Gobble gobble");
  }

  @override
  void fly() {
    print("I'm flying a short distance");
  }
}

class TurkeyAdapter implements Duck {
  final Turkey turkey;

  TurkeyAdapter(this.turkey);

  @override
  void quack() {
    turkey.gobble();
  }

  @override
  void fly() {
    for (int i = 0; i < 5; i++) {
      turkey.fly();
    }
  }
}

void testTurkeyAdapter() {
  final Duck duck = MallardDuck();
  final Turkey turkey = WildTurkey();
  final Duck turkeyAdapter = TurkeyAdapter(turkey);

  print("The Turkey says...");
  turkey.gobble();
  turkey.fly();

  print("The Duck says...");
  duck.quack();
  duck.fly();

  print("The TurkeyAdapter says...");
  turkeyAdapter.quack();
  turkeyAdapter.fly();

  print('');
}
