#import "RoFmmkvPlugin.h"
#if __has_include(<ro_fmmkv/ro_fmmkv-Swift.h>)
#import <ro_fmmkv/ro_fmmkv-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ro_fmmkv-Swift.h"
#endif

@implementation RoFmmkvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRoFmmkvPlugin registerWithRegistrar:registrar];
}
@end
