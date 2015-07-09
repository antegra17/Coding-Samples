//
//  UIScrollImageView.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIScrollImageView.h"
#import "UIOutfitView.h"
#import "UIOutfitImageView.h"
#import "AppDelegate.h"
#import "MixerController.h"
#import "UIViewInScroll.h"
#import <QuartzCore/QuartzCore.h>




@implementation UIScrollImageView


@synthesize fileNumRef, categoryType, catname, rackname;

UIView *mainView;
UIScrollView *tempScroll;
UIScrollImageView *touchedImageView;
UIScrollImageView *imageViewStay;
UIView *viewToInsertImage;
UIView *viewRealInsert;
CGPoint touchPoint;

NSMutableArray *topsArray;


AppDelegate *appDelegate;
MixerController* mixerController;



    

- (void)handleTap
{
    //UIScrollDisplay *temp = (UIScrollDisplay *) sender.view;
    //NSLog(@"remove me %i", temp.tag);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appDelegate.mixerController;
    
    if(mixerController.backDropOn == YES)
    {
        
        NSLog(@"hello backdrop");
      
        
        mixerController.backDropView.image = self.image;
        
        
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self.superview];
    
    touchedImageView = [self.superview hitTest:touchPoint withEvent:nil];

    
    NSLog(@"you touch me %i", touchedImageView.tag);
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

/*


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
            
            
            
            
        
            
            touchPoint.y = touchPoint.y - 20;
            touchPoint.x = touchPoint.x - 30;
            touchedImageView.center = touchPoint;
            
            
            
            
            
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
            
            
            
            
            
            
            
            touchPoint.y = touchPoint.y + 20;
            touchPoint.y = touchPoint.y + 30;
            
           
            
           
            
            
            
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


*/




CGPoint touchPointOutfit;

- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event 
{
    
    
    
    viewToInsertImage = mixerController.outfitDisplay;
    viewRealInsert = mixerController.outfitView;
    

    
    
    
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:mixerController.view];
    touchPointOutfit = [touch locationInView:mixerController.outfitView];
   
    if (touchedImageView.superview.tag == 30004 || touchedImageView.superview.tag == 10000)
    {
        
        
        
        if (touchedImageView.frame.origin.y > viewToInsertImage.frame.origin.y &&
            touchedImageView.frame.origin.y + touchedImageView.frame.size.height < viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height &&
            touchedImageView.frame.origin.x > viewToInsertImage.frame.origin.x &&
            touchedImageView.frame.origin.x + touchedImageView.frame.size.width < viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width)
        {
            viewToInsertImage.layer.borderColor = [[UIColor yellowColor] CGColor];
           
        }
        else{
            viewToInsertImage.layer.borderColor = [[UIColor blackColor] CGColor];
           
        }
        
        
    

    if([touchedImageView isKindOfClass:[UIScrollImageView class]])
    {
        if (touchedImageView.superview.tag == 30004)
        {
            touchedImageView.layer.borderColor = [[UIColor magentaColor] CGColor];
            touchedImageView.layer.borderWidth = 2;
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
            
            imageViewStay.layer.borderColor = [[UIColor grayColor] CGColor];
            imageViewStay.layer.borderWidth = 1;
    
            [imageViewStay setUserInteractionEnabled:YES];
            [self.superview insertSubview:imageViewStay atIndex:imageViewStay.tag-1];
            NSLog(@"imageviewstay added back to scrollbar at %i", imageViewStay.tag);

            
            [mainView addSubview:touchedImageView];
            
            touchedImageView.frame = CGRectMake(touchedImageView.frame.origin.x, touchedImageView.frame.origin.y, 100,100);
            
          
            
             touchedImageView.center = touchPoint;
            
              
        
        
            if (touchedImageView.frame.origin.y < -30)
            {
                NSLog(@"overbounds!");
                touchedImageView.image = nil;
                [touchedImageView removeFromSuperview];
            } 
        }
        else
        {
          
            touchedImageView.center = touchPoint;
           
    
            
            NSLog(@"image touchmove drag origin, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
            
            NSLog(@"image touchmove drag limits, cgpoint %f, %f", touchedImageView.frame.origin.x + touchedImageView.frame.size.width,touchedImageView.frame.origin.y + touchedImageView.frame.size.height);
            
            
            NSLog(@"outfitview origin, cgpoint %f, %f", viewToInsertImage.frame.origin.x,viewToInsertImage.frame.origin.y);
            
            NSLog(@"outfitview limits, cgpoint %f, %f", viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width,viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height);
            
            if (touchedImageView.frame.origin.y < -30)
            {
                NSLog(@"overbounds!");
                //touchedImageView.image = nil;
                //[touchedImageView removeFromSuperview];
            }
        }
      }
    }
     
}

        
   




-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (touchedImageView.layer.borderColor != [[UIColor grayColor] CGColor])
    {
        touchedImageView.layer.opacity = 1;
        touchedImageView.layer.borderWidth = 0;
    }
    
   /* if (touchedImageView.frame.origin.y < viewToInsertImage.frame.origin.y ||
            touchedImageView.frame.origin.y + touchedImageView.frame.size.height > viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height ||
            touchedImageView.frame.origin.x < viewToInsertImage.frame.origin.x ||
            touchedImageView.frame.origin.x + touchedImageView.frame.size.width > viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width)
    {
     
      
    }*/
    
    if (touchedImageView.superview.tag == 30004 || touchedImageView.superview.tag == 10000)
    {
    
    NSLog(@"image touchend, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
    
    
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
            UIScrollDisplay *imageInsertToOutfit = [[UIScrollDisplay alloc] init];
            CGRect newRectForImageInsert = CGRectMake(touchPointOutfit.x-50,touchPointOutfit.y-56, 100, 100);
            imageInsertToOutfit.frame = newRectForImageInsert;
            imageInsertToOutfit.contentMode = UIViewContentModeScaleAspectFit;
            imageInsertToOutfit.image = touchedImageView.image;
            imageInsertToOutfit.tag = touchedImageView.fileNumRef;
            [imageInsertToOutfit setUserInteractionEnabled:YES];
            
            
           // UITapGestureRecognizer *doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
            
            
           // [doubletap setNumberOfTapsRequired:2];
            //[doubletap setNumberOfTouchesRequired:1];
            
            //[imageInsertToOutfit addGestureRecognizer:doubletap];
            
      
            [viewRealInsert addSubview:imageInsertToOutfit];
        
            mysupertag = imageInsertToOutfit.superview.tag;
            NSLog(@"my parent after insert is %i", mysupertag);
            
            touchedImageView.image = nil;
            [touchedImageView removeFromSuperview];
            
          
            viewToInsertImage.layer.borderColor = [[UIColor blackColor] CGColor];
            
        }
     
    }
    else{
        if (touchedImageView.superview.tag != 30004)
        {
            
            NSLog(@"%i superview tag", touchedImageView.superview.tag);
            NSLog(@"cannot place here!");
            touchedImageView.image = nil;
            [touchedImageView removeFromSuperview];
        }
    }
        
          tempScroll.scrollEnabled = YES;
    }

  
}





-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
      viewToInsertImage.layer.borderColor = [[UIColor blackColor] CGColor];
    
    touchedImageView.layer.opacity = 1;
    /*
    //touchedImageView.layer.borderWidth = 0;
    if (touchedImageView.superview.tag == 30004 || touchedImageView.superview.tag == 10000)
    {
    
    if (touchedImageView.frame.origin.y < viewToInsertImage.frame.origin.y || 
        touchedImageView.frame.origin.y + touchedImageView.frame.size.height > viewToInsertImage.frame.origin.y + viewToInsertImage.frame.size.height ||
        touchedImageView.frame.origin.x < viewToInsertImage.frame.origin.x ||
        touchedImageView.frame.origin.x + touchedImageView.frame.size.width > viewToInsertImage.frame.origin.x + viewToInsertImage.frame.size.width)
        
    {
            NSLog(@"cannot place here!");
            // touchedImageView.image = nil;
            //[touchedImageView removeFromSuperview];

    }
    
        tempScroll.scrollEnabled = YES;
    }
    */
    
}
 



@end
