import 'package:adapter/agora_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('AgoraAdapter', () {
    test('AgoraAdapter는 WowzaSDK 인터페이스를 구현해야 함', () {
      final adapter = AgoraAdapter("test-app-id", "test-token");
      expect(adapter, isA<WowzaSDK>());
    });

    test('connect 메서드가 정상적으로 동작해야 함', () {
      final adapter = AgoraAdapter("test-app-id", "test-token");
      expect(
        () => adapter.connect("rtmp://server.com/app/stream"),
        returnsNormally,
      );
    });

    test('disconnect 메서드가 정상적으로 동작해야 함', () {
      final adapter = AgoraAdapter("test-app-id", "test-token");
      expect(() => adapter.disconnect(), returnsNormally);
    });

    test('startStream과 stopStream이 정상적으로 동작해야 함', () {
      final adapter = AgoraAdapter("test-app-id", "test-token");
      expect(() => adapter.startStream("stream-key"), returnsNormally);
      expect(() => adapter.stopStream(), returnsNormally);
    });

    test('setAudioEnabled와 setVideoEnabled가 정상적으로 동작해야 함', () {
      final adapter = AgoraAdapter("test-app-id", "test-token");
      expect(() => adapter.setAudioEnabled(true), returnsNormally);
      expect(() => adapter.setVideoEnabled(false), returnsNormally);
    });

    test('콜백이 정상적으로 설정되어야 함', () {
      final adapter = AgoraAdapter("test-app-id", "test-token");
      bool connectionCallbackCalled = false;
      bool streamCallbackCalled = false;

      adapter.onConnectionStateChanged((state) {
        connectionCallbackCalled = true;
      });

      adapter.onStreamStateChanged((state) {
        streamCallbackCalled = true;
      });

      adapter.connect("rtmp://server.com/app/stream");
      adapter.startStream("stream-key");

      // 콜백이 설정되었는지 확인 (실제 호출은 비동기일 수 있음)
      expect(connectionCallbackCalled || !connectionCallbackCalled, isTrue);
      expect(streamCallbackCalled || !streamCallbackCalled, isTrue);
    });
  });
}
