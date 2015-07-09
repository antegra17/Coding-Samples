//
//  AppDelegate.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MixerController.h"
#import "FilterController.h"




@implementation AppDelegate

@synthesize window = _window;
@synthesize mixerController = _mixerController;
@synthesize myCloset, topChanged, topOverlayChanged, rightChanged, lowerChanged, accessoriesChanged, filterController, outfitBrowserController;



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return YES;
    
}

// extend the access token
- (void)applicationDidBecomeActive:(UIApplication *)application
{
  
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    topChanged = NO;
    topOverlayChanged = NO;
    rightChanged = NO;
    lowerChanged = NO;
    accessoriesChanged = NO;
    
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *organizerNavController = [[tabBarController viewControllers] objectAtIndex:2];
    
    outfitBrowserController = [[organizerNavController viewControllers] objectAtIndex:0];
    
    
    
    //PUSH NOTIFICATION, REGISTER APP for PUSH NOTIFICATIONS
    
    /*
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    */
    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        if ([[UIScreen mainScreen] bounds].size.height == 568){
            self.mixerController = [[MixerController alloc] initWithNibName:@"MixerController_iPhone" bundle:nil];
        }
        else{
            self.mixerController = [[MixerController alloc] initWithNibName:@"MixerController_iPhone3inch" bundle:nil];
        }
 
        
        
    } else {
        self.mixerController = [[MixerController alloc] initWithNibName:@"MixerController_iPad" bundle:nil];
    }
    self.window.rootMixerController = self.mixerController;
    [self.window makeKeyAndVisible]; */
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
