import 'package:strategy/email_login_strategy.dart';
import 'package:strategy/login_context.dart';
import 'package:strategy/social_login_strategy.dart';

void main(List<String> arguments) async {
  final loginContext = LoginContext(EmailLoginStrategy());
  await loginContext.login('user@example.com', 'password123');

  loginContext.changeLoginStrategy(SocialLoginStrategy());
  await loginContext.login('VALID_TOKEN_12345', 'google');
}
