//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import "AppDelegate.h"

#import "TBCCoreExampleViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TBCCoreExampleViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
