import 'package:template_method/email_login.dart';
import 'package:template_method/login_result.dart';
import 'package:test/test.dart';

void main() {
  late EmailLogin emailLogin;

  setUp(() {
    emailLogin = EmailLogin();
  });

  test('email login Success', () async {
    final result = await emailLogin.executeLogin(
      'user@example.com',
      'password123',
    );
    expect(result.isSuccess(), true);

    final loginResult = result.tryGetSuccess();
    expect(loginResult, isA<LoginResult>());
    expect(loginResult?.user, 'user@example.com');
  });

  test('email login fail with wrong password', () async {
    final result = await emailLogin.executeLogin(
      'user@example.com',
      'wrongpassword',
    );
    expect(result.isError(), true);
    final exception = result.tryGetError();
    expect(exception, isA<Exception>());
    expect(exception?.toString(), contains('인증 실패'));
  });

  test('email login fail with empty email', () async {
    final result = await emailLogin.executeLogin('', 'password123');
    expect(result.isError(), true);
    final exception = result.tryGetError();
    expect(exception, isA<Exception>());
    expect(exception?.toString(), contains('ID 또는 비밀번호를 입력해주세요'));
  });

  test('email login fail with empty password', () async {
    final result = await emailLogin.executeLogin('user@example.com', '');
    expect(result.isError(), true);
    final exception = result.tryGetError();
    expect(exception, isA<Exception>());
    expect(exception?.toString(), contains('ID 또는 비밀번호를 입력해주세요'));
  });
}
