import 'package:template_method/login_result.dart';
import 'package:template_method/social_login.dart';
import 'package:test/test.dart';

void main() {
  late SocialLogin socialLogin;

  setUp(() {
    socialLogin = SocialLogin();
  });

  test('social login success', () async {
    final result = await socialLogin.executeLogin('VALID_TOKEN_123', 'google');
    expect(result.isSuccess(), true);

    final loginResult = result.tryGetSuccess();
    expect(loginResult, isA<LoginResult>());
    expect(loginResult?.user, 'google_user_12345');
  });

  test('social login fail with invalid token', () async {
    final result = await socialLogin.executeLogin('INVALID_TOKEN', 'google');
    expect(result.isError(), true);

    final exception = result.tryGetError();
    expect(exception, isA<Exception>());
    expect(exception?.toString(), contains('유효하지 않은 소셜 토큰입니다'));
  });

  test('social login fail with empty token', () async {
    final result = await socialLogin.executeLogin('', 'google');
    expect(result.isError(), true);

    final exception = result.tryGetError();
    expect(exception, isA<Exception>());
    expect(exception?.toString(), contains('ID 또는 비밀번호를 입력해주세요'));
  });

  test('social login fail with empty service', () async {
    final result = await socialLogin.executeLogin('VALID_TOKEN_123', '');
    expect(result.isError(), true);

    final exception = result.tryGetError();
    expect(exception, isA<Exception>());
    expect(exception?.toString(), contains('ID 또는 비밀번호를 입력해주세요'));
  });
}
