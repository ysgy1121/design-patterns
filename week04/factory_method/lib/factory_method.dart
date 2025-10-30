// 제품 인터페이스
abstract class Document {
  String getType();
  void open();
  void save();
  void close();
}

// 구체 제품들
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

class PDFDocument implements Document {
  @override
  String getType() => "PDF 문서";

  @override
  void open() => print("PDF 문서를 엽니다");

  @override
  void save() => print("PDF 문서를 저장합니다");

  @override
  void close() => print("PDF 문서를 닫습니다");
}

class ExcelDocument implements Document {
  @override
  String getType() => "Excel 문서";

  @override
  void open() => print("Excel 문서를 엽니다");

  @override
  void save() => print("Excel 문서를 저장합니다");

  @override
  void close() => print("Excel 문서를 닫습니다");
}

// 크리에이터 (추상 클래스)
abstract class DocumentCreator {
  // 팩토리 메서드 - 서브클래스에서 구현
  Document createDocument();

  // 템플릿 메서드 - 공통 로직
  void processDocument() {
    var document = createDocument();
    print("${document.getType()} 생성 중...");
    document.open();
    document.save();
    document.close();
    print("${document.getType()} 처리가 완료되었습니다.\n");
  }
}

// 구체 크리에이터들
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
