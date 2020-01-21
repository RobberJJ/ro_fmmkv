import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ro_fmmkv/ro_fmmkv.dart';

void main() {
  const MethodChannel channel = MethodChannel('ro_fmmkv');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RoFmmkv.platformVersion, '42');
  });
}
