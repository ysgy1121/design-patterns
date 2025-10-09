
# 템플릿 메서드 패턴 (Template Method Pattern)
템플릿 메서드 패턴은 알고리즘을 캡슐화하여, 서브클래스에서 언제든 필요할 때마다 가져다 쓸 수 있도록 하는 디자인 패턴입니다.

## 💡 핵심 원칙 및 특징
알고리즘의 골격 정의: 상위(추상) 클래스에 알고리즘의 <b>전체 흐름(뼈대)</b>을 정의하는 메서드(Template Method)를 `final`로 선언하여 서브클래스에서 순서를 변경할 수 없도록 고정할 수 있습니다.

서브클래스의 역할: 알고리즘의 특정 단계 중 일부는 서브클래스에서 구현하도록 위임합니다 (Abstract Method 사용).

코드 재사용: 알고리즘의 공통된 부분은 상위 클래스에 정의하여 중복을 줄이고 코드 재사용에 크게 기여합니다. (예: 커피와 홍차 끓이는 과정의 공통 부분 추상화)

## ☕️ 구성 요소
템플릿 메서드가 들어있는 추상 클래스는 다음 세 가지 종류의 메서드를 정의할 수 있습니다.

### 템플릿 메서드 (Template Method):
알고리즘의 전체 구조를 정의하는 메서드입니다.
일반적으로 `final`로 선언하여 서브클래스에서 `override`를 방지합니다.
(Abstract Method, Concrete Method, Hook 등을 순서대로 호출합니다.)

### 추상 메서드 (Abstract Method):
서브클래스에서 반드시 구현해야 하는, 구체적인 행동을 정의하지 않은 메서드입니다.
(예: 커피와 홍차에서 첨가물을 추가하는 구체적인 방법)

### 후크 (Hook):
추상 클래스에 들어있는 구상 메서드입니다.
기본적으로 아무 일도 하지 않거나 (Empty Body) 기본 행동을 정의합니다.
서브클래스에서 선택적으로 `override`할 수 있으며, 반드시 그래야 하는 것은 아닙니다.

## 📚 관련 원칙
> 헐리우드 원칙 (Hollywood Principle) "먼저 연락하지 마세요. 저희가 연락 드리겠습니다."

의존성 부패 (dependency rot) 방지: 고수준 구성요소 (상위 클래스)만 저수준 구성요소 (서브클래스)를 호출할 수 있도록 합니다. (저 → 고 호출 금지)

템플릿 메서드 패턴에서는 상위 클래스가 후크나 추상 메서드를 호출하여 서브클래스의 구현을 사용합니다.

> 의존성 역전 원칙 (Dependency Inversion Principle, DIP)와의 차이

DIP는 저수준 → 고수준을 참조해야 할 경우 추상화(인터페이스/추상 클래스)를 사용하여 참조하도록 하는 원칙입니다.

DIP는 참조 방향에 초점을 맞추는 반면, 헐리우드 원칙은 호출 주체에 초점을 맞추어 제어 흐름을 관리합니다. 템플릿 메서드 패턴은 DIP를 준수하며 헐리우드 원칙을 따릅니다.

## 💻 예제 코드: 다양한 로그인 방식 구현
이번 예제에서는 이메일 로그인과 소셜 로그인이라는 두 가지 로그인 방식을 템플릿 메서드 패턴을 통해 구현합니다. 로그인 과정의 전체적인 흐름은 동일하지만, 실제 인증 방식에서 차이가 나는 상황입니다.

### 📄 `Login` (추상 클래스)
`Login` 클래스는 로그인 알고리즘의 뼈대를 정의합니다.

- **`executeLogin` (템플릿 메서드):**
  - 모든 로그인 방식이 따라야 할 전체적인 흐름을 정의합니다.
  - `입력 값 검증` → `인증` → `세션 생성` → `(선택적) 로깅` 순으로 진행됩니다.
  - `final`로 선언하여 하위 클래스가 이 순서를 변경할 수 없도록 강제할 수 있습니다. (예제에서는 편의상 생략)

- **`authenticate` (추상 메서드):**
  - 이메일, 소셜 등 구체적인 인증 방식은 하위 클래스에서 구현하도록 강제합니다.

- **`shouldLog`, `logLogin` (후크 메서드):**
  - 로그를 남길지 여부를 결정하는 '갈고리' 역할을 합니다.
  - 기본적으로 `true`를 반환하며, 하위 클래스는 필요에 따라 이 메서드를 `override`하여 로깅 단계를 건너뛸 수 있습니다.
  - `logLogin`의 경우, 하위 클래스에서 필요시 `override`하여 다른 로깅 메시지를 출력할 수 있습니다.

- **`_validateInputs`, `_createSession` (구상 메서드):**
  - 모든 로그인 방식에 공통적으로 필요한 기능들입니다.

```dart:template_method/lib/login.dart
abstract class Login {
  // 템플릿 메서드
  Future<Result<LoginResult, Exception>> executeLogin(
    String identifier,
    String credential,
  ) async {
    try {
      // 1. (공통) 입력 값 검증
      _validateInputs(identifier, credential);

      // 2. (핵심) 인증 - 하위 클래스에 위임
      var user = await authenticate(identifier, credential);
      
      // 3. (공통) 세션 생성
      await _createSession(user);

      // 4. (선택) 로깅 - Hook 사용
      if (shouldLog()) {
        logLogin(user);
      }

      return Success(LoginResult(user));
    } on Exception catch (e) {
      return Error(e);
    }
  }

  // 추상 메서드 - 하위 클래스에서 반드시 구현
  Future<String> authenticate(String identifier, String credential);

  // 후크 메서드 - 하위 클래스에서 선택적으로 오버라이드
  bool shouldLog() => true; 

  void logLogin(String user) { /* ... */ }

  // 구상 메서드
  void _validateInputs(String identifier, String credential) { /* ... */ }
  Future<void> _createSession(String user) async { /* ... */ }
}
```

### 📄 `EmailLogin` & `SocialLogin` (구상 클래스)

- **`EmailLogin`:**
  - `authenticate` 메서드를 DB에서 이메일/비밀번호를 검증하는 로직으로 구현합니다.
  - `logLogin` 메서드를 `override`하여 더 상세한 감사 로그를 남깁니다.

- **`SocialLogin`:**
  - `authenticate` 메서드를 외부 소셜 서버에 토큰 유효성을 검사하는 로직으로 구현합니다.
  - `shouldLog` 후크 메서드를 `override`하여 `false`를 반환함으로써, `executeLogin`의 로깅 단계를 건너뛰도록 합니다.

```dart:template_method/lib/email_login.dart
class EmailLogin extends Login {
  @override
  Future<String> authenticate(String email, String password) async {
    // DB에서 이메일/비밀번호 검증 로직
  }

  @override
  void logLogin(String user) {
    print('AUDIT: $user의 이메일/비밀번호 상세 로그인 기록.');
  }
}
```

```dart:template_method/lib/social_login.dart
class SocialLogin extends Login {
  @override
  Future<String> authenticate(String identifier, String credential) async {
    // 소셜 서버에 토큰 유효성 검사 로직
  }

  @override
  bool shouldLog() => false; // 로깅 단계를 건너뛴다.
}
```


## 🤔 심화 질문 01: 흐름 순서 변경 필요 시 대처
템플릿 메서드 패턴은 전체 알고리즘의 뼈대를 상위 클래스에서 고정하는 것이 핵심입니다. 만약 Android/iOS와 같이 플랫폼별로 흐름의 순서 자체가 달라져야 한다면, 근본적으로 템플릿 메서드 패턴이 적합한지 재고해보고 컴포지션 패턴 등을 대안으로 고려해볼 수 있습니다.

만약 반드시 템플릿 메서드 패턴을 유지해야 한다면:

템플릿 메서드 내부에서 조건문을 사용하거나, Hook 메서드를 활용하여 플랫폼/조건에 맞는 경우에만 해당 단계를 호출하도록 처리할 수 있습니다.


## 🤔 심화 질문 02: StatefulWidget은 템플릿 메소드 패턴인가? (경옥님의 답변)
엄밀히 말하면 템플릿 메소드 패턴은 아닙니다. StatefulElement에서 State<T>의 함수를 각각 호출(외부 호출) 합니다. 실제적으로 State<T> 클래스 내부에는 템플릿 메소드가 존재하지 않습니다. 따라서 생명주기 콜백 패턴이라고 보는것이 더 정확한 표현입니다.

