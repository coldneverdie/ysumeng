#import "YsumengPlugin.h"
#if __has_include(<ysumeng/ysumeng-Swift.h>)
#import <ysumeng/ysumeng-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ysumeng-Swift.h"
#endif

@implementation YsumengPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYsumengPlugin registerWithRegistrar:registrar];
}
@end
