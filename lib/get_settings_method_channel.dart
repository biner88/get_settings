import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'get_settings_platform_interface.dart';

/// An implementation of [GetSettingsPlatform] that uses method channels.
class MethodChannelGetSettings extends GetSettingsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('get_settings');
  final eventChannel = const EventChannel("get_settings_channel");

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
  Future<String> ipodToPath(String ipodLibraryUri, bool rewrite) async {
    String? path = await methodChannel.invokeMethod<String>('ipodToPath', {
      'ipodLibraryUri': ipodLibraryUri,
      'rewrite': rewrite,
    });
    return path ?? '';
  }

  @override
  Future<String> contentToPath(String contentUri, bool rewrite) async {
    String? path = await methodChannel.invokeMethod<String>('contentToPath', {
      'contentUri': contentUri,
      'rewrite': rewrite,
    });
    return path ?? '';
  }
}
