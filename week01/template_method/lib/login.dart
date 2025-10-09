import 'package:multiple_result/multiple_result.dart';
import 'package:template_method/login_result.dart';

abstract class Login {
  Future<Result<LoginResult, Exception>> executeLogin(
    String identifier,
    String credential,
  ) async {
    try {
      _validateInputs(identifier, credential);

      var user = await authenticate(identifier, credential);
      await _createSession(user);
      if (shouldLog()) {
        logLogin(user);
      }

      return Success(LoginResult(user));
    } on Exception catch (e) {
      return Error(e);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  void _validateInputs(String identifier, String credential) {
    if (identifier.isEmpty || credential.isEmpty) {
      throw Exception('ID 또는 비밀번호를 입력해주세요.');
    }
    print('입력 데이터 유효성 검사 완료.');
  }

  Future<String> authenticate(String identifier, String credential);

  Future<void> _createSession(String user) async {
    print('$user에 대한 세션이 생성되었습니다.');
  }

  bool shouldLog() => true;
  void logLogin(String user) {
    print('LOG: $user의 표준 로그인 기록을 남깁니다.');
  }
}
