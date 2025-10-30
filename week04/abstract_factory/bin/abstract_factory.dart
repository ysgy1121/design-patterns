import 'package:abstract_factory/abstract_factory.dart';

void main(List<String> arguments) {
  print('=== 추상 팩토리 패턴 예제 ===\n');

  // Windows 환경에서 실행
  print('🪟 Windows 환경에서 실행:');
  print('─' * 40);
  var windowsApp = Application(WindowsFactory());
  windowsApp.render();
  windowsApp.handleEvents();

  print('\n');

  // macOS 환경에서 실행
  print('🍎 macOS 환경에서 실행:');
  print('─' * 40);
  var macApp = Application(MacOSFactory());
  macApp.render();
  macApp.handleEvents();

  print('\n');
  print('=== 패턴 설명 ===');
  print('• 추상 팩토리 패턴은 관련된 객체들의 패밀리를 생성합니다');
  print('• WindowsFactory와 MacOSFactory는 각각의 GUI 스타일을 생성합니다');
  print('• 클라이언트(Application)는 구체적인 클래스에 의존하지 않습니다');
}
