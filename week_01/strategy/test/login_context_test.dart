import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:strategy/email_login_strategy.dart';
import 'login_context_test.mocks.dart';

class FakeResult extends Fake implements Result<LoginResult, Exception> {}

@GenerateMocks([LoginStrategy])
void main() {
  late LoginContext loginContext;
  late MockLoginStrategy mockLoginStrategy;

  setUpAll(() {
    registerFallbackValue(FakeResult());
  });

  setUp(() {
    mockLoginStrategy = MockLoginStrategy();
  }
}
