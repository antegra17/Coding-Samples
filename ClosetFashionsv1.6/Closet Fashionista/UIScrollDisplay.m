//
//  scrollDisplay.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIScrollDisplay.h"
#import "UIOutfitView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MixerController.h"

@implementation UIScrollDisplay

@synthesize fileNumRef, categoryType, catname, rackname;


UIScrollDisplay *touchedImageView;
UIScrollDisplay *imageViewStay;
//UIOutfitView *viewToInsertImage;
CGPoint originTouchPoint;
CGPoint touchPoint;
CGPoint touchCorner;





float originalWidth;
float originalHeight;

BOOL scaleOn;
BOOL moveOn;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    scaleOn= NO;
    moveOn = NO;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MixerController* mixerController = appDelegate.mixerController;
    

    
    UITouch *touch = [[event allTouches] anyObject];

    touchPoint = [touch locationInView:self.superview];
    
    originTouchPoint = touchPoint;
    
    touchCorner = [touch locationInView:self];
    
    
       touchedImageView = [self.superview hitTest:touchPoint withEvent:nil];
    
    

    
    
    for(int d=0; d< [mixerController.outfitView.subviews count]; d++)
    {
        UIImageView *tempview = [mixerController.outfitView.subviews objectAtIndex:d];
        
        if(tempview.tag != touchedImageView.tag)
        {
            tempview.layer.borderWidth = 0;
            tempview.layer.opacity = 1;
        }
        if(tempview.tag == touchedImageView.tag)
        {
            
            touchedImageView.layer.opacity = 0.75;
            touchedImageView.layer.borderColor = [[UIColor yellowColor] CGColor];
            touchedImageView.layer.borderWidth = 2;
        }
    }
    
    
    originalHeight = touchedImageView.frame.size.height;
    originalWidth = touchedImageView.frame.size.width;
    
    
    if(touchedImageView.frame.size.height - touchCorner.y < 35 && touchedImageView.frame.size.width-touchCorner.x < 35)
    {
        
        NSLog(@"touching corner! x %f y %f", touchCorner.x, touchCorner.y);
        
        scaleOn = YES;
        
        if (touchedImageView.frame.size.width <= 60)
        {
               float originHWRatio = touchedImageView.frame.size.height/touchedImageView.frame.size.width;
             touchedImageView.frame = CGRectMake(touchedImageView.frame.origin.x, touchedImageView.frame.origin.y,61, 61 * originHWRatio);
        }
   
    }
    else{
        touchedImageView.center = touchPoint;
        scaleOn = NO;
    }
    
    
    
    
        
    
    UIView *outfitView = touchedImageView.superview;
    
    int index = [self tagNumMatch:touchedImageView inView:outfitView];
    
    [outfitView bringSubviewToFront:[outfitView.subviews objectAtIndex:index]];
   
    
    
    NSLog(@"you touch me %i", touchedImageView.tag);
}


-(int) tagNumMatch: (UIScrollDisplay *) display inView: (UIOutfitView *)outfitview
{
    
    int index;
    
    for (int x = 0; x < [outfitview.subviews count]; ++x)
    {
        
        UIImageView *accessAddedImages = [outfitview.subviews objectAtIndex:x];
        
        if (display.tag == accessAddedImages.tag)
        {
            NSLog(@"display %i, access %i", display.tag, accessAddedImages.tag);
            index = x;
            break;
        }
        
    }
    NSLog(@"returning %i", index);
    return index;
}


 
 
 - (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
 {
     
     
 UITouch *touch = [[event allTouches] anyObject];
 touchPoint = [touch locationInView:self.superview];
     
     
 
 
 if([touchedImageView isKindOfClass:[UIScrollDisplay class]])
 {
     
     NSLog(@"superview tag is %i", touchedImageView.superview.tag);
     
     
     if (touchedImageView.superview.tag == 50000)
     {
      
 
         [touchedImageView setUserInteractionEnabled:YES];
         
         if (scaleOn == NO)
         {

            touchedImageView.center = touchPoint;
             NSLog(@"%f, %f, %f, %f",touchedImageView.frame.origin.x, touchedImageView.frame.origin.y, touchedImageView.frame.size.width, touchedImageView.frame.size.height);
         }
         else if (scaleOn == YES)
         {
                          
             float Xdist = touchPoint.x - originTouchPoint.x;
             
             NSLog(@"moved %f", Xdist);
             
             if (touchedImageView.frame.size.width < 60)
             {
                 
           
             }
             else
             {
                 float ratio = (originalWidth + Xdist)/ originalWidth;
                 
                 touchedImageView.frame = CGRectMake(touchedImageView.frame.origin.x, touchedImageView.frame.origin.y,originalWidth + Xdist, originalHeight * ratio);
                 
                 NSLog(@"new height %f, new width %f", touchedImageView.frame.size.height, touchedImageView.frame.size.width);
             }
             
    
             
         }
 
 
 
         NSLog(@"image touchmove drag, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
 
         if (touchedImageView.frame.origin.y < -30)
         {
                NSLog(@"overbounds!");
                //touchedImageView.image = nil;
                //[touchedImageView removeFromSuperview];
         }
     }
 }
     
 }



-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchedImageView.layer.opacity = 1;
    touchedImageView.layer.borderWidth = 0;
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchedImageView.layer.opacity = 1;
    touchedImageView.layer.borderWidth = 0;
    
}
@end

/*
 
 -(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 {
 
 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 MixerController* mixerController = appDelegate.mixerController;
 
 CGPoint leftProbe;
 CGPoint rightProbe;
 leftProbe.x = touchedImageView.center.x - 25;
 leftProbe.y = touchedImageView.center.y;
 rightProbe.x = touchedImageView.center.x +25;
 rightProbe.y = touchedImageView.center.y;
 
 UIImageView *leftImageView = [self.superview hitTest:leftProbe withEvent:nil];
 
 UIImageView *rightImageView = [self.superview hitTest:rightProbe withEvent:nil];
 
 if([leftImageView isKindOfClass:[UIScrollImageView class]])
 {
 NSLog(@"left left has imageview %i", leftImageView.tag);
 
 }
 
 
 if([rightImageView isKindOfClass:[UIScrollImageView class]])
 {
 NSLog(@"right right has imageview %i", rightImageView.tag);
 
 }
 
 NSLog(@"insert %i between the above two, archive, and reload archive into scrollview", touchedImageView.tag);
 
 
 
 UIImage *tempImage;
 NSString *pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
 ImageRecord *testretrieve;
 
 
 
 UIScrollView *scrollTops = [appDelegate.mixerController.view.subviews objectAtIndex:9];
 UIViewInScroll *viewInScrollTops = [scrollTops.subviews objectAtIndex:0];
 
 
 NSString *pathtops = [pathhome stringByAppendingPathComponent:@"topsarchive.arch"];
 topsArray = [[NSMutableArray alloc] init];
 topsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:pathtops];
 
 
 
 
 
 
 [topsArray insertObject:touchedImageView atIndex:rightImageView.tag];
 [NSKeyedArchiver archiveRootObject:topsArray toFile:pathtops];
 
 topsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:pathtops];
 
 if(!topsArray)
 {
 topsArray = [[NSMutableArray alloc] init];
 }
 
 for(int x=0; x < [topsArray count]; ++x)
 {
 
 testretrieve = [topsArray objectAtIndex:x];
 
 
 tempImage = [[UIImage alloc] initWithContentsOfFile:testretrieve.imageFilePath];
 NSLog(@"init image with %@", testretrieve.imageFilePath);
 
 UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:tempImage];
 
 
 CGFloat yOrigin = ([viewInScrollTops.subviews count]+2) * self.superview.superview.superview.frame.size.width/7;
 
 
 archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
 archiveImageView.frame = CGRectMake(yOrigin, 0, self.superview.superview.superview.frame.size.width/7, self.superview.superview.superview.frame.size.height/12);
 archiveImageView.fileNumRef = testretrieve.fileNumRef;
 archiveImageView.tag = x+1;
 archiveImageView.categoryType = testretrieve.categoryType;
 
 [archiveImageView setUserInteractionEnabled:YES];
 
 
 
 [viewInScrollTops addSubview:archiveImageView];
 
 NSLog(@"AFTER ADD, new viewInScrollTops count: %i",[viewInScrollTops.subviews count]);
 
 
 viewInScrollTops.frame = CGRectMake( 0, 0, ([viewInScrollTops.subviews count]+4) * self.superview.superview.superview.frame.size.width/7, self.superview.superview.superview.frame.size.height/12);
 
 
 scrollTops.contentSize = CGSizeMake(([viewInScrollTops.subviews count]+4) * self.superview.superview.superview.frame.size.width/7, self.superview.superview.superview.frame.size.height/12);
 
 }
 
 
 }
 

 
 - (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
 {
 UITouch *touch = [[event allTouches] anyObject];
 touchPoint = [touch locationInView:self.superview.superview.superview];
 
 
 if([touchedImageView isKindOfClass:[UIScrollImageView class]])
 {
 if (touchedImageView.superview.tag == 30000)
 {
 mainView = self.superview.superview.superview;
 [mainView setUserInteractionEnabled:YES];
 tempScroll = self.superview.superview;
 tempScroll.scrollEnabled = NO;
 
 [touchedImageView setUserInteractionEnabled:YES];
 
 imageViewStay = [[UIScrollImageView alloc] init];
 imageViewStay.frame = touchedImageView.frame;
 imageViewStay.contentMode = UIViewContentModeScaleAspectFit;
 imageViewStay.image = touchedImageView.image;
 imageViewStay.tag = touchedImageView.tag;
 imageViewStay.fileNumRef = touchedImageView.fileNumRef;
 
 [imageViewStay setUserInteractionEnabled:YES];
 [self.superview insertSubview:imageViewStay atIndex:imageViewStay.tag-1];
 NSLog(@"imageviewstay added back to scrollbar at %i", imageViewStay.tag);
 
 
 [mainView addSubview:touchedImageView];
 
 touchPoint.y = touchPoint.y - 25;
 touchedImageView.center = touchPoint;
 touchPoint.y = touchPoint.y + 25;
 NSLog(@"image touchmove drag, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
 
 if (touchedImageView.frame.origin.y < -30)
 {
 NSLog(@"overbounds!");
 touchedImageView.image = nil;
 [touchedImageView removeFromSuperview];
 }
 }
 else
 {
 touchPoint.y = touchPoint.y - 25;
 touchedImageView.center = touchPoint;
 touchPoint.y = touchPoint.y + 25;
 NSLog(@"image touchmove drag, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
 
 if (touchedImageView.frame.origin.y < -30)
 {
 NSLog(@"overbounds!");
 touchedImageView.image = nil;
 [touchedImageView removeFromSuperview];
 }
 
 
 }
 
 
 
 }
 }
 
 
 -(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 {
 
 if (touchedImageView.frame.origin.y < viewToInsertImage.frame.origin.y ||
 touchedImageView.frame.origin.y + touchedImageView.frame.size.height > viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height ||
 touchedImageView.frame.origin.x < viewToInsertImage.frame.origin.x ||
 touchedImageView.frame.origin.x + touchedImageView.frame.size.width > viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width)
 {
 if (touchedImageView.superview.tag != 30000)
 {
 NSLog(@"cannot place here!");
 touchedImageView.image = nil;
 [touchedImageView removeFromSuperview];
 }
 
 }
 
 
 
 if (touchedImageView.frame.origin.y > viewToInsertImage.frame.origin.y &&
 touchedImageView.frame.origin.y + touchedImageView.frame.size.height < viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height &&
 touchedImageView.frame.origin.x > viewToInsertImage.frame.origin.x &&
 touchedImageView.frame.origin.x + touchedImageView.frame.size.width < viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width)
 {
 
 int mysupertag = touchedImageView.superview.tag;
 NSLog(@"my parent is %i", mysupertag);
 
 
 
 if([self fileNumMatch:touchedImageView inView:viewToInsertImage])
 {
 NSLog(@"already there!");
 touchedImageView.image = nil;
 [touchedImageView removeFromSuperview];
 }
 else
 {
 UIOutfitImageView *imageInsertToOutfit = [[UIOutfitImageView alloc] init];
 CGRect newRectForImageInsert = CGRectMake(0, 0, 100, 100);
 imageInsertToOutfit.frame = newRectForImageInsert;
 imageInsertToOutfit.contentMode = UIViewContentModeScaleAspectFit;
 imageInsertToOutfit.image = touchedImageView.image;
 imageInsertToOutfit.tag = touchedImageView.fileNumRef;
 [imageInsertToOutfit setUserInteractionEnabled:YES];
 
 
 [viewToInsertImage addSubview:imageInsertToOutfit];
 
 mysupertag = imageInsertToOutfit.superview.tag;
 NSLog(@"my parent after insert is %i", mysupertag);
 
 touchedImageView.image = nil;
 [touchedImageView removeFromSuperview];
 }
 
 }
 tempScroll.scrollEnabled = YES;
 }
 
 
 
 -(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
 {
 
 if (touchedImageView.frame.origin.y < viewToInsertImage.frame.origin.y ||
 touchedImageView.frame.origin.y + touchedImageView.frame.size.height > viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height ||
 touchedImageView.frame.origin.x < viewToInsertImage.frame.origin.x ||
 touchedImageView.frame.origin.x + touchedImageView.frame.size.width > viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width)
 
 {
 NSLog(@"cannot place here!");
 touchedImageView.image = nil;
 [touchedImageView removeFromSuperview];
 
 }
 
 
 tempScroll.scrollEnabled = YES;
 }

 -(BOOL) fileNumMatch: (UIScrollImageView *) image inView: (UIOutfitView *)outfitview
 {
 
 int intfileNumMatchCount = 0;
 
 for (int x = 0; x < [outfitview.subviews count]; ++x)
 {
 
 UIImageView *accessAddedImages = [outfitview.subviews objectAtIndex:x];
 
 if (image.fileNumRef == accessAddedImages.tag)
 {
 ++intfileNumMatchCount;
 }
 
 if (intfileNumMatchCount == 1)
 {
 return YES;
 }
 
 
 }
 
 return NO;
 }

*/


