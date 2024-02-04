import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'getsettings_method_channel.dart';

abstract class GetSettingsPlatform extends PlatformInterface {
  /// Constructs a getsettingsPlatform.
  GetSettingsPlatform() : super(token: _token);

  static final Object _token = Object();

  static GetSettingsPlatform _instance = MethodChannelGetSettingsPlatform();

  /// The default instance of [getsettingsPlatform] to use.
  ///
  /// Defaults to [MethodChannelgetsettings].
  static GetSettingsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [getsettingsPlatform] when
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
}
