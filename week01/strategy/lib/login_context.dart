import 'package:strategy/login_strategy.dart';

class LoginContext {
  LoginStrategy loginStrategy;
  LoginContext(this.loginStrategy);

  void changeLoginStrategy(LoginStrategy loginStrategy) {
    print('LoginContext changeLoginStrategy');
    this.loginStrategy = loginStrategy;
  }

  Future<void> login(String identifier, String credential) async {
    final result = await loginStrategy.executeLogin(identifier, credential);
    result.when(
      (result) => print('로그인 성공! ${result.user}님 환영합니다.'),
      (error) => print('로그인 실패: ${error.toString()}'),
    );
  }
}
