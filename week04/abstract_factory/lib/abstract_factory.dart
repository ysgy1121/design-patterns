// 추상 제품들
abstract class Button {
  String render();
  String onClick();
}

abstract class Checkbox {
  String render();
  String onCheck();
}

// 구체 제품들 - Windows 스타일
class WindowsButton implements Button {
  @override
  String render() => "Windows 스타일 버튼 렌더링";

  @override
  String onClick() => "Windows 버튼 클릭 이벤트 처리";
}

class WindowsCheckbox implements Checkbox {
  @override
  String render() => "Windows 스타일 체크박스 렌더링";

  @override
  String onCheck() => "Windows 체크박스 체크 이벤트 처리";
}

// 구체 제품들 - macOS 스타일
class MacOSButton implements Button {
  @override
  String render() => "macOS 스타일 버튼 렌더링";

  @override
  String onClick() => "macOS 버튼 클릭 이벤트 처리";
}

class MacOSCheckbox implements Checkbox {
  @override
  String render() => "macOS 스타일 체크박스 렌더링";

  @override
  String onCheck() => "macOS 체크박스 체크 이벤트 처리";
}

// 추상 팩토리
abstract class GUIFactory {
  Button createButton();
  Checkbox createCheckbox();
}

// 구체 팩토리들
class WindowsFactory implements GUIFactory {
  @override
  Button createButton() => WindowsButton();

  @override
  Checkbox createCheckbox() => WindowsCheckbox();
}

class MacOSFactory implements GUIFactory {
  @override
  Button createButton() => MacOSButton();

  @override
  Checkbox createCheckbox() => MacOSCheckbox();
}

// 클라이언트
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
