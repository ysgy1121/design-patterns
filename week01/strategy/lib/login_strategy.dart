import 'package:multiple_result/multiple_result.dart';
import 'package:strategy/login_result.dart';

abstract class LoginStrategy {
  Future<Result<LoginResult, Exception>> executeLogin(
    String identifier,
    String credential,
  );
}
