# 팩토리 메서드 패턴 (Factory Method Pattern)

팩토리 메서드 패턴은 객체 생성을 서브클래스에 위임하는 디자인 패턴입니다. 상위 클래스에서는 객체를 생성하는 인터페이스만 정의하고, 실제 객체 생성은 서브클래스에서 담당합니다.

## 💡 핵심 원칙 및 특징

**생성 로직 캡슐화:** 객체 생성의 구체적인 로직을 서브클래스에 위임하여 캡슐화합니다.

**확장성:** 새로운 제품 타입을 추가할 때 기존 코드를 수정하지 않고 새로운 서브클래스만 추가하면 됩니다.

**의존성 역전:** 클라이언트는 구체적인 클래스가 아닌 추상 클래스에 의존합니다.

## ☕️ 구성 요소

### 제품 (Product):
생성될 객체의 인터페이스를 정의합니다.

### 구체 제품 (Concrete Product):
제품 인터페이스를 구현하는 구체적인 클래스입니다.

### 크리에이터 (Creator):
제품을 생성하는 팩토리 메서드를 정의하는 추상 클래스입니다.

### 구체 크리에이터 (Concrete Creator):
크리에이터를 상속받아 구체적인 제품을 생성하는 클래스입니다.

## 📚 장점 및 디자인 원칙

**개방-폐쇄 원칙(OCP) 준수:** 새로운 제품 타입을 추가할 때 기존 코드를 수정하지 않고 확장할 수 있습니다.

**단일 책임 원칙(SRP) 준수:** 각 구체 크리에이터는 하나의 제품 타입만 생성합니다.

**의존성 역전 원칙(DIP) 준수:** 클라이언트는 구체적인 클래스가 아닌 추상화에 의존합니다.

## 💻 예제 코드: 문서 생성기

다양한 문서 타입(Word, PDF, Excel)을 생성하는 팩토리 메서드 패턴을 구현합니다.

### 📄 제품 인터페이스

```dart
abstract class Document {
  String getType();
  void open();
  void save();
  void close();
}
```

### 📄 구체 제품들

```dart
class WordDocument implements Document {
  @override
  String getType() => "Word 문서";
  
  @override
  void open() => print("Word 문서를 엽니다");
  
  @override
  void save() => print("Word 문서를 저장합니다");
  
  @override
  void close() => print("Word 문서를 닫습니다");
}
```

### 📄 구체 크리에이터들

```dart
class WordCreator extends DocumentCreator {
  @override
  Document createDocument() => WordDocument();
}

class PDFCreator extends DocumentCreator {
  @override
  Document createDocument() => PDFDocument();
}

class ExcelCreator extends DocumentCreator {
  @override
  Document createDocument() => ExcelDocument();
}
```

### 📄 클라이언트 코드

```dart
void main() {
  // 다양한 문서 생성기 사용
  var wordCreator = WordCreator();
  var pdfCreator = PDFCreator();
  var excelCreator = ExcelCreator();
  
  // 각각의 문서 처리
  wordCreator.processDocument();
  pdfCreator.processDocument();
  excelCreator.processDocument();
}
```

## 🤔 심화 질문 01: 팩토리 메서드 패턴과 추상 팩토리 패턴의 차이점

| 특징 | 팩토리 메서드 패턴 | 추상 팩토리 패턴 |
| :--- | :--- | :--- |
| **목적** | **단일 객체**의 생성을 캡슐화 | **관련된 객체들의 패밀리**를 생성 |
| **구조** | **하나의 메서드**로 하나의 제품을 생성 | **여러 메서드**로 여러 제품을 생성 |
| **확장성** | 새로운 **제품 타입**을 추가 | 새로운 **패밀리 전체**를 추가 |
| **상속 vs 구성** | **상속**을 통한 객체 생성 | **구성**을 통한 객체 생성 |

## 🤔 심화 질문 02: 팩토리 메서드 패턴의 단점 및 제약 사항

### 새로운 제품 타입 추가 시 서브클래스 필요
새로운 제품 타입을 추가할 때마다 새로운 서브클래스를 만들어야 하므로 클래스의 수가 증가합니다.

**해결 방법:**
- **매개변수화된 팩토리 메서드**: 제품 타입을 매개변수로 받아 생성
- **등록 기반 팩토리**: 제품 타입과 생성자를 맵에 등록하여 관리
- **빌더 패턴**과 결합: 복잡한 객체 생성을 단계별로 처리

### 상속에 의한 강한 결합
서브클래스가 부모 클래스의 구현에 의존하게 되어 강한 결합이 발생할 수 있습니다.

**해결 방법:**
- **구성(Composition) 기반 팩토리** 사용
- **의존성 주입(DI)** 프레임워크 활용
- **전략 패턴**과 결합하여 생성 로직을 분리
