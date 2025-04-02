import 'package:flutter_test/flutter_test.dart';
import 'package:get_settings/get_settings.dart';
import 'package:get_settings/get_settings_platform_interface.dart';
import 'package:get_settings/get_settings_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGetSettingsPlatform with MockPlatformInterfaceMixin implements GetSettingsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> contentToPath(String contentUri, bool rewrite) {
    // TODO: implement contentToPath
    throw UnimplementedError();
  }

  @override
  Future<String?> getCPUType() {
    // TODO: implement getCPUType
    throw UnimplementedError();
  }

  @override
  Future<String?> getUserAgent() {
    // TODO: implement getUserAgent
    throw UnimplementedError();
  }

  @override
  Future<String> ipodToPath(String ipodLibraryUri, bool rewrite) {
    // TODO: implement ipodToPath
    throw UnimplementedError();
  }

  @override
  Future<bool?> isPad() {
    // TODO: implement isPad
    throw UnimplementedError();
  }

  @override
  Future<bool?> isRotationOn() {
    // TODO: implement isRotationOn
    throw UnimplementedError();
  }

  @override
  Future<bool?> isiOSAppOnMac() {
    // TODO: implement isiOSAppOnMac
    throw UnimplementedError();
  }

  @override
  void onListenSettings(onEvent, onError) {
    // TODO: implement onListenSettings
  }
}

void main() {
  final GetSettingsPlatform initialPlatform = GetSettingsPlatform.instance;

  test('$MethodChannelGetSettings is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGetSettings>());
  });

  test('getPlatformVersion', () async {
    GetSettings getSettingsPlugin = GetSettings();
    MockGetSettingsPlatform fakePlatform = MockGetSettingsPlatform();
    GetSettingsPlatform.instance = fakePlatform;

    expect(await getSettingsPlugin.getPlatformVersion(), '42');
  });
}
