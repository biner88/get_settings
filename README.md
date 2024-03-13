# Get Settings

Toolbox, some useful methods, not commonly used but indispensable

## Support

|  Method   | IOS Support  | Android Support  |
|  ----  | ----  | ----  |
| getPlatformVersion  | ✅ | ✅ |
| isiOSAppOnMac  | ✅ | ❌ |
| getUserAgent  | ✅ | ✅ |
| isRotationOn  | ❌ | ✅ |
| getCPUType  | ✅ | ❌ |
| isPad  | ✅ | ✅ |
| ipodToPath  | ✅ | ❌ |
| contentToPath  | ❌ | ✅ |

## Usage

```dart
import 'package:get_settings/getsettings.dart';
final setting = GetSettings();

```

### Rotation On

Android Only

```dart
setting.onListenSettings((rotation) {
  print(rotation);
}, (onError) {
  print('error:$onError');
});
Future<bool?> isRotationOn =await setting.isRotationOn();
```

### Platform Version

```dart
Future<String?> getPlatformVersion =await setting.getPlatformVersion();
print(getPlatformVersion);
```

### iOS App On Mac

Particularly useful for detecting whether an app is running on macOS, IOS Only

```dart
Future<bool?> isiOSAppOnMac =await setting.isiOSAppOnMac();
print(isiOSAppOnMac);
```

### User Agent

webview UserAgent

```dart
Future<String?> getUserAgent =await setting.getUserAgent();
print(getUserAgent);
```

### CPU type

IOS Only

```dart
Future<String?> getCPUType =await setting.getCPUType();
print(getCPUType);
//ARM,ARM64,X86,X86_64
```

### Uri to file

Use [on_audio_query](https://pub.dev/packages/on_audio_query) to obtain the uri of the audio file. This method can obtain the absolute path of the file.

* `content://` to filepath , app cache dir, Android Only.
* `ipod-library` to filepath, app document dir, IOS Only.

```dart

Future<String> ipodPath = await setting.ipodToPath('ipod-library://item/item.mp3?id=6894390456987001162'); 
print(ipodPath); 

Future<String> contentPath = await setting.contentToPath('content://media/external/audio/media/1000000346'); 
print(ipodpath); 
```
