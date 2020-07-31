#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

#import <UMCommon/UMCommon.h>

#import <UMCommonLog/UMCommonLogHeaders.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    
    [UMCommonLogManager setUpUMCommonLogManager];
    

    [UMConfigure setLogEnabled:YES];//设置打开日志
    
    
    [UMConfigure initWithAppkey:@"5f1e81fad62dd10bc71c5501" channel:@"App Store"];




  // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
