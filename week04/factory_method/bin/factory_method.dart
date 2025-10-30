import 'package:factory_method/factory_method.dart';

void main(List<String> arguments) {
  print('=== 팩토리 메서드 패턴 예제 ===\n');

  // 다양한 문서 생성기 사용
  print('📄 Word 문서 생성기:');
  print('─' * 30);
  var wordCreator = WordCreator();
  wordCreator.processDocument();

  print('📄 PDF 문서 생성기:');
  print('─' * 30);
  var pdfCreator = PDFCreator();
  pdfCreator.processDocument();

  print('📄 Excel 문서 생성기:');
  print('─' * 30);
  var excelCreator = ExcelCreator();
  excelCreator.processDocument();

  print('=== 패턴 설명 ===');
  print('• 팩토리 메서드 패턴은 객체 생성을 서브클래스에 위임합니다');
  print('• DocumentCreator는 팩토리 메서드(createDocument)를 정의합니다');
  print('• 각 구체 크리에이터는 자신만의 문서 타입을 생성합니다');
  print('• 템플릿 메서드(processDocument)로 공통 로직을 처리합니다');
}
