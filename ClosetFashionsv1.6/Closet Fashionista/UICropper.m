//
//  UICropper.m
//  ClosetFash
//
//  Created by Anthony Tran on 11/17/12.
//
//

#import "UICropper.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MixerController.h"
#import "OrganizerController.h"

@implementation UICropper

CGPoint touchPoint;
CGPoint originTouchPoint;
CGPoint touchCorner;
CGPoint previousTouchPoint;



UIImageView *touchedImageView;

UIImageView *finalImageView;
UIImage *finalImage;

CGImageRef testref;

float originalWidth;
float originalHeight;
CGPoint originalOrigin;

BOOL scaleOn;
BOOL moveOn;
BOOL movingLeft;
BOOL movingRight;
BOOL movingUp;
BOOL movingDown;

OrganizerController *organizerController;
UITouch *touch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        
    
        
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    movingLeft = NO;
    movingRight = NO;
    movingUp = NO;
    movingDown = NO;
     
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MixerController* mixerController = appDelegate.mixerController;
    organizerController = mixerController.organizerController;
    
    
    scaleOn= NO;
    moveOn = NO;
    
  
    
    
    touch = [[event allTouches] anyObject];
    
    touchPoint = [touch locationInView:self.superview];
    
    originTouchPoint = touchPoint;
    
    touchCorner = [touch locationInView:self];
    
    
    touchedImageView = [self.superview hitTest:touchPoint withEvent:nil];
    
    originalHeight = touchedImageView.frame.size.height;
    originalWidth = touchedImageView.frame.size.width;
    originalOrigin = touchedImageView.frame.origin;
    
    
    if(touchedImageView.frame.size.height - touchCorner.y < 50 && touchedImageView.frame.size.width-touchCorner.x < 50)
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
}


- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
{
    //UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self.superview];
    
    
    
    if (previousTouchPoint.x > touchPoint.x)
    {
        NSLog(@"moving left");
        movingLeft = YES;
        movingRight = NO;
    }
    else{
        
        NSLog(@"moving right");
        movingLeft = NO;
        movingRight = YES;
    }
    
    if (previousTouchPoint.y > touchPoint.y)
    {
        NSLog(@"moving up");
        movingUp = YES;
        movingDown = NO;
    }
    else{
        
        NSLog(@"moving down");
        movingUp = NO;
        movingDown = YES;
    }
    
    
    
       if([touchedImageView isKindOfClass:[UICropper class]])
    {
        
        NSLog(@"superview tag is %i", touchedImageView.superview.tag);
        
            
            [touchedImageView setUserInteractionEnabled:YES];
            
            if (scaleOn == NO)
            {
                
                if((touchedImageView.frame.origin.x + touchedImageView.frame.size.width > 318 && movingRight)||
                   (touchedImageView.frame.origin.x < 2 && movingLeft))
                {
                    
                        
                    //touchedImageView.frame = CGRectMake(xOrigMax, touchedImageView.frame.origin.y, touchedImageView.frame.size.width, touchedImageView.frame.size.height);
                    
                    
                }
                else if((touchedImageView.frame.origin.y + touchedImageView.frame.size.height > 418 && movingDown)||
                        (touchedImageView.frame.origin.y < 2 && movingUp))
                {
                    
                }
                else{
                    touchedImageView.center = touchPoint;
                    NSLog(@"%f, %f, %f, %f",touchedImageView.frame.origin.x, touchedImageView.frame.origin.y, touchedImageView.frame.size.width, touchedImageView.frame.size.height);
                }
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
        
        }
    
    previousTouchPoint = CGPointMake(touchPoint.x, touchPoint.y);

    
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    int xOrigMax = 320 - touchedImageView.frame.size.width;
    int yOrigMax = 420 - touchedImageView.frame.size.height;
    
    
    if(touchedImageView.frame.origin.x + touchedImageView.frame.size.width > 320)
    {
        touchedImageView.frame = CGRectMake(xOrigMax, touchedImageView.frame.origin.y, touchedImageView.frame.size.width, touchedImageView.frame.size.height);
        
        
    }
    
   // UIImageView *tempCroppedImage = [organizerController retrieveView:1011 fromView:organizerController.view];
    //UIImageView *tempUncroppedImage = [organizerController retrieveView:1010 fromView:organizerController.view];
    
    CGRect newFrame = CGRectMake(touchedImageView.frame.origin.x, touchedImageView.frame.origin.y, touchedImageView.frame.size.width, touchedImageView.frame.size.height);
    
    int maxX = 320 - originalOrigin.x;
    
    int maxY = 420 - originalOrigin.y;
    
    if (touchedImageView.frame.origin.x < 0 || touchedImageView.frame.origin.x + touchedImageView.frame.size.width > 320)
    {
       
        
        
       /* if (scaleOn == YES){
            
            if(touchedImageView.frame.origin.y + newFrame.size.height > 420)
            {
                
                touchedImageView.frame = CGRectMake(originalOrigin.x, originalOrigin.y, maxX, maxY);
                
            }
            else
            {
            
                NSLog(@"scale is on, x greater than 320");
                touchedImageView.frame = CGRectMake(originalOrigin.x, originalOrigin.y, maxX, newFrame.size.height);
            }
            
        }
        else{ */
       
                touchedImageView.frame = CGRectMake(originalOrigin.x, originalOrigin.y, originalWidth, originalHeight);
        
    }
    else if (touchedImageView.frame.origin.y < 0 || touchedImageView.frame.origin.y + touchedImageView.frame.size.height > 420)
    {
       
        /*
        if (scaleOn == YES){
            
            if(touchedImageView.frame.origin.x + newFrame.size.width > 320)
            {
                
                touchedImageView.frame = CGRectMake(originalOrigin.x, originalOrigin.y, maxX, maxY);
                
            }
            else

            
            touchedImageView.frame = CGRectMake(originalOrigin.x, originalOrigin.y, newFrame.size.width, maxY);
            
        }
        else {*/
        
            touchedImageView.frame = CGRectMake(originalOrigin.x, originalOrigin.y, originalWidth, originalHeight);
        
    }
 

    float widthRatio = organizerController.cropperView.image.size.width/320;
    float heightRatio = organizerController.cropperView.image.size.height/420;
    
    
    //  CGSize size = [organizerController.cropperView bounds].size;
    
    //UIGraphicsBeginImageContextWithOptions(size, organizerController.cropperView.opaque, 2);
    
    
    
    //[organizerController.cropperView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //UIImage *tempCropped = UIGraphicsGetImageFromCurrentImageContext();
    
    //UIGraphicsEndImageContext();
    
    CGImageRef testref = CGImageCreateWithImageInRect([organizerController.tempCropped CGImage], CGRectMake(touchedImageView.frame.origin.x*3, touchedImageView.frame.origin.y*3, touchedImageView.frame.size.width*3, touchedImageView.frame.size.height*3));
    
    organizerController.croppedImage.image = [UIImage imageWithCGImage:testref];
    
    
    CGImageRelease(testref);
    
    
    organizerController.croppedImage.frame = touchedImageView.frame;
    
    

    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
