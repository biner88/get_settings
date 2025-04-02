import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'get_settings_method_channel.dart';

abstract class GetSettingsPlatform extends PlatformInterface {
  /// Constructs a GetSettingsPlatform.
  GetSettingsPlatform() : super(token: _token);

  static final Object _token = Object();

  static GetSettingsPlatform _instance = MethodChannelGetSettings();

  /// The default instance of [GetSettingsPlatform] to use.
  ///
  /// Defaults to [MethodChannelGetSettings].
  static GetSettingsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GetSettingsPlatform] when
  /// they register themselves.
  static set instance(GetSettingsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void onListenSettings(onEvent, onError) {
    throw UnimplementedError('onListenSettings() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> isRotationOn() {
    throw UnimplementedError('isRotationOn() has not been implemented.');
  }

  Future<bool?> isiOSAppOnMac() {
    throw UnimplementedError('isiOSAppOnMac() has not been implemented.');
  }

  Future<String?> getUserAgent() {
    throw UnimplementedError('getUserAgent() has not been implemented.');
  }

  Future<String?> getCPUType() {
    throw UnimplementedError('getCPUType() has not been implemented.');
  }

  Future<bool?> isPad() {
    throw UnimplementedError('isPad() has not been implemented.');
  }

  Future<String> ipodToPath(String ipodLibraryUri, bool rewrite) {
    throw UnimplementedError('ipod2path() has not been implemented.');
  }

  Future<String> contentToPath(String contentUri, bool rewrite) {
    throw UnimplementedError('contentToPath() has not been implemented.');
  }
}
