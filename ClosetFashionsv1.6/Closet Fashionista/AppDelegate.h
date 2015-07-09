//
//  AppDelegate.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MixerController.h"
#import "FilterController.h"
#import "OutfitBrowserController.h"




@class MixerController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MixerController *mixerController;
@property (strong, nonatomic) FilterController *filterController;
@property (strong, nonatomic) OutfitBrowserController *outfitBrowserController;

@property (strong, nonatomic) Closet *myCloset;
@property (nonatomic) BOOL reloadarchives;
@property (nonatomic) BOOL topChanged;
@property (nonatomic) BOOL topOverlayChanged;
@property (nonatomic) BOOL accessoriesChanged;
@property (nonatomic) BOOL rightChanged;
@property (nonatomic) BOOL lowerChanged;


@end
