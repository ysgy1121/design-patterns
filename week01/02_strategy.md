# 전략 패턴
전략 패턴은 알고리즘을 정의하고 각각 캡슐화하여, 서로 교환 가능하도록 만드는 패턴입니다. 이 패턴을 사용하면 알고리즘을 사용하는 클라이언트(컨텍스트)와는 독립적으로 알고리즘을 변경할 수 있습니다.

## 💡 핵심 원칙 및 특징
알고리즘 캡슐화: 다양한 알고리즘을 각각 별도의 클래스로 캡슐화합니다.

유연한 교체: 알고리즘을 사용하는 컨텍스트(클래스)가 상속 대신 <b>구성(Composition)</b>을 통해 캡슐화된 알고리즘 객체를 참조합니다. 이를 통해 런타임에 알고리즘을 동적으로 교체할 수 있습니다. (예: 오리의 비행 행동 (FlyBehavior)을 `FlyWithWings`에서 `FlyNoWay`로 변경)

행동 분리: 특정 클래스(예: Duck)의 다양한 행동(예: 꽥꽥거리는 방식, 나는 방식)을 별도의 인터페이스/추상 클래스 계층으로 분리하여 유연성, 재사용성, 확장성을 높입니다.

## 예시: 🪿 오리(Duck) 문제 해결
상속 대신 전략 패턴을 적용하여 오리의 행동을 분리함으로써, 서브클래스 간의 중복 코드 발생을 줄이고, 오리 소리를 내는 사냥꾼이나 로켓으로 날아가는 장난감 오리 같은 새로운 요구사항을 쉽게 구현할 수 있습니다.

행동 인터페이스/추상 클래스:

```dart
abstract class FlyBehavior {}
abstract class QuackBehavior {}
```
구체적인 전략 (Concrete Strategy):

```dart
class FlyWithWings extends FlyBehavior {}
class FlyNoWay extends FlyBehavior {}
class Quack extends QuackBehavior {}
class Squeak extends QuackBehavior {}
class MuteQuack extends QuackBehavior {}
```
## 🛠️ 구성 요소

#### 컨텍스트 (Context):

알고리즘을 사용하는 클래스입니다. (예: Duck 클래스)
전략 인터페이스에 대한 참조를 가집니다.
필요할 때 전략 객체를 통해 알고리즘을 호출합니다.

#### 전략 인터페이스 (Strategy):

모든 구체적인 전략 클래스가 구현해야 하는 공통 인터페이스 또는 추상 클래스입니다. (예: FlyBehavior)

#### 구체적인 전략 (Concrete Strategy):

전략 인터페이스를 구현하며 실제 알고리즘을 정의하는 클래스입니다. (예: FlyWithWings)

## 🤔 심화 질문: 전략 주입 방식에 따른 패턴 정의

생성자 주입 방식만 사용하더라도 알고리즘을 클래스로 캡슐화하고 인터페이스를 통해 분리했다는 전략 패턴의 핵심 구조를 만족하므로, 이는 전략 패턴으로 간주될 수 있습니다. 런타임에 전략을 바꿔야 할 필요가 있을 때만 Setter 주입을 추가로 고려하면 됩니다.