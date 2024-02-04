# Get Settings

|  Method   | IOS Support  | Android Support  |
|  ----  | ----  | ----  |
| getPlatformVersion  | YES | YES |
| isiOSAppOnMac  | YES | NO |
| getUserAgent  | YES | YES |
| isRotationOn  | NO | YES |
| getCPUType  | YES | NO |
| isPad  | YES | YES |

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
```
