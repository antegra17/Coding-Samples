//
//  UIOutfitView.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIOutfitView.h"
#import "UIOutfitImageView.h"
#import "ImageRecord.h"
#import "UIScrollImageView.h"
#import "UIScrollDisplay.h"

#import "AppDelegate.h"
#import "MixerController.h"
#import "Closet.h"

@implementation UIOutfitView
{
    
    Closet *myCloset;

}

@synthesize outfitType;



-(int) findTopDisplayFileRefNum
{
  
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MixerController *mixerController = appDelegate.mixerController;
    
    myCloset = mixerController.myCloset;
    

    
    return mixerController.scrollDisplayTops.fileNumRef;
}



-(int) findMiddleDisplayFileRefNum
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MixerController *mixerController = appDelegate.mixerController;
    
    myCloset = mixerController.myCloset;
    

    
    
    return mixerController.scrollDisplayBottoms.fileNumRef;
}




-(int) findLowerDisplayFileRefNum
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MixerController *mixerController = appDelegate.mixerController;
 
    myCloset = mixerController.myCloset;
 

 
 
    return mixerController.scrollDisplayShoes.fileNumRef;
}

-(int) findTopOverlayDisplayFileRefNum
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MixerController *mixerController = appDelegate.mixerController;
    
    myCloset = mixerController.myCloset;
    
    
    
    
    return mixerController.scrollDisplayTopsOverlay.fileNumRef;
}



-(void)removeAccessory: (int) accessNum
{
    NSLog(@"removing accessory %i", accessNum);
}

 
 
 
/*

-(OutfitRecord *) OutfitTBwithTop:(ImageRecord *)T Bottom:(ImageRecord *)B
{
    outfitType = 0;
    OutfitRecord *newOutfit = [[OutfitRecord alloc] init];
    newOutfit.top = [[ImageRecord alloc] init];
    newOutfit.bottom = [[ImageRecord alloc] init];
    
    newOutfit.top = T;
    newOutfit.bottom = B;
    
    return newOutfit;
}

-(OutfitRecord *)OutfitTSwithTop:(ImageRecord *)T Shoes:(ImageRecord *)S
{
 outfitType = 1;
 OutfitRecord *newOutfit = [[OutfitRecord alloc] init];
 newOutfit.top = [[ImageRecord alloc] init];
 newOutfit.shoes = [[ImageRecord alloc] init];
 newOutfit.top = T;
 newOutfit.shoes = S;
 
 NSLog(@"outfit created!");
 return newOutfit;
}




-(OutfitRecord *)OutfitTBSwithTop:(ImageRecord *)T Bottom:(ImageRecord *)B Shoes:(ImageRecord *)S
{
    outfitType = 2;
    OutfitRecord *newOutfit = [[OutfitRecord alloc] init];
    newOutfit.top = [[ImageRecord alloc] init];
    newOutfit.bottom = [[ImageRecord alloc] init];
    newOutfit.shoes = [[ImageRecord alloc] init];
    newOutfit.top = T;
    newOutfit.bottom = B;
    newOutfit.shoes = S;
    return newOutfit;
}

*/


/*  //FOR MOVING ITEMS IN OUTFIT VIEW
UIOutfitImageView *touchedOutfitImageView;
UIOutfitImageView *recoveryImageView;
CGPoint touchPoint;
CGPoint previousTouchPoint;

float outfitViewRightEdge;
float imageRightEdge;
float outfitViewLeftEdge;
float imageLeftEdge;
float outfitViewTopEdge;
float imageTopEdge;
float outfitViewBottomEdge;
float imageBottomEdge;




-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self];
    previousTouchPoint = [touch previousLocationInView:self];
    
    touchedOutfitImageView = [self hitTest:touchPoint withEvent:nil];
    
    
    
    
    
    
    if ([touchedOutfitImageView isKindOfClass:[UIOutfitImageView class]])
    {      
        recoveryImageView = touchedOutfitImageView;
        
        imageLeftEdge = touchedOutfitImageView.frame.origin.x;
        outfitViewLeftEdge = 0;
        
        imageRightEdge = touchedOutfitImageView.frame.origin.x + touchedOutfitImageView.frame.size.width;
        outfitViewRightEdge = self.frame.size.width;
        
        imageTopEdge = touchedOutfitImageView.frame.origin.y;
        outfitViewTopEdge = 0;
        
        imageBottomEdge = touchedOutfitImageView.frame.origin.y + touchedOutfitImageView.frame.size.height;
        outfitViewBottomEdge = self.frame.size.height;

        
        NSLog(@"imagerightedge %f, outfitrightedge %f", imageRightEdge, outfitViewRightEdge);
        NSLog(@"imageleftedge %f, outfitleftedge %f", imageLeftEdge, outfitViewLeftEdge);
        NSLog(@"touchpoint now:%f, previous:%f", touchPoint.x, previousTouchPoint.x);
    


            
       
        touchedOutfitImageView.center = touchPoint;
     
        
        
    }
   
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"ended");
    NSLog(@"imagerightedge %f, outfitrightedge %f", imageRightEdge, outfitViewRightEdge);
    NSLog(@"imageleftedge %f, outfitleftedge %f", imageLeftEdge, outfitViewLeftEdge);


        if (imageRightEdge >= outfitViewRightEdge)
        {
            CGPoint fixCenter = CGPointMake(outfitViewRightEdge-(2+recoveryImageView.frame.size.width/2), recoveryImageView.center.y);
            recoveryImageView.center = fixCenter;
            
            
        }
        
        if(imageLeftEdge <= outfitViewLeftEdge)
        {
            CGPoint fixCenter = CGPointMake(2+recoveryImageView.frame.size.width/2, recoveryImageView.center.y);
            recoveryImageView.center = fixCenter;
            
        }
        
        if (imageTopEdge <= outfitViewTopEdge)
        {
            CGPoint fixCenter = CGPointMake(recoveryImageView.center.x, 2+recoveryImageView.frame.size.height/2);
            recoveryImageView.center = fixCenter;
        }
        
        if(imageBottomEdge >= outfitViewBottomEdge)
        {
            CGPoint fixCenter = CGPointMake(recoveryImageView.center.x,outfitViewBottomEdge-(2+recoveryImageView.frame.size.height/2));
            recoveryImageView.center = fixCenter;
        }
    
}

-(void)touchesCancelled: (NSSet *)touches withEvent:(UIEvent *)event
    
{
    
    NSLog(@"cancelled");
}
 
 
 */


@end
