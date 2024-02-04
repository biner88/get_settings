import 'getsettings_platform_interface.dart';

class GetSettings {
  void onListenSettings(onEvent, onError) {
    GetSettingsPlatform.instance.onListenSettings(onEvent, onError);
  }

  Future<String?> getPlatformVersion() {
    return GetSettingsPlatform.instance.getPlatformVersion();
  }

  Future<bool?> isRotationOn() {
    return GetSettingsPlatform.instance.isRotationOn();
  }

  Future<bool?> isiOSAppOnMac() {
    return GetSettingsPlatform.instance.isiOSAppOnMac();
  }

  Future<String?> getUserAgent() {
    return GetSettingsPlatform.instance.getUserAgent();
  }

  Future<String?> getCPUType() {
    return GetSettingsPlatform.instance.getCPUType();
  }

  Future<bool?> isPad() {
    return GetSettingsPlatform.instance.isPad();
  }
}
