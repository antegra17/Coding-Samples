//
//  UIOrganizerImageView.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIOrganizerImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MixerController.h"
#import "OrganizerController.h"


@implementation UIOrganizerImageView


@synthesize fileNumRef, categoryType, rackName;

UIView *mainView;
UIScrollView *tempScroll;
UIOrganizerImageView *touchedImageView;
UIOrganizerImageView *imageViewStay;

CGPoint touchPoint;
NSMutableArray *topsArray;

AppDelegate *appDelegate;
OrganizerController *organizercontroller;
MixerController *mixerController;

UIView *popUpItemWindow;
UIOrganizerImageView *popUpItemDisplay;
UIImageView * popUpItemDisplayCloseButton;

int tempcurrentcat;
NSString *tempcurrentrack;



-(void)closeOutfitDisplay
{
    
    NSLog(@"closing outfitdisplay byebye!");

    [popUpItemWindow removeFromSuperview];
    
    for(int x = 0; x<[organizercontroller.view.subviews count]; x++)
    {
        UIView *tempview = [organizercontroller.view.subviews objectAtIndex:x];
        if (tempview.tag != 555)
        {
            tempview.userInteractionEnabled = YES;
        }
    }
    
  
    [organizercontroller loadImagesInTileScroll];
    


    
}

-(ImageRecord *) retrieveRecord: (int)filenumref
{
    Closet *tempcloset = appDelegate.myCloset;
    
    for (int x = 0; x < [tempcloset.categories count]; ++x)
    {
        Category * tempcategory = [tempcloset.categories objectAtIndex:x];
        
        for (int y =0; y < [tempcategory.racksarray count]; y++)
        {
            Rack *temprack = [tempcategory.racksarray objectAtIndex:y];
            for (int z = 0; z < [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                if(temprecord.fileNumRef == touchedImageView.fileNumRef)
                {
                    
                    
                    
                    NSLog(@"found %i in %@ in %@", temprecord.fileNumRef, temprack.rackname, tempcategory.categoryname);
                    NSLog(@"%@, %@, %@, %@", temprecord.color, temprecord.occasion, temprecord.brand, temprecord.additionaltags);
                    return temprecord;
                }
            }
        }
    }
                    
    return nil;
}


BOOL didmove;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    didmove = FALSE;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //organizercontroller = appDelegate.mixerController.organizerController;
    mixerController = appDelegate.mixerController;

    
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self.superview.superview.superview];
    
    touchedImageView = [self.superview.superview.superview hitTest:touchPoint withEvent:nil];

    imageViewStay = [[UIOrganizerImageView alloc] init];
    imageViewStay.frame = touchedImageView.frame;
    imageViewStay.fileNumRef = touchedImageView.fileNumRef;
    NSLog(@"you touch me filenumref %i", touchedImageView.fileNumRef);
    NSLog(@"superview tag is %i", touchedImageView.superview.tag);
    NSLog(@"imageview stay %f, %f", imageViewStay.center.x, imageViewStay.center.y);
    

                        
       
    
}


- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event 
{
    
    /*
    didmove = TRUE;
    
    
    
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self.superview.superview.superview];
    
    
    if([touchedImageView isKindOfClass:[UIOrganizerImageView class]])
    {
         NSLog(@"touchedview superview tag %i", touchedImageView.superview.tag);
        NSLog(@"touchedview supersuperview tag %i", touchedImageView.superview.superview.tag);
       if (touchedImageView.superview.tag == 64321)
        {
            
            mainView = self.superview.superview.superview;
            [mainView setUserInteractionEnabled:YES];
            tempScroll = (UIScrollView *) self.superview.superview;
            tempScroll.scrollEnabled = NO;
            
            [touchedImageView setUserInteractionEnabled:YES];
            
           
       
            touchedImageView.center = touchPoint;
            
            touchedImageView.layer.opacity = 0.5;
            
            
             [self.superview.superview.superview addSubview:touchedImageView];
            
            NSLog(@"image touchmove drag, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
 
  
            }
        }
    
    
        if(touchedImageView.superview.tag == 1000000000)
        {
            touchPoint = [touch locationInView:self.superview];
            touchedImageView.center = touchPoint;
            
            CGPoint leftProbe;
            CGPoint rightProbe;
            leftProbe.x = touchPoint.x-( touchedImageView.frame.size.width/2 +4);
            leftProbe.y = touchPoint.y;
            rightProbe.x = touchPoint.x +(touchedImageView.frame.size.width/2 +4);
            rightProbe.y = touchPoint.y;
            
            UIOrganizerImageView *leftImageView = [self.superview hitTest:leftProbe withEvent:nil];
            
            UIOrganizerImageView *rightImageView = [self.superview hitTest:rightProbe withEvent:nil];
            
            if([leftImageView isKindOfClass:[UIOrganizerImageView class]])
            {
                NSLog(@"left left has imageview %i", leftImageView.fileNumRef);
                
            }

            NSLog(@"image touchmove drag, cgpoint %f, %f", touchedImageView.frame.origin.x,touchedImageView.frame.origin.y);
        
        }
    
    
    if (CGRectContainsPoint(organizercontroller.trash.frame, touchedImageView.center))
    {
        
        [organizercontroller.trash setHighlighted:YES];
    }
    else
    {
        [organizercontroller.trash setHighlighted:NO];
    }
    
    
        
        
        */
    
}


ImageRecord *tempimagerecordedit;
UILabel *popUpItemDisplayDetailsLabel;












    

-(void) suggestOutfit:(UIButton *)sender
{
    
    
    organizercontroller.geniusItemOneFound = NO;
    organizercontroller.geniusItemTwoFound = NO;
    
    organizercontroller.geniusHubLabel.text = @"";
    
    ImageRecord *tempsuggestrecord = [self retrieveRecord:touchedImageView.fileNumRef];
    
    organizercontroller.geniusItemBase = tempsuggestrecord;
    
    
    NSLog(@"%i, %@, %@, %@, goes well with:",tempsuggestrecord.fileNumRef, tempsuggestrecord.color, tempsuggestrecord.rackName, tempsuggestrecord.catName);
    
    if ([tempsuggestrecord.catName compare:@"Tops"] == NSOrderedSame)
    {
        
        organizercontroller.currentMatchCat = @"Bottoms";
        
        organizercontroller.startingMatchCat = @"Bottoms";
        
        [organizercontroller stepThroughClosetFind:@"Bottoms"];
    
        
        
    }

    
}



-(void) loadEditDetails: (UIButton *) sender
{
    
    
    int tempfilenumref = sender.tag;


    
    tempimagerecordedit = [organizercontroller retrieveRecordNum:tempfilenumref FromCat:organizercontroller.currenteditcat RackName:organizercontroller.currenteditrack];
    
    NSLog(@"%i, %@,%@ %i",organizercontroller.currenteditcat, organizercontroller.currenteditrack, tempimagerecordedit.color,tempfilenumref);
    

  
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:tempimagerecordedit.imageFilePathBest];
    
    organizercontroller.newitem = FALSE;
    [organizercontroller loadItemEditor:image fileNumRef:tempfilenumref label:popUpItemDisplayDetailsLabel];
    
 
}










-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *organizerNavController = [[tabBarController viewControllers] objectAtIndex:1];
    
    OrganizerController *organizerController = [[organizerNavController viewControllers] objectAtIndex:0];

    [organizerController editItem: touchedImageView.fileNumRef];
    /*
    
    
    organizercontroller.geniusHubLabel.text = @"";
    
    NSLog(@"before lastworn search");
    
    NSDate *lastworn = [appDelegate.myCloset findLastWorn:fileNumRef];
    
    NSString *lastwornfull;
    
    NSLog(@"after lastworn search");
    
    
    if(lastworn != NULL)
        
    {
        NSLog(@"last worn code");
        
        int daysToAdd = 1;
        NSDate *newDate1 = [lastworn dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
     
        
        [dateFormatter setDateFormat:@"EEE MM/dd/yy"];
        NSString *weekDay =  [dateFormatter stringFromDate:newDate1];
        
        
  
        
        NSString *lastwornprefix = @"Last Wear ";
        lastwornfull = [lastwornprefix stringByAppendingString:weekDay];
        
        
        
    }
    
    
    
    NSDate *nextworn = [appDelegate.myCloset findNextWorn:fileNumRef];
    
    NSString *nextwornfull;
    
    if(nextworn != NULL)
        
    {
        NSLog(@"next worn code");
        
        int daysToAdd = 1;
        NSDate *newDate1 = [nextworn dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        

        
        [dateFormatter setDateFormat:@"EEE MM/dd/yy"];
        NSString *weekDay =  [dateFormatter stringFromDate:newDate1];
        
        
        
        NSString *nextwornprefix = @"Next Wear ";
        nextwornfull = [nextwornprefix stringByAppendingString:weekDay];
        
     
        
        
    }
    
    
    BOOL wornToday = [appDelegate.myCloset isWornToday:fileNumRef];
    if(wornToday) NSLog(@"WORN TODAYYYYYY");
    
    
    
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self.superview];
    
    UIViewInScroll *tempviewinscroll = [organizercontroller.tileScroll.subviews objectAtIndex:0];
    
    NSLog(@"tempviewinscroll tag %i", tempviewinscroll.tag);
    
    NSLog(@"dropped at %f, %f", touchedImageView.center.x, touchedImageView.center.y);
    
    NSLog(@"trash origin %f, %f", organizercontroller.trash.frame.origin.x, organizercontroller.trash.frame.origin.y);
    
    
    
    
    
    
    
    if (CGRectContainsPoint(organizercontroller.trash.frame, touchedImageView.center))
    {
        
        NSLog(@"in trash!");
        [touchedImageView removeFromSuperview];
        
        int currentcategorynum = [organizercontroller getCurrentCategoryNumber];
        NSString *currentrackname = [organizercontroller getCurrentRackName];
        
        
        Rack *temprack = [organizercontroller findRack:currentrackname InCategory:currentcategorynum];
        
        
        NSLog(@"u deleted this image from %@", temprack.rackname);
        
        [organizercontroller deleteItemFileNum:imageViewStay.fileNumRef FromRack:temprack];
        
        [organizercontroller.trash setHighlighted:NO];
        
        if(currentcategorynum == 0 || currentcategorynum == 1) mixerController.topChanged = YES;
        if(currentcategorynum == 2) mixerController.rightChanged = YES;
        if(currentcategorynum == 3) mixerController.lowerChanged = YES;
        if(currentcategorynum == 4) mixerController.topOverlayChanged = YES;
        if(currentcategorynum == 5) mixerController.accessoriesChanged = YES;
        
        
        
        
        
        
    }
    
    
    else
    {
        touchedImageView.layer.opacity = 1;
        if(touchedImageView.superview.tag == 64321 && didmove == FALSE)
        {
            ImageRecord *temprecord = [self retrieveRecord:touchedImageView.fileNumRef];
            
            if(!temprecord)
            {
                NSLog(@"record not found");
            }
            else
            {
                if([touchedImageView isKindOfClass:[UIOrganizerImageView class]])
                {
                    tempcurrentcat = [organizercontroller getCurrentCategoryNumber];
                    tempcurrentrack = [organizercontroller getCurrentRackName];
                    
                    
                    
                    organizercontroller.currenteditcat = tempcurrentcat;
                    organizercontroller.currenteditrack = tempcurrentrack;
                    
                    NSLog(@"passed into if kind of organizerimageview class");
                    
                    
                    popUpItemWindow = [[UIView alloc] init];
                    popUpItemWindow.frame = CGRectMake(0, 20, 320, 460);
                    
                    
                    UIImage *woodbg = [UIImage imageNamed:@"wood.png"];
                    popUpItemWindow.backgroundColor = [UIColor colorWithPatternImage:woodbg];
                    popUpItemWindow.layer.cornerRadius = 5;
                    popUpItemWindow.tag = 555;
                    
                    
                    
                    
                    popUpItemDisplay = [[UIOrganizerImageView alloc] init];
                    popUpItemDisplay.frame = CGRectMake(0, 70, 320, 348);
                    popUpItemDisplay.backgroundColor = [UIColor clearColor];
                    
                    
                    //popUpItemDisplay.layer.borderWidth = 2;
                    //popUpItemDisplay.layer.borderColor = [[UIColor blackColor] CGColor];
                    
                    popUpItemDisplay.contentMode = UIViewContentModeScaleAspectFit;
                    
                    
                    
                    
                    UILabel *newOutfitFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 418, 320,40)];
                    
                    newOutfitFooter.text = @"";
                    newOutfitFooter.textColor = [UIColor blackColor];
                    newOutfitFooter.textAlignment = UITextAlignmentCenter;
                    newOutfitFooter.font = [UIFont fontWithName:@"Futura" size:30];
                    newOutfitFooter.backgroundColor = [UIColor clearColor];
                    [popUpItemWindow addSubview:newOutfitFooter];
                    
                    
                    
                    UIImage *bestImage = [UIImage imageWithContentsOfFile:temprecord.imageFilePathBest];
                    
                    popUpItemDisplay.image = bestImage;
                    
                    UIImage *edit = [UIImage imageNamed:@"editdetails.jpg"];
                    UIImage *editpressed = [UIImage imageNamed:@"editdetailspressed.jpg"];
                    
                    if (organizercontroller.geniusMode ==YES)
                    {
                        UIButton *suggestButton = [[UIButton alloc] initWithFrame:CGRectMake(226, 420, 90, 36)];
                        
                        [suggestButton setImage:edit forState:UIControlStateNormal];
                        [suggestButton setImage:editpressed forState:UIControlStateHighlighted];
                        [suggestButton addTarget:self action:@selector(suggestOutfit:) forControlEvents:UIControlEventTouchUpInside];
                        suggestButton.tag = touchedImageView.fileNumRef;
                        [popUpItemWindow addSubview:suggestButton];
                        
                        
                        
                    }
                    else{
                    
                    
                    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(226, 420, 90, 36)];
                    
                    [editButton setImage:edit forState:UIControlStateNormal];
                    [editButton setImage:editpressed forState:UIControlStateHighlighted];
                    [editButton addTarget:self action:@selector(loadEditDetails:) forControlEvents:UIControlEventTouchUpInside];
                    editButton.tag = touchedImageView.fileNumRef;
                    [popUpItemWindow addSubview:editButton];
                        
                    }
                    
                    
                    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 420, 90, 36)];
                    UIImage *back = [UIImage imageNamed:@"back.jpg"];
                    UIImage *backpressed = [UIImage imageNamed:@"backpressed.jpg"];
                    backButton.tag = 456;
                    [backButton setImage:back forState:UIControlStateNormal];
                    [backButton setImage:backpressed forState:UIControlStateHighlighted];
                    [backButton addTarget:self action:@selector(closeOutfitDisplay) forControlEvents:UIControlEventTouchUpInside];
                    
                    [popUpItemWindow addSubview:backButton];
                    
                    
                    popUpItemDisplayDetailsLabel = [[UILabel alloc] init];
                    popUpItemDisplayDetailsLabel.textAlignment = UITextAlignmentCenter;
                    popUpItemDisplayDetailsLabel.frame = CGRectMake(0, 0, 320, 50);
                    
                    NSString *brandstring;
                    NSString *occasionstring;
                    
                    
                    
                    if([temprecord.brand compare:@"N/A"]==NSOrderedSame) brandstring = @"";
                    else brandstring = [NSString stringWithFormat:@"by %@",temprecord.brand];
                    
                    if([temprecord.occasion compare:@"N/A"]==NSOrderedSame) occasionstring = @"";
                    else occasionstring = [NSString stringWithFormat:@"%@",temprecord.occasion];
                    
                    
                    NSString *details = [NSString stringWithFormat:@"%@ %@ %@ \n%@", temprecord.color, temprecord.rackName, brandstring, occasionstring];
                    
                    popUpItemDisplayDetailsLabel.font = [UIFont fontWithName:@"Futura" size:18];
                    popUpItemDisplayDetailsLabel.text = details;
                    popUpItemDisplayDetailsLabel.textColor = [UIColor blackColor];
                    
                    
                    popUpItemDisplayDetailsLabel.numberOfLines = 0;
                    popUpItemDisplayDetailsLabel.backgroundColor = [UIColor clearColor];
                    
     
     
                    
                    
                    [popUpItemWindow addSubview:popUpItemDisplay];
                    [popUpItemWindow addSubview:popUpItemDisplayCloseButton];
                    [popUpItemWindow addSubview:popUpItemDisplayDetailsLabel];
                    
                    
                    
                    
                    
                    if(wornToday)
                    {
                        
                        //popUpItemDisplayDetailsLabel.frame = CGRectMake(0, 0, 220, 50);
                        UILabel *newOutfitHeaderToday = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
                        newOutfitHeaderToday.text = @"Wearing Today!";
                        newOutfitHeaderToday.textColor = [UIColor blackColor];
                        newOutfitHeaderToday.textAlignment = UITextAlignmentCenter;
                        newOutfitHeaderToday.font = [UIFont fontWithName:@"Futura" size:12];
                        newOutfitHeaderToday.backgroundColor = [UIColor clearColor];
                        [popUpItemWindow addSubview:newOutfitHeaderToday];
                        
                        
                        
                    }
                    
                    UILabel *lastWornLabel = [[UILabel alloc] init];
                    lastWornLabel.textAlignment = UITextAlignmentCenter;
                    lastWornLabel.frame = CGRectMake(0, 50, 160, 20);
                    lastWornLabel.font = [UIFont fontWithName:@"Futura" size:12];
                    lastWornLabel.textColor = [UIColor blackColor];
                    lastWornLabel.backgroundColor = [UIColor clearColor];
                    lastWornLabel.text = lastwornfull;
                    
                    [popUpItemWindow addSubview:lastWornLabel];
                    
                    
                    UILabel *nextWornLabel = [[UILabel alloc] init];
                    nextWornLabel.textAlignment = UITextAlignmentCenter;
                    nextWornLabel.frame = CGRectMake(160, 50, 160, 20);
                    nextWornLabel.font = [UIFont fontWithName:@"Futura" size:12];
                    nextWornLabel.textColor = [UIColor blackColor];
                    nextWornLabel.backgroundColor = [UIColor clearColor];
                    nextWornLabel.text = nextwornfull;
                    
                    [popUpItemWindow addSubview:nextWornLabel];
                    
                    
                    
                    [organizercontroller.view addSubview:popUpItemWindow];
                    
                    
                    
                    NSLog(@"you touch me %i", touchedImageView.tag);
                    
                    
                    
                    for(int x = 0; x<[organizercontroller.view.subviews count]; x++)
                    {
                        UIView *tempview = [organizercontroller.view.subviews objectAtIndex:x];
                        if (tempview.tag != 555)
                        {
                            tempview.userInteractionEnabled = NO;
                        }
                    }
                }
            }
            
            
        }
        
        
        
        if(touchedImageView.superview.tag == 1000000000)
        {
            touchPoint = [touch locationInView:self.superview];
            
            touchedImageView.center = touchPoint;
            
            
            CGPoint leftProbe;
            CGPoint rightProbe;
            leftProbe.x = touchPoint.x-( touchedImageView.frame.size.width/2 +4);
            leftProbe.y = touchPoint.y;
            rightProbe.x = touchPoint.x +(touchedImageView.frame.size.width/2 +4);
            rightProbe.y = touchPoint.y;
            
            UIOrganizerImageView *leftImageView = [self.superview hitTest:leftProbe withEvent:nil];
            
            UIOrganizerImageView *rightImageView = [self.superview hitTest:rightProbe withEvent:nil];
            
            
            
            
            int currentcategorynum = [organizercontroller getCurrentCategoryNumber];
            NSString *currentrackname = [organizercontroller getCurrentRackName];
            Rack *temprack = [organizercontroller findRack:currentrackname InCategory:currentcategorynum];
            
            int oldposition = [organizercontroller findPositionOfRecordFileNum:touchedImageView.fileNumRef inRack:temprack];
            
            
            
            if([leftImageView isKindOfClass:[UIOrganizerImageView class]])
            {
                NSLog(@"left left has imageview %i", leftImageView.fileNumRef);
                //NSLog(@"right right has imageview %i", rightImageView.fileNumRef);
                
                ImageRecord *temprecordtomove = [organizercontroller findRecordFileNum:touchedImageView.fileNumRef inRack:temprack];
                NSLog(@"temprecord %i", temprecordtomove.fileNumRef);
                
                ImageRecord *newpositionrecord = [[ImageRecord alloc] init];
                
                newpositionrecord.fileNumRef = temprecordtomove.fileNumRef;
                newpositionrecord.imageFilePathThumb = temprecordtomove.imageFilePathThumb;
                
                newpositionrecord.imageFilePath = temprecordtomove.imageFilePath;
                newpositionrecord.imageFilePathBest = temprecordtomove.imageFilePathBest;
                
                
                newpositionrecord.color = temprecordtomove.color;
                newpositionrecord.rackName = temprecordtomove.rackName;
                newpositionrecord.catName = temprecordtomove.catName;
                
                NSLog(@"old cat name %@, new cat name %@", temprecordtomove.catName, newpositionrecord.catName);
                
                newpositionrecord.occasion = temprecordtomove.occasion;
                newpositionrecord.brand = temprecordtomove.brand;
                newpositionrecord.additionaltags= temprecordtomove.additionaltags;
                
                
                
                int leftposition = [organizercontroller findPositionOfRecordFileNum:leftImageView.fileNumRef inRack:temprack];
                NSLog(@"left position of filenum %i is %i", leftImageView.fileNumRef, leftposition);
                
                
                NSLog(@"old position of filenum %i is %i", touchedImageView.fileNumRef, oldposition);
                
                [temprack.rackitemsarray removeObjectAtIndex:oldposition];
                
                
                int shiftanimatecat = [organizercontroller getCurrentCategoryNumber];
                float shiftamount;
                
                if (shiftanimatecat == 3 || shiftanimatecat == 5)
                {
                    shiftamount = 55;
                }
                else{
                    shiftamount = 75;
                }
                
                NSLog(@"%f", shiftamount);
                if(leftposition == oldposition-1)
                {
                    
                    [temprack.rackitemsarray insertObject:newpositionrecord atIndex:oldposition];
                    NSLog(@"inserting back to old position!");
                    touchedImageView.frame = imageViewStay.frame;
                    [tempviewinscroll insertSubview:touchedImageView atIndex:oldposition];
                }
                else if (oldposition > leftposition)
                {
                    NSLog(@"in the else!, inserting at positon %i", leftposition+1);
                    [temprack.rackitemsarray insertObject:newpositionrecord atIndex:leftposition+1];
                    
                    
                    CGRect tempframe;
                    UIOrganizerImageView *tempview = [tempviewinscroll.subviews objectAtIndex:leftposition+1];
                    tempframe = tempview.frame;
                    touchedImageView.frame = tempframe;
                    [tempviewinscroll insertSubview:touchedImageView atIndex:leftposition+1]; //add back to viewintilescroll
                    
                    
                    [UIView beginAnimations:@"rearranging tiles" context:nil];
                    [UIView setAnimationDelegate:self];
                    [UIView setAnimationDuration:0.5];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    
                    
                    
                    
                    for(int x= leftposition+2; x<[tempviewinscroll.subviews count]; ++x)
                    {
                        
                        if (x <= oldposition)
                        {
                            
                            
                            
                            tempview = [tempviewinscroll.subviews objectAtIndex:x];
                            
                            if (x%3 == 1)
                            {
                                CGPoint new = CGPointMake(tempview.frame.origin.x + self.superview.superview.frame.size.width/3, tempview.frame.origin.y);
                                tempview.frame = CGRectMake(new.x, new.y, tempview.frame.size.width, tempview.frame.size.height);
                            }
                            if (x%3 == 2)
                            {
                                
                                CGPoint new = CGPointMake(tempview.frame.origin.x + self.superview.superview.frame.size.width/3, tempview.frame.origin.y);
                                tempview.frame = CGRectMake(new.x, new.y, tempview.frame.size.width, tempview.frame.size.height);
                            }
                            if (x%3 == 0)
                            {
                                
                                CGPoint new = CGPointMake(tempview.frame.origin.x - 2*(self.superview.superview.frame.size.width/3), tempview.frame.origin.y + shiftamount);
                                tempview.frame = CGRectMake(new.x, new.y, tempview.frame.size.width, tempview.frame.size.height);
                            }
                        }
                        
                    }
                    [UIView commitAnimations];
                    
                    
                }
                else if (oldposition < leftposition)
                {
                    NSLog(@"in the 2nd else!, inserting at positon %i", leftposition);
                    [temprack.rackitemsarray insertObject:newpositionrecord atIndex:leftposition];
                    
                    CGRect tempframe;
                    UIOrganizerImageView *tempview = [tempviewinscroll.subviews objectAtIndex:leftposition-1];
                    tempframe = tempview.frame;
                    touchedImageView.frame = tempframe;
                    [tempviewinscroll insertSubview:touchedImageView atIndex:leftposition]; //add back to viewintilescroll
                    
                    
                    [UIView beginAnimations:@"rearranging tiles" context:nil];
                    [UIView setAnimationDelegate:self];
                    [UIView setAnimationDuration:0.5];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    
                    
                    for(int x= leftposition-1; x >= 0; --x)
                    {
                        
                        if (x >= oldposition)
                        {
                            
                            
                            
                            tempview = [tempviewinscroll.subviews objectAtIndex:x];
                            
                            if (x%3 == 1)
                            {
                                CGPoint new = CGPointMake(tempview.frame.origin.x - self.superview.superview.frame.size.width/3, tempview.frame.origin.y);
                                tempview.frame = CGRectMake(new.x, new.y, tempview.frame.size.width, tempview.frame.size.height);
                            }
                            if (x%3 == 2)
                            {
                                
                                CGPoint new = CGPointMake(tempview.frame.origin.x + 2*( self.superview.superview.frame.size.width/3), tempview.frame.origin.y - shiftamount);
                                tempview.frame = CGRectMake(new.x, new.y, tempview.frame.size.width, tempview.frame.size.height);
                            }
                            if (x%3 == 0)
                            {
                                
                                CGPoint new = CGPointMake(tempview.frame.origin.x - self.superview.superview.frame.size.width/3, tempview.frame.origin.y);
                                tempview.frame = CGRectMake(new.x, new.y, tempview.frame.size.width, tempview.frame.size.height);
                            }
                        }
                        
                    }
                    [UIView commitAnimations];
                    
                    
                }
                
                
            }
            else
            {
                
                touchedImageView.frame = imageViewStay.frame;
                
                
                [tempviewinscroll insertSubview:touchedImageView atIndex:oldposition];
                NSLog(@"inserting at old positon %i", oldposition);
                
            }
            tempScroll = (UIScrollView *) self.superview.superview;
            tempScroll.scrollEnabled = YES;
            
            
            
            
            [appDelegate.myCloset saveClosetArchive];
            
            if(currentcategorynum == 0 || currentcategorynum == 1) {
                
                mixerController.topChanged = YES;
                NSLog(@"topchanged!");
            }
            
            if(currentcategorynum == 2) mixerController.rightChanged = YES;
            if(currentcategorynum == 3) mixerController.lowerChanged = YES;
            if(currentcategorynum == 4) mixerController.topOverlayChanged = YES;
            if(currentcategorynum == 5) mixerController.accessoriesChanged = YES;
            
        }
        
        
        
    }
    
    */
    
    
}



@end
