import 'getsettings_platform_interface.dart';

class GetSettings {
  void onListenSettings(onEvent, onError) {
    GetSettingsPlatform.instance.onListenSettings(onEvent, onError);
  }

  ///Get system version number
  Future<String?> getPlatformVersion() {
    return GetSettingsPlatform.instance.getPlatformVersion();
  }

  ///Detect whether the system orientation lock switch is turned on, only supports Android devices
  Future<bool?> isRotationOn() {
    return GetSettingsPlatform.instance.isRotationOn();
  }

  ///Detect whether mobile applications are running on Apple silicon devices to support Apple devices
  Future<bool?> isiOSAppOnMac() {
    return GetSettingsPlatform.instance.isiOSAppOnMac();
  }

  ///Detect device user agent
  Future<String?> getUserAgent() {
    return GetSettingsPlatform.instance.getUserAgent();
  }

  ///Detect device cpu type.ARM,ARM64,X86,X86_64 ...
  Future<String?> getCPUType() {
    return GetSettingsPlatform.instance.getCPUType();
  }

  ///Detect whether the device is a tablet or mobile device
  Future<bool?> isPad() {
    return GetSettingsPlatform.instance.isPad();
  }

  ///ipod-library:// to path ,only supports IOS devices
  Future<String> ipod2path(String ipodLibraryUri, {bool rewrite = false}) {
    return GetSettingsPlatform.instance.ipod2path(ipodLibraryUri, rewrite);
  }

  ///content:// to path ,only supports Android devices
  Future<String> content2path(String contentUri, {bool rewrite = false}) {
    return GetSettingsPlatform.instance.content2path(contentUri, rewrite);
  }
}
