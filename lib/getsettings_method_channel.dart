import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'getsettings_platform_interface.dart';

/// An implementation of [GetSettingsPlatform] that uses method channels.
class MethodChannelGetSettingsPlatform extends GetSettingsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('GetsettingsPlugin');
  final eventChannel = const EventChannel("GetSettingsChannel");
  @override
  void onListenSettings(onEvent, onError) {
    eventChannel.receiveBroadcastStream().listen(onEvent, onError: onError);
  }

  @override
  Future<String?> getPlatformVersion() async {
    return methodChannel.invokeMethod<String>('getPlatformVersion');
  }

  @override
  Future<bool?> isRotationOn() async {
    return await methodChannel.invokeMethod<bool>('isRotationOn');
  }

  @override
  Future<bool?> isiOSAppOnMac() async {
    return await methodChannel.invokeMethod<bool>('isiOSAppOnMac');
  }

  @override
  Future<String?> getUserAgent() async {
    return await methodChannel.invokeMethod<String>('getUserAgent');
  }

  @override
  Future<String?> getCPUType() async {
    return await methodChannel.invokeMethod<String>('getCPUType');
  }

  @override
  Future<bool?> isPad() async {
    return await methodChannel.invokeMethod<bool>('isPad');
  }

  @override
  Future<String> ipod2path(String ipodLibraryUri, bool rewrite) async {
    String? path = await methodChannel.invokeMethod<String>('ipod2path', {
      'ipodLibraryUri': ipodLibraryUri,
      'rewrite': rewrite,
    });
    return path ?? '';
  }

  @override
  Future<String> content2path(String contentUri, bool rewrite) async {
    String? path = await methodChannel.invokeMethod<String>('content2path', {
      'contentUri': contentUri,
      'rewrite': rewrite,
    });
    return path ?? '';
  }
}
