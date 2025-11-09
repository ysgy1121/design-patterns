// Wowza SDK 인터페이스 (Target Interface)
// 클라이언트가 기대하는 인터페이스
abstract class WowzaSDK {
  void connect(String serverUrl);
  void disconnect();
  void startStream(String streamKey);
  void stopStream();
  void setAudioEnabled(bool enabled);
  void setVideoEnabled(bool enabled);
  void onConnectionStateChanged(Function(String state) callback);
  void onStreamStateChanged(Function(String state) callback);
}

// Agora SDK (Adaptee)
// 실제로 사용할 새로운 SDK
class AgoraSDK {
  String? _appId;
  String? _channelName;
  bool _audioEnabled = true;
  bool _videoEnabled = true;
  Function(String)? _connectionCallback;
  Function(String)? _streamCallback;

  void initialize(String appId) {
    _appId = appId;
    print("Agora SDK 초기화: AppId = $appId");
  }

  String? get appId => _appId;
  bool get audioEnabled => _audioEnabled;
  bool get videoEnabled => _videoEnabled;

  void joinChannel(String channelName, String token) {
    _channelName = channelName;
    print("Agora 채널 참가: $channelName");
    _connectionCallback?.call("connected");
  }

  void leaveChannel() {
    print("Agora 채널 나가기: $_channelName");
    _channelName = null;
    _connectionCallback?.call("disconnected");
  }

  void startPublishing() {
    print("Agora 스트림 발행 시작");
    _streamCallback?.call("streaming");
  }

  void stopPublishing() {
    print("Agora 스트림 발행 중지");
    _streamCallback?.call("stopped");
  }

  void enableAudio(bool enabled) {
    _audioEnabled = enabled;
    print("Agora 오디오 ${enabled ? '활성화' : '비활성화'}");
  }

  void enableVideo(bool enabled) {
    _videoEnabled = enabled;
    print("Agora 비디오 ${enabled ? '활성화' : '비활성화'}");
  }

  void setConnectionStateHandler(Function(String state) handler) {
    _connectionCallback = handler;
  }

  void setStreamStateHandler(Function(String state) handler) {
    _streamCallback = handler;
  }
}

// AgoraAdapter
// Agora SDK를 Wowza SDK 인터페이스로 변환하는 어댑터
class AgoraAdapter implements WowzaSDK {
  final AgoraSDK _agoraSDK;
  final String _agoraAppId;
  final String _agoraToken;
  Function(String)? _connectionCallback;
  Function(String)? _streamCallback;

  AgoraAdapter(this._agoraAppId, this._agoraToken) : _agoraSDK = AgoraSDK() {
    _agoraSDK.initialize(_agoraAppId);
    _agoraSDK.setConnectionStateHandler((state) {
      _connectionCallback?.call(state);
    });
    _agoraSDK.setStreamStateHandler((state) {
      _streamCallback?.call(state);
    });
  }

  @override
  void connect(String serverUrl) {
    // Wowza의 serverUrl을 Agora의 channelName으로 변환
    // 예: "rtmp://server.com/app" -> "app"
    final channelName = _extractChannelName(serverUrl);
    _agoraSDK.joinChannel(channelName, _agoraToken);
  }

  @override
  void disconnect() {
    _agoraSDK.leaveChannel();
  }

  @override
  void startStream(String streamKey) {
    // Wowza의 streamKey를 사용하여 Agora 스트림 시작
    _agoraSDK.startPublishing();
  }

  @override
  void stopStream() {
    _agoraSDK.stopPublishing();
  }

  @override
  void setAudioEnabled(bool enabled) {
    _agoraSDK.enableAudio(enabled);
  }

  @override
  void setVideoEnabled(bool enabled) {
    _agoraSDK.enableVideo(enabled);
  }

  @override
  void onConnectionStateChanged(Function(String state) callback) {
    _connectionCallback = callback;
  }

  @override
  void onStreamStateChanged(Function(String state) callback) {
    _streamCallback = callback;
  }

  // Helper method: Wowza URL에서 채널명 추출
  String _extractChannelName(String serverUrl) {
    // 예: "rtmp://server.com/app/stream" -> "app"
    final uri = Uri.parse(serverUrl);
    final pathSegments = uri.pathSegments;
    return pathSegments.isNotEmpty ? pathSegments[0] : 'default';
  }
}

// 클라이언트 코드 예제
void testAgoraAdapter() {
  print("=== Wowza SDK를 Agora SDK로 변경하는 Adapter 패턴 테스트 ===\n");

  // AgoraAdapter를 WowzaSDK 인터페이스로 사용
  final WowzaSDK sdk = AgoraAdapter("your-agora-app-id", "your-agora-token");

  // 연결 상태 콜백 설정
  sdk.onConnectionStateChanged((state) {
    print("연결 상태 변경: $state");
  });

  // 스트림 상태 콜백 설정
  sdk.onStreamStateChanged((state) {
    print("스트림 상태 변경: $state");
  });

  print("1. Wowza 서버에 연결 (실제로는 Agora 채널에 연결됨)");
  sdk.connect("rtmp://wowza-server.com/app/stream");

  print("\n2. 오디오/비디오 설정");
  sdk.setAudioEnabled(true);
  sdk.setVideoEnabled(true);

  print("\n3. 스트림 시작");
  sdk.startStream("stream-key-123");

  print("\n4. 스트림 중지");
  sdk.stopStream();

  print("\n5. 연결 종료");
  sdk.disconnect();

  print("\n=== 테스트 완료 ===\n");
}
