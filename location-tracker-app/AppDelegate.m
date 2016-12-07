//
//  AppDelegate.m
//  location-tracker-app
//
//  Created by Cormac Chisholm on 28/11/2016.
//  Copyright © 2016 Wia. All rights reserved.
//

#import "AppDelegate.h"

@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"YOUR API KEY"];
    return YES;
}

@end
