# 추상 팩토리 패턴 (Abstract Factory Pattern)

추상 팩토리 패턴은 관련된 객체들의 패밀리를 생성하기 위한 인터페이스를 제공하는 디자인 패턴입니다. 구체적인 클래스를 지정하지 않고도 관련된 객체들의 패밀리를 생성할 수 있도록 합니다.

## 💡 핵심 원칙 및 특징

**패밀리 생성:** 서로 관련된 객체들의 그룹(패밀리)을 함께 생성할 수 있습니다. (예: GUI 컴포넌트의 Windows 스타일 패밀리, macOS 스타일 패밀리)

**구체 클래스 분리:** 클라이언트 코드는 구체적인 클래스에 의존하지 않고 추상 인터페이스만을 통해 객체를 생성합니다.

**확장성:** 새로운 패밀리를 추가할 때 기존 코드를 수정하지 않고 새로운 구체 팩토리만 추가하면 됩니다.

## ☕️ 구성 요소

### 추상 팩토리 (Abstract Factory):
관련된 객체들의 패밀리를 생성하기 위한 인터페이스를 정의합니다. 각 제품군에 대한 생성 메서드를 선언합니다.

### 구체 팩토리 (Concrete Factory):
추상 팩토리를 구현하여 특정 패밀리의 객체들을 생성합니다. (예: WindowsFactory, MacOSFactory)

### 추상 제품 (Abstract Product):
패밀리 내의 각 제품에 대한 인터페이스를 정의합니다. (예: Button, Checkbox)

### 구체 제품 (Concrete Product):
추상 제품을 구현하는 구체적인 클래스입니다. (예: WindowsButton, MacOSButton)

### 클라이언트 (Client):
추상 팩토리와 추상 제품만을 사용하여 객체를 생성하고 사용합니다.

## 📚 장점 및 디자인 원칙

**개방-폐쇄 원칙(OCP) 준수:** 새로운 제품 패밀리를 추가할 때 기존 코드를 수정하지 않고 새로운 구체 팩토리만 추가하면 됩니다.

**단일 책임 원칙(SRP) 준수:** 각 팩토리는 특정 패밀리의 객체 생성만을 담당합니다.

**의존성 역전 원칙(DIP) 준수:** 클라이언트는 구체적인 클래스가 아닌 추상화에 의존합니다.

## 💻 예제 코드: GUI 컴포넌트 팩토리

다양한 운영체제(Windows, macOS)에 맞는 GUI 컴포넌트를 생성하는 추상 팩토리 패턴을 구현합니다.

### 📄 추상 팩토리

```dart
abstract class GUIFactory {
  Button createButton();
  Checkbox createCheckbox();
}
```

### 📄 구체 팩토리들

```dart
// Windows GUI 팩토리
class WindowsFactory implements GUIFactory {
  @override
  Button createButton() => WindowsButton();
  
  @override
  Checkbox createCheckbox() => WindowsCheckbox();
}

// macOS GUI 팩토리
class MacOSFactory implements GUIFactory {
  @override
  Button createButton() => MacOSButton();
  
  @override
  Checkbox createCheckbox() => MacOSCheckbox();
}
```

### 📄 클라이언트 코드

```dart
class Application {
  late Button button;
  late Checkbox checkbox;
  
  Application(GUIFactory factory) {
    button = factory.createButton();
    checkbox = factory.createCheckbox();
  }
  
  void render() {
    print(button.render());
    print(checkbox.render());
  }
  
  void handleEvents() {
    print(button.onClick());
    print(checkbox.onCheck());
  }
}

```

## 🤔 심화 질문 01: 추상 팩토리 패턴과 팩토리 메서드 패턴의 차이점

| 특징 | 추상 팩토리 패턴 | 팩토리 메서드 패턴 |
| :--- | :--- | :--- |
| **목적** | **관련된 객체들의 패밀리**를 생성 | **단일 객체**의 생성을 캡슐화 |
| **구조** | 여러 제품군을 생성하는 **여러 메서드**를 가진 팩토리 | **하나의 메서드**로 하나의 제품을 생성 |
| **확장성** | 새로운 **패밀리 전체**를 추가 | 새로운 **제품 타입**을 추가 |

## 🤔 심화 질문 02: 추상 팩토리 패턴의 단점 및 제약 사항

### 새로운 제품 타입 추가의 어려움
새로운 제품 타입(예: TextField)을 추가하려면 모든 구체 팩토리 클래스를 수정해야 합니다. 이는 개방-폐쇄 원칙을 위반하게 됩니다.

**해결 방법:**
- **인터페이스 분리 원칙(ISP)** 적용: 제품을 기능별로 더 작은 인터페이스로 분리
- **빌더 패턴**과 결합: 복잡한 객체 생성을 단계별로 처리
- **프로토타입 패턴** 활용: 기존 객체를 복제하여 새로운 객체 생성

### 복잡성 증가
패턴을 적용하면 클래스의 수가 크게 증가하여 시스템이 복잡해질 수 있습니다.

**해결 방법:**
- **의존성 주입(DI)** 프레임워크 활용: 팩토리 생성과 관리 자동화
- **설정 기반 팩토리**: 설정 파일을 통해 팩토리 선택
- **단순한 경우에는 팩토리 메서드 패턴** 고려
