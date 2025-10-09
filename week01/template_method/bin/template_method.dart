import 'package:template_method/email_login.dart';
import 'package:template_method/social_login.dart';

void main(List<String> arguments) async {
  // 이메일 로그인
  var emailLogin = EmailLogin();
  final emailLoginResult = await emailLogin.executeLogin(
    'user@example.com',
    'password123',
  );
  emailLoginResult.when(
    (result) => print('로그인 성공! ${result.user}님 환영합니다.'),
    (error) => print('로그인 실패: ${error.toString()}'),
  );

  // 소셜 로그인
  var socialLogin = SocialLogin();
  final socialLoginResult = await socialLogin.executeLogin(
    'VALID_TOKEN_12345',
    'google',
  );
  socialLoginResult.when(
    (result) => print('로그인 성공! ${result.user}님 환영합니다.'),
    (error) => print('로그인 실패: ${error.toString()}'),
  );
}
