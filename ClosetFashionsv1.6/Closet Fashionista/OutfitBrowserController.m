//
//  OutfitBrowser.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OutfitBrowserController.h"
#import "ImageRecord.h"
#import "UIOutfitImageView.h"
#import "ClipView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "OutfitRecord.h"
#import "DateRecord.h"
#import "Closet.h"
#import "MixerController.h"
#import "ItemViewController.h"

@implementation OutfitBrowserController


@synthesize outfitsScroll, goBackButton, outfitCategoryScroll, calendarViewButton, addCatButton, removeCatButton, currentSelectedDate, editMade;



static int calendarShadowOffset = (int)-20;

UIViewInScroll *viewInScrollOutfits;

NSString *pathhome;
NSString *pathcloset;

NSMutableArray *outfitsArray;

BOOL archiveloaded;
BOOL waitingforoutfitselection;
BOOL calremove;

ClipView *clipview;
UIView *scrollcontain;
float catlabelwidth;
float catlabelheight;

UILabel *currentcatlabel;
AppDelegate *appDelegate;


UILabel *outfitCategoryLabel;

UIView  *currentLabelInScroll;

UIButton *addOutfitButton;

int normaloutfitwidth;
int normaloutfitheight;
int normaloutfitwidthspacing;
int normaloutfitheightspacing;

Closet *myCloset;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ItemViewController class]]) {
        
        NSNumber *sentNumber = (NSNumber *)sender;
        NSLog(@"sent  item is number %i",[sentNumber intValue]);
        
        ItemViewController *outfitViewController = segue.destinationViewController;
        
        outfitViewController.touchedItemNum = [sentNumber intValue];
        outfitViewController.isOutfit = TRUE;
        outfitViewController.outfitBrowserController = self;
    }
}

-(void) viewOutfit: (int) touchedItemNum
{
    
    NSLog(@"touched item number is %i", touchedItemNum);
    
    NSNumber *touchedItemNumber = [NSNumber numberWithInt:touchedItemNum];
    
    [self performSegueWithIdentifier:@"OutfitViewSegue" sender:touchedItemNumber];
}

-(OutfitRecord *) retrieveRecord: (int)fileNumRef
{
    Closet *tempcloset = appDelegate.myCloset;
    
    
    for (int x = 0; x<[tempcloset.outfitsArray count]; ++x)
    {
        OutfitRecord *outfitRetrieve = [tempcloset.outfitsArray objectAtIndex:x];
        
        NSLog(@"outfit filenumref is %i", outfitRetrieve.fileNumRef);
        
        if(fileNumRef == outfitRetrieve.fileNumRef)
        {
            NSLog(@"found outfit %i!", outfitRetrieve.fileNumRef);
            return outfitRetrieve;
        }
    }
    NSLog(@"outfit record not found!");
    return nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    myCloset = appDelegate.myCloset;
    
    
    
    calremove = FALSE;
    archiveloaded = FALSE;
    waitingforoutfitselection = FALSE;
    
    
    [super viewDidLoad];
    catlabelwidth = self.view.frame.size.width/4;
    catlabelheight = 24;
    
     // Do any additional setup after loading the view from its nib.

    
    
    pathcloset = mixerController.pathcloset;

   
    outfitsScroll = [[UITiledScrollView alloc] initWithFrame: CGRectMake(0, 64, 200, 480)];

    outfitsScroll.backgroundColor = [UIColor blueColor];
    outfitsScroll.userInteractionEnabled = YES;
    viewInScrollOutfits = [[UIViewInScroll  alloc] initWithFrame:CGRectMake(0, -64, outfitsScroll.frame.size.width, outfitCategoryScroll.frame.size.height)];
    
    viewInScrollOutfits.userInteractionEnabled = YES;
    viewInScrollOutfits.backgroundColor = [UIColor yellowColor];
    viewInScrollOutfits.tag = 64321;
    
    viewInScrollOutfits.addselectionmode = FALSE;

    viewInScrollOutfits.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:outfitsScroll];
    [outfitsScroll addSubview:viewInScrollOutfits];

    
    outfitCategoryScroll = [[UIScrollView alloc] init];
    outfitCategoryScroll.delegate = self;
    outfitCategoryScroll.backgroundColor = [UIColor blackColor];
    outfitCategoryScroll.pagingEnabled=NO;
    outfitCategoryScroll.showsHorizontalScrollIndicator = NO;
    outfitCategoryScroll.showsVerticalScrollIndicator =YES;
    outfitCategoryScroll.scrollEnabled=YES;
    outfitCategoryScroll.userInteractionEnabled = YES;
    outfitCategoryScroll.bounces = YES;
    outfitCategoryScroll.alwaysBounceHorizontal =NO;
    outfitCategoryScroll.alwaysBounceVertical = YES;
    
    self.view.tag = 1001;

    outfitCategoryScroll.tag = 20000;
    
    
    outfitCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 110, catlabelwidth, 30)];
    
    outfitCategoryLabel.text = @"Categories";
    outfitCategoryLabel.backgroundColor = [UIColor blackColor];
    outfitCategoryLabel.textColor = [UIColor whiteColor];
    outfitCategoryLabel.font = [UIFont fontWithName:@"Futura" size:16];
    
    [self.view addSubview:outfitCategoryLabel];
    
    
    scrollcontain = [[UIView alloc] init];
    
   
    
    outfitCategoryScroll.pagingEnabled = YES;
    outfitCategoryScroll.clipsToBounds = NO;
    
    clipview = [[ClipView alloc] init];
    
    
    scrollcontain.tag = 20000;
    clipview.tag = 8888;
    
    
    [scrollcontain addSubview:outfitCategoryScroll];
    
    [self.view addSubview:clipview];
    
    [self.view addSubview:scrollcontain];
    
    
    
    outfitCategoryScroll.frame = CGRectMake(0, 20, catlabelwidth, 300);
    scrollcontain.frame = CGRectMake(220, 155, catlabelwidth, outfitCategoryScroll.frame.size.height*7);
    scrollcontain.backgroundColor = [UIColor blackColor];
    scrollcontain.clipsToBounds = YES;
    
    clipview.frame = CGRectMake(220, 170, catlabelwidth, outfitCategoryScroll.frame.size.height*7);
    [self.view bringSubviewToFront:clipview];
    clipview.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    currentcatlabel = [[UILabel alloc] init];
    
    
    if([myCloset.outfitCategories count] > 0)
    {
        currentcatlabel.text = [myCloset.outfitCategories objectAtIndex:0];
    }


    [self loadVerticalArchiveInViewInScroll:outfitCategoryScroll];
    
    
    
    
    
    normaloutfitwidth = outfitsScroll.frame.size.width/2.2;
    normaloutfitheight = outfitsScroll.frame.size.height/2;
    normaloutfitwidthspacing = outfitsScroll.frame.size.width/2.1;
    normaloutfitheightspacing = outfitsScroll.frame.size.height/2.1;
    
    
    [self loadArchive];
    
    
    addOutfitButton = [[UIButton alloc] initWithFrame:CGRectMake(224, 113, 36, 36)];
    UIImage *add = [UIImage imageNamed:@"add.jpg"];
    UIImage *addpressed = [UIImage imageNamed:@"addpressed.jpg"];
    
    
    
    [addOutfitButton setImage:add forState:UIControlStateNormal];
    
    [addOutfitButton setImage:addpressed forState:UIControlStateHighlighted];
    
    [addOutfitButton addTarget:self action:@selector(loadOutfitSelector) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addOutfitButton];
    
    [addOutfitButton setHidden:TRUE];
    calendarViewButton.tag = 98766;
    
    NSLog(@"OCS count is %i", (int)[outfitCategoryScroll.subviews count]);
    
 
}






-(BOOL) doesViewAlreadyExist: (int) findviewtag
{
    for(int x = 0; x < [self.view.subviews count]; ++x)
    {
        UIView *tempview = [self.view.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return TRUE;
        }
        
    }
    return FALSE;
}



-(void) textFieldShouldReturn:(UITextField *)textField
{

    
    if(textField.superview.tag == 38)
    {
        NSLog(@"adding new category");
        
        
        NSLog(@"%@", textField.text);
        
        
        if ([textField.text compare:@""] == NSOrderedSame) //need to change to any number of blanks
        {
            
        }
        else [self addNewOutfitCategory:textField.text];
        
        [textField.superview removeFromSuperview];
        [self reactivateAllInView:self.view];
        
    }

    
    [textField resignFirstResponder];
}











-(UIView *) retrieveView: (int) findviewtag
{
    for(int x = 0; x < [self.view.subviews count]; ++x)
    {
        UIView *tempview = [self.view.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return tempview;
        }
        
    }
    return nil;
}


-(void) deactivateAllInView: (UIView *) view except: (int) y
{
    
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        
        
        if (tempview.tag != y)
        {
            
            tempview.userInteractionEnabled = NO;
        }
        
    }
}


-(void) reactivateAllInView: (UIView *) view
{
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        
        if (tempview.tag != x)
            tempview.userInteractionEnabled = YES;
        
    }
}


-(IBAction) addNewOutfitCategoryCallUp
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 100;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *enterCategoryNameView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 125)];
        
        enterCategoryNameView.backgroundColor = [UIColor whiteColor];
        
        
        enterCategoryNameView.tag = 38;
        
        enterCategoryNameView.layer.borderColor = [[UIColor grayColor] CGColor];
        enterCategoryNameView.layer.borderWidth = 2;
    
        
        
        
        
        
        [self.view addSubview:enterCategoryNameView];
        
        UILabel *addcatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        addcatLabel.text = @"NEW CATEGORY";
        addcatLabel.textAlignment = UITextAlignmentCenter;
        addcatLabel.textColor = [UIColor whiteColor];
        addcatLabel.backgroundColor = [UIColor blackColor];
        addcatLabel.font = [UIFont fontWithName:@"Futura" size:22];
        
        [enterCategoryNameView addSubview:addcatLabel];
        
        
        UITextField *newcategoryfield = [[UITextField alloc] initWithFrame:CGRectMake(25, 60, 150, 40)];
        newcategoryfield.backgroundColor = [UIColor whiteColor];
        newcategoryfield.font = [UIFont fontWithName:@"Futura" size:16];
        newcategoryfield.userInteractionEnabled = YES;
        newcategoryfield.borderStyle = UITextBorderStyleRoundedRect;
        newcategoryfield.delegate = self;
        
        [enterCategoryNameView addSubview:newcategoryfield];
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}


/*
 -(IBAction) alertDelete
 {
 
 [self setCurrentRackLabel];
 
 if (currentLabelInScroll.tag == 999)
 {
 
 
 if([self doesViewAlreadyExist:38] == NO)
 {
 
 
 int originX = self.view.frame.size.width/2 - 125;
 int originY = self.view.frame.size.height/2 - 125;
 
 
 
 UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 125)];
 
 alertView.backgroundColor = [UIColor whiteColor];
 
 
 alertView.tag = 38;
 
 alertView.layer.borderColor = [[UIColor blackColor] CGColor];
 alertView.layer.borderWidth = 2;
 
 
 
 [self.view addSubview:alertView];
 
 UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 50)];
 alertLabel.numberOfLines = 0;
 
 
 NSString *currentcatname = [self getCurrentCategory];
 NSString *deletetypestring = [NSString stringWithFormat:@"Remove %@? ", currentracklabel.text, currentcatname];
 
 
 alertLabel.text = deletetypestring;
 alertLabel.textColor = [UIColor blackColor];
 alertLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
 alertLabel.textAlignment = UITextAlignmentCenter;
 
 [alertView addSubview:alertLabel];
 
 
 
 UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
 UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
 
 UIImage *no = [UIImage imageNamed:@"no.jpg"];
 UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
 
 UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 yesButton.frame = CGRectMake(65, 70, 54, 36);
 yesButton.tag=66;
 
 [yesButton setImage:yes forState:UIControlStateNormal];
 [yesButton setImage:yespressed forState:UIControlStateHighlighted];
 
 [yesButton addTarget:self action:@selector(deleteRack) forControlEvents:UIControlEventTouchUpInside];
 
 UIButton *noButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 noButton.frame = CGRectMake(131, 70, 54, 36);
 
 
 noButton.tag= 77;
 [noButton setImage:no forState:UIControlStateNormal];
 [noButton setImage:nopressed forState:UIControlStateHighlighted];
 
 [noButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
 
 
 [alertView addSubview:yesButton];
 [alertView addSubview:noButton];
 
 [self deactivateAllInView:self.view except:38];
 
 }
 else
 {
 NSLog(@"38 already there!");
 
 }
 
 }
 }*/

-(IBAction) removeOutfitCategoryCallUp
{
    
    [self getCurrentCat];
    
    if (currentLabelInScroll.tag == 999)
    {
        
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *removeCategoryView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 125)];
        
        removeCategoryView.backgroundColor = [UIColor whiteColor];
        
        
        removeCategoryView.tag = 38;
        
        removeCategoryView.layer.borderColor = [[UIColor blackColor] CGColor];
        removeCategoryView.layer.borderWidth = 2;
        
        removeCategoryView.layer.cornerRadius = 5;
        
        
        
        [self.view addSubview:removeCategoryView];
        
        UILabel *removecatLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 50)];
        
        NSString *removequery = [NSString stringWithFormat:@"Remove %@?", currentcatlabel.text];
        removecatLabel.text = removequery;
        removecatLabel.textAlignment= UITextAlignmentCenter;
        removecatLabel.textColor = [UIColor blackColor];
        removecatLabel.font = [UIFont fontWithName:@"Futura" size:16];
        
        [removeCategoryView addSubview:removecatLabel];
        
        
        
        UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
        UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
        
        UIImage *no = [UIImage imageNamed:@"no.jpg"];
        UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
        
        UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 70, 54, 36)];
        yesButton.tag=66;
        
        [yesButton setImage:yes forState:UIControlStateNormal];
        [yesButton setImage:yespressed forState:UIControlStateHighlighted];
        
        [yesButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(131, 70, 54, 36)];
        
        
        noButton.tag= 77;
        [noButton setImage:no forState:UIControlStateNormal];
        [noButton setImage:nopressed forState:UIControlStateHighlighted];
        
        [noButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [removeCategoryView addSubview:yesButton];
        [removeCategoryView addSubview:noButton];
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    }
    
}









-(void) addNewOutfitCategory: (NSString *)name
{
    if(!myCloset.outfitCategories)
    {
        myCloset.outfitCategories = [[NSMutableArray alloc] init];
    }
    
    
    
    BOOL catexists = FALSE;
    
    for(int x = 0; x<[myCloset.outfitCategories count]; x++)
    {
        NSString *tempcat = [myCloset.outfitCategories objectAtIndex:x];
        if([tempcat compare:name] == NSOrderedSame)
        {
            NSLog(@"cat already exists!");
            catexists = TRUE;
        }
    }
    
    if(!catexists)
    {
    
        [myCloset.outfitCategories addObject:name];
        [myCloset sortStringArray:myCloset.outfitCategories];
    
        NSLog(@"%@ added to category", name);
        
        if([NSKeyedArchiver archiveRootObject:myCloset toFile:pathcloset] == YES)
        {
            NSLog(@"ARCHIVING CLOSET new outfit category SUCCESSFUL");
        }
    
    
        [self clearScrollView:outfitCategoryScroll];
    
        [self loadVerticalArchiveInViewInScroll:outfitCategoryScroll];
        [self loadArchive];
        
        
    }
}




-(void) alertShare
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 100;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 100)];
        
        shareView.backgroundColor = [UIColor whiteColor];
        
        
        shareView.tag = 38;
        
        shareView.layer.borderColor = [[UIColor blackColor] CGColor];
        shareView.layer.borderWidth = 2;
      
        
        
        
        
        [self.view addSubview:shareView];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 150, 20)];
        shareLabel.text = @"Include a message with your outfit?";
        shareLabel.textColor = [UIColor blackColor];
        shareLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [shareView addSubview:shareLabel];
        
        
        
        UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
        UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
        
        UIImage *no = [UIImage imageNamed:@"no.jpg"];
        UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
        
        UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 55, 54, 36)];
        yesButton.tag=66;
        
        [yesButton setImage:yes forState:UIControlStateNormal];
        [yesButton setImage:yespressed forState:UIControlStateHighlighted];
        
        [yesButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(106, 55, 54, 36)];
        
        
        noButton.tag= 77;
        [noButton setImage:no forState:UIControlStateNormal];
        [noButton setImage:nopressed forState:UIControlStateHighlighted];
        
        [noButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [shareView addSubview:yesButton];
        [shareView addSubview:noButton];
        
        
      //  UITextField *messagefield = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 100, 25)];
      //  messagefield.backgroundColor = [UIColor whiteColor];
       // messagefield.userInteractionEnabled = YES;
       // messagefield.borderStyle = UITextBorderStyleRoundedRect;
        //messagefield.delegate = self;
        
        //[shareView addSubview:messagefield];
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}






TKCalendarMonthView *calendar;


// Show/Hide the calendar by sliding it down/up from the top of the device.
- (void)toggleCalendar {
	// If calendar is off the screen, show it, else hide it (both with animations)
    
     [self clearViewInScroll:viewInScrollOutfits];
    
    [addOutfitButton setHidden:TRUE];
    
    
    if(calremove == FALSE)
    {
        
        [calendarViewButton setSelected:YES];
        calendar = 	[[TKCalendarMonthView alloc] init];
        calendar.delegate = self;
        calendar.dataSource = self;
        // Add Calendar to just off the top of the screen so it can later slide down
        calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset+800, calendar.frame.size.width, calendar.frame.size.height);
        // Ensure this is the last "addSubview" because the calendar must be the top most view layer	
        [self.view addSubview:calendar];
        [calendar reload];
        
        [self clearViewInScroll:viewInScrollOutfits];
        
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, 215, calendar.frame.size.width, calendar.frame.size.height);
        
        
        
        
        
        outfitsScroll.frame = CGRectMake(0, 20, 200,200);
        
    
		[UIView commitAnimations];
        
      
        
     
        [outfitCategoryLabel setHidden:TRUE];
        [scrollcontain setHidden:TRUE];
        [clipview setHidden:TRUE];
        
        
      
        //set user interaction off!!!!!!!!!!!!!!!!!!!!!!!!!!!! ???
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
        
        [comp setHour:8];
        NSDate *newtoday = [gregorian dateFromComponents:comp];
        
        currentSelectedDate = newtoday;
    
        NSLog(@"toggle calendar %@", newtoday);

        [self loadOutfitsFromDate:newtoday];
       
        
  
        calremove = TRUE;
        
        
    }
    
    
    else if(calremove == TRUE)
    {
        
         [calendarViewButton setSelected:NO];
        NSLog(@"hide calendar");
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);		
        outfitsScroll.frame = CGRectMake(0, 20, 200, 480);
        
        
		[UIView commitAnimations];
        [outfitCategoryLabel setHidden:FALSE];
        [scrollcontain setHidden:FALSE];
        [clipview setHidden:FALSE];

        calremove = FALSE;
        
    
        viewInScrollOutfits.addselectionmode = FALSE;
        
       
        
        [calendar removeFromSuperview];
        
        
        [self clearViewInScroll:viewInScrollOutfits];
        
        [self loadArchive];
        
	}	
    
    
    
}




#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods




- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
    
    NSLog(@"did select date: %@", d);
    
    currentSelectedDate = d;
    
    if(viewInScrollOutfits.addselectionmode == TRUE)
    {
        viewInScrollOutfits.addselectionmode = FALSE;
        
        [outfitCategoryLabel setHidden:TRUE];
        [scrollcontain setHidden:TRUE];
        [clipview setHidden:TRUE];
        
        
        [self clearViewInScroll:viewInScrollOutfits];
        
    
    }
    
    
    [addOutfitButton setHidden:FALSE];
    
    //add add item button
    
    
    
    
    [self loadOutfitsFromDate:d];
    

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
    
    for (int x = 0; x < [myCloset.dateRecords count]; x++)
    {
        DateRecord *temprecord = [myCloset.dateRecords objectAtIndex:x];
        NSDate *tempdate = temprecord.date;
    
        
        int daysToAdd = 1;
        NSDate *newDate1 = [tempdate dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd 00:00:00 +0000"];
        
        
        //NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        //[dateFormat setDateFormat:@"eee"];
        //[dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        NSString *stringFromDate = [formatter stringFromDate:newDate1];
        

        NSLog(@"date from DATE RECORDS from daterecordclass is %@", tempdate);
        NSLog(@"date from DATE RECORDS is %@", stringFromDate);
        
        [data addObject:stringFromDate]; //instead of adding stringfromdate
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









-(void) loadOutfitsFromDate: (NSDate *) loaddate
{
    
    NSLog(@"loading from %@!", loaddate);
    
    [self clearViewInScroll:viewInScrollOutfits];
    
    DateRecord *tempdaterecord;
    BOOL founddate = FALSE;
    
    for(int x = 0; x<[myCloset.dateRecords count]; x++)
    {
        tempdaterecord = [myCloset.dateRecords objectAtIndex:x];
        
        if([tempdaterecord.date compare:loaddate] == NSOrderedSame)
        {
            founddate = TRUE;
            NSLog(@"found date with clothes!");
            break;
        }
    }
    
    
    if(founddate == TRUE)
    {

        int matchingoutfitcount = 0;
        int yLabel = 0;
        int xmult = -1;
        
        

        for (int x = 0; x < [myCloset.outfitsArray count]; ++x)
        {
        
            OutfitRecord *retrieveOutfit = [myCloset.outfitsArray objectAtIndex:x];
        
            for(int y = 0; y < [tempdaterecord.outfitRefNumsArray count]; y++)
            {
            
                NSNumber *tempoutfitrefnum = [tempdaterecord.outfitRefNumsArray objectAtIndex:y];
            
            
                if([tempoutfitrefnum intValue] == retrieveOutfit.fileNumRef)
                {
                    xmult++;
                    if(matchingoutfitcount % 2 == 0)
                    {
                        
                        yLabel = 2;
                    }
                    
                    if(matchingoutfitcount % 2 == 1)
                    {
                        yLabel = -25;
                    }

                    NSLog(@"%@ contains outfit %i", tempdaterecord.date, [tempoutfitrefnum intValue]);
                    NSLog(@"loading %@ for this date", retrieveOutfit.imageFilePath); 
                    UIImage *retrieveOutfitImage = [UIImage imageWithContentsOfFile:retrieveOutfit.imageFilePath];
                    UIOutfitImageView *outfitImageView = [[UIOutfitImageView alloc] initWithImage:retrieveOutfitImage];
                
                    NSLog(@"outfit record filenumref %i", retrieveOutfit.fileNumRef);
                
                    outfitImageView.fileNumRef = retrieveOutfit.fileNumRef;
                    outfitImageView.boolcal = TRUE;
                
                    outfitImageView.frame = CGRectMake(
                                                   ((5+matchingoutfitcount * outfitsScroll.frame.size.width/2.4)+20),
                                                   5, 
                                                   outfitsScroll.frame.size.width/2.5, 
                                                   outfitsScroll.frame.size.height/1.1);
                
                
                
                
                    outfitImageView.contentMode = UIViewContentModeScaleAspectFit;
                    outfitImageView.userInteractionEnabled = YES;
                    viewInScrollOutfits.frame = CGRectMake(0, 0, outfitImageView.frame.origin.x + 120, outfitsScroll.frame.size.height);
                    
                    outfitImageView.backgroundColor = [UIColor clearColor];
                
                
                    [viewInScrollOutfits addSubview:outfitImageView];
                    
                    UILabel *nameLabelC;
                  
                    
                    if (xmult % 2 == 0)
                    {
                        NSLog(@"first one, %@, %i", retrieveOutfit.outfitName,matchingoutfitcount);
                        nameLabelC = [[UILabel alloc] initWithFrame:CGRectMake(outfitImageView.frame.origin.x-30, outfitImageView.frame.origin.y+yLabel, 160, 24)];
                        
                    }
                    else if (xmult % 2 == 1)
                    {
                         NSLog(@"second one, %@, %i", retrieveOutfit.outfitName, matchingoutfitcount);
                        nameLabelC = [[UILabel alloc] initWithFrame:CGRectMake(outfitImageView.frame.origin.x-30, outfitImageView.frame.origin.y+outfitImageView.frame.size.height+yLabel, 160, 24)];
                    }
                    
                    
                    nameLabelC.text = retrieveOutfit.outfitName;
                    nameLabelC.layer.cornerRadius = 5;
                    nameLabelC.backgroundColor = [UIColor blackColor];
                    nameLabelC.textColor = [UIColor whiteColor];
                    nameLabelC.textAlignment = UITextAlignmentCenter;
                    nameLabelC.numberOfLines = 0;
                    nameLabelC.tag = 1019;
                    nameLabelC.font = [UIFont fontWithName:@"Futura" size:14];
                    
                    [viewInScrollOutfits addSubview:nameLabelC];
                    
                    outfitsScroll.contentSize = CGSizeMake(viewInScrollOutfits.frame.size.width, outfitImageView.frame.size.height);
                
                    
                
                    ++matchingoutfitcount;
       
                    break;
     
                }
       
            }
        }
    
        archiveloaded = TRUE;
        
    }
    
    else if(founddate == FALSE)
    {
        NSLog(@"nothing in this date");

    }
    
    

}




-(void) loadOutfitSelector
{
    viewInScrollOutfits.addselectionmode = TRUE;
    
    [outfitCategoryLabel setHidden:FALSE];
    [addOutfitButton setHidden:TRUE];
    [scrollcontain setHidden:FALSE];
    [clipview setHidden:FALSE];

    [self clearViewInScroll:viewInScrollOutfits];
    
    [self loadArchive];
    
}

-(void) closeOutfitSelector
{
    viewInScrollOutfits.addselectionmode = FALSE;
    
    [outfitCategoryLabel setHidden:TRUE];
    [scrollcontain setHidden:TRUE];
    [clipview setHidden:TRUE];
    
    [self clearViewInScroll:viewInScrollOutfits];
    
    [self loadOutfitsFromDate:currentSelectedDate];
    
}






-(void) reloadOutfitBrowser
{
    [self clearScrollView:outfitCategoryScroll];
    [self clearViewInScroll:viewInScrollOutfits];
    
    normaloutfitwidth = outfitsScroll.frame.size.width/2.2;
    normaloutfitheight = outfitsScroll.frame.size.height/2;
    normaloutfitwidthspacing = outfitsScroll.frame.size.width/2.1;
    normaloutfitheightspacing = outfitsScroll.frame.size.height/2.1;
    
    [self loadVerticalArchiveInViewInScroll:outfitCategoryScroll];
    [self loadArchive];
}



-(void) loadVerticalArchiveInViewInScroll: (UIScrollView *) scrollview
{
    
   
    
    NSString *tempname;
NSLog(@"REACHED LOAD vertical before if statement");
    
    if ([myCloset.outfitCategories count]>0)
    {
        
        
        for(int x=0; x < [myCloset.outfitCategories count]; ++x)
        {
            CGFloat yOrigin = ([scrollview.subviews count]) * (catlabelheight + 10);
            
           
            tempname = [myCloset.outfitCategories objectAtIndex:x];
            
            NSLog(@"outfit category is %@", tempname);
            
            UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, catlabelwidth, catlabelheight)];
            UILabel *templabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, catlabelwidth, catlabelheight)];
            
            
            tempview.tag = 999;
            templabel.tag = 888;
            
            
            templabel.text = tempname;
               templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
            templabel.textColor = [UIColor lightGrayColor];
            templabel.backgroundColor = [UIColor blackColor];
            
            
            
            if (x == 0) {
               
                NSLog(@"first will be pink!!");
                templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:20];
                templabel.textColor = [UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1];
                   
            }
            
            [tempview addSubview:templabel];
            [scrollview addSubview:tempview];
            
            NSLog(@"views in categoryscroll are %i", [scrollview.subviews count]);
            
            scrollview.frame = CGRectMake(0, 0, catlabelwidth, ((catlabelheight+10)));
          
          
            scrollview.contentSize = CGSizeMake(catlabelwidth, ([scrollview.subviews count]) * (catlabelheight+10));
            
      
        }
    }
   
    [self getCurrentCat];
   
    
    
    [self loadImagesInOutfitsScroll];
}





-(void)clearScrollView: (UIView *) scrolltoclear
{
    int scrollcount = [scrolltoclear.subviews count];
    
    for(int x=0; x < scrollcount; ++x)
    {
        UIImageView *removescrollitem = [scrolltoclear.subviews objectAtIndex:0];
        [removescrollitem removeFromSuperview];
        NSLog(@"CLEARED SCROLL");
    }
}

int offset;
int height;

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    NSLog(@"scrolling");
    if (scrollView.tag == 20000)
    {
        [self getCurrentCat];
    }
}




-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    offset = (int) scrollView.contentOffset.y;
    height = (int) scrollView.frame.size.height;
    NSLog(@"end decelerate");
    if (scrollView.tag == 20000)
    {
        NSLog(@"ended scrolling");
        
        NSLog(@"offset %i", offset);
        
        if(offset%height == 0 || offset == 0)
        { [self loadImagesInOutfitsScroll];}
        
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    offset = (int) scrollView.contentOffset.y;
    height = (int) scrollView.frame.size.height;
    NSLog(@"end decelerate");
    if (scrollView.tag == 20000)
    {
        NSLog(@"ended scrolling");
     
        NSLog(@"offset %i", offset);
        
        if(offset%height == 0 || offset == 0)
        { [self loadImagesInOutfitsScroll];}
       
        
    }
}


-(void) getCurrentCat
{
    [self reactivateAllInView:self.view];
    
    CGPoint centerScrollPoint = CGPointMake(outfitCategoryScroll.frame.origin.x+  outfitCategoryScroll.frame.size.width/2, 
                                            12);
    
    
    currentLabelInScroll = [outfitCategoryScroll.superview hitTest:centerScrollPoint withEvent:nil];
    
    
    if ([currentLabelInScroll isKindOfClass:[UIView class]] && currentLabelInScroll.tag == 999)
    {   
        currentcatlabel = [currentLabelInScroll.subviews objectAtIndex:0];
        
        NSLog(@"getCurrentCat Call: label at center reads %@", currentcatlabel.text);
    }
    else NSLog(@"just what %@",currentcatlabel.text);
    
    
    for(int x = 0; x < [outfitCategoryScroll.subviews count]; ++x)
    {
        NSLog(@"in loop, OCS count is %i", (int)[outfitCategoryScroll.subviews count]);//why does this end up being 1 more than it should be? so need to check for subview of label below, else throws error
        
        UIView *tempview = [outfitCategoryScroll.subviews objectAtIndex:x];
        
        if([tempview.subviews count] >0)
        {
        
            UILabel *templabel = [tempview.subviews objectAtIndex:0];
            templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
            templabel.textColor = [UIColor lightGrayColor];
        }
    }
    NSLog(@"out of loops");
    
    
    currentcatlabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:20];
    currentcatlabel.textColor = [UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1];
    
    
}


-(void)loadImagesInOutfitsScroll
{
  
        if(!([currentcatlabel.text compare:outfitsScroll.loadedcatname] == NSOrderedSame) || archiveloaded == NO)
        {
            [self outfitsScrollLoader];
            
         
            if(currentcatlabel.text)
            {
                outfitsScroll.loadedcatname = [NSString stringWithString: currentcatlabel.text];
            }
            NSLog(@"current cat in tile scroll is %@", outfitsScroll.loadedcatname);
        }
    
    NSLog(@"getting current cat");
    [self getCurrentCat];
   

}


-(void) outfitsScrollLoader
{
    NSLog(@"outsscrollloader called");
    
    NSLog(@"current rack in tile scroll is %@", outfitsScroll.loadedcatname);
    

    outfitsScroll.scrollEnabled = YES;

    NSLog(@"current rack in tile scroll is %@, %@", outfitsScroll.loadedcatname, currentcatlabel.text);
            
    if([outfitsScroll.loadedcatname compare:currentcatlabel.text] == NSOrderedSame &&
               [viewInScrollOutfits.subviews count] != 0)
        {
                NSLog(@"doing nothing");
        }
    else
        {
            NSLog(@"loading the right outfits ********");
            [self loadArchive];
        }

}


-(void)clearViewInScroll: (UIViewInScroll *) scrolltoclear;
{
    
    if(archiveloaded)
    {
        int scrollcount = [scrolltoclear.subviews count];
        
        for(int x=0; x < scrollcount; ++x)
        {
            UIImageView *removescrollitem = [scrolltoclear.subviews objectAtIndex:0];
            [removescrollitem removeFromSuperview];
        }
    
        NSLog(@"CLEARED SCROLL");
    }
    
    archiveloaded = NO;
    
}




-(void) loadArchive
{
    
    UILabel *nameLabel;
    
    
    if(archiveloaded)
    {
        [self clearScrollView:viewInScrollOutfits];
    }
    
    int ymult = -1;
    int xmult = 0;
    
    int matchingoutfitcount = 0;
    
    for (int x = 0; x < [myCloset.outfitsArray count]; ++x)
    {

    
        NSLog(@"checking outfit at index %i in outfitsarray", x);
        
        OutfitRecord *retrieveOutfit = [myCloset.outfitsArray objectAtIndex:x];
        
        BOOL matchingCategory = FALSE;
        
        NSLog(@"num cats in outfit is %i", (int)[retrieveOutfit.categories count]);
        NSLog(@"num dates in outfit is %i", (int)[retrieveOutfit.dates count]);
    
        for(NSString * category in retrieveOutfit.categories)
        {
            NSLog(@"outfit category is %@", category);
            
            if([category compare:currentcatlabel.text] == NSOrderedSame){
                
                matchingCategory = TRUE;
                NSLog(@"matched outfitcat");
            }
        }
        
        
        if(matchingCategory)
        {
            
            
            if(matchingoutfitcount % 2 == 0)
            {
                xmult = 0;
                ++ymult;
            }
            
            if(matchingoutfitcount % 2 == 1)
            {
                xmult = 1;
            }
            
            ++matchingoutfitcount;
            
            
            NSLog(@"try loading %@", retrieveOutfit.imageFilePathThumb);
            UIImage *retrieveOutfitImage = [UIImage imageWithContentsOfFile:retrieveOutfit.imageFilePathThumb];
            UIOutfitImageView *outfitImageView = [[UIOutfitImageView alloc] initWithImage:retrieveOutfitImage];
            
            
        
            NSLog(@"outfit record filenumref %i", retrieveOutfit.fileNumRef);
        
            outfitImageView.fileNumRef = retrieveOutfit.fileNumRef;
            outfitImageView.boolcal = FALSE;
            
            NSLog(@"loading %i for addmode", outfitImageView.fileNumRef);
          
            
            
            outfitImageView.frame = CGRectMake(
                                           (7+ xmult * normaloutfitwidthspacing), 
                                           ymult * normaloutfitheightspacing, 
                                           normaloutfitwidth, 
                                           normaloutfitheight);
            
            outfitImageView.backgroundColor = [UIColor redColor];
            
            
           if (xmult == 0)
            {
                nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, outfitImageView.frame.origin.y+10, 160, 24)];
                
            }
            else if (xmult == 1)
            {
                nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, outfitImageView.frame.origin.y+outfitImageView.frame.size.height-34, 160, 24)];
            }
            
            
            
            
            if(viewInScrollOutfits.addselectionmode == TRUE)
            {
                outfitImageView.frame = CGRectMake(
                                                   (5+xmult * outfitsScroll.frame.size.width/2.4),
                                                   ymult * (outfitsScroll.frame.size.height/1.1)+12,
                                                   outfitsScroll.frame.size.width/2.5,
                                                   outfitsScroll.frame.size.height/1.1);
                
                if (xmult == 0)
                {
                    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, outfitImageView.frame.origin.y, 160, 24)];
                    
                }
                else if (xmult == 1)
                {
                    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, outfitImageView.frame.origin.y+outfitImageView.frame.size.height-25, 160, 24)];
                }
                
                
            }
            
            
            
            nameLabel.layer.cornerRadius = 5;
            nameLabel.text = retrieveOutfit.outfitName;
            nameLabel.backgroundColor = [UIColor blackColor];
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.textAlignment = UITextAlignmentCenter;
            nameLabel.numberOfLines = 0;
            nameLabel.tag = 1019;
            nameLabel.font = [UIFont fontWithName:@"Futura" size:14];
            
        
            
        
            outfitImageView.contentMode = UIViewContentModeScaleAspectFit;
            outfitImageView.userInteractionEnabled = YES;
            
            viewInScrollOutfits.frame = CGRectMake(0, -64, outfitsScroll.frame.size.width, (ymult+1) * (outfitImageView.frame.size.height+20));
            outfitImageView.backgroundColor = [UIColor clearColor];
        
            [viewInScrollOutfits addSubview:outfitImageView];
           
            [viewInScrollOutfits addSubview:nameLabel];
            
            
        
            outfitsScroll.contentSize = CGSizeMake(outfitsScroll.frame.size.width, (ymult+1) * (outfitImageView.frame.size.height+20));
        }
        
    }
    
    archiveloaded = YES;
    
    for (int x = 0; x < [myCloset.outfitsArray count]; ++x)
    {
        
        OutfitRecord *retrieveOutfit = [myCloset.outfitsArray objectAtIndex:x];
        
        NSLog(@"all cats, outfit %i listed", retrieveOutfit.fileNumRef);
    }
    
    
}







-(ImageRecord *) retrieveRecordNum:(int) recordnum FromCatName: (NSString *) catname RackName:(NSString *)rackname
{
    
    for(int z = 0; z < [myCloset.categories count]; z++)
    {
         Category *tempcategory = [myCloset.categories objectAtIndex:z];
        
         if ([tempcategory.categoryname compare:catname] == NSOrderedSame)
         {
             
             NSLog(@"%@ is found!", tempcategory.categoryname);
             
             
             for(int x = 0; x <[tempcategory.racksarray count]; x++)
             {
                 Rack * temprack = [tempcategory.racksarray objectAtIndex:x];
                 
                 if ([temprack.rackname compare:rackname] == NSOrderedSame)
                 {
                     
                      NSLog(@"%@ is found!", temprack.rackname);
                     for(int y = 0; y <[temprack.rackitemsarray count]; y++)
                     {
                         ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:y];
                         
                          NSLog(@"check %i", temprecord.fileNumRef);
                         if (temprecord.fileNumRef == recordnum)
                         {
                             NSLog(@"%i is found!", temprecord.fileNumRef);
                             return temprecord;
                         }
                     }
                 }
                 
                 
             }

             
         }
        
        
    }
    return  nil;
}


-(void)deleteOutfitNum:(int)x
{
    
}

-(void) deleteOutfitCategory: (UIButton *) sender
{
    
    if(sender.tag == 66)
    {
        
        [self getCurrentCat];
        
        
        for(int x = 0; x<[myCloset.outfitCategories count]; x++)
        {
            
            NSString *tempcat = [myCloset.outfitCategories objectAtIndex:x];
            
            if ([currentcatlabel.text compare:tempcat] == NSOrderedSame)
            {
                
                
                NSLog(@"will delete %@", tempcat);
                [self deleteOutfitCategoryComplete:currentcatlabel.text];
                
               
                [myCloset.outfitCategories removeObjectAtIndex:x];
                
               
                
                break;
                
            }
        }
        
        
        [myCloset saveClosetArchive];
        
        [self clearScrollView:outfitCategoryScroll];
        [self loadVerticalArchiveInViewInScroll:outfitCategoryScroll];
        [self loadArchive];
        
    }
    
    [sender.superview removeFromSuperview];
    [self reactivateAllInView:self.view];
    
}


-(void)deleteOutfitCategoryComplete:(NSString *) deletecat
{
    
    
    

    //pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //pathcloset = [pathhome stringByAppendingPathComponent:@"closet.arch"];
    
    
    
    for (int x = 0; x<[myCloset.outfitsArray count]; ++x)
    {
        OutfitRecord * outfitRetrieve = [myCloset.outfitsArray objectAtIndex:x];
        
        
        if([outfitRetrieve.outfitCategory compare:deletecat] == NSOrderedSame)
        {
            [mixerController deleteFile:outfitRetrieve.imageFilePath];
            [mixerController deleteFile:outfitRetrieve.imageFilePathThumb];
            
            //delete from calendar dates
            
            
            [myCloset removeOutfitNum:outfitRetrieve.fileNumRef fromDates:outfitRetrieve.dates];
            
            
            //finish delete from calender dates
            
            
            [myCloset.outfitsArray removeObjectAtIndex:x];
            
            x--;
        }
        
    }
    
    //the following not necessary if outfview not fullscreen??? 
    
    
    
    //[mixerController.outfitBrowserController loadArchive];
    
}







-(void) deleteAllOutfitsOfCategory: (NSString *) catname
{
    for (int x = 0; x<[myCloset.outfitsArray count]; ++x)
    {
        OutfitRecord *outfitRetrieve = [myCloset.outfitsArray objectAtIndex:x];
        
        if([outfitRetrieve.outfitCategory compare:catname] == NSOrderedSame)
        {
            
            [mixerController deleteFile:outfitRetrieve.imageFilePath];
            
            //delete from calendar dates
            
            [myCloset removeOutfitNum:outfitRetrieve.fileNumRef fromDates:outfitRetrieve.dates];
            
            [myCloset.outfitsArray removeObjectAtIndex:x];
        }
    }
}


-(IBAction) goBack
{
    calremove = FALSE;
    [self dismissModalViewControllerAnimated:YES];
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)unwindFromModalViewController:(UIStoryboardSegue *)segue
{

    NSLog(@"unwinded from edit outfit");
    ItemViewController *outfitViewController = segue.sourceViewController;
    
    self.editMade = outfitViewController.editMade;
    if(editMade){
         [self loadArchive];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self reloadOutfitBrowser];
    
    
    if(editMade){
        NSLog(@"edit made");
        [self loadArchive];
    }
    
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
