import 'package:multiple_result/multiple_result.dart';
import 'package:strategy/login_result.dart';
import 'package:strategy/login_strategy.dart';

class EmailLoginStrategy implements LoginStrategy {
  @override
  Future<Result<LoginResult, Exception>> executeLogin(
    String identifier,
    String credential,
  ) async {
    try {
      print('EmailLoginStrategy executeLogin');
      _validateInputs(identifier, credential);

      var user = await _authenticate(identifier, credential);
      await _createSession(user);
      _logLogin(user);

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

  Future<String> _authenticate(String email, String password) async {
    print('  -> DB에서 이메일과 비밀번호를 검증하는 중...');
    if (email == 'user@example.com' && password == 'password123') {
      return email;
    }
    throw Exception('인증 실패: 이메일 또는 비밀번호가 일치하지 않습니다.');
  }

  Future<void> _createSession(String user) async {
    print('$user에 대한 세션이 생성되었습니다.');
  }

  void _logLogin(String user) {
    print('LOG: $user의 표준 로그인 기록을 남깁니다.');
  }
}
