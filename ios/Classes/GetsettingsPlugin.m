#import "GetsettingsPlugin.h"
#if __has_include(<get_settings/get_settings-Swift.h>)
#import <get_settings/get_settings-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "get_settings-Swift.h"
#endif

@implementation GetsettingsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGetsettingsPlugin registerWithRegistrar:registrar];
}
@end
