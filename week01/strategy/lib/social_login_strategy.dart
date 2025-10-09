import 'package:multiple_result/multiple_result.dart';
import 'package:strategy/login_result.dart';
import 'package:strategy/login_strategy.dart';

class SocialLoginStrategy implements LoginStrategy {
  @override
  Future<Result<LoginResult, Exception>> executeLogin(
    String identifier,
    String credential,
  ) async {
    try {
      print('SocialLoginStrategy executeLogin');
      _validateInputs(identifier, credential);

      var user = await _authenticate(identifier, credential);
      await _createSession(user);

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

  Future<String> _authenticate(String identifier, String credential) async {
    String token = identifier;
    String service = credential;

    print('  -> $service 서버에 토큰의 유효성을 요청하는 중...');
    if (token.startsWith('VALID_TOKEN')) {
      return '${service}_user_12345';
    }
    throw Exception('인증 실패: 유효하지 않은 소셜 토큰입니다.');
  }

  Future<void> _createSession(String user) async {
    print('$user에 대한 세션이 생성되었습니다.');
  }
}
