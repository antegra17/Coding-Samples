//
//  UIOutfitImageView.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIOutfitImageView.h"
#import "ImageRecord.h"
#import "MixerController.h"
#import "OutfitBrowserController.h"
#import "AppDelegate.h"
#import "MixerController.h"
#import "Closet.h"
#import "DateRecord.h"

#import <QuartzCore/QuartzCore.h>
//#import <BMSocialShare/BMSocialShare.h>


@implementation UIOutfitImageView

@synthesize fileNumRef, boolcal;


CGPoint touchPoint;
UIOutfitImageView *touchedImageView;
UIImageView *popUpOutfitDisplay;
UIImageView *popUpOutfitDisplayCloseButton;
UIImageView *popUpOutfitDisplayDeleteButton;
UIScrollView *outfitsScroll;

NSMutableArray *selectedDatesOVArray;


NSMutableArray *outfitsArray;
NSString *pathhome;
NSString *pathcloset;
OutfitRecord *outfitRetrieve;




AppDelegate *appDelegate;
MixerController *mixerController;


UIScrollView *popUpItemWindow;
UIOutfitImageView *popUpItemDisplay;
UIImageView * popUpItemDisplayCloseButton;


OutfitRecord *tempimagerecordedit;
UILabel *popUpItemDisplayDetailsLabel;

int currentselecteddate;


static int calendarShadowOffset = (int)-20;

BOOL didmove;
BOOL calremove;
BOOL shiftedUp;

TKCalendarMonthView *calendar;




UIView *uploadWindow;

UITextField *outfitNameField;
UITextView *messagefield;


-(void) alertShareFB
{
  
 
    UIImage *fbImage = [UIImage imageWithContentsOfFile:temprecord.imageFilePath];
    
   // BMFacebookPost *post = [[BMFacebookPost alloc] initWithImage:fbImage];
    
   // [[BMSocialShare sharedInstance] facebookPublish:post];
    
    NSString *urlencodedusername = [mixerController.currentUser.username
                                   stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    [self updateFBcount:urlencodedusername];
    
    
    
}


// Show/Hide the calendar by sliding it down/up from the top of the device.
- (void)toggleCalendar {
	// If calendar is off the screen, show it, else hide it (both with animations)
    
   

    
    if(calremove == FALSE)
    {
        [popUpItemWindow setUserInteractionEnabled:FALSE];
        
        calendar = 	[[TKCalendarMonthView alloc] init];
        calendar.delegate = self;
        calendar.dataSource = self;
        // Add Calendar to just off the top of the screen so it can later slide down
        calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset+800, calendar.frame.size.width, calendar.frame.size.height);
        // Ensure this is the last "addSubview" because the calendar must be the top most view layer	
        [popUpItemWindow.superview addSubview:calendar];
        [calendar reload];
        
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, 195, calendar.frame.size.width, calendar.frame.size.height);
		[UIView commitAnimations];
        
        
        
        
        
    }
    
    
    else if(calremove == TRUE)
    {
        
        [popUpItemWindow setUserInteractionEnabled:TRUE];
        NSLog(@"hide calendar");
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);		
		[UIView commitAnimations];
        
  
        
        calremove = FALSE;
        
	}	
    
    
    
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods






UIButton *removeDateButton;

UIPickerView *assignedDatesPicker;




- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component 
{

    if(pickerView.tag == 893)
    {
        
        currentselecteddate = row;
        
        
    }
    

}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
  /*  if(pickerView.tag == 892)
    {
        NSUInteger numRows = [myCloset.outfitCategories count];
        
        return numRows;
    } */
   
   
    if(pickerView.tag == 893)
    {
        NSUInteger numRows = [selectedDatesOVArray count];
        
        return numRows;
    }
    
    return nil;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// tell the picker the title for a given component
/* - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
 {
 NSString *title;
 title = [@"" stringByAppendingFormat:@"%d",row];
 
 return title;
 }   */





- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view 
{
    
    UILabel *pickerLabel = (UILabel *)view;
    
   /* if (pickerView.tag == 892) 
    {
        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 200, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentCenter];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont boldSystemFontOfSize:36]];
        }
        
        
        [pickerLabel setText:[myCloset.outfitCategories objectAtIndex:row]];
        
    }*/
    
    if (pickerView.tag == 893) 
    {
        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 200, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentCenter];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont boldSystemFontOfSize:30]];
        }
        
        NSDate *tempdate = [selectedDatesOVArray objectAtIndex:row];
        
        
        
        
        int daysToAdd = 1;
        NSDate *newDate1 = [tempdate dateByAddingTimeInterval:60*60*24*daysToAdd];
      
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
        NSString *tempdatestring = [dateFormatter stringFromDate:newDate1];
        
        [dateFormatter setDateFormat:@"EEE "];
        NSString *weekDay =  [dateFormatter stringFromDate:tempdate];
        
        
        
        
        NSString *finaldate = [weekDay stringByAppendingString:tempdatestring];
        
        [pickerLabel setText:finaldate];
        
    }
    
    return pickerLabel;
    
    
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component 
{
    int sectionWidth = 300;
    
    return sectionWidth;
}






- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
    

    
    
    NSLog(@"%@", d);
    
    
    BOOL duplicatedate;
    duplicatedate = FALSE;
    
    for(int x = 0; x<[selectedDatesOVArray count]; x++)
    {
        NSDate *tempdate = [selectedDatesOVArray objectAtIndex:x];
        if([tempdate compare:d] == NSOrderedSame)
        {
            duplicatedate = TRUE;
            break;
        }
    }
    
    
    if(duplicatedate == FALSE)
    {
    
        
        NSLog(@"adding date to picker!");
        [selectedDatesOVArray addObject:d];
        
        [selectedDatesOVArray sortUsingSelector:@selector(compare:)];
        
        
        NSLog(@"reloading ALL COMPONENT OF DATE PICKERVIEW AFTER ADDING TO ARRAY");
        
        [assignedDatesPicker reloadAllComponents];
        
        assignedDatesPicker.userInteractionEnabled = YES;
    }
    
    calremove = TRUE;
    
    [self toggleCalendar];
    
    
}








- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
	NSLog(@"calendarMonthView marksFromDate toDate");	
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < [mixerController.myCloset.dateRecords count]; x++)
    {
        DateRecord *temprecord = [mixerController.myCloset.dateRecords objectAtIndex:x];
        NSDate *tempdate = temprecord.date;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd 00:00:00 +0000"];
        
        
        NSString *stringFromDate = [formatter stringFromDate:tempdate];
        
        NSLog(@"%@", stringFromDate);
        [data addObject:stringFromDate];
    }  
	
    
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
                                              NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
                                    fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
	// Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];	
	
    
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		
		// If the date is in the data array, add it to the marks array, else don't
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
            
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
    
	
	return [NSArray arrayWithArray:marks];
}

UIViewInScroll *tempmainscroll;
-(void)closeOutfitDisplay
{
   
    NSLog(@"closing outfitdisplay byebye!");
    
    [popUpItemWindow removeFromSuperview];
    
    
    for(int x = 0; x<[mixerController.outfitBrowserController.view.subviews count]; x++)
    {
        UIView *tempview = [mixerController.outfitBrowserController.view.subviews objectAtIndex:x];
        if (tempview.tag != 555)
        {
            tempview.userInteractionEnabled = YES;
        }
    }
    
    
}


-(UIView *) retrieveView: (int) findviewtag
{
    for(int x = 0; x < [popUpItemWindow.subviews count]; ++x)
    {
        UIView *tempview = [popUpItemWindow.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return tempview;
        }
        
    }
    return nil;
}

-(void)removeCurrentOutfitFromDate
{
    OutfitBrowserController *browsercontroller = mixerController.outfitBrowserController;
    NSMutableArray *removefromdates = [[NSMutableArray alloc] init ];
    
    NSLog(@"current date is %@", browsercontroller.currentSelectedDate);
    [removefromdates addObject:browsercontroller.currentSelectedDate];
    [mixerController.myCloset removeOutfitNum:touchedImageView.fileNumRef fromDates:removefromdates];
    
   // [browsercontroller toggleCalendar];
   // [browsercontroller toggleCalendar];
    
    [self closeOutfitDisplay];
    
}

-(void)deleteOutfit
{
    

    
    NSLog(@"deleting outfit byebye!");
    self.superview.userInteractionEnabled = YES;
    UIScrollView *outfitsScroll = (UIScrollView *) self.superview.superview;
    outfitsScroll.scrollEnabled = YES;
    
    [popUpItemWindow removeFromSuperview];
    
    NSLog(@"touchedimageview delete me!:%i", touchedImageView.fileNumRef);
    
    pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    pathcloset = [pathhome stringByAppendingPathComponent:@"closet.arch"];
    
    
    for (int x = 0; x<[mixerController.myCloset.outfitsArray count]; ++x)
    {
        outfitRetrieve = [mixerController.myCloset.outfitsArray objectAtIndex:x];
        
      
        
        if(touchedImageView.fileNumRef == outfitRetrieve.fileNumRef)
        {
            [mixerController deleteFile:outfitRetrieve.imageFilePath];
            [mixerController deleteFile:outfitRetrieve.imageFilePathThumb];
            
            //delete from calendar dates
            
            
            [mixerController.myCloset removeOutfitNum:outfitRetrieve.fileNumRef fromDates:outfitRetrieve.dates];
            
            
            //finish delete from calender dates
            
            
            [mixerController.myCloset.outfitsArray removeObjectAtIndex:x];
        }
        
    }
    
    

    [mixerController.myCloset saveClosetArchive];
    
    
    
    
    //the following not necessary if outfview not fullscreen??? 
    
 
    
    [mixerController.outfitBrowserController loadArchive];

}


-(BOOL) doesViewAlreadyExist: (int) findviewtag
{
    for(int x = 0; x < [popUpItemWindow.subviews count]; ++x)
    {
        UIView *tempview = [popUpItemWindow.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return TRUE;
        }
        
    }
    return FALSE;
}

-(void) deactivateAllInView: (UIView *) view except: (int) y
{
    
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        
        NSLog(@"%i", tempview.tag);
        if (tempview.tag != y)
        {
            NSLog(@"deactivate %i", tempview.tag);
            tempview.userInteractionEnabled = NO;
        }
        
    }
    
}




-(void) reactivateAllInView
{
    
    for (int x = 0; x<[popUpItemWindow.subviews count]; x++)
    {
        UIView *tempview = [popUpItemWindow.subviews objectAtIndex:x];
           
        if (tempview.tag != 556)
            tempview.userInteractionEnabled = YES;
        NSLog(@"reactivate %i", tempview.tag);
        
    }
    
}

-(void) reactivateAllInUploadWindow
{
    
    for (int x = 0; x<[uploadWindow.subviews count]; x++)
    {
        UIView *tempview = [uploadWindow.subviews objectAtIndex:x];
        
       
            tempview.userInteractionEnabled = YES;
        
    }
    
}



-(void) alertDelete
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(35, 670, 250, 100)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        [self deactivateAllInView:popUpItemWindow except:38];
        
        
        [popUpItemWindow addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 20)];
        
        alertLabel.text = @"Delete this outfit?";
        alertLabel.textAlignment = UITextAlignmentCenter;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:16];
        
        [alertView addSubview:alertLabel];
        
      /*  UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okayppressed.jpg"];
        
        
        
        UIButton *okayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okayButton.frame = CGRectMake(98, 50, 54, 36);
        okayButton.tag = 55;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:okayButton];*/
        
           UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
         UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
         
         UIImage *no = [UIImage imageNamed:@"no.jpg"];
         UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
         
        UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 55, 54, 36)];
         yesButton.tag=66;
         
         [yesButton setImage:yes forState:UIControlStateNormal];
         [yesButton setImage:yespressed forState:UIControlStateHighlighted];
         
         [yesButton addTarget:self action:@selector(deleteOutfit) forControlEvents:UIControlEventTouchUpInside];
         
                                UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(131, 55, 54, 36)];
         
         
         noButton.tag= 77;
         [noButton setImage:no forState:UIControlStateNormal];
         [noButton setImage:nopressed forState:UIControlStateHighlighted];
         
        [noButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
         
         
         [alertView addSubview:yesButton];
         [alertView addSubview:noButton];
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}




-(void) alertDates
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        
        
        
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(35, 670, 250, 100)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        [self deactivateAllInView:popUpItemWindow except:38];
        
        
        [popUpItemWindow addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 20)];
        
        alertLabel.textAlignment = UITextAlignmentCenter;
        alertLabel.text = @"Dates successfully added!";
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:16];
        
        [alertView addSubview:alertLabel];
        
          UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
         UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
         
         
         
         UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 50, 54, 36)];
         okayButton.tag = 45;
         
         [okayButton setImage:okay forState:UIControlStateNormal];
         [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
         
         [okayButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
         
         [alertView addSubview:okayButton];
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}

-(void) alertName
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        
        
        
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(35, 670, 250, 100)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        [self deactivateAllInView:popUpItemWindow except:38];
        
        
        [popUpItemWindow addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 20)];
        
        alertLabel.text = @"Name successfully changed!";
        alertLabel.textAlignment = UITextAlignmentCenter;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:16];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 50, 54, 36)];
        okayButton.tag = 45;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:okayButton];
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}


-(void) alertUploadFail
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [myIndicator stopAnimating];
    
    if([self doesViewAlreadyExist:404] == NO)
    {
        
        
        
        int originX = popUpItemWindow.frame.size.width/2 - 100;
        int originY = popUpItemWindow.frame.size.height/2 - 150;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 150)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 404;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
         alertView.layer.cornerRadius = 5;
        
        
        [self deactivateAllInView:popUpItemWindow except:404];
        
        
        [popUpItemWindow addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 150, 70)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = @"Sorry, there seems to be some connection issues. Please try again.";
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okayppressed.jpg"];
        
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(73, 90, 54, 36)];
        okayButton.tag = 55;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:okayButton];
        
        
    }
    else
    {
        NSLog(@"404 already there!");
        
    }
    
    
}







UIActivityIndicatorView *myIndicator;
NSString *returnString;
NSURLConnection *activeConnection;
NSMutableData *returnData;



-(void) dismissAlert
{
    
    
    UIView *temp = [self retrieveView:38];
    [temp removeFromSuperview];
    [self reactivateAllInView];
    
}



-(void) dismissAlert: (UIButton *) sender
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activeConnection cancel];
    [sender.superview removeFromSuperview];
    
    if(sender.tag == 55)
    {
        [self reactivateAllInView];
        [self reactivateAllInUploadWindow];
        [self deactivateAllInView:popUpItemWindow except:38];
    }else
        [self reactivateAllInView];
    
}






-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appDelegate.mixerController;
    
    UITouch *touch = [[event allTouches] anyObject];
    touchPoint = [touch locationInView:self.superview];
    
    touchedImageView = [self.superview hitTest:touchPoint withEvent:nil];
    
    NSLog(@"touched filenumref is %i", touchedImageView.fileNumRef);
    
    didmove = FALSE;
    
    
    if(!selectedDatesOVArray)
    {
        selectedDatesOVArray = [[NSMutableArray alloc] init];
        NSLog(@"date created");
    }
}


-(OutfitRecord *) retrieveRecord: (int)fileNumRef
{
    Closet *tempcloset = appDelegate.myCloset;
    
    
    for (int x = 0; x<[tempcloset.outfitsArray count]; ++x)
    {
        outfitRetrieve = [tempcloset.outfitsArray objectAtIndex:x];
        
        NSLog(@"outfit filenumref is %i", outfitRetrieve.fileNumRef);
        
        
        if(touchedImageView.fileNumRef == outfitRetrieve.fileNumRef)
        {
            NSLog(@"found outfit %i!", outfitRetrieve.fileNumRef);
            return outfitRetrieve;
        }
        
        
        
    }    
    NSLog(@"outfit record not found!");
    return nil;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
	if ( [ text isEqualToString: @"\n" ] ) {

        
        
		[ textView resignFirstResponder ];
		return NO;
	}
	return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    CGPoint positionWithKeyboard = CGPointMake(popUpItemWindow.center.x, popUpItemWindow.center.y +170);
   
    
    if(shiftedUp)
    {
    
    
    [UIView beginAnimations:@"rearranging tiles" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    popUpItemWindow.center = positionWithKeyboard;
    
    
    [UIView commitAnimations];
        
        shiftedUp = NO;
    
    }
    
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
 
    
    UIScrollView *tempscroll = (UIScrollView *) textField.superview;
    
    CGPoint bottomOffset = CGPointMake(0, tempscroll.contentSize.height - tempscroll.bounds.size.height);
    [tempscroll setContentOffset:bottomOffset animated:YES];
    
    CGPoint positionWithoutKeyboard = CGPointMake(popUpItemWindow.center.x, popUpItemWindow.center.y -170);
    
    
    [UIView beginAnimations:@"rearranging tiles" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    popUpItemWindow.center = positionWithoutKeyboard;
    
    
    [UIView commitAnimations];
    
    shiftedUp = YES;

}





-(void) alertShare
{
    
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:popUpItemWindow except:38];
        
        
        
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(40, 90+popUpItemWindow.contentOffset.y, 240, 250)];
        
        shareView.backgroundColor = [UIColor whiteColor];
        
        
        shareView.tag = 38;
        
        shareView.layer.borderColor = [[UIColor blackColor] CGColor];
        shareView.layer.borderWidth = 2;
        shareView.layer.cornerRadius = 5;
        
        
        
        
        [popUpItemWindow addSubview:shareView];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 40)];
        shareLabel.text = @"SHARE OUTFIT";
        shareLabel.textColor = [UIColor whiteColor];
        shareLabel.backgroundColor = [UIColor blackColor];
        shareLabel.textAlignment = UITextAlignmentCenter;
        shareLabel.font = [UIFont fontWithName:@"Futura" size:22];
        
        [shareView addSubview:shareLabel];
        
        
        
        messagefield = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 200, 125)];
        messagefield.backgroundColor = [UIColor whiteColor];
        
        messagefield.layer.borderColor = [[UIColor grayColor] CGColor];
        messagefield.layer.borderWidth = 2;
        messagefield.layer.cornerRadius = 5;
        
        messagefield.tag = 777;
        
        
        
        
        OutfitBrowserController *browsercontroller = mixerController.outfitBrowserController;
        
        ImageRecord *topitemrecord = [browsercontroller retrieveRecordNum:temprecord.toprefnum FromCatName:temprecord.topcatname RackName:temprecord.toprackname];
        
        ImageRecord *rightitemrecord = [browsercontroller retrieveRecordNum:temprecord.rightrefnum FromCatName:temprecord.rightcatname RackName:temprecord.rightrackname];
        
        ImageRecord *loweritemrecord = [browsercontroller retrieveRecordNum:temprecord.lowerrefnum FromCatName:temprecord.lowercatname RackName:temprecord.lowerrackname];
        
        ImageRecord *topoverlayitemrecord = [browsercontroller retrieveRecordNum:temprecord.topoverlayrefnum FromCatName:temprecord.topoverlaycatname RackName:temprecord.topoverlayrackname];
        
        
        NSString *details;
        
        
        NSString * topbrand = topitemrecord.brand;
        NSString * rightbrand = rightitemrecord.brand;
        NSString * lowerbrand = loweritemrecord.brand;
        NSString * topoverlaybrand = topoverlayitemrecord.brand;
        
        NSLog(@"top brand is %@!!!!!", topitemrecord.brand);
        
        NSLog(@"top rack is %@!!!!!", topitemrecord.rackName);
        
        if (topbrand == NULL || [topbrand compare:@"N/A"] == NSOrderedSame) topbrand = @"";
        
        if (rightbrand == NULL || [rightbrand compare:@"N/A"] == NSOrderedSame) rightbrand = @"";
        
        if (lowerbrand == NULL || [lowerbrand compare:@"N/A"] == NSOrderedSame) lowerbrand = @"";
        
        if (topoverlaybrand == NULL || [topoverlaybrand compare:@"N/A"] == NSOrderedSame) topoverlaybrand = @"";
        
        
        if(temprecord.outfitTypeNum == 0)
        {
            
            if(topitemrecord.rackName != NULL && rightitemrecord.rackName != NULL && loweritemrecord.rackName != NULL)
            {
                details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@ ",
                           topitemrecord.color,topitemrecord.rackName, topbrand,rightitemrecord.color,rightitemrecord.rackName,
                           rightbrand,loweritemrecord.color,loweritemrecord.rackName,
                           lowerbrand];
            }
            
            else
                details = @"";
        }
        
        if(temprecord.outfitTypeNum == 1)
        {
            if(topitemrecord.rackName != NULL && loweritemrecord.rackName != NULL)
            {
                
                details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ ",
                           topitemrecord.color, topitemrecord.rackName, topbrand,loweritemrecord.color,loweritemrecord.rackName,
                           lowerbrand];
            }
            else
                details = @"";
        }
        
        if(temprecord.outfitTypeNum == 2)
        {
            
            if(topitemrecord.rackName != NULL && rightitemrecord.rackName != NULL && loweritemrecord.rackName != NULL & topoverlayitemrecord.rackName != NULL)
            {
                details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@", topoverlayitemrecord.color,topoverlayitemrecord.rackName, topoverlaybrand,
                           topitemrecord.color,topitemrecord.rackName,topbrand,rightitemrecord.color,rightitemrecord.rackName,
                           rightbrand,loweritemrecord.color,loweritemrecord.rackName,
                           lowerbrand];
            }
            
            else
                details = @"";
            
            
        }
        
        if(temprecord.outfitTypeNum == 3)
        {
            if(topitemrecord.rackName != NULL && loweritemrecord.rackName != NULL && topoverlayitemrecord.rackName != NULL)
            {
                
                details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@",
                           topoverlayitemrecord.color,topoverlayitemrecord.rackName, topoverlaybrand, topitemrecord.color,topitemrecord.rackName, topbrand,loweritemrecord.color,loweritemrecord.rackName,
                           lowerbrand];
            }
            else
                details = @"";
        }
        
        
        
        
        
        NSString *sharestring = [NSString stringWithFormat:@"%@ (%@)", outfitRetrieve.outfitName, details];
        
        
    
        messagefield.text = sharestring;
        messagefield.delegate = self;
        
        messagefield.font = [UIFont fontWithName:@"Futura" size:16];
        
        [shareView addSubview:messagefield];
        
        
        UIImage *post = [UIImage imageNamed:@"post.jpg"];
        UIImage *postpressed = [UIImage imageNamed:@"postpressed.jpg"];
        
        UIImage *cancel = [UIImage imageNamed:@"cancel.jpg"];
        UIImage *cancelpressed = [UIImage imageNamed:@"cancelpressed.jpg"];
        
        UIButton *postButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 90, 36)];
        postButton.tag=66;
        
        [postButton setImage:post  forState:UIControlStateNormal];
        [postButton setImage:postpressed forState:UIControlStateHighlighted];
        
        [postButton addTarget:self action:@selector(pushUpload) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 200, 90, 36)];
        
        
        cancelButton.tag= 38;
        [cancelButton setImage:cancel forState:UIControlStateNormal];
        [cancelButton setImage:cancelpressed forState:UIControlStateHighlighted];
        
        [cancelButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [shareView addSubview:postButton];
        [shareView addSubview:cancelButton];
        
        
        
        //[shareView addSubview:messagefield];
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}










OutfitRecord *temprecord;


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *outfitNavController = [[tabBarController viewControllers] objectAtIndex:2];
    
    OutfitBrowserController *outfitBrowserController = [[outfitNavController viewControllers] objectAtIndex:0];
    
    [outfitBrowserController viewOutfit:touchedImageView.fileNumRef];
    
    /*
    
    NSDate *lastworn = [mixerController.myCloset findLastWorn:fileNumRef];
    
    NSString *lastwornfull;
    
    if(lastworn != NULL)
        
    {
        int daysToAdd = 1;
        NSDate *newDate1 = [lastworn dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
    
        
        [dateFormatter setDateFormat:@"EEE MM/dd/yy"];
        NSString *weekDay =  [dateFormatter stringFromDate:newDate1];
        
        
    
        
        NSString *lastwornprefix = @"Last Wear ";
        lastwornfull = [lastwornprefix stringByAppendingString:weekDay];
        
    }
    
    
    
    NSDate *nextworn = [mixerController.myCloset findNextWorn:fileNumRef];
    
    NSString *nextwornfull;
    
    if(nextworn != NULL)
        
    {
        
        int daysToAdd = 1;
        NSDate *newDate1 = [nextworn dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
   
        
        [dateFormatter setDateFormat:@"EEE MM/dd/yy"];
        NSString *weekDay =  [dateFormatter stringFromDate:newDate1];
        
        
 
        
        NSString *nextwornprefix = @"Next Wear ";
        
        nextwornfull = [nextwornprefix stringByAppendingString:weekDay];
        
      
        
        
    }
    
    
    BOOL wornToday = [mixerController.myCloset isWornToday:fileNumRef];
    if(wornToday) NSLog(@"WORN TODAYYYYYY");
    
    
    
    
    shiftedUp = NO;
    
    NSLog(@"touch ended, superview tag %i", touchedImageView.superview.tag);
    
    tempmainscroll = (UIViewInScroll *) self.superview;
    
    if(touchedImageView.superview.tag == 64321 && didmove == FALSE && tempmainscroll.addselectionmode == FALSE)
    {
        temprecord = [self retrieveRecord:touchedImageView.fileNumRef];
        
        if(!temprecord)
        {
            NSLog(@"record not found");
        }
        else
        {
            if([touchedImageView isKindOfClass:[UIOutfitImageView class]])
            {
                
                
                NSLog(@"passed into if kind of outfitimageview class");
                
                
                popUpItemWindow = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
                
                
                
                UIImage *woodbg = [UIImage imageNamed:@"wood.png"];
                popUpItemWindow.backgroundColor = [UIColor colorWithPatternImage:woodbg];
                popUpItemWindow.bounces = NO;
                popUpItemWindow.scrollEnabled = YES;
                popUpItemWindow.contentSize = CGSizeMake(320, 876);
                popUpItemWindow.tag = 555;
                
                
                UILabel *newOutfitHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
                
                newOutfitHeader.text = temprecord.outfitName;
                newOutfitHeader.textColor = [UIColor blackColor];
                newOutfitHeader.textAlignment = UITextAlignmentCenter;
                newOutfitHeader.font = [UIFont fontWithName:@"Futura" size:18];
                newOutfitHeader.backgroundColor = [UIColor clearColor];
                [popUpItemWindow addSubview:newOutfitHeader];
                
                
                if(wornToday)
                {
                    
                    newOutfitHeader.frame = CGRectMake(0, 0, 210, 50);
                    UILabel *newOutfitHeaderToday = [[UILabel alloc] initWithFrame:CGRectMake(210, 3, 100, 50)];
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
                
                
                
                UILabel *newOutfitFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 418, 320,40)];
                
                newOutfitFooter.text = @"SHARE";
                newOutfitFooter.textColor = [UIColor whiteColor];
                newOutfitFooter.textAlignment = UITextAlignmentCenter;
                newOutfitFooter.font = [UIFont fontWithName:@"Futura" size:30];
                newOutfitFooter.backgroundColor = [UIColor blackColor];
                [popUpItemWindow addSubview:newOutfitFooter];
                
                
                UILabel *newOutfitFooterC = [[UILabel alloc] initWithFrame:CGRectMake(0, 460, 320,40)];
                
                newOutfitFooterC.text = @"OUTFIT DETAILS";
                newOutfitFooterC.textColor = [UIColor whiteColor];
                newOutfitFooterC.textAlignment = UITextAlignmentCenter;
                newOutfitFooterC.font = [UIFont fontWithName:@"Futura" size:30];
                newOutfitFooterC.backgroundColor = [UIColor blackColor];
                [popUpItemWindow addSubview:newOutfitFooterC];
                
                
                
                UILabel *newOutfitFooterB = [[UILabel alloc] initWithFrame:CGRectMake(0, 834, 320, 40)];
                
                newOutfitFooterB.text = @"";
                newOutfitFooterB.textColor = [UIColor blackColor];
                newOutfitFooterB.textAlignment = UITextAlignmentCenter;
                newOutfitFooterB.font = [UIFont fontWithName:@"Futura" size:30];
                newOutfitFooterB.backgroundColor = [UIColor blackColor];
                
                
                
                [popUpItemWindow addSubview:newOutfitFooterB];
                
                
                popUpItemDisplay = [[UIOutfitImageView alloc] init];
                popUpItemDisplay.tag = 556;
                popUpItemDisplay.userInteractionEnabled = NO;
                
                popUpItemDisplayCloseButton = [[UIImageView alloc] init];
                
                
                popUpItemDisplay.frame = CGRectMake(0, 70, 320, 348);
                popUpItemDisplay.contentMode = UIViewContentModeScaleAspectFit;
                
                //popUpItemDisplay.layer.borderColor = [[UIColor blackColor] CGColor];
                //popUpItemDisplay.layer.borderWidth = 2;
                
                
                //float increasedwidth = touchedImageView.image.size.width;
                //float increasedheight = touchedImageView.image.size.height;
                
                //CGSize bigSize = CGSizeMake(increasedwidth, increasedheight);
                
                
                //UIImage *bigImage = [self imageWithImage:outfitImage scaledToSize:bigSize];
                
                UIImage *outfitImage = [UIImage imageWithContentsOfFile:temprecord.imageFilePath];
                
                popUpItemDisplay.image = outfitImage;
                
                
                
                UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 420, 54, 36)];
                UIImage *back = [UIImage imageNamed:@"backsm.jpg"];
                UIImage *backpressed = [UIImage imageNamed:@"backsmpressed.jpg"];
                backButton.tag = 456;
                [backButton setImage:back forState:UIControlStateNormal];
                [backButton setImage:backpressed forState:UIControlStateHighlighted];
                [backButton addTarget:self action:@selector(closeOutfitDisplay) forControlEvents:UIControlEventTouchUpInside];
                
                [popUpItemWindow addSubview:backButton];
                
                
                if (boolcal == FALSE)
                {
                    UIButton *popUpItemDisplayEditButton;
                    
                    popUpItemDisplayEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    [popUpItemDisplayEditButton setTitle:@"Edit Details" forState:UIControlStateNormal];
                    [popUpItemDisplayEditButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
                    [popUpItemDisplayEditButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                    popUpItemDisplayEditButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
                    popUpItemDisplayEditButton.frame = CGRectMake(320, 350, 80, 20);
                    
                    popUpItemDisplayEditButton.tag = touchedImageView.fileNumRef;
                    
                    
                    
                    popUpItemDisplayEditButton.backgroundColor = [UIColor grayColor];
                    popUpItemDisplayEditButton.titleLabel.textColor = [UIColor blackColor];
                    
                    
                    [popUpItemDisplayEditButton addTarget:self action:@selector(loadEditDetails:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    
                    
                    
                    
                    if(tempmainscroll.addselectionmode == FALSE)
                    {
                        
                        calremove = FALSE;
                        
                        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 836, 90, 36)];
                        UIImage *delete = [UIImage imageNamed:@"delete.jpg"];
                        UIImage *deletepressed = [UIImage imageNamed:@"deletepressed.jpg"];
                        [deleteButton setImage:delete forState:UIControlStateNormal];
                        [deleteButton setImage:deletepressed forState:UIControlStateHighlighted];
                        [deleteButton addTarget:self action:@selector(alertDelete) forControlEvents:UIControlEventTouchUpInside];
                        
                        [popUpItemWindow addSubview:deleteButton];
                        
                        
                        [popUpItemWindow addSubview:popUpOutfitDisplayDeleteButton];
                        
                        
                        UILabel *bar = [[UILabel alloc] initWithFrame:CGRectMake(0, 612, 320, 36)];
                        
                        
                        bar.backgroundColor = [UIColor blackColor];
                        
                        [popUpItemWindow addSubview:bar];
                        
                        UILabel *assignDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 620, 150,20)];
                        assignDateLabel.backgroundColor = [UIColor blackColor];
                        assignDateLabel.text = @"Add Dates";
                        assignDateLabel.textColor = [UIColor whiteColor];
                        assignDateLabel.font = [UIFont fontWithName:@"Futura" size:16];
                        assignDateLabel.numberOfLines = 0;
                        
                        [popUpItemWindow addSubview:assignDateLabel];
                        
                        UILabel *bar2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 742, 320, 36)];
                        
                        
                        bar2.backgroundColor = [UIColor blackColor];
                        
                        [popUpItemWindow addSubview:bar2];
                        
                        
                        UILabel *editNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 750, 200,20)];
                        editNameLabel.backgroundColor = [UIColor blackColor];
                        editNameLabel.text = @"Change Outfit Name";
                        editNameLabel.textColor = [UIColor whiteColor];
                        editNameLabel.font = [UIFont fontWithName:@"Futura" size:16];
                        editNameLabel.numberOfLines = 0;
                        
                        [popUpItemWindow addSubview:editNameLabel];
                        
                        UIButton *confirmNameButton = [[UIButton alloc] initWithFrame:CGRectMake(270,745,45,30)];
                        UIImage *check = [UIImage imageNamed:@"check.jpg"];
                        UIImage *checkpressed = [UIImage imageNamed:@"checkpressed.jpg"];
                        [confirmNameButton setImage:check forState:UIControlStateNormal];
                        [confirmNameButton setImage:checkpressed forState:UIControlStateHighlighted];
                        [confirmNameButton addTarget:self action:@selector(confirmName) forControlEvents:UIControlEventTouchUpInside];
                        
                        [popUpItemWindow addSubview:confirmNameButton];
                        
                        
                        outfitNameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 788, 280, 35)];
                        outfitNameField.backgroundColor = [UIColor whiteColor];
                        outfitNameField.textColor = [UIColor blackColor];
                        outfitNameField.borderStyle = UITextBorderStyleRoundedRect;
                        outfitNameField.tag = 203;
                        outfitNameField.text = temprecord.outfitName;
                        outfitNameField.delegate = self;
                        
                        outfitNameField.font = [UIFont fontWithName:@"Futura" size:16];
                        
                        [popUpItemWindow addSubview:outfitNameField];
                        
                        
                        
                        
                        
                        
                        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 664, 30, 30)];
                        UIImage *add = [UIImage imageNamed:@"add.jpg"];
                        UIImage *addpressed = [UIImage imageNamed:@"addpressed.jpg"];
                        [addButton setImage:add forState:UIControlStateNormal];
                        [addButton setImage:addpressed forState:UIControlStateHighlighted];
                        [addButton addTarget:self action:@selector(toggleCalendar) forControlEvents:UIControlEventTouchUpInside];
                        addButton.tag = 209;
                        
                        
                        
                        [popUpItemWindow addSubview:addButton];
                        
                        
                        UIButton *removeButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 702, 30, 30)];
                        UIImage *remove = [UIImage imageNamed:@"removeblue.jpg"];
                        UIImage *removepressed = [UIImage imageNamed:@"removebluepressed.jpg"];
                        [removeButton setImage:remove forState:UIControlStateNormal];
                        [removeButton setImage:removepressed forState:UIControlStateHighlighted];
                        [removeButton addTarget:self action:@selector(removeDate) forControlEvents:UIControlEventTouchUpInside];
                        
                        [popUpItemWindow addSubview:removeButton];
                        
                        
                        
                        
                        UIButton *confirmDatesButton = [[UIButton alloc] initWithFrame:CGRectMake(270,615,45,30)];
                        
                        [confirmDatesButton setImage:check forState:UIControlStateNormal];
                        [confirmDatesButton setImage:checkpressed forState:UIControlStateHighlighted];
                        [confirmDatesButton addTarget:self action:@selector(confirmDates) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        [popUpItemWindow addSubview:confirmDatesButton];
                        
                        currentselecteddate = 0;
                        
                        assignedDatesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                        assignedDatesPicker.tag = 893;
                        assignedDatesPicker.delegate = self;
                        assignedDatesPicker.showsSelectionIndicator = YES;
                        
                        assignedDatesPicker.userInteractionEnabled = NO;
                        
                        CGAffineTransform t0 = CGAffineTransformMakeTranslation(assignedDatesPicker.bounds.size.width/2, assignedDatesPicker.bounds.size.height/2);
                        CGAffineTransform s0 = CGAffineTransformMakeScale(0.35, 0.35);
                        CGAffineTransform t1 = CGAffineTransformMakeTranslation(-assignedDatesPicker.bounds.size.width/2, -assignedDatesPicker.bounds.size.height/2);
                        
                        UIView *datepickerHolder = [[UIView alloc] initWithFrame:CGRectMake(110, 658, 125, 75)];
                        
                        assignedDatesPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
                        
                        [datepickerHolder addSubview:assignedDatesPicker];
                        datepickerHolder.clipsToBounds = NO;
                        
                        [popUpItemWindow addSubview:datepickerHolder];
                    }
                }
                
                ///   if(tempmainscroll.addselectionmode == TRUE)
                 {
                 UIButton *addToCurrentDateButton;
                 
                 addToCurrentDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
                 [addToCurrentDateButton setTitle:@"ADD TO DATE" forState:UIControlStateNormal];
                 [addToCurrentDateButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
                 [addToCurrentDateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 
                 addToCurrentDateButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
                 addToCurrentDateButton.frame = CGRectMake(220, 350, 80, 20);
                 
                 addToCurrentDateButton.tag = touchedImageView.fileNumRef;
                 
                 
                 
                 addToCurrentDateButton.backgroundColor = [UIColor grayColor];
                 addToCurrentDateButton.titleLabel.textColor = [UIColor blackColor];
                 
                 
                 [addToCurrentDateButton addTarget:self action:@selector(closeOutfitSelector:) forControlEvents:UIControlEventTouchUpInside];
                 
                 [popUpItemWindow addSubview:addToCurrentDateButton];
                 }///
                
                
                
                
                OutfitBrowserController *browsercontroller = mixerController.outfitBrowserController;
                
                ImageRecord *topitemrecord = [browsercontroller retrieveRecordNum:temprecord.toprefnum FromCatName:temprecord.topcatname RackName:temprecord.toprackname];
                
                ImageRecord *rightitemrecord = [browsercontroller retrieveRecordNum:temprecord.rightrefnum FromCatName:temprecord.rightcatname RackName:temprecord.rightrackname];
                
                ImageRecord *loweritemrecord = [browsercontroller retrieveRecordNum:temprecord.lowerrefnum FromCatName:temprecord.lowercatname RackName:temprecord.lowerrackname];
                
                ImageRecord *topoverlayitemrecord = [browsercontroller retrieveRecordNum:temprecord.topoverlayrefnum FromCatName:temprecord.topoverlaycatname RackName:temprecord.topoverlayrackname];
                
                
                NSString *details;
                
                
                NSString * topbrand = topitemrecord.brand;
                NSString * rightbrand = rightitemrecord.brand;
                NSString * lowerbrand = loweritemrecord.brand;
                NSString * topoverlaybrand = topoverlayitemrecord.brand;
                
                NSLog(@"top brand is %@!!!!!", topitemrecord.brand);
                
                NSLog(@"top rack is %@!!!!!", topitemrecord.rackName);
                
                if (topbrand == NULL || [topbrand compare:@"N/A"] == NSOrderedSame) topbrand = @"";
                
                if (rightbrand == NULL || [rightbrand compare:@"N/A"] == NSOrderedSame) rightbrand = @"";
                
                if (lowerbrand == NULL || [lowerbrand compare:@"N/A"] == NSOrderedSame) lowerbrand = @"";
                
                if (topoverlaybrand == NULL || [topoverlaybrand compare:@"N/A"] == NSOrderedSame) topoverlaybrand = @"";
                
                
                if(temprecord.outfitTypeNum == 0)
                {
                    
                    if(topitemrecord.rackName != NULL && rightitemrecord.rackName != NULL && loweritemrecord.rackName != NULL)
                    {
                        details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@ ",
                                   topitemrecord.color,topitemrecord.rackName, topbrand,rightitemrecord.color,rightitemrecord.rackName,
                                   rightbrand,loweritemrecord.color,loweritemrecord.rackName,
                                   lowerbrand];
                    }
                    
                    else
                        details = @"";
                }
                
                if(temprecord.outfitTypeNum == 1)
                {
                    if(topitemrecord.rackName != NULL && loweritemrecord.rackName != NULL)
                    {
                        
                        details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ ",
                                   topitemrecord.color, topitemrecord.rackName, topbrand,loweritemrecord.color,loweritemrecord.rackName,
                                   lowerbrand];
                    }
                    else
                        details = @"";
                }
                
                if(temprecord.outfitTypeNum == 2)
                {
                    
                    if(topitemrecord.rackName != NULL && rightitemrecord.rackName != NULL && loweritemrecord.rackName != NULL & topoverlayitemrecord.rackName != NULL)
                    {
                        details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@", topoverlayitemrecord.color,topoverlayitemrecord.rackName, topoverlaybrand,
                                   topitemrecord.color,topitemrecord.rackName,topbrand,rightitemrecord.color,rightitemrecord.rackName,
                                   rightbrand,loweritemrecord.color,loweritemrecord.rackName,
                                   lowerbrand];
                    }
                    
                    else
                        details = @"";
                    
                    
                }
                
                if(temprecord.outfitTypeNum == 3)
                {
                    if(topitemrecord.rackName != NULL && loweritemrecord.rackName != NULL && topoverlayitemrecord.rackName != NULL)
                    {
                        
                        details = [NSString stringWithFormat:@"%@ %@: %@ \n%@ %@: %@ \n%@ %@: %@",
                                   topoverlayitemrecord.color,topoverlayitemrecord.rackName, topoverlaybrand, topitemrecord.color,topitemrecord.rackName, topbrand,loweritemrecord.color,loweritemrecord.rackName,
                                   lowerbrand];
                    }
                    else
                        details = @"";
                }
                
                
                
                popUpItemDisplayDetailsLabel = [[UILabel alloc] init];
                
                popUpItemDisplayDetailsLabel.frame = CGRectMake(10, 502, 300, 100);
                
                
                
                
                
                popUpItemDisplayDetailsLabel.numberOfLines = 0;
                
                popUpItemDisplayDetailsLabel.text = details;
                popUpItemDisplayDetailsLabel.textColor = [UIColor blackColor];
                popUpItemDisplayDetailsLabel.font = [UIFont fontWithName:@"Futura" size:16];
                
                popUpItemDisplayDetailsLabel.backgroundColor = [UIColor clearColor];
                
                
                
                [popUpItemWindow addSubview:popUpItemDisplay];
                [popUpItemWindow addSubview:popUpItemDisplayDetailsLabel];
                
                
                
                
                UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(274, 420, 36, 36)];
                
                UIImage *share = [UIImage imageNamed:@"cfshare.jpg"];
                UIImage *sharepressed = [UIImage imageNamed:@"cfsharepressed.jpg"];
                [shareButton setImage:share forState:UIControlStateNormal];
                [shareButton setImage:sharepressed forState:UIControlStateHighlighted];
                
                [shareButton addTarget:self action:@selector(alertShare) forControlEvents:UIControlEventTouchUpInside];
                
                [popUpItemWindow addSubview:shareButton];
                
                
                UIButton *shareFBButton = [[UIButton alloc] initWithFrame:CGRectMake(228, 420, 36, 36)];
                
                UIImage *fbshare = [UIImage imageNamed:@"fbshare.png"];
                UIImage *fbsharepressed = [UIImage imageNamed:@"fbsharepressed.png"];
                [shareFBButton setImage:fbshare forState:UIControlStateNormal];
                [shareFBButton setImage:fbsharepressed forState:UIControlStateHighlighted];
                
                [shareFBButton addTarget:self action:@selector(alertShareFB) forControlEvents:UIControlEventTouchUpInside];
                
                [popUpItemWindow addSubview:shareFBButton];
                
                
                
                
                // UIButton *accessButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
                
                
                // accessButton.frame = CGRectMake(20, 20, 36, 36);
                
                //UIImage *share = [UIImage imageNamed:@"share.jpg"];
                //UIImage *sharepressed = [UIImage imageNamed:@"sharepressed"];
                //[shareButton setImage:share forState:UIControlStateNormal];
                //[shareButton setImage:sharepressed forState:UIControlStateHighlighted];
                
                // [accessButton addTarget:self action:@selector(accessorize) forControlEvents:UIControlEventTouchUpInside];
                
                // [popUpItemWindow addSubview:accessButton];
                
                
                
                
                [self.superview.superview.superview addSubview:popUpItemWindow];
                
                
                
                
                if(boolcal == TRUE)
                {
                    UIImage *canceldate = [UIImage imageNamed:@"canceldate.jpg"];
                    UIImage *canceldatepressed = [UIImage imageNamed:@"canceldatepressed.jpg"];
                    
                    
                    
                    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 836, 90, 36)];
                    cancelButton.tag = 55;
                    
                    [cancelButton setImage:canceldate forState:UIControlStateNormal];
                    [cancelButton setImage:canceldatepressed forState:UIControlStateHighlighted];
                    
                    [cancelButton addTarget:self action:@selector(removeCurrentOutfitFromDate) forControlEvents:UIControlEventTouchUpInside];
                    
                    [popUpItemWindow addSubview:cancelButton];
                }
                
                
                
            }
        }
    }
    
    if(tempmainscroll.addselectionmode == TRUE)
    {
        NSLog(@"add true");
        [self closeOutfitSelector:touchedImageView.fileNumRef];
    }
    
    */
}




-(void) accessorize
{
    mixerController.outfitDisplay.backgroundColor = [UIColor colorWithPatternImage:popUpItemDisplay.image];
}


- (void)pushUpload 
{
    
    if([mixerController.currentUser.username compare:@"unregistered"] == NSOrderedSame)
    {
        [self alertWithBig:@"Sorry, a user account is needed to share your outfits on the ClosetFashions network.  You can do this by pressing New User when loading up ClosetFashions."];
    }
    else {
    
    myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	myIndicator.center = CGPointMake(120, 200);
	myIndicator.hidesWhenStopped = YES;
 
    uploadWindow = [self retrieveView:38];
    [uploadWindow addSubview:myIndicator];
    
    
    
    [self deactivateAllInView:uploadWindow except:38];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [myIndicator startAnimating];
    
    
	//NSData *imageData = UIImageJPEGRepresentation(popUpItemDisplay.image, 90);
    
    float uploadreducedwidth = popUpItemDisplay.frame.size.width/1.0;
    float uploadreducedheight = popUpItemDisplay.frame.size.height/1.0;
    
    
    CGSize uploadSize = CGSizeMake(uploadreducedwidth, uploadreducedheight);
    
    UIImage *uploadImage = [self imageWithImage:popUpItemDisplay.image scaledToSize:uploadSize];
    
    
    

    //NSData *imageData = UIImagePNGRepresentation(uploadImage);
  
    NSData *imageData = [[NSFileManager defaultManager] contentsAtPath:temprecord.imageFilePathThumb];
    
     NSString *urlString = [NSString stringWithFormat:@"http://%@/upload.php?username=%@", mixerController.domain,mixerController.currentUser.username];
    
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];

	
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPBody:body];
	
	//NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    activeConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    
        
    }
    /*
     
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error){ 
        
        if ([data length] > 0 && error == nil)
        {
            returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",returnString);
            int postnum = [returnString intValue];
            [self postUserName:mixerController.currentUser.username postNum:postnum description:messagefield.text];
        }
        else if ([data length] == 0 && error == nil)
        {
            NSLog(@"nothing was downloaded");
        }
        else if (error != nil)
        {
            NSLog(@"Error = %@", error);
        }
    }];*/
    
}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
    returnData = [[NSMutableData alloc] init]; // _data being an ivar
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [returnData appendData:data];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"failed!!!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [myIndicator stopAnimating];
    
    [self alertWithBig:@"Sorry, either the server is temporarily down or you do not have an active internet connection.  An internet connection is necessary to post outfits.  Please try again later."];
}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    
    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
    int postnum = [returnString intValue];
    
    NSString *imageURL= [NSString stringWithFormat:@"http://%@/users/%@/%i.png",mixerController.domain,mixerController.currentUser.username,postnum];
    
    NSLog(@"%@", imageURL);
    
    
    UIImage *imageVerify = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    
    int verifyHeight = (int) imageVerify.size.height;
    NSLog(@"imageheight %i", verifyHeight);
   
    UIColor *pixelVerify = [self getRGBAsFromImage:imageVerify atX:10 andY:695];
    
    NSLog(@"pixel 10,695 is : %@", pixelVerify);
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    int checkValue;
    
    checkValue = 255;
    [pixelVerify getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int intred = (int) (red *255);
    int intgreen = (int) (green *255);
    int intblue = (int) (blue *255);
    
    NSLog(@"%i, %i, %i", intred, intgreen, intblue);
    
    
    if (verifyHeight == 696 && intred == checkValue && intgreen == checkValue && intblue == checkValue)
    {
        
        NSLog(@"%i", verifyHeight);
        [self postUserName:mixerController.currentUser.username postNum:postnum description:messagefield.text];
    }
    else
    {
        [self alertUploadFail];
    }
    
     // Deal with the data 
}




-(UIColor *)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy
{
    //NSMutableArray *result = [NSMutableArray arrayWithCapacity:3];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;

        CGFloat red   = (rawData[byteIndex]     * 1.0) /255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) /255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) /255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) /255.0;
        byteIndex += 4;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        //[result addObject:acolor];
    
    free(rawData);
    
    return acolor;
}








-(void)postUserName: (NSString *) username postNum: (int) postnum description: (NSString *) description
{

    NSString *urlString = [NSString stringWithFormat:@"http://%@/post.php", mixerController.domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
    NSString *requestBodyString = [NSString stringWithFormat:@"username=%@&postnum=%i&description=%@&set=add", username, postnum, description];
    
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"]; // added from first suggestion 
     //NSURLResponse *response = NULL;
     //NSError *requestError = NULL;
     //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error){ 
        
        if ([data length] > 0 && error == nil)
        {
            NSLog(@"something was downloaded");
            NSLog(@"requeststring is %@", requestBodyString);
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"responsestring is %@", responseString);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [myIndicator stopAnimating];
            [self dismissAlert];
          
        }
        else if ([data length] == 0 && error == nil)
        {
            
            NSLog(@"nothing was downloaded");
             NSLog(@"requeststring is %@", requestBodyString);
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"responsestring is %@", responseString);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [myIndicator stopAnimating];
            [self dismissAlert];
        }
        else if (error != nil)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [myIndicator stopAnimating];
            [self dismissAlert];
            NSLog(@"Error = %@", error);
             [self alertWithBig:@"Sorry, either the server is temporarily down or you do not have an active internet connection.  An internet connection is necessary to post outfits.  Please try again later."];
        }
    }];
    
    
   
    
}


-(void)updateFBcount: (NSString *) username
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/fbshare.php", mixerController.domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
    NSString *requestBodyString = [NSString stringWithFormat:@"username=%@", username];
    
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"]; // added from first suggestion
    //NSURLResponse *response = NULL;
    //NSError *requestError = NULL;
    //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error){
        
        if ([data length] > 0 && error == nil)
        {
  
            
        }
        else if ([data length] == 0 && error == nil)
        {
            
         
        }
        else if (error != nil)
        {
   
        }
    }];
    
    
    
    
}

-(void) alertWithBig: (NSString *) alertstring
{
    
    
    
    if([self doesViewAlreadyExist:404] == NO)
    {
        [self deactivateAllInView:popUpItemWindow except:404];
        
        
        int originX = popUpItemWindow.frame.size.width/2 - 125;
        int originY = popUpItemWindow.frame.size.height/2 - 50;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 225)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 404;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
         alertView.layer.cornerRadius = 5;
        
        
        
        
        [popUpItemWindow addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 180, 150)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        
        UIButton *okayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okayButton.frame = CGRectMake(98, 175, 54, 36);
        okayButton.tag = 55;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:okayButton];
        
        /*    UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
         UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
         
         UIImage *no = [UIImage imageNamed:@"no.jpg"];
         UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
         
         UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         yesButton.frame = CGRectMake(40, 55, 54, 36);
         yesButton.tag=66;
         
         [yesButton setImage:yes forState:UIControlStateNormal];
         [yesButton setImage:yespressed forState:UIControlStateHighlighted];
         
         [yesButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
         
         UIButton *noButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         noButton.frame = CGRectMake(106, 55, 54, 36);
         
         
         noButton.tag= 77;
         [noButton setImage:no forState:UIControlStateNormal];
         [noButton setImage:nopressed forState:UIControlStateHighlighted];
         
         [noButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
         
         
         [removeCategoryView addSubview:yesButton];
         [removeCategoryView addSubview:noButton];*/
        
        
    }
    else
    {
        NSLog(@"404 already there!");
        
    }
    
    
}


/*-(void)insert: (NSString *) filename
{
    NSString *urlString = [NSString stringWithFormat:@"http://closetfashionista.uphero.com/insert.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
    NSString *requestBodyString = [NSString stringWithFormat:@"activity=%@", filename];
    
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"]; // added from first suggestion 
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", responseString);
}*/












-(void) removeDate
{
    if([selectedDatesOVArray count] > 0)
    {
        [selectedDatesOVArray removeObjectAtIndex:currentselecteddate];
    }
    
    if([selectedDatesOVArray count] == 0)
    {
        assignedDatesPicker.userInteractionEnabled = NO;
    }
    
    [assignedDatesPicker reloadAllComponents];
    
    currentselecteddate = 0;
    
    
}

-(void) confirmDates
{
  
    for(int x = 0; x<[selectedDatesOVArray count]; x++)
    {
        NSDate *tempdate = [selectedDatesOVArray objectAtIndex:x];
       
        
        [mixerController.myCloset addDate:tempdate toOutfitNum:touchedImageView.fileNumRef];
    }
    
    
  
    //  add dates to datesrecord array, sort, seek dates and add outfit to respective dates   
    
    [mixerController.myCloset addDates:selectedDatesOVArray];
   
    [mixerController.myCloset insertOutfitNum:touchedImageView.fileNumRef toDates:selectedDatesOVArray];
   
    [selectedDatesOVArray removeAllObjects];
    
    assignedDatesPicker.userInteractionEnabled = NO;

    [assignedDatesPicker reloadAllComponents];
    
    [self alertDates];
}

-(void) confirmName
{
    CGPoint positionWithoutKeyboard = CGPointMake(popUpItemWindow.center.x, popUpItemWindow.center.y +170);

    
    if(shiftedUp)
    {
        [outfitNameField resignFirstResponder];
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        popUpItemWindow.center = positionWithoutKeyboard;
        
        
        [UIView commitAnimations];
        
        shiftedUp = NO;
      
    }
    
    temprecord.outfitName = outfitNameField.text;
    [mixerController.myCloset saveClosetArchive];
    
    [self alertName];
    
    OutfitBrowserController *browsercontroller = mixerController.outfitBrowserController;
    
    [browsercontroller loadArchive];
    
   
}




-(void) closeOutfitSelector: (int) outfitnum;
{
    
    OutfitBrowserController *browsercontroller = mixerController.outfitBrowserController;
    
    NSMutableArray *tempdatearray = [[NSMutableArray alloc] init ];
    [tempdatearray addObject:browsercontroller.currentSelectedDate];
    
    NSLog(@"outfit image view output: current selected date %@", browsercontroller.currentSelectedDate);
    
    [mixerController.myCloset addDate:browsercontroller.currentSelectedDate toOutfitNum:outfitnum];
    [mixerController.myCloset addDates:tempdatearray];
    [mixerController.myCloset insertOutfitNum:outfitnum toDates:tempdatearray];
    
    [self closeOutfitDisplay];
    [browsercontroller closeOutfitSelector];
    
    //[browsercontroller toggleCalendar];
    //[browsercontroller toggleCalendar];
}

//USE TO SCALE IMAGES DOWN

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}                                                       //END SCALE IMAGES DOWN




        



@end
