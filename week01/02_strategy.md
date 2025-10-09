# 전략 패턴
전략 패턴은 알고리즘을 정의하고 각각 캡슐화하여, 서로 교환 가능하도록 만드는 패턴입니다. 이 패턴을 사용하면 알고리즘을 사용하는 클라이언트(컨텍스트)와는 독립적으로 알고리즘을 변경할 수 있습니다.

## 💡 핵심 원칙 및 특징
알고리즘 캡슐화: 다양한 알고리즘을 각각 별도의 클래스로 캡슐화합니다.

유연한 교체: 알고리즘을 사용하는 컨텍스트(클래스)가 상속 대신 <b>구성(Composition)</b>을 통해 캡슐화된 알고리즘 객체를 참조합니다. 이를 통해 런타임에 알고리즘을 동적으로 교체할 수 있습니다. (예: 오리의 비행 행동 (FlyBehavior)을 `FlyWithWings`에서 `FlyNoWay`로 변경)

행동 분리: 특정 클래스(예: Duck)의 다양한 행동(예: 꽥꽥거리는 방식, 나는 방식)을 별도의 인터페이스/추상 클래스 계층으로 분리하여 유연성, 재사용성, 확장성을 높입니다.

## 🛠️ 구성 요소

#### 컨텍스트 (Context):

알고리즘을 사용하는 클래스입니다. (예: Duck 클래스)
전략 인터페이스에 대한 참조를 가집니다.
필요할 때 전략 객체를 통해 알고리즘을 호출합니다.

#### 전략 인터페이스 (Strategy):

모든 구체적인 전략 클래스가 구현해야 하는 공통 인터페이스 또는 추상 클래스입니다. (예: FlyBehavior)

#### 구체적인 전략 (Concrete Strategy):

전략 인터페이스를 구현하며 실제 알고리즘을 정의하는 클래스입니다. (예: FlyWithWings)


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


## 💻 예제 코드: 다양한 로그인 방식 구현 (템플릿 메서드 예제와 비교)
템플릿 메서드 패턴 예제와 동일하게 이메일/소셜 로그인 기능을 구현합니다. 상속 대신 **구성(Composition)**을 사용하여 런타임에 로그인 전략을 동적으로 교체할 수 있도록 설계합니다.

### 📄 `LoginStrategy` (전략 인터페이스)
모든 구체적인 로그인 전략(알고리즘)이 구현해야 할 `executeLogin` 메서드를 정의합니다.

```dart:strategy/lib/login_strategy.dart
abstract class LoginStrategy {
  Future<Result<LoginResult, Exception>> executeLogin(
    String identifier,
    String credential,
  );
}
```

### 📄 `EmailLoginStrategy` & `SocialLoginStrategy` (구상 전략)
`LoginStrategy` 인터페이스를 구현하는 실제 알고리즘 클래스입니다.

- **`EmailLoginStrategy`**: 이메일/비밀번호를 사용하는 전체 로그인 과정을 `executeLogin` 메서드 안에서 직접 구현합니다.
- **`SocialLoginStrategy`**: 소셜 토큰을 사용하는 전체 로그인 과정을 `executeLogin` 메서드 안에서 직접 구현합니다.

템플릿 메서드 패턴과 달리, **알고리즘의 각 단계가 아닌 알고리즘 전체가 하나의 클래스로 캡슐화**됩니다. 이로 인해 `EmailLoginStrategy`와 `SocialLoginStrategy` 간에 `_validateInputs`, `_createSession`과 같은 중복 코드가 발생할 수 있습니다. (물론 별도의 유틸리티 클래스로 분리하여 해결할 수 있습니다.)

```dart:strategy/lib/email_login_strategy.dart
class EmailLoginStrategy implements LoginStrategy {
  @override
  Future<Result<LoginResult, Exception>> executeLogin(/*...*/) async {
    try {
      // 이메일 로그인에 필요한 모든 절차 (검증, 인증, 세션, 로깅)를 포함
      _validateInputs(identifier, credential);
      var user = await _authenticate(identifier, credential);
      await _createSession(user);
      _logLogin(user);
      return Success(LoginResult(user));
    } catch (e) { /*...*/ }
  }
  // ... 각 단계에 대한 private 메서드들
}
```

### 📄 `LoginContext` (컨텍스트)
전략을 사용하는 클라이언트입니다.

- `LoginStrategy` 타입의 참조 변수를 가집니다. 이를 통해 구체적인 로그인 방식(전략)과 느슨하게 연결됩니다.
- 생성자를 통해 최초의 로그인 전략을 주입받습니다.
- `changeLoginStrategy` 메서드를 통해 런타임에 동적으로 전략을 변경할 수 있습니다.
- `login` 메서드는 실제 작업 수행을 현재 설정된 `loginStrategy` 객체에 위임합니다.

```dart:strategy/lib/login_context.dart
class LoginContext {
  LoginStrategy loginStrategy;
  LoginContext(this.loginStrategy); // 생성자 주입

  // Setter를 통한 런타임 전략 변경
  void changeLoginStrategy(LoginStrategy loginStrategy) {
    this.loginStrategy = loginStrategy;
  }

  Future<void> login(String identifier, String credential) async {
    // 실제 실행은 현재의 전략 객체에 위임
    final result = await loginStrategy.executeLogin(identifier, credential);
    // ... 결과 처리
  }
}
```

## 🤔 심화 질문: 전략 주입 방식에 따른 패턴 정의

생성자 주입 방식만 사용하더라도 알고리즘을 클래스로 캡슐화하고 인터페이스를 통해 분리했다는 전략 패턴의 핵심 구조를 만족하므로, 이는 전략 패턴으로 간주될 수 있습니다. 런타임에 전략을 바꿔야 할 필요가 있을 때만 Setter 주입을 추가로 고려하면 됩니다.
