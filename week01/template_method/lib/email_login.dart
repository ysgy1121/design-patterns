import 'package:template_method/login.dart';

class EmailLogin extends Login {
  @override
  Future<String> authenticate(String email, String password) async {
    print('  -> DB에서 이메일과 비밀번호를 검증하는 중...');
    if (email == 'user@example.com' && password == 'password123') {
      return email;
    }
    throw Exception('인증 실패: 이메일 또는 비밀번호가 일치하지 않습니다.');
  }

  @override
  void logLogin(String user) {
    print('AUDIT: $user의 이메일/비밀번호 상세 로그인 기록.');
  }
}
