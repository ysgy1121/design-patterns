import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:strategy/email_login_strategy.dart';
import 'package:strategy/login_context.dart';
import 'package:strategy/login_result.dart';
import 'package:strategy/login_strategy.dart';
import 'package:strategy/social_login_strategy.dart';
import 'package:test/test.dart';

import 'login_context_test.mocks.dart';

@GenerateMocks([LoginStrategy])
void main() {
  late LoginContext loginContext;
  late MockLoginStrategy mockLoginStrategy;

  setUp(() {
    mockLoginStrategy = MockLoginStrategy();
    loginContext = LoginContext(mockLoginStrategy);
    provideDummy<Result<LoginResult, Exception>>(
      Success(LoginResult('test_user')),
    );
  });

  test('login context should use the given strategy', () async {
    when(
      mockLoginStrategy.executeLogin(any, any),
    ).thenAnswer((_) async => Success(LoginResult('test_user')));
    await loginContext.login('id', 'pw');
    verify(mockLoginStrategy.executeLogin('id', 'pw')).called(1);
  });

  test('login context should change strategy', () async {
    final newStrategy = SocialLoginStrategy();
    loginContext.changeLoginStrategy(newStrategy);
    expect(loginContext.loginStrategy, isA<SocialLoginStrategy>());

    final anotherStrategy = EmailLoginStrategy();
    loginContext.changeLoginStrategy(anotherStrategy);
    expect(loginContext.loginStrategy, isA<EmailLoginStrategy>());
  });
}
