import 'package:template_method/login.dart';

class SocialLogin extends Login {
  @override
  Future<String> authenticate(String identifier, String credential) async {
    String token = identifier;
    String service = credential;

    print('  -> $service 서버에 토큰의 유효성을 요청하는 중...');
    if (token.startsWith('VALID_TOKEN')) {
      return '${service}_user_12345';
    }
    throw Exception('인증 실패: 유효하지 않은 소셜 토큰입니다.');
  }

  @override
  bool shouldLog() => false;
}
