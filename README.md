# Get Settings

|  Method   | IOS Support  | Android Support  |
|  ----  | ----  | ----  |
| getPlatformVersion  | ✅ | ✅ |
| isiOSAppOnMac  | ✅ | ❌ |
| getUserAgent  | ✅ | ✅ |
| isRotationOn  | ❌ | ✅ |
| getCPUType  | ✅ | ❌ |
| isPad  | ✅ | ✅ |
| ipod2path  | ✅ | ❌ |
| content2path  | ❌ | ✅ |

## Usage

```
import 'package:get_settings/getsettings.dart';
final setting = GetSettings();

setting.onListenSettings((data) {
  print(data);
  setState(() {});
}, (onError) {
  print('error:$onError');
});

Future<bool?> isRotationOn =await setting.isRotationOn();
print(isRotationOn);

Future<String?> getPlatformVersion =await setting.getPlatformVersion();
print(getPlatformVersion);

Future<bool?> isiOSAppOnMac =await setting.isiOSAppOnMac();
print(isiOSAppOnMac);

Future<String?> getUserAgent =await setting.getUserAgent();
print(getUserAgent);

Future<String?> getCPUType =await setting.getCPUType();
print(getCPUType);
//ARM,ARM64,X86,X86_64

Future<String?> ipodpath =await setting.ipod2path('ipod-library://item/item.mp3?id=6894390456987001162');
print(ipodpath);
```
