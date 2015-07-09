//
//  MixerController.m 1.3.3 new
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MixerController.h"
#import "UIImage+Scale.h"
#import "UIScrollImageView.h"
#import "UIOutfitView.h"
#import "UIViewInScroll.h"
#import "ImageRecord.h"
#import "OutfitRecord.h"

#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "OrganizerController.h"
#import "HelpController.h"

#import "DateRecord.h"
//#import "SSZipArchive/SSZipArchive.h"
#import "ZipArchive/ZipArchive.h"
#import "MainViewController.h"
#import "FilterController.h"
#import "OutfitDetailController.h"



@implementation MixerController

@synthesize outfitView,scrollTops, scrollDisplayTops, scrollShoes, scrollDisplayShoes, scrollBottoms, scrollDisplayBottoms, createButton, outfitDisplay, outfitBrowserController, organizerController, myCloset, reloadarchives, filterTopButton, filterLowerButton, filterRightButton,fashionfeedController, currentUser, pathuserfull, sortedCountryArray, activecountriesloaded, helpButton, firstuse, pathcloset, myLoadIndicator, domain, whitebar1, whitebar2, loadOutterwearButton,scrollDisplayTopsOverlay, scrollTopsOverlay, menuView, menuButton, scrollAccessories, accessoriesButton, filterAccessoriesButton, filterTopOverlayButton, menuSecondButton, menuSecondView, topChanged, topOverlayChanged, rightChanged, lowerChanged, accessoriesChanged, backDropOn, backDropView, exclamation, topbar, bottombar, closetRestored, geniusMode, geniusButton;



                                            //VARIABLE AND OBJECT DEFINITIONS
static int calendarShadowOffset = (int)-20;


UIViewInScroll *viewInScrollTopsOverlay;
UIViewInScroll *viewInScrollAccessories;

UIViewInScroll *viewInScrollTops;
UIViewInScroll *viewInScrollBottoms;
UIViewInScroll *viewInScrollShoes;

ImageRecord *newRecord;


NSString *fileToDisplay;
NSString *pathhome;
NSString *pathtops;
NSString *pathbottoms;
NSString *pathshoes;
NSString *pathoutfits;
NSString *pathoutfitcategories;


NSString *pathlastimagenum;
NSString *pathlasttopcatnum;
NSString *pathlasttopoverlaycatnum;
NSString *pathlastrightcatnum;
NSString *pathlastlowercatnum;


NSString *searchtagtop;
NSString *searchtaglower;
NSString *searchtagright;
NSString *searchtagtopoverlay;
NSString *searchtagaccessories;


UITextView *searchtagfieldtop;
UITextView *searchtagfieldtopoverlay;
UITextView *searchtagfieldlower;
UITextView *searchtagfieldright;
UITextView *searchtagfieldaccessories;

NSNumber *lastImageNumArch;
NSNumber *lastTopCategoryNum;
NSNumber *lastTopOverlayCategoryNum;
NSNumber *lastRightCategoryNum;
NSNumber *lastLowerCategoryNum;





static int imageFileNum;
int outfitViewType;  // 0 = tbs, 1 = ts, 2=otbs 3=ots

float scrollimagewidth;
float scrollimageheight;
float windowwidth;
float windowheight;
float labelheight;
float labelwidth;




OrganizerController *organizercontroller;



int currentcategorytopscroll, currentcategorylowerscroll, currentcategoryrightscroll, currentcategorytopoverlayscroll, currentcategoryaccessoriesscroll;

NSString *currenttopscrollcatname;
NSString *currenttopoverlayscrollcatname;
NSString *currentlowerscrollcatname;
NSString *currentrightscrollcatname;

NSString *currenttopscrollrackname;
NSString *currenttopoverlayscrollrackname;
NSString *currentlowerscrollrackname;
NSString *currentrightscrollrackname;

NSString *newOutfitNameSet;

BOOL startBackup;
BOOL topshoemode;
BOOL topbottommode;
BOOL topbottomshoemode;
BOOL overlayOn;
BOOL overlayOnMode;
BOOL menuOn;
BOOL menuSecondOn;
BOOL accessoriesOn;
BOOL didshiftpw;


BOOL savedtopandfilter;
BOOL savedtopoverlayandfilter;
BOOL savedaccessoriesandfilter;
BOOL savedlowerandfilter;
BOOL savedrightandfilter;

BOOL existing;
BOOL skip;
BOOL calremove;

BOOL modeChange;

BOOL isTopOpen;
BOOL isTopOverlayOpen;
BOOL isRightOpen;
BOOL isLowerOpen;
BOOL isAccessoriesOpen;
BOOL assignDate;

BOOL outfitNameEditOn;


BOOL shouldTransfer;

BOOL closetRestored;

BOOL geniusMode;

UIButton *topAndButton;
UIButton *topOrButton;

UIButton *lowerAndButton;
UIButton *lowerOrButton;

UIButton *rightAndButton;
UIButton *rightOrButton;





NSMutableArray *outfitModesArray;



CGRect topsDisplayFrame;
CGRect topsDisplayFrameWithOverlay;
CGRect bottomsDisplayFrame;

CGRect topsDisplayFrameLarge;
CGRect topsDisplayFrameDressWithOverlay;

CGRect topsOverlayDisplayFrame;
CGRect topsOverlayDisplayWithDress;
CGRect shoesDisplayFrameShiftedWithDress;

CGRect bottomsDisplayFrameHalf;
CGRect shoesDisplayFrame;
CGRect shoesDisplayFrameShifted;

CGRect topsDisplayFrameHalf;
                       
//END VARIABLE AND OBJECT DEFINITIONS

UIView *centerViewInScroll;

UIView *topFilterView;
UIView *topOverlayFilterView;
UIView *rightFilterView;
UIView *lowerFilterView;
UIView *accessoriesFilterView;




User *user1;
User *user2;
NSMutableArray *users;

UIView *newUserView;
UILabel *signup;
UILabel *signuppw;
UILabel *signuppwr;
UIButton *signupNextButton;
UIButton *signupPrevButton;


UIPickerView *outfitCategoryPicker;
UITextField *outfitNameField;

MainViewController *mainViewController;



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    if ([segue.destinationViewController isKindOfClass:[OutfitDetailController class]]) {
        
        NSLog(@"going to outfit detail controller from mixer");
        
        OutfitDetailController *outfitDetailController = segue.destinationViewController;
        
        
        CGSize size = [outfitView bounds].size;
        
        UIGraphicsBeginImageContextWithOptions(size, outfitView.opaque, 3);
        
        [outfitView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        newOutfitImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        UIGraphicsBeginImageContextWithOptions(size, outfitView.opaque, 2);
        
        //[outfitView addSubview:verifyBar];
        
        [outfitView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        newOutfitImageThumb = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        //[verifyBar removeFromSuperview];
        
        outfitDetailController.outfitImage = newOutfitImage;
        
        outfitDetailController.mixerController = self;
       
    }
    
    
    if ([segue.destinationViewController isKindOfClass:[OutfitDetailController class]]) {
        
        
        OutfitDetailController *outfitBrowserController = segue.destinationViewController;
        
        outfitBrowserController.mixerController = self;
      
        
    }

}












                    
//START VIEWCONTROLLER INITIALIZATIONS
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
}

#pragma mark - View lifecycle


-(void) checkForActivity
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //[myIndicator startAnimating];

    NSString *urlString = [NSString stringWithFormat:@"http://%@/checktracker.php", domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    NSString *requestBodyString = [NSString stringWithFormat:@"cuser=%@", currentUser.username];
    NSLog(@"%@", requestBodyString);
    
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
            
            //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            //[myIndicator stopAnimating];
            
            NSLog(@"something was downloaded");
            
            
            [self reactivateAllInView:self.view];
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            int z = [responseString intValue];
            
            NSLog(@"return string is %@", responseString);
            NSLog(@"return activity is %i", z);
            
            if (z > 0)
            {
                NSLog(@"make appear");
                [exclamation setHidden:NO];
            }
            
            
            
            
        }
        else if ([data length] == 0 && error == nil)
        {
            
    
            
            
            
        }
        else if (error != nil)
        {
            
       
            
        }
    }];
    
    
}




- (void)viewDidLoad
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    domain = @"closetfashions.net";
    firstuse = NO;
   
    startBackup = NO;
    topshoemode = NO;
    topbottommode = NO;
    topbottomshoemode = NO;
    overlayOn = NO;
    overlayOnMode = NO;
    menuOn = NO;
    menuSecondOn = NO;
    accessoriesOn = NO;
    didshiftpw = NO;
    
    
    savedtopandfilter = NO;
    savedtopoverlayandfilter = NO;
    savedaccessoriesandfilter = NO;
    savedlowerandfilter = NO;
    savedrightandfilter = NO;
    
    existing = NO;
    skip = NO;
    calremove = NO;
    
    modeChange = NO;
    
    isTopOpen = NO;
    isTopOverlayOpen = NO;
    isRightOpen = NO;
    isLowerOpen = NO;
    isAccessoriesOpen = NO;
    assignDate = NO;
    
    reloadarchives = YES;
    
    outfitNameEditOn = NO;
    shouldTransfer = NO;
    closetRestored = NO;
    geniusMode = NO;
    
    [super viewDidLoad];
    
    
    
    NSString *userpath;
    
    
    userpath = [NSString stringWithFormat:@"user.arch"];
    pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    pathuserfull = [pathhome stringByAppendingPathComponent:userpath];
    pathcloset = [pathhome stringByAppendingPathComponent:@"closet.arch"];
    
    
    
    if(!(currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:pathuserfull]) || [currentUser.username compare:@"unregistered"] == NSOrderedSame)
    {
        NSLog(@"starting new user signup");
        
        if(!(currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:pathuserfull]))
        {
            
            firstuse = YES;
            NSLog(@"allocating newuser");
            currentUser = [[User alloc] init];
            
        }
        else
        {
            firstuse = NO;
            NSLog(@"unregistered user present");
            
            myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathcloset];
            
            if([myCloset needToRectify] == YES)
            {
                [myCloset rectifyImagePaths];
                [myCloset saveClosetArchive];
            }
            else{
                NSLog(@"no need rectify");
            }
        }
        
        myLoadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        myLoadIndicator.center = CGPointMake(170, 15);
        myLoadIndicator.hidesWhenStopped = YES;
        [outfitDisplay addSubview:myLoadIndicator];
        
         [self startLoadAnimation];
        
        [self newUser];
        [self openCloset];
    }
    else
    {
        myLoadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        myLoadIndicator.center = CGPointMake(170, 15);
        myLoadIndicator.hidesWhenStopped = YES;
        [outfitDisplay addSubview:myLoadIndicator];
        
        [self startLoadAnimation];
    
        NSLog(@"old closetfile %@", currentUser.closetfile);
        
        NSString *userclosetpath = [NSString stringWithFormat:@"closet.arch"];
        
        currentUser.closetfile = userclosetpath;
        
        [NSKeyedArchiver archiveRootObject:currentUser toFile:pathuserfull];
        
        
        
        NSString *oldclosetfile = [NSString stringWithFormat:@"closet%@.arch", currentUser.username];
        NSString *oldpathcloset = [pathhome stringByAppendingPathComponent:oldclosetfile];
        
        //[self clearArchive];
        //[self clearUserInfo];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:oldpathcloset];
        
        if(fileExists)
        {
            NSLog(@"old closet exists!");
            myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:oldpathcloset];
            
            [myCloset addNewCategory:@"Outerwear"];
            
            [myCloset addNewCategory:@"Accessories"];
            
            
            [myCloset addNewRack:@"Necklace" toCatNum: 5];
            [myCloset addNewRack:@"Bracelet" toCatNum: 5];
            [myCloset addNewRack:@"Earrings" toCatNum: 5];
            [myCloset addNewRack:@"Scarf" toCatNum: 5];
            [myCloset addNewRack:@"Handbag" toCatNum: 5];
            
            
            [myCloset addNewRack:@"Jacket" toCatNum: 4];
            [myCloset addNewRack:@"Coat" toCatNum: 4];
            [myCloset addNewRack:@"Cardigan" toCatNum: 4];
            [myCloset addNewRack:@"Sweater" toCatNum: 4];
            
            
            [myCloset rectifyImagePaths];
            
            
            [self deleteFile:oldpathcloset];
        }
        
        
        myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathcloset];
        
        
        if([myCloset needToRectify] == YES)
        {
            [myCloset rectifyImagePaths];
            [myCloset saveClosetArchive];
        }
        else{
            NSLog(@"no need rectify");
        }
        
        
        
   
        
        [self openCloset];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loadCurrentUser) userInfo:nil repeats:NO];
       
    }
    
    if ([myCloset.categories count] < 6)
    {
        
        [myCloset addNewCategory:@"Backdrops"];
        
        
        
        [myCloset addNewRack:@"Professional" toCatNum: 6];
        [myCloset addNewRack:@"Simple" toCatNum: 6];
        [myCloset addNewRack:@"Playful" toCatNum: 6];
        
        [myCloset saveClosetArchive];
    }
    
    /*
    //UIImage *image = [UIImage imageNamed:@"MenuIcon"];
    CGRect frame = CGRectMake(0, 0, 40, 22);
    UIButton*filterButton = [[UIButton alloc] initWithFrame:frame];
    filterButton.frame = frame;
    [filterButton setTitle:@"Filter" forState:UIControlStateNormal];
    filterButton.backgroundColor = [UIColor blueColor];
  

    [filterButton setShowsTouchWhenHighlighted:YES];
    [filterButton addTarget:self action:@selector(toggleFilterMenu) forControlEvents:UIControlEventTouchDown];
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* openFilterButton = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    
    
    UIButton*saveButton = [[UIButton alloc] initWithFrame:frame];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setShowsTouchWhenHighlighted:YES];
    [saveButton addTarget:self action:@selector(saveOutfit) forControlEvents:UIControlEventTouchDown];
    saveButton.backgroundColor = [UIColor blueColor];
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* saveOutfitButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    UIBarButtonItem *negativeSpacerLarge = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacerLarge setWidth:85];

        
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:openFilterButton,negativeSpacerLarge,saveOutfitButton,nil];*/
        
    
    
    
}

-(void) saveOutfit
{
    NSLog(@"saving outfit");
}

-(void)loadCurrentUser
{
     [self loadWithUser:currentUser];
}


-(void) openCloset
{
    
    
    
    
    
     backDropView = [[UIImageView alloc] initWithFrame:outfitView.frame];
     backDropView.userInteractionEnabled = NO;
     [outfitView insertSubview:backDropView atIndex:0];
    
    [backDropView setImage:[UIImage imageNamed:@"offwhitebackground.png"]];
    
   
    //backDropView.backgroundColor = [UIColor blueColor];
    
    [filterTopButton removeFromSuperview];
    [self.view addSubview:filterTopButton];
    [filterLowerButton removeFromSuperview];
    [self.view addSubview:filterLowerButton];
    [filterRightButton removeFromSuperview];
    [self.view addSubview:filterRightButton];

    
    
    if(signUpSelect && currentUser.country == NULL && skip == NO)
    {
       
        [newUserView removeFromSuperview];
        [self.view addSubview:newUserView];
        [signUpSelect removeFromSuperview];
        [self.view addSubview:signUpSelect];
    }
    
    
   
    int headerstartY;
    int frameheight;
    
    UIImage *headerleft;
    
    if([[UIScreen mainScreen] bounds].size.height == 568){
        headerleft = [UIImage imageNamed:@"header.png"];
        headerstartY = 0;
        frameheight = 568;
    }
    else
    {
        headerleft = [UIImage imageNamed:@"header3inch.png"];
        headerstartY = 0;
        frameheight = 480;
    }
    
    NSLog(@"frame height is %f", self.view.frame.size.height);
    
    outfitDisplay.layer.borderWidth = 0;
    outfitDisplay.layer.borderColor = [[UIColor blackColor] CGColor];
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, headerstartY, 320, self.view.frame.size.height)];
       header.tag = 9001;
    
    header.backgroundColor = [UIColor whiteColor];
    

    
    header.backgroundColor = [UIColor colorWithPatternImage:headerleft];

    [self.view addSubview:header];
    
    
    //UILabel *header2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160, self.view.frame.size.height)];
       // header2.tag = 9001;
    
    //header2.backgroundColor = [UIColor colorWithPatternImage:headerright];
    
    //[self.view addSubview:header2];
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3];
    
   header.frame = CGRectMake(-320, headerstartY,320, self.view.frame.size.height);

    [UIView commitAnimations];
    
    organizerController = [[OrganizerController alloc] initWithNibName:@"OrganizerController" bundle:nil];
    
}


UITextField *usernamefield;
UITextField *pwfield;
UITextField *pwfieldr;
UIPickerView *countryPicker;
UIView *signUpSelect;

int currentcountryrow;
-(void) newUser
{
    
    if(currentUser.username == NULL || [currentUser.username compare:@"unregistered"] == NSOrderedSame)
    {
    
    //NSLog(@"fonts: %@", [UIFont familyNames]);
    
    newUserView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    newUserView.tag = 9000;
        newUserView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headersmall.png"]];
    
    [self.view addSubview:newUserView];
        
        
        
        //UIImage *header = [UIImage imageNamed:@"signupheader.png"];
        
        
        //UIImageView *headerview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        
        //headerview.image = header;
        
        //headerview.contentMode = UIViewContentModeScaleAspectFit;
        
        //[newUserView addSubview:headerview];
                
        
        signup = [[UILabel alloc] initWithFrame:CGRectMake(30, 85, 250, 50)];
        signup.text = @"Pick a username: \n (between 4 - 15 characters long)";
        signup.backgroundColor = [UIColor clearColor];
        signup.textAlignment = UITextAlignmentLeft;
        signup.numberOfLines = 0;
        signup.font = [UIFont fontWithName:@"Futura" size:14];
        signup.tag = 9002;
        
        signup.textColor = [UIColor blackColor];
        
        [newUserView addSubview:signup];
        
        usernamefield = [[UITextField alloc] initWithFrame:CGRectMake(150, 140, 125, 25)];
        
        usernamefield.backgroundColor = [UIColor whiteColor];
        usernamefield.font = [UIFont fontWithName:@"Futura" size:14];
        
        usernamefield.borderStyle = UITextBorderStyleRoundedRect;
        usernamefield.delegate = self;
        
        usernamefield.tag = 9003;
        [newUserView addSubview:usernamefield];
        
        signuppw = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 250, 50)];
        signuppw.textAlignment = UITextAlignmentLeft;
        signuppw.numberOfLines = 0;
        signuppw.tag = 1012;
        signuppw.text = @"Choose a password: \n (between 4 - 8 characters long)";
         signuppw.backgroundColor = [UIColor clearColor];
        signuppw.font = [UIFont fontWithName:@"Futura" size:14];
        signuppw.tag = 9004;
        signuppw.textColor = [UIColor blackColor];
       
        [newUserView addSubview:signuppw];
        
        pwfield = [[UITextField alloc] initWithFrame:CGRectMake(150, 225, 125, 25)];
        pwfield.backgroundColor = [UIColor whiteColor];
        pwfield.borderStyle = UITextBorderStyleRoundedRect;
        pwfield.font = [UIFont fontWithName:@"Futura" size:14];
        pwfield.delegate = self;
        pwfield.tag = 9005;
        pwfield.secureTextEntry = YES;
        [newUserView addSubview:pwfield];
        
        signuppwr = [[UILabel alloc] initWithFrame:CGRectMake(30, 265, 250, 25)];
        signuppwr.textAlignment = UITextAlignmentLeft;
        signuppwr.numberOfLines = 0;
        signuppwr.tag = 1012;
        signuppwr.text = @"Re-enter the password:";
         signuppwr.backgroundColor = [UIColor clearColor];
        signuppwr.font = [UIFont fontWithName:@"Futura" size:14];
        signuppwr.tag = 9004;
        signuppwr.textColor = [UIColor blackColor];
       
        [newUserView addSubview:signuppwr];
        
        pwfieldr = [[UITextField alloc] initWithFrame:CGRectMake(150, 310, 125, 25)];
        pwfieldr.backgroundColor = [UIColor whiteColor];
        pwfieldr.font = [UIFont fontWithName:@"Futura" size:14];
        pwfieldr.borderStyle = UITextBorderStyleRoundedRect;
        pwfieldr.delegate = self;
        pwfieldr.secureTextEntry = YES;
        pwfieldr.tag = 9005;
        [newUserView addSubview:pwfieldr];
        
        
        signupNextButton = [[UIButton alloc] init];
        signupNextButton.frame = CGRectMake(230, 360, 65, 65);
        [signupNextButton setImage:[UIImage imageNamed:@"nextarrow.png"] forState:UIControlStateNormal];
        
                [signupNextButton setImage:[UIImage imageNamed:@"nextarrowpressed.png"] forState:UIControlStateHighlighted];
     
        [signupNextButton addTarget:self action:@selector(nextSignUp) forControlEvents:UIControlEventTouchUpInside];
        
        [newUserView addSubview:signupNextButton];
        
        signupPrevButton = [[UIButton alloc] init];
        signupPrevButton.frame = CGRectMake(25, 360, 65, 65);
        [signupPrevButton setImage:[UIImage imageNamed:@"prevarrow.png"] forState:UIControlStateNormal];
        
        [signupPrevButton setImage:[UIImage imageNamed:@"prevarrowpressed.png"] forState:UIControlStateHighlighted];
        
        [signupPrevButton addTarget:self action:@selector(prevSignUp) forControlEvents:UIControlEventTouchUpInside];
        
        [newUserView addSubview:signupPrevButton];
        
        
        //UIImage *sidebarsignup = [UIImage imageNamed:@"sidebarsignup.jpg"];
        UIImage *newuser = [UIImage imageNamed:@"newuser.jpg"];
        UIImage *newuserpressed = [UIImage imageNamed:@"newuserpressed.jpg"];
        UIImage *existinguser = [UIImage imageNamed:@"existinguser.jpg"];
        UIImage *existinguserpressed = [UIImage imageNamed:@"existinguserpressed.jpg"];
        
        
        
        signUpSelect = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
        
        signUpSelect.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"signupheader.png"]];
        
        [self.view addSubview:signUpSelect];
        
        //UIImageView *signupmain = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 320, 200)];
        
        UIButton *newbutton = [[UIButton alloc] initWithFrame:CGRectMake(115, 188, 90, 36)];
        [newbutton setImage:newuser forState:UIControlStateNormal];
        [newbutton setImage:newuserpressed forState:UIControlStateHighlighted];
        UIButton *existbutton = [[UIButton alloc] initWithFrame:CGRectMake(115, 235, 90, 36)];
        [existbutton setImage:existinguser forState:UIControlStateNormal];
        [existbutton setImage:existinguserpressed forState:UIControlStateHighlighted];
        
        [newbutton addTarget:self action:@selector(startNew) forControlEvents:UIControlEventTouchUpInside];
        
        [existbutton addTarget:self action:@selector(startExist) forControlEvents:UIControlEventTouchUpInside];
      
        //signupmain.image = sidebarsignup;
        
        //[signUpSelect addSubview:signupmain];
        [signUpSelect addSubview:newbutton];
        [signUpSelect addSubview:existbutton];
        
        
        
        UILabel *signupmsg = [[UILabel alloc] initWithFrame:CGRectMake(30, 320, 275, 75)];
        signupmsg.textAlignment = UITextAlignmentLeft;
        signupmsg.backgroundColor = [UIColor clearColor];
        signupmsg.numberOfLines = 0;
        signupmsg.tag = 1019;
        signupmsg.font = [UIFont fontWithName:@"Futura" size:14];
        signupmsg.text = @"Please register a username to enable all the social networking features of ClosetFashions.  You may also tap the arrow to skip this step or register later.";
        
        [signUpSelect addSubview:signupmsg];
        
        UIButton *signupSkipButton = [[UIButton alloc] init];
        signupSkipButton.frame = CGRectMake(230, 385, 65, 65);
        [signupSkipButton setImage:[UIImage imageNamed:@"nextarrow.png"] forState:UIControlStateNormal];
        
        [signupSkipButton setImage:[UIImage imageNamed:@"nextarrowpressed.png"] forState:UIControlStateHighlighted];
        
        [signupSkipButton addTarget:self action:@selector(skipSignUp) forControlEvents:UIControlEventTouchUpInside];
        [signUpSelect addSubview:signupSkipButton];


    }
    
    //this block clears the username entry field and loads country selection
    else if(currentUser.username != NULL && currentUser.country == NULL)
    {
        signup.text = @"Which country are you from?";
        
        usernamefield.hidden = YES;
        signuppw.hidden = YES;
        pwfield.hidden = YES;
        signuppwr.hidden = YES;
        pwfieldr.hidden = YES;
        
        for(int y=0; y < [newUserView.subviews count]; y++)
        {
            UIView *tempview = [newUserView.subviews objectAtIndex:y];
            if (tempview.tag == 9003)
            {
                [tempview removeFromSuperview];
            }
        }
        
        
        //UIView *countryPickerHolder = [[UIView alloc] init];
        
        
        //countryPickerHolder.backgroundColor = [UIColor redColor];
    
    
        countryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(32,150, 0, 0)];
        countryPicker.tag = 9004;
        countryPicker.delegate = self;
        countryPicker.showsSelectionIndicator = YES;
        

    
       // scale size of pickerview for categories
        
        CGAffineTransform t0 = CGAffineTransformMakeTranslation(countryPicker.bounds.size.width/1.0, countryPicker.bounds.size.height/1.0);
        CGAffineTransform s0 = CGAffineTransformMakeScale(0.9,0.9);
        CGAffineTransform t1 = CGAffineTransformMakeTranslation(-countryPicker.bounds.size.width/1.0, -countryPicker.bounds.size.height/1.0);
        countryPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
        
        //scale size of pickerview for categories
        
        //[countryPickerHolder addSubview:countryPicker];
        
        //countryPickerHolder.clipsToBounds = NO;
        
        [newUserView addSubview:countryPicker];
        currentcountryrow=0;
        
        
    }
    
    
    
    if(currentUser.country != NULL)
    {
     
        NSString *oldclosetfile = [NSString stringWithFormat:@"closet%@.arch", currentUser.username];
        NSString *oldpathcloset = [pathhome stringByAppendingPathComponent:oldclosetfile];
        
        //[self clearArchive];
        //[self clearUserInfo];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:oldclosetfile];
        
        if(fileExists)
        {
            myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:oldpathcloset];
        }
        
        
        
        NSString *userclosetpath = [NSString stringWithFormat:@"closet.arch"];
        
        currentUser.closetfile = userclosetpath;
        
        
        
        if(!myCloset)
        {
            NSLog(@"unarchiving from pathcloset %@ A", pathcloset);
            myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathcloset];
        }
        else
        {
            [myCloset saveClosetArchive];
        }
        
        
        if (!myCloset)
        {
            NSLog(@"unarchiving from pathcloset %@ B", pathcloset);
            NSLog(@"closet empty, reallocating");
            myCloset = [[Closet alloc] initWithRacks];
            
            [myCloset saveClosetArchive];
        }
        
        
        NSLog(@"new user closetfile%@", currentUser.closetfile);
        
        [NSKeyedArchiver archiveRootObject:currentUser toFile:pathuserfull];
        
        [signUpSelect removeFromSuperview];
        [newUserView removeFromSuperview];
        
        [self loadWithUser:currentUser];
        
        [self openCloset];
        
        if (firstuse == YES)
        {
            [self switchToHelp];
        }
        
        
    }
    
    
    

}



-(void) skipSignUp
{
    
    skip = YES;
    [signUpSelect removeFromSuperview];
    [newUserView removeFromSuperview];
    
    currentUser.username = @"unregistered";
    currentUser.password = @"unregistered";
    
    NSString *userclosetpath = [NSString stringWithFormat:@"closet.arch"];
    
    currentUser.closetfile = userclosetpath;
    
    NSLog(@"in skip %@", currentUser.closetfile);
    
    [NSKeyedArchiver archiveRootObject:currentUser toFile:pathuserfull];
    
    
    [self loadWithUser:currentUser];
    
    [self openCloset];
    
    if (firstuse == YES)
    {
 
        [self switchToHelp];
    }
    
    
}


-(void) prevSignUp
{
    
    if(didshiftpw)
    {
        NSLog(@"should shift back down");
        CGPoint positionWithoutKeyboard = CGPointMake(self.view.center.x, self.view.center.y +180);
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithoutKeyboard;
        
        
        [UIView commitAnimations];
        
        [pwfield resignFirstResponder];
        [pwfieldr resignFirstResponder];
        
        didshiftpw = NO;
    }
    
    [newUserView addSubview:usernamefield];
    [newUserView addSubview:pwfield];
    [newUserView addSubview:pwfieldr];
    
    usernamefield.hidden = NO;
    signuppw.hidden = NO;
    pwfield.hidden = NO;
    signuppwr.hidden = NO;
    pwfieldr.hidden = NO;
    
    currentUser.username = NULL;
    currentUser.country = NULL;
    
    
    
    [countryPicker removeFromSuperview];
    [self.view addSubview:signUpSelect];
    
}


-(void) nextSignUp
{
    
    if(didshiftpw)
    {
        NSLog(@"should shift back down");
        CGPoint positionWithoutKeyboard = CGPointMake(self.view.center.x, self.view.center.y +180);
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithoutKeyboard;
        
        
        [UIView commitAnimations];
        
        didshiftpw = NO;
    }

    
    if(existing){
            
            if(currentUser.username == NULL || [currentUser.username compare:@"unregistered"] == NSOrderedSame)
                [self checkusername];
            
            else if(currentUser.country == NULL){ currentUser.country = [sortedCountryArray objectAtIndex:currentcountryrow];
                
                [self addUser];
            }
            
    }
    else if (!existing || [currentUser.username compare:@"unregistered"] == NSOrderedSame){
        
            if ([usernamefield.text componentsSeparatedByString:@" "].count > 1 || [pwfield.text componentsSeparatedByString:@" "].count >1)
            {
                [self alertWith:@"No spaces are allowed in the username or password.  Please try again."];
            
            }
        
           else if(usernamefield.text.length < 4 || usernamefield.text.length >15)
           {
               [self alertWith:@"Your username must be 4 to 15 characters long. Please try again."];
             
               
           }
           else if (pwfield.text.length < 4 || pwfield.text.length > 8)
           {
               [self alertWith:@"Your password must be 4 to 8 characters long. Please try again."];
               
           }
           else if ([pwfield.text compare:pwfieldr.text] == NSOrderedSame)
           {
               if(currentUser.username == NULL || [currentUser.username compare:@"unregistered"] == NSOrderedSame)[self checkusername];
    
               else if(currentUser.country == NULL){ currentUser.country = [sortedCountryArray objectAtIndex:currentcountryrow];
            
                   [self addUser];
               }
           }
           else [self alertWith:@"Your passwords do not match, please try again."];
        
    }

}


-(void) startNew
{
    existing = NO;
    [signUpSelect removeFromSuperview];
    
    pwfieldr.hidden = NO;
    signuppwr.hidden = NO;
    
    
    usernamefield.frame = CGRectMake(150, 140, 125, 25);
    pwfield.frame = CGRectMake(150, 225, 125, 25);
    
    
    
    signup.frame = CGRectMake(30, 85, 250, 50);
    signup.text = @"Pick a username: \n (between 4 - 15 characters long)";
    
    signuppw.frame = CGRectMake(30, 170, 250, 50);
    signuppw.text = @"Choose a password: \n (between 4 - 8 characters long)";
   
}

-(void) startExist
{
    existing = YES;
    [signUpSelect removeFromSuperview];
    pwfieldr.hidden = YES;
    signuppwr.hidden = YES;
    
    usernamefield.frame = CGRectMake(150, 98, 125, 25);
    pwfield.frame=CGRectMake(150, 183, 125, 25);
    
    signup.text = @"Username:";
    
    signup.frame = CGRectMake(50, 85, 150, 50);
    
    signuppw.text = @"Password:";
    signuppw.frame = CGRectMake(50, 170, 150, 50);
}


-(void) startLoadAnimation
{
    [myLoadIndicator startAnimating];
}

-(void) stopLoadAnimation
{
    [myLoadIndicator stopAnimating];
         [self refreshOutfitDisplay];
}




UIImage *openvertgray;
UIImage *openvertgraypressed;
UIImage *closevertgray;
UIImage *closevertgraypressed;


UIImage *opengray;
UIImage *opengraypressed;
UIImage *closegray;
UIImage *closegraypressed;


UIImage *openmenu2;
UIImage *openmenu2pressed;
UIImage *closemenu2;
UIImage *closemenu2pressed;

UIImage *openmenu;
UIImage *openmenupressed;
UIImage *closemenu;
UIImage *closemenupressed;

UIImage *openmenu2;
UIImage *openmenu2pressed;
UIImage *closemenu2;
UIImage *closemenu2pressed;


UIImage *extendmag;
UIImage *extendmagpressed;
UIImage *retractmag;
UIImage *retractmagpressed;

UIImage *extendmag2;
UIImage *extendmag2pressed;
UIImage *retractmag2;
UIImage *retractmag2pressed;

UIView *verifyBar;
AppDelegate *appDelegate;

-(void) loadWithUser: (User *) user
{
    
    pathhomebackupcloset = [pathhome stringByAppendingPathComponent:@"Backup"];
    
    pathcloset = [pathhome stringByAppendingPathComponent:@"closet.arch"];
    
    NSLog(@"%@ is pathcloset", pathcloset);
    
    myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathcloset];
    
    if (!myCloset)
    {
        NSLog(@"closet empty, reallocating");
        myCloset = [[Closet alloc] initWithRacks];
        
        [myCloset saveClosetArchive];
    }
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.myCloset = myCloset;
    appDelegate.filterController.myCloset = myCloset;
    
    [appDelegate.filterController.tableView reloadData];
    
    Closet *tempcloset = myCloset;
    
    NSLog(@"mixer controller my closet count is %i", [myCloset.categories count]);
    
    
    NSLog(@"app delegate my closet count is %i", [appDelegate.myCloset.categories count]);
    

    
    
    NSLog(@"path closet is %@", pathcloset);
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
   
  
    
    
    labelwidth = 120;
    labelheight = self.view.frame.size.height/20;
    scrollimagewidth = self.view.frame.size.width/7;
    scrollimageheight = self.view.frame.size.height/10; //was 12
    windowwidth = self.view.frame.size.width;
    windowheight = self.view.frame.size.height;
    
    

 

    
    [outfitView addSubview:scrollDisplayTopsOverlay];
    
    scrollTops.delegate = self; // IMPORTANT FOR SCROLLING METHODS (ON THE FLY UPDATES)
    scrollTopsOverlay.delegate = self;
    scrollAccessories.delegate = self;
    scrollBottoms.delegate = self;
    scrollShoes.delegate = self;
    
    
    
    scrollDisplayTops.contentMode = UIViewContentModeScaleAspectFit;
    scrollDisplayTopsOverlay.contentMode = UIViewContentModeScaleAspectFit;
    scrollDisplayBottoms.contentMode = UIViewContentModeScaleAspectFit;
    scrollDisplayShoes.contentMode = UIViewContentModeScaleAspectFit;

   
    
    outfitView.tag = 50000;
    outfitDisplay.tag = 50000;
    
    scrollDisplayTops.tag = 70000;
    scrollDisplayTopsOverlay.tag = 70003;
    scrollDisplayTopsOverlay.backgroundColor = [UIColor clearColor];
   
    scrollDisplayBottoms.tag = 70001;
    scrollDisplayShoes.tag = 70002;
    
    
    loadOutterwearButton.tag = 3949;
    
    menuButton.tag = 3948;
 
    
    
    //START SCROLLVIEW CREATION
    
    //[self.view addSubview:scrollTops];
    //[self.view addSubview:scrollTopsOverlay];
    //[self.view addSubview:scrollBottoms];
    //[self.view addSubview:scrollShoes];
    

    
    viewInScrollTops = [[UIViewInScroll alloc] initWithFrame:CGRectMake(outfitDisplay.frame.origin.x- scrollTops.frame.origin.x, 0, windowwidth, scrollimageheight)];
    
    
    viewInScrollTopsOverlay = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, scrollimagewidth, windowheight)];
    
    
    viewInScrollAccessories = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, windowwidth, scrollimageheight)];
    
    viewInScrollBottoms = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, scrollimagewidth, windowheight)];
    viewInScrollShoes = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, windowwidth, scrollimageheight)];
    
    
    [scrollTops addSubview:viewInScrollTops];
    [scrollTopsOverlay addSubview:viewInScrollTopsOverlay];
    [scrollShoes addSubview:viewInScrollShoes];
    [scrollBottoms addSubview:viewInScrollBottoms];
    
    [scrollAccessories addSubview:viewInScrollAccessories];

    
    self.view.tag = 10000;
    
    scrollTops.tag = 20000;
    scrollBottoms.tag = 20001;
    scrollShoes.tag = 20002;
    scrollTopsOverlay.tag =20003;
    scrollAccessories.tag = 20004;
    viewInScrollTops.tag = 30000;
    viewInScrollBottoms.tag = 30001;
    viewInScrollShoes.tag = 30002;
    viewInScrollTopsOverlay.tag = 30003;
    viewInScrollAccessories.tag = 30004;
    
    
    
    [self.view setUserInteractionEnabled:YES];
    
    
    
    [scrollDisplayTops setUserInteractionEnabled:YES];
    [scrollDisplayTopsOverlay setUserInteractionEnabled:YES];
    [scrollDisplayBottoms setUserInteractionEnabled:YES];
    [scrollDisplayShoes setUserInteractionEnabled:YES];
   
    
    [scrollTops setUserInteractionEnabled:YES];
    [scrollTopsOverlay setUserInteractionEnabled:YES];
    [scrollAccessories setUserInteractionEnabled:YES];
    [scrollBottoms setUserInteractionEnabled:YES];
    [scrollShoes setUserInteractionEnabled:YES];
    
    
    [viewInScrollTops setUserInteractionEnabled:YES];
    [viewInScrollTopsOverlay setUserInteractionEnabled:YES];
    [viewInScrollAccessories setUserInteractionEnabled:YES];
    [viewInScrollBottoms setUserInteractionEnabled:YES];
    [viewInScrollShoes setUserInteractionEnabled:YES];
    
    
    [outfitView setUserInteractionEnabled:YES];
    outfitView.clipsToBounds = YES;
    
    
    
    //LOAD ARCHIVED DATA
    
    
    pathlastimagenum = [pathhome stringByAppendingPathComponent:@"lastimagenum.arch"];
    
    pathlasttopcatnum = [pathhome stringByAppendingPathComponent:@"lasttopnum.arch"];
    
    
    pathlasttopoverlaycatnum = [pathhome stringByAppendingPathComponent:@"lasttopoverlaynum.arch"];
    
    pathlastrightcatnum = [pathhome stringByAppendingPathComponent:@"lastrightnum.arch"];
    
    pathlastlowercatnum = [pathhome stringByAppendingPathComponent:@"lastlowernum.arch"];
    
    
    if(!(lastLowerCategoryNum = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastlowercatnum]))
    {
        
        NSLog(@"loading lowerscrollnum from archive FAIL");
        currentcategorylowerscroll = 3;
    }
    else
    {
        NSLog(@"loading lowerscrollnum from archive");
        currentcategorylowerscroll = [lastLowerCategoryNum intValue];
    }
    
    if(!(lastRightCategoryNum = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastrightcatnum]))
    {
        currentcategoryrightscroll = 2;
    }
    else
    {
        currentcategoryrightscroll = [lastRightCategoryNum intValue];
    }
    
    if(!(lastTopCategoryNum = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlasttopcatnum]))
    {
        currentcategorytopscroll = 0;
    }
    else
    {
        currentcategorytopscroll = [lastTopCategoryNum intValue];
    }
    

    if(!(lastTopOverlayCategoryNum = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlasttopoverlaycatnum]))
    {
        currentcategorytopoverlayscroll = 4;
    }
    else
    {
        currentcategorytopoverlayscroll = [lastTopOverlayCategoryNum intValue];
    }
    
    
    currentcategoryaccessoriesscroll = 5;
 
   
    
    [self startLoadAnimation];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loadAllArchives) userInfo:nil repeats:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(stopLoadAnimation) userInfo:nil repeats:NO];
   
   [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refreshOutfitDisplay) userInfo:nil repeats:NO];
    
    
    //TO DO: adding cateogires to outfitcategories array and archiving to pathoutfitcategories, then refresh scroll selection. deleting categories from outfitcategories.  adding dates to outfits.  outfitview, view by outfit category or date.  use organizer controller?
    
    
    
    
    if(!(lastImageNumArch = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastimagenum]))
    {
        imageFileNum = 1;
    }
    else
    {
        imageFileNum = [lastImageNumArch intValue];
    }
    
    
    
    
    
    savedtopandfilter = NO;
    savedtopoverlayandfilter = NO;
    savedaccessoriesandfilter = NO;
    savedlowerandfilter = NO;
    savedrightandfilter = NO;
    
    
    organizercontroller = self.organizerController;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
    outfitModesArray = [NSMutableArray arrayWithObjects:@"Tops/Bottoms/Shoes", @"Tops/Shoes", @"Tops/Bottoms", @"w/ Tops-Overlay", nil];
    
    
    topsDisplayFrame = CGRectMake(scrollDisplayTops.frame.origin.x, scrollDisplayTops.frame.origin.y, scrollDisplayTops.frame.size.width, scrollDisplayTops.frame.size.height);
    
     topsDisplayFrameWithOverlay = CGRectMake(110, 2, 100, 133);
    
    topsDisplayFrameLarge = CGRectMake(28, 3, 164, 219);
   
    
    topsDisplayFrameHalf = CGRectMake(scrollDisplayTops.frame.origin.x, scrollDisplayTops.frame.origin.y, scrollDisplayTops.frame.size.width, outfitView.frame.size.height/2);
    
    
    
    
    topsOverlayDisplayFrame = CGRectMake(scrollDisplayTopsOverlay.frame.origin.x, scrollDisplayTopsOverlay.frame.origin.y, scrollDisplayTopsOverlay.frame.size.width, scrollDisplayTopsOverlay.frame.size.height);
    
    topsOverlayDisplayWithDress = CGRectMake(3, 3, 100, 133);
    
    topsDisplayFrameDressWithOverlay = CGRectMake(80, 110, 138, 183);
    
    shoesDisplayFrameShiftedWithDress = CGRectMake(3, 270, 100, 76);
    
    
    
    bottomsDisplayFrame = CGRectMake(scrollDisplayBottoms.frame.origin.x, scrollDisplayBottoms.frame.origin.y, scrollDisplayBottoms.frame.size.width, scrollDisplayBottoms.frame.size.height);
    
    bottomsDisplayFrameHalf = CGRectMake(scrollDisplayBottoms.frame.origin.x, outfitView.frame.origin.y + outfitView.frame.size.height/2 - 5, scrollDisplayBottoms.frame.size.width, outfitView.frame.size.height/2);
    
    
    shoesDisplayFrame = CGRectMake(scrollDisplayShoes.frame.origin.x, scrollDisplayShoes.frame.origin.y, scrollDisplayShoes.frame.size.width, scrollDisplayShoes.frame.size.height);
    
    shoesDisplayFrameShifted = CGRectMake(28, 222, 164, 124);
    
    outfitViewType = 0;
    outfitView.outfitType = outfitViewType;
    
    
    overlayOn = NO;
    overlayOnMode = NO;
    accessoriesOn = NO;
    //viewInScrollTopsOverlay.backgroundColor = [UIColor grayColor];
    
    scrollTopsOverlay.hidden = NO;
    scrollDisplayTopsOverlay.hidden = NO;
    
    shiftedUp= NO;
    
    topbottomshoemode = TRUE;
    
    
    filterTopButton.tag = 89;
    filterTopOverlayButton.tag = 92;
    filterRightButton.tag = 90;
    filterLowerButton.tag = 91;
    filterAccessoriesButton.tag = 93;
    
    
    
    [self loadTopFilter];
    [self loadTopOverlayFilter];
    [self loadAccessoriesFilter];
    [self loadRightFilter];
    [self loadLowerFilter];
    
    
    
    
    if(currentcategorytopscroll == 1)
    {
      [self dressOn];
    }
    
    activecountriesloaded = NO;
  
    
    //outfitView.layer.borderColor = [[UIColor blackColor] CGColor];
    //outfitView.layer.borderWidth = 2;
    
    NSLog(@"%@", pathcloset);
   
    
    openmenu = [UIImage imageNamed:@"extendmagvert.jpg"];
    openmenupressed = [UIImage imageNamed:@"extendmagvertpressed.jpg"];
    
    
    closemenu = [UIImage imageNamed:@"retractmagvert.jpg"];
    closemenupressed = [UIImage imageNamed:@"retractmagvertpressed.jpg"];
    
    openmenu2 = [UIImage imageNamed:@"extendmagvert2.jpg"];
    openmenu2pressed = [UIImage imageNamed:@"extendmagvert2pressed.jpg"];
    
    
    closemenu2 = [UIImage imageNamed:@"retractmagvert2.jpg"];
    closemenu2pressed = [UIImage imageNamed:@"retractmagvert2pressed.jpg"];
    
    
    retractmag = [UIImage imageNamed:@"retractmag.jpg"];
    retractmagpressed = [UIImage imageNamed:@"retractmagpressed.jpg"];
    
    extendmag = [UIImage imageNamed:@"extendmag.jpg"];
    extendmagpressed = [UIImage imageNamed:@"extendmagpressed.jpg"];
    
    
    
    opengray = [UIImage imageNamed:@"extendgray.jpg"];
    opengraypressed = [UIImage imageNamed:@"extendgraypressed.jpg"];
    
    
    closegray = [UIImage imageNamed:@"retractgray.jpg"];
    closegraypressed = [UIImage imageNamed:@"retractgraypressed.jpg"];
    
    openvertgray = [UIImage imageNamed:@"extendgrayvert.jpg"];
    openvertgraypressed = [UIImage imageNamed:@"extendgrayvertpressed.jpg"];
    
    
    closevertgray = [UIImage imageNamed:@"retractgrayvert.jpg"];
    closevertgraypressed = [UIImage imageNamed:@"retractgrayvertpressed.jpg"];
    
    
    overlayOn = NO;
    menuOn = YES;
    menuSecondOn = NO;
    
    menuView.layer.borderWidth = 0;
    menuView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    
    menuSecondView.layer.borderWidth = 0;
    menuSecondView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    
    
    
    
    
    UITapGestureRecognizer *doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    
    [doubletap setNumberOfTapsRequired:2];
    //[doubletap setNumberOfTouchesRequired:1];
    
    [outfitView addGestureRecognizer:doubletap];
    
    
    
    //scrollTops.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodscrollhoriz.png"]];
    
    
    //scrollBottoms.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodscrollvertright.png"]];
    
    
    //scrollShoes.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodscrollhoriz.png"]];
    
    
    //scrollTopsOverlay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodscrollvert.png"]];
    
    //viewInScrollTops.backgroundColor = [UIColor yellowColor];
    
    //viewInScrollBottoms.backgroundColor = [UIColor clearColor];
    
    //viewInScrollShoes.backgroundColor = [UIColor clearColor];
    
    //viewInScrollTopsOverlay.backgroundColor = [UIColor clearColor];
    
    //scrollAccessories.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodscrollhoriz.png"]];
    
    
    //viewInScrollAccessories.backgroundColor = [UIColor clearColor];

    
    
    
    verifyBar = [[UIView alloc] initWithFrame:CGRectMake(0, 347, 220, 1)];
    verifyBar.backgroundColor = [UIColor whiteColor];
   
    
    topChanged = NO ;
    topOverlayChanged = NO ;
    accessoriesChanged = NO ;
    rightChanged = NO ;
    lowerChanged = NO ;
    
    //[self checkForActivity];
    
    [self createLiteDirectory];
    [self createBackupDirectory];
    
    
}

-(void) createLiteDirectory
{
    
    NSLog(@"going to create lite directory");
    NSFileManager *filemgr;
    NSArray *dirPaths;
    NSString *docsDir;
    NSString *newDir;
    BOOL liteDirExists;
    
    filemgr =[NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    newDir = [docsDir stringByAppendingPathComponent:@"Lite"];
    
    if([filemgr fileExistsAtPath:newDir isDirectory:&liteDirExists] && liteDirExists)
    {
        NSLog(@"LITE directory already exists");
    }
    else {
    
        if ([filemgr createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error: NULL] == NO)
        {
            // Failed to create directory
            NSLog(@"directory creation failed");
        }
        else{
            NSLog(@"directory creation succesful");
        }
    }


    
  
}

-(void) createBackupDirectory
{
    
    NSLog(@"going to create backup directory");
    NSFileManager *filemgr;
    NSArray *dirPaths;
    NSString *docsDir;
    NSString *newDir;
    BOOL backupDirExists;
    
    filemgr =[NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    newDir = [docsDir stringByAppendingPathComponent:@"Backup"];
    
    if([filemgr fileExistsAtPath:newDir isDirectory:&backupDirExists] && backupDirExists)
    {
        NSLog(@"BACKUP directory already exists");
    }
    else {
        
        if ([filemgr createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error: NULL] == NO)
        {
            // Failed to create directory
            NSLog(@"backup directory creation failed");
        }
        else{
            NSLog(@"backup directory creation succesful");
        }
    }
    
    
    
    
}



NSString *pathlitecloset;
NSString *pathfullcloset;

NSString *pathhomelitecloset;
NSString *pathliteclosetzip;
Closet *liteCloset;
Closet *fullCloset;


NSString *pathbackupclosetzip;
NSString *pathhomebackupcloset;


UIActivityIndicatorView *myZipIndicator;

-(void) alertWithBigZip: (NSString *) alertstring
{
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = 150;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 275)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        
        alertView.layer.cornerRadius = 5;
        
        
        myZipIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        myZipIndicator.center = CGPointMake(125, 235);
        myZipIndicator.hidesWhenStopped = YES;
        myZipIndicator.backgroundColor = [UIColor lightGrayColor];
        
        myZipIndicator.layer.cornerRadius = 5;
        
        [alertView addSubview:myZipIndicator];
        
        
        
        [myZipIndicator startAnimating];
        
        
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 210, 180)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel];

        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}


-(IBAction) userTapBackup
{
    startBackup = YES;
    [self confirmAlert:@"Backing up your closet will erase the previous backup stored on your iPhone.  Are you sure you want to do this?"];
}

-(IBAction) userTapRestore
{
    startBackup = NO;
    
  
    [self confirmAlert:@"Restoring your closet from a backup file will erase all existing oufits and items. Are you sure you want to do this?"];
    
}

-(void) confirmAlert: (NSString *) askstring
{
    
        if([self doesViewAlreadyExist:38] == NO)
        {
            
            
            int originX = self.view.frame.size.width/2 - 125;
            int originY = 150;
            
            
            
            UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 225)];
            
            alertView.backgroundColor = [UIColor whiteColor];
            
            
            alertView.tag = 38;
            
            alertView.layer.borderColor = [[UIColor blackColor] CGColor];
            alertView.layer.borderWidth = 2;
            alertView.layer.cornerRadius = 5;
            
            
            
            [self.view addSubview:alertView];
            
            UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 150)];
            alertLabel.numberOfLines = 0;
            
            
            
            
            alertLabel.text = askstring;
            alertLabel.textColor = [UIColor blackColor];
            alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
            alertLabel.textAlignment = UITextAlignmentLeft;
            
            
            [alertView addSubview:alertLabel];
            
            
            
            UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
            UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
            
            UIImage *no = [UIImage imageNamed:@"no.jpg"];
            UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
            
            UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 175, 54, 36)];
            yesButton.tag=66;
            
            [yesButton setImage:yes forState:UIControlStateNormal];
            [yesButton setImage:yespressed forState:UIControlStateHighlighted];
            
            
            
            if(startBackup == YES)
            {
                
                [yesButton addTarget:self action:@selector(startBackupProcess) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                [yesButton addTarget:self action:@selector(startRestoreProcess) forControlEvents:UIControlEventTouchUpInside];
            }
            
            UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(131, 175, 54, 36)];
            
            
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

-(void) dismissAlert
{
    UIView *retrieveview= [self retrieveView:38];
    [retrieveview removeFromSuperview];
    [self reactivateAllInView:self.view];
}

-(void) startBackupProcess
{
    [self dismissAlert];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    NSLog(@"starting backup!");
    [self alertWithBigZip:@"Your backup file is being created. Please wait until you get a confirmation message. This may take a few minutes. Do not leave the app or the backup will fail. If you do not get a confirmation message, the backup did not complete and you will need to try again."];
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backupFullCloset) userInfo:nil repeats:NO];
    
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stopZipAnimation) userInfo:nil repeats:NO];
    
}


-(void) startRestoreProcess
{
    [self dismissAlert];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    
    NSFileManager *filemgr;
    
    
    filemgr =[NSFileManager defaultManager];
    
    pathhomebackupcloset = [pathhome stringByAppendingPathComponent:@"Backup"];
    
    pathbackupclosetzip = [pathhome stringByAppendingPathComponent:@"restoreMyCloset.zip"];
    
    
    if([filemgr fileExistsAtPath:pathbackupclosetzip])
    
    {

        [self alertWithBigZip:@"Your backup is being restored.  Please wait until you get a confirmation message. This may take a few minutes. Do not leave the app, or the restore will fail. If you do not get a confirmation message, the restore did not complete and you will need to try again."];
    
    
    
    
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(restoreFullCloset) userInfo:nil repeats:NO];
    
    
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stopZipAnimation) userInfo:nil repeats:NO];
    }
    else{
        [self alertWithBig:@"To restore data from your backup, you must first copy the backup file and rename it, then copy it back into ClosetFashions.  Please refer to the tutorial for complete instructions."];
    }
    
}




-(void) stopZipAnimation
{
    
    [myZipIndicator stopAnimating];
    
    UIView *tempview = [self retrieveView:38];
    
    [tempview removeFromSuperview];
    
    [self reactivateAllInView:self.view];
    
    if(startBackup == YES)
    {
    
        shouldTransfer = YES;

        [self alertWithBig:@"A backup of your closet has been successfully created.  You will now be sent to the tutorial showing how to make a copy of the backup for safe-keeping, plus how to restore the backup."];
        
        
    
    }
    else
    {
        
        [self alertWith:@"Your backup has been restored!"];
        
        closetRestored = YES;
        
        [self loadAllArchives];
        
    }
    
     [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

    
}

-(void) stopLiteZipAnimation
{
    
    [myZipIndicator stopAnimating];
    
    UIView *tempview = [self retrieveView:38];
    
    [tempview removeFromSuperview];
    
    [self reactivateAllInView:self.view];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    
}





-(void) restoreFullCloset
{
    NSLog(@"identity before clear %@", myCloset.closetIdentity);
   
    NSLog(@"going to restore now");
   
    
    if (!organizercontroller)
    {
         organizerController = [[OrganizerController alloc] initWithNibName:@"OrganizerController" bundle:nil];
    }
    
    organizercontroller = self.organizerController;
    
     [organizercontroller restoreFullCloset];
    

}

-(void) backupFullCloset
{
    
    NSLog(@"running backupFullCloset");
    pathbackupclosetzip = [pathhome stringByAppendingPathComponent:@"MyCloset.zip"];
    
    NSMutableArray *inputPaths = [[NSMutableArray alloc] init];
    [inputPaths addObject:pathcloset]; //ADD closet.arch file!
    
    
    
    ZipArchive *zipper = [[ZipArchive alloc] init];
    
    [zipper CreateZipFile2:pathbackupclosetzip];
    [zipper addFileToZip:pathcloset newname:@"closet.arch"];
    
    for(int y=0; y<[myCloset.categories count]; y++)
    {
        
        Category *tempcategory = [myCloset.categories objectAtIndex:y];
        
        for (int x = 0; x < [tempcategory.racksarray count]; ++x)
        {
            Rack * temprack;
            temprack = [tempcategory.racksarray objectAtIndex:x];
            
            for(int z=0; z< [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                
                //change record number
                
                [inputPaths addObject:temprecord.imageFilePath];
                [inputPaths addObject:temprecord.imageFilePathBest];
                [inputPaths addObject:temprecord.imageFilePathThumb];
                
                [zipper addFileToZip:temprecord.imageFilePath newname:[NSString stringWithFormat:@"%d.png",temprecord.fileNumRef]];
                [zipper addFileToZip:temprecord.imageFilePathBest newname:[NSString stringWithFormat:@"%db.png",temprecord.fileNumRef]];
                [zipper addFileToZip:temprecord.imageFilePathThumb newname:[NSString stringWithFormat:@"%dt.png",temprecord.fileNumRef]];
                
                NSString *pathadded = [inputPaths objectAtIndex:inputPaths.count -1];
                
                NSLog(@"%@", pathadded);
            }
            
        }
        
    }
    
    
    for(int y=0; y<[myCloset.outfitsArray count]; y++)
    {
        
        
        
        for (int x = 0; x < [myCloset.outfitsArray count]; ++x)
        {
            ImageRecord *tempoutfit = [myCloset.outfitsArray objectAtIndex:x];
           
            [inputPaths addObject:tempoutfit.imageFilePath];
            [inputPaths addObject:tempoutfit.imageFilePathThumb];
            
            
            [zipper addFileToZip:tempoutfit.imageFilePath newname:[NSString stringWithFormat:@"%do.png",tempoutfit.fileNumRef]];
            
            [zipper addFileToZip:tempoutfit.imageFilePathThumb newname:[NSString stringWithFormat:@"%dot.png",tempoutfit.fileNumRef]];
            
            NSString *pathadded = [inputPaths objectAtIndex:inputPaths.count -1];
                
                NSLog(@"%@", pathadded);
            
            
        }
        
    }
    
    
    //NSFileManager *fm = [[NSFileManager alloc] init];

    //if([fm removeItemAtPath:pathbackupclosetzip error:nil]) NSLog(@"backup zip deleted, starting new zip backup");
    
    
        NSLog(@"number of input paths is %i", [inputPaths count]);
    
    BOOL success = [zipper CloseZipFile2];
    
    NSLog(@"Zipped file with result %d",success);
    
    //[SSZipArchive createZipFileAtPath:pathbackupclosetzip withFilesAtPaths:inputPaths];
  

}



-(void) backupLiteCloset
{
    pathhomelitecloset = [pathhome stringByAppendingPathComponent:@"Lite"];
    
    pathliteclosetzip = [pathhome stringByAppendingPathComponent:@"litecloset.zip"];
    
    NSMutableArray *inputPaths = [[NSMutableArray alloc] init];
    
    [inputPaths addObject:pathcloset]; //ADD closet.arch file!
    
    
    for(int y=0; y<[myCloset.categories count]; y++)
    {
        
        Category *tempcategory = [myCloset.categories objectAtIndex:y];
        
        for (int x = 0; x < [tempcategory.racksarray count]; ++x)
        {
            Rack * temprack;
            temprack = [tempcategory.racksarray objectAtIndex:x];
            
            for(int z=0; z< [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                
                //change record number
                
                [inputPaths addObject:temprecord.imageFilePath];
                [inputPaths addObject:temprecord.imageFilePathBest];
                [inputPaths addObject:temprecord.imageFilePathThumb];
                
                NSString *pathadded = [inputPaths objectAtIndex:inputPaths.count -1];
                
                NSLog(@"%@", pathadded);
            }
            
        }
        
    }
    
    
    //SSZipArchive *sszip = [[SSZipArchive alloc] init];
    
    
   // [SSZipArchive createZipFileAtPath:pathliteclosetzip withFilesAtPaths:inputPaths];
    
    //[self unzipLiteCloset];
    
}






UIScrollView *scrollCategoriesInTopFilterView;
UIScrollView *scrollRacksInTopFilterView;
UIViewInScroll *viewRacksInTopFilterView;

UIScrollView *scrollCategoriesInTopOverlayFilterView;
UIScrollView *scrollRacksInTopOverlayFilterView;
UIViewInScroll *viewRacksInTopOverlayFilterView;

UIScrollView *scrollCategoriesInRightFilterView;
UIScrollView *scrollRacksInRightFilterView;
UIViewInScroll *viewRacksInRightFilterView;

UIScrollView *scrollCategoriesInLowerFilterView;
UIScrollView *scrollRacksInLowerFilterView;
UIViewInScroll *viewRacksInLowerFilterView;

UIScrollView *scrollCategoriesInAccessoriesFilterView;
UIScrollView *scrollRacksInAccessoriesFilterView;
UIViewInScroll *viewRacksInAccessoriesFilterView;

UIButton *topAllButton;
UIButton *topOverlayAllButton;
UIButton *rightAllButton;
UIButton *lowerAllButton;
UIButton *accessoriesAllButton;


-(void) loadTopFilter
{
    
    [topFilterView removeFromSuperview];
    
    labelwidth = 120;
    topFilterView = [[UIView alloc] initWithFrame:CGRectMake(0, 21, 0, 0)];
    topFilterView.tag = 89;
    

    
    topFilterView.backgroundColor = [UIColor whiteColor];
    topFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    topFilterView.layer.borderWidth = 2;
    
    topFilterView.clipsToBounds = YES;
    
    
    
    
    scrollCategoriesInTopFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 40)];
    
    scrollCategoriesInTopFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    scrollCategoriesInTopFilterView.layer.borderWidth = 2;
    scrollCategoriesInTopFilterView.showsHorizontalScrollIndicator= NO;
    scrollCategoriesInTopFilterView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"settingcatlabel.jpg"]];
    
        scrollCategoriesInTopFilterView.tag = 89;

    scrollCategoriesInTopFilterView.pagingEnabled = YES;
    scrollCategoriesInTopFilterView.delegate = self;
    
    [self loadCategoryArchive:scrollCategoriesInTopFilterView];
    
    
    scrollCategoriesInTopFilterView.contentOffset = CGPointMake(currentcategorytopscroll*labelwidth, 0);
    
    [topFilterView addSubview:scrollCategoriesInTopFilterView];
    
    
    UIImage *bar =[UIImage imageNamed:@"bar.jpg"];
    
    
    UIImageView *barview = [[UIImageView alloc] initWithImage:bar];
    barview.frame = CGRectMake(0, 350, 120, 4);
                 
    [topFilterView addSubview:barview];
    
    
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 355, 110, 20)];
    filterLabel.text = @"Search by tag(s):";
    filterLabel.textColor = [UIColor blackColor];
       filterLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
    
    
    [topFilterView addSubview:filterLabel];
    
    
    searchtagfieldtop = [[UITextView alloc] initWithFrame:CGRectMake(5, 380, 110, 35)];
     
    searchtagfieldtop.layer.borderColor = [[UIColor grayColor] CGColor];
    searchtagfieldtop.layer.borderWidth = 2;
    searchtagfieldtop.layer.cornerRadius = 5;

    //searchtagfield.layer.shadowColor = [[UIColor blackColor] CGColor];
    //searchtagfield.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    //searchtagfield.layer.shadowOpacity = 1.0;
    //searchtagfield.layer.shadowRadius = 6.0;
    
    searchtagfieldtop.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    searchtagfieldtop.delegate = self;
    
    searchtagfieldtop.text = searchtagtop;
    
    [topFilterView addSubview:searchtagfieldtop];
    
    

    
    
    
    topAllButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 420, 110, 20)];
    topAllButton.titleLabel.text = @"     Match All";
    topAllButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    topAllButton.titleLabel.textColor = [UIColor lightGrayColor];
    //topAllButton.layer.borderColor = [[UIColor grayColor] CGColor];
    //topAllButton.layer.borderWidth = 2;
    //topAllButton.layer.cornerRadius = 5;
    topAllButton.clipsToBounds = YES;
    if (savedtopandfilter == NO)
    {
       //topAllButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"matchallunpressed.jpg"]];
        [topAllButton setSelected:NO];
    }
    else
    {
           //topAllButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"matchallchecked.jpg"]];
        [topAllButton setSelected:YES];
    }
    UIImage *matchallpressed = [UIImage imageNamed:@"matchallpressed.jpg"];
    UIImage *matchall = [UIImage imageNamed:@"matchall.jpg"];
    UIImage *matchallchecked = [UIImage imageNamed:@"matchallchecked.jpg"];
    
    [topAllButton setBackgroundImage:matchall forState:UIControlStateNormal];
    [topAllButton setBackgroundImage:matchallpressed forState:UIControlStateHighlighted];
    [topAllButton setBackgroundImage:matchallchecked forState:UIControlStateSelected];
 
    
    [topAllButton addTarget:self action:@selector(setAllTag) forControlEvents:UIControlEventTouchUpInside];
    
    
    topAllButton.tag = 333;
    

    [topFilterView addSubview:topAllButton];
    
    
    
    scrollRacksInTopFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, labelwidth, 290)];
    
    scrollRacksInTopFilterView.tag = 36;
    
    viewRacksInTopFilterView = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 290)];
    
    viewRacksInTopFilterView.tag = 37;
    
    scrollRacksInTopFilterView.backgroundColor = [UIColor whiteColor];
    
    viewRacksInTopFilterView.backgroundColor = [UIColor whiteColor];
    
    
    
    [scrollRacksInTopFilterView addSubview:viewRacksInTopFilterView];
    
    [topFilterView addSubview:scrollRacksInTopFilterView];
    
    [self.view addSubview:topFilterView];
    
        [self loadRackFilterListInViewInScroll:viewRacksInTopFilterView withCategory:currentcategorytopscroll];
}

-(void) loadRightFilter
{
    
    [rightFilterView removeFromSuperview];
    
    labelwidth = 120;
    rightFilterView = [[UIView alloc] initWithFrame:CGRectMake(319,58,0,0)];
    rightFilterView.tag = 90;
    
    rightFilterView.backgroundColor = [UIColor whiteColor];
    rightFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    rightFilterView.layer.borderWidth = 2;
     scrollCategoriesInRightFilterView.showsHorizontalScrollIndicator= NO;
    
    rightFilterView.clipsToBounds = YES;
    
    
    
    
    scrollCategoriesInRightFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 40)];
    
    scrollCategoriesInRightFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    scrollCategoriesInRightFilterView.layer.borderWidth = 2;
    
    
    
    scrollCategoriesInRightFilterView.tag = 90;
    
    scrollCategoriesInRightFilterView.pagingEnabled = YES;
    scrollCategoriesInRightFilterView.delegate = self;
    
    [self loadCategoryArchive:scrollCategoriesInRightFilterView];
    
    
    scrollCategoriesInRightFilterView.contentOffset = CGPointMake(currentcategoryrightscroll*labelwidth, 0);
    
    [rightFilterView addSubview:scrollCategoriesInRightFilterView];
    
    
    UIImage *bar =[UIImage imageNamed:@"bar.jpg"];
    
    
    UIImageView *barview = [[UIImageView alloc] initWithImage:bar];
    barview.frame = CGRectMake(0, 325, 120, 4);
    
    [rightFilterView addSubview:barview];
    
    
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 330, 110, 20)];
    filterLabel.text = @"Search by tag(s):";
    filterLabel.textColor = [UIColor blackColor];
         filterLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
    
    
    [rightFilterView addSubview:filterLabel];
    
    
    searchtagfieldright = [[UITextView alloc] initWithFrame:CGRectMake(5, 355, 110, 35)];
    
    searchtagfieldright.layer.borderColor = [[UIColor grayColor] CGColor];
    searchtagfieldright.layer.borderWidth = 2;
    searchtagfieldright.layer.cornerRadius = 5;
    
    //searchtagfield.layer.shadowColor = [[UIColor blackColor] CGColor];
    //searchtagfield.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    //searchtagfield.layer.shadowOpacity = 1.0;
    //searchtagfield.layer.shadowRadius = 6.0;
    
    
    searchtagfieldright.delegate = self;
    
    searchtagfieldright.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    searchtagfieldright.text = searchtagright;
    
    [rightFilterView addSubview:searchtagfieldright];
    
    
    
    rightAllButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 395, 110, 20)];
    rightAllButton.titleLabel.text = @"     Match All";
    rightAllButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    rightAllButton.titleLabel.textColor = [UIColor lightGrayColor];

    rightAllButton.clipsToBounds = YES;
    if (savedrightandfilter == NO)
    {
       
        [rightAllButton setSelected:NO];
    }
    else
    {
        [rightAllButton setSelected:YES];
    }
    UIImage *matchallpressed = [UIImage imageNamed:@"matchallpressed.jpg"];
    UIImage *matchall = [UIImage imageNamed:@"matchall.jpg"];
    UIImage *matchallchecked = [UIImage imageNamed:@"matchallchecked.jpg"];
    
    [rightAllButton setBackgroundImage:matchall forState:UIControlStateNormal];
    [rightAllButton setBackgroundImage:matchallpressed forState:UIControlStateHighlighted];
    [rightAllButton setBackgroundImage:matchallchecked forState:UIControlStateSelected];
    
    
    [rightAllButton addTarget:self action:@selector(setAllTag) forControlEvents:UIControlEventTouchUpInside];
    
    
    rightAllButton.tag = 333;
    
    [rightFilterView addSubview:rightAllButton];
    
    
    
    scrollRacksInRightFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, labelwidth, 285)];
    
    scrollRacksInRightFilterView.tag = 38;
    
    viewRacksInRightFilterView = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 285)];
    
    viewRacksInRightFilterView.tag = 39;
    
    scrollRacksInRightFilterView.backgroundColor = [UIColor whiteColor];
    
    viewRacksInRightFilterView.backgroundColor = [UIColor whiteColor];
    
    
    
    [scrollRacksInRightFilterView addSubview:viewRacksInRightFilterView];
    
    [rightFilterView addSubview:scrollRacksInRightFilterView];
    
    [self.view addSubview:rightFilterView];

    

    
        [self loadRackFilterListInViewInScroll:viewRacksInRightFilterView withCategory:currentcategoryrightscroll];
    
}


-(void) loadLowerFilter
{
    
    [lowerFilterView removeFromSuperview];
    
    labelwidth = 120;
    lowerFilterView = [[UIView alloc] initWithFrame:CGRectMake(0, 467, 0, 0)];
    lowerFilterView.tag = 91;
    
    lowerFilterView.backgroundColor = [UIColor whiteColor];
    lowerFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    lowerFilterView.layer.borderWidth = 2;
    
     scrollCategoriesInLowerFilterView.showsHorizontalScrollIndicator= NO;
    lowerFilterView.clipsToBounds = YES;
    
    
    
    
    scrollCategoriesInLowerFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 40)];
    
    scrollCategoriesInLowerFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    scrollCategoriesInLowerFilterView.layer.borderWidth = 2;
    
    
    
    scrollCategoriesInLowerFilterView.tag = 91;
    
    scrollCategoriesInLowerFilterView.pagingEnabled = YES;
    scrollCategoriesInLowerFilterView.delegate = self;
    
    [self loadCategoryArchive:scrollCategoriesInLowerFilterView];
    
    
    scrollCategoriesInLowerFilterView.contentOffset = CGPointMake(currentcategorylowerscroll*labelwidth, 0);
    
    [lowerFilterView addSubview:scrollCategoriesInLowerFilterView];
    
    
    UIImage *bar =[UIImage imageNamed:@"bar.jpg"];
    
    
    UIImageView *barview = [[UIImageView alloc] initWithImage:bar];
    barview.frame = CGRectMake(0, 345, 120, 4);
    
    [lowerFilterView addSubview:barview];
    
    
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 350, 110, 20)];
    filterLabel.text = @"Search by tag(s):";
    filterLabel.textColor = [UIColor blackColor];
         filterLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
    
    
    [lowerFilterView addSubview:filterLabel];
    
    
    searchtagfieldlower = [[UITextView alloc] initWithFrame:CGRectMake(5, 375, 110, 35)];
    
    searchtagfieldlower.layer.borderColor = [[UIColor grayColor] CGColor];
    searchtagfieldlower.layer.borderWidth = 2;
    searchtagfieldlower.layer.cornerRadius = 5;
    
    //searchtagfield.layer.shadowColor = [[UIColor blackColor] CGColor];
    //searchtagfield.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    //searchtagfield.layer.shadowOpacity = 1.0;
    //searchtagfield.layer.shadowRadius = 6.0;
    
    
    searchtagfieldlower.delegate = self;
    
    searchtagfieldlower.text = searchtaglower;
    
    searchtagfieldlower.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    
    [lowerFilterView addSubview:searchtagfieldlower];
    
    
    
    lowerAllButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 415, 110, 20)];
    lowerAllButton.titleLabel.text = @"     Match All";
    lowerAllButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    lowerAllButton.titleLabel.textColor = [UIColor lightGrayColor];
    //lowerAllButton.layer.borderColor = [[UIColor grayColor] CGColor];
    //lowerAllButton.layer.borderWidth = 2;
    //lowerAllButton.layer.cornerRadius = 5;
    lowerAllButton.clipsToBounds = YES;
    if (savedlowerandfilter == NO)
    {
        [lowerAllButton setSelected:NO];
    }
    else
    {
        [lowerAllButton setSelected:YES];
    }
    UIImage *matchallpressed = [UIImage imageNamed:@"matchallpressed.jpg"];
    UIImage *matchall = [UIImage imageNamed:@"matchall.jpg"];
    UIImage *matchallchecked = [UIImage imageNamed:@"matchallchecked.jpg"];
    
    [lowerAllButton setBackgroundImage:matchall forState:UIControlStateNormal];
    [lowerAllButton setBackgroundImage:matchallpressed forState:UIControlStateHighlighted];
    [lowerAllButton setBackgroundImage:matchallchecked forState:UIControlStateSelected];
    
    
    [lowerAllButton addTarget:self action:@selector(setAllTag) forControlEvents:UIControlEventTouchUpInside];
    
    
    lowerAllButton.tag = 333;
    
    
    [lowerFilterView addSubview:lowerAllButton];
    
    
    
    scrollRacksInLowerFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, labelwidth, 305)];
    
    scrollRacksInLowerFilterView.tag = 40;
    
    viewRacksInLowerFilterView = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 305)];
    
    viewRacksInLowerFilterView.tag = 41;
    
    scrollRacksInLowerFilterView.backgroundColor = [UIColor whiteColor];
    
    viewRacksInLowerFilterView.backgroundColor = [UIColor whiteColor];
    
    
    
    [scrollRacksInLowerFilterView addSubview:viewRacksInLowerFilterView];
    
    [lowerFilterView addSubview:scrollRacksInLowerFilterView];
    
    [self.view addSubview:lowerFilterView];
    
    
    
    
    [self loadRackFilterListInViewInScroll:viewRacksInLowerFilterView withCategory:currentcategorylowerscroll];
    
}









-(void) loadTopOverlayFilter
{
    
    [topOverlayFilterView removeFromSuperview];
    
    labelwidth = 120;
    topOverlayFilterView = [[UIView alloc] initWithFrame:CGRectMake(0,58,0,0)];
    topOverlayFilterView.tag = 92;
    
    topOverlayFilterView.backgroundColor = [UIColor whiteColor];
    topOverlayFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    topOverlayFilterView.layer.borderWidth = 2;
    scrollCategoriesInTopOverlayFilterView.showsHorizontalScrollIndicator= NO;
    
    topOverlayFilterView.clipsToBounds = YES;
    
    
    
    
    scrollCategoriesInTopOverlayFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 40)];
    
    scrollCategoriesInTopOverlayFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    scrollCategoriesInTopOverlayFilterView.layer.borderWidth = 2;
    
    
    
    scrollCategoriesInTopOverlayFilterView.tag = 92;
    
    scrollCategoriesInTopOverlayFilterView.pagingEnabled = YES;
    scrollCategoriesInTopOverlayFilterView.delegate = self;
    
    [self loadCategoryArchive:scrollCategoriesInTopOverlayFilterView];
    
    
    scrollCategoriesInTopOverlayFilterView.contentOffset = CGPointMake(currentcategorytopoverlayscroll*labelwidth, 0);
    
    [topOverlayFilterView addSubview:scrollCategoriesInTopOverlayFilterView];
    
    
    UIImage *bar =[UIImage imageNamed:@"bar.jpg"];
    
    
    UIImageView *barview = [[UIImageView alloc] initWithImage:bar];
    barview.frame = CGRectMake(0, 325, 120, 4);
    
    [topOverlayFilterView addSubview:barview];
    
    
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 330, 110, 20)];
    filterLabel.text = @"Tag filter";
    filterLabel.textColor = [UIColor blackColor];
    filterLabel.font = [UIFont fontWithName:@"Futura" size:14];
    
    
    [topOverlayFilterView addSubview:filterLabel];
    
    
    searchtagfieldtopoverlay = [[UITextView alloc] initWithFrame:CGRectMake(5, 355, 110, 35)];
    
    searchtagfieldtopoverlay.layer.borderColor = [[UIColor grayColor] CGColor];
    searchtagfieldtopoverlay.layer.borderWidth = 2;
    searchtagfieldtopoverlay.layer.cornerRadius = 5;
    
    //searchtagfield.layer.shadowColor = [[UIColor blackColor] CGColor];
    //searchtagfield.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    //searchtagfield.layer.shadowOpacity = 1.0;
    //searchtagfield.layer.shadowRadius = 6.0;
    
    
    searchtagfieldtopoverlay.delegate = self;
    
    searchtagfieldtopoverlay.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    searchtagfieldtopoverlay.text = searchtagtopoverlay;
    
    [topOverlayFilterView addSubview:searchtagfieldtopoverlay];
    
    
    
    topOverlayAllButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 395, 110, 20)];
    topOverlayAllButton.titleLabel.text = @"     Match All";
    topOverlayAllButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    topOverlayAllButton.titleLabel.textColor = [UIColor lightGrayColor];
    
    topOverlayAllButton.clipsToBounds = YES;
    if (savedtopoverlayandfilter == NO)
    {
        
        [topOverlayAllButton setSelected:NO];
    }
    else
    {
        [topOverlayAllButton setSelected:YES];
    }
    UIImage *matchallpressed = [UIImage imageNamed:@"matchallpressed.jpg"];
    UIImage *matchall = [UIImage imageNamed:@"matchall.jpg"];
    UIImage *matchallchecked = [UIImage imageNamed:@"matchallchecked.jpg"];
    
    [topOverlayAllButton setBackgroundImage:matchall forState:UIControlStateNormal];
    [topOverlayAllButton setBackgroundImage:matchallpressed forState:UIControlStateHighlighted];
    [topOverlayAllButton setBackgroundImage:matchallchecked forState:UIControlStateSelected];
    
    
    [topOverlayAllButton addTarget:self action:@selector(setAllTag) forControlEvents:UIControlEventTouchUpInside];
    
    
    topOverlayAllButton.tag = 333;
    
    [topOverlayFilterView addSubview:topOverlayAllButton];
    
    
    
    scrollRacksInTopOverlayFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, labelwidth, 285)];
    
    scrollRacksInTopOverlayFilterView.tag = 38;
    
    viewRacksInTopOverlayFilterView = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 285)];
    
    viewRacksInTopOverlayFilterView.tag = 39;
    
    scrollRacksInTopOverlayFilterView.backgroundColor = [UIColor whiteColor];
    
    viewRacksInTopOverlayFilterView.backgroundColor = [UIColor whiteColor];
    
    
    
    [scrollRacksInTopOverlayFilterView addSubview:viewRacksInTopOverlayFilterView];
    
    [topOverlayFilterView addSubview:scrollRacksInTopOverlayFilterView];
    
    [self.view addSubview:topOverlayFilterView];
    
    
    
    
    [self loadRackFilterListInViewInScroll:viewRacksInTopOverlayFilterView withCategory:currentcategorytopoverlayscroll];
    
}



-(void) loadAccessoriesFilter
{
    
    [accessoriesFilterView removeFromSuperview];
    
    labelwidth = 120;
    accessoriesFilterView = [[UIView alloc] initWithFrame:CGRectMake(0, 447, 0, 0)];
    accessoriesFilterView.tag = 93;
    
    accessoriesFilterView.backgroundColor = [UIColor whiteColor];
    accessoriesFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    accessoriesFilterView.layer.borderWidth = 2;
    
    scrollCategoriesInAccessoriesFilterView.showsHorizontalScrollIndicator= NO;
    accessoriesFilterView.clipsToBounds = YES;
    
    
    
    
    scrollCategoriesInAccessoriesFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 40)];
    
    scrollCategoriesInAccessoriesFilterView.layer.borderColor = [[UIColor blackColor] CGColor];
    scrollCategoriesInAccessoriesFilterView.layer.borderWidth = 2;
    
    
    
    scrollCategoriesInAccessoriesFilterView.tag = 93;
    
    scrollCategoriesInAccessoriesFilterView.pagingEnabled = YES;
    scrollCategoriesInAccessoriesFilterView.delegate = self;
    
    [self loadCategoryArchive:scrollCategoriesInAccessoriesFilterView];
    
    
    scrollCategoriesInAccessoriesFilterView.contentOffset = CGPointMake(currentcategoryaccessoriesscroll*labelwidth, 0);
    
    [accessoriesFilterView addSubview:scrollCategoriesInAccessoriesFilterView];
    
    
    UIImage *bar =[UIImage imageNamed:@"bar.jpg"];
    
    
    UIImageView *barview = [[UIImageView alloc] initWithImage:bar];
    barview.frame = CGRectMake(0, 345, 120, 4);
    
    [accessoriesFilterView addSubview:barview];
    
    
    
    UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 350, 110, 20)];
    filterLabel.text = @"Search by tag(s):";
    filterLabel.textColor = [UIColor blackColor];
    filterLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
    
    
    [accessoriesFilterView addSubview:filterLabel];
    
    
    searchtagfieldaccessories = [[UITextView alloc] initWithFrame:CGRectMake(5, 375, 110, 35)];
    
    searchtagfieldaccessories.layer.borderColor = [[UIColor grayColor] CGColor];
    searchtagfieldaccessories.layer.borderWidth = 2;
    searchtagfieldaccessories.layer.cornerRadius = 5;
    
    //searchtagfield.layer.shadowColor = [[UIColor blackColor] CGColor];
    //searchtagfield.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    //searchtagfield.layer.shadowOpacity = 1.0;
    //searchtagfield.layer.shadowRadius = 6.0;
    
    
    searchtagfieldaccessories.delegate = self;
    
    searchtagfieldaccessories.text = searchtagaccessories;
    
    searchtagfieldaccessories.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    
    [accessoriesFilterView addSubview:searchtagfieldaccessories];
    
    
    
    accessoriesAllButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 415, 110, 20)];
    accessoriesAllButton.titleLabel.text = @"     Match All";
    accessoriesAllButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
    accessoriesAllButton.titleLabel.textColor = [UIColor lightGrayColor];
    //accessoriesAllButton.layer.borderColor = [[UIColor grayColor] CGColor];
    //accessoriesAllButton.layer.borderWidth = 2;
    //accessoriesAllButton.layer.cornerRadius = 5;
    accessoriesAllButton.clipsToBounds = YES;
    if (savedaccessoriesandfilter == NO)
    {
        [accessoriesAllButton setSelected:NO];
    }
    else
    {
        [accessoriesAllButton setSelected:YES];
    }
    UIImage *matchallpressed = [UIImage imageNamed:@"matchallpressed.jpg"];
    UIImage *matchall = [UIImage imageNamed:@"matchall.jpg"];
    UIImage *matchallchecked = [UIImage imageNamed:@"matchallchecked.jpg"];
    
    [accessoriesAllButton setBackgroundImage:matchall forState:UIControlStateNormal];
    [accessoriesAllButton setBackgroundImage:matchallpressed forState:UIControlStateHighlighted];
    [accessoriesAllButton setBackgroundImage:matchallchecked forState:UIControlStateSelected];
    
    
    [accessoriesAllButton addTarget:self action:@selector(setAllTag) forControlEvents:UIControlEventTouchUpInside];
    
    
    accessoriesAllButton.tag = 333;
    
    
    [accessoriesFilterView addSubview:accessoriesAllButton];
    
    
    
    scrollRacksInAccessoriesFilterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, labelwidth, 305)];
    
    scrollRacksInAccessoriesFilterView.tag = 40;
    
    viewRacksInAccessoriesFilterView = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, labelwidth, 305)];
    
    viewRacksInAccessoriesFilterView.tag = 41;
    
    scrollRacksInAccessoriesFilterView.backgroundColor = [UIColor whiteColor];
    
    viewRacksInAccessoriesFilterView.backgroundColor = [UIColor whiteColor];
    
    
    
    [scrollRacksInAccessoriesFilterView addSubview:viewRacksInAccessoriesFilterView];
    
    [accessoriesFilterView addSubview:scrollRacksInAccessoriesFilterView];
    
    [self.view addSubview:accessoriesFilterView];
    
    
    
    
    [self loadRackFilterListInViewInScroll:viewRacksInAccessoriesFilterView withCategory:currentcategoryaccessoriesscroll];
    
}


                                            //END VIEWCONTROLLER INITIALIZATIONS


-(void) loadLogin
{
    
    int originX = self.view.frame.size.width/2 - 100;
    int originY = self.view.frame.size.height/2 - 75;
    
    
    
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 100)];
    
    loginView.backgroundColor = [UIColor blackColor];
    
    
    loginView.tag = 30;
    
    [self.view addSubview:loginView];
    
    
    UITextField *usernamefield = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 100, 25)];
    usernamefield.backgroundColor = [UIColor whiteColor];
    usernamefield.userInteractionEnabled = YES;
    usernamefield.borderStyle = UITextBorderStyleRoundedRect;
    usernamefield.delegate = self;
    
    [loginView addSubview:usernamefield];
}


 TKCalendarMonthView *calendar;

// Show/Hide the calendar by sliding it down/up from the top of the device.
- (void)toggleCalendar {
	// If calendar is off the screen, show it, else hide it (both with animations)
      
    UIView *temp = [self retrieveView:6102]; 
   
    
    if(calremove == FALSE)
    {
   
        temp.userInteractionEnabled = NO;
       
        calendar = 	[[TKCalendarMonthView alloc] init];
        calendar.delegate = self;
        calendar.dataSource = self;
        // Add Calendar to just off the top of the screen so it can later slide down
        calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);
        // Ensure this is the last "addSubview" because the calendar must be the top most view layer	
        [self.view addSubview:calendar];
        [calendar reload];
    
 
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
		[UIView commitAnimations];
      
    }
    
    
    else if(calremove == TRUE)
    {
        NSLog(@"hide calendar");
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);		
		[UIView commitAnimations];
        
        UIView *temp = [self retrieveView:6102];
        
        temp.userInteractionEnabled = YES;
        
        calremove = FALSE;

	}	
    
    
    
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

UIPickerView *assignedDatesPicker;

NSMutableArray *selectedDatesArray;

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
    
    int daysToAdd = 1;
    NSDate *newDate1 = [d dateByAddingTimeInterval:60*60*24*daysToAdd];

    
    NSLog(@"%@", d);
    NSLog(@"new date %@", newDate1);
    
    
    
    BOOL duplicatedate;
    duplicatedate = FALSE;
    
    for(int x = 0; x<[selectedDatesArray count]; x++)
    {
        NSDate *tempdate = [selectedDatesArray objectAtIndex:x];
        if([tempdate compare:d] == NSOrderedSame)
        {
            duplicatedate = TRUE;
            break;
        }
        
    }
    
    
    if(duplicatedate == FALSE)
    {
        [selectedDatesArray addObject:d];
    
        [selectedDatesArray sortUsingSelector:@selector(compare:)];
    
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
    
    for (int x = 0; x < [myCloset.dateRecords count]; x++)
    {
        DateRecord *temprecord = [myCloset.dateRecords objectAtIndex:x];
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





-(IBAction) loadOutfitModeMenu
{
    
    if([self doesViewAlreadyExist:100] == NO &&
       [self doesViewAlreadyExist:89] == NO && 
       [self doesViewAlreadyExist:90] == NO && 
       [self doesViewAlreadyExist:91] == NO)
    {
        UIView *outfitModeMenu = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 200, 150)];
        outfitModeMenu.tag = 100;
        outfitModeMenu.backgroundColor = [UIColor whiteColor];

        for(int x = 0; x < [outfitModesArray count]; x++)
        {
            CGFloat yOrigin = x * (labelheight + 10);
            
            UILabel *outfitmodelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yOrigin, 200, labelheight)];
            
            outfitmodelabel.text = [outfitModesArray objectAtIndex:x];
            outfitmodelabel.font = [UIFont boldSystemFontOfSize:14];
            
            outfitmodelabel.tag = 100+x;
            
            outfitmodelabel.userInteractionEnabled = YES;
        
 
            outfitmodelabel.textColor = [UIColor blackColor];
            outfitmodelabel.backgroundColor = [UIColor whiteColor];
 
        
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
        
            [tap setNumberOfTapsRequired:1];
            [tap setNumberOfTouchesRequired:1];
        
            [outfitmodelabel addGestureRecognizer:tap];
            
            [outfitModeMenu addSubview:outfitmodelabel];
        
        }
        [self.view addSubview:outfitModeMenu];
    }
    else if([self doesViewAlreadyExist:100]==YES)
    {
        UIView *removeoutfitview = [self retrieveView:100];
        [removeoutfitview removeFromSuperview];
    }

    
}





- (void)keyboardDidShow: (NSNotification *) notif{
    
    
    CGPoint positionWithKeyboard = CGPointMake(self.view.center.x, self.view.center.y -210);
    
    if(![self retrieveView:6102])
    {

    [UIView beginAnimations:@"rearranging tiles" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.view.center = positionWithKeyboard;
    
        
        shiftedUp = YES;
    
    [UIView commitAnimations];
    }

    if(outfitNameEditOn)
    {
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithKeyboard;
        
        
        shiftedUp = YES;
        
        [UIView commitAnimations];
        
        
    }


    

}

- (void)keyboardDidHide: (NSNotification *) notif{
    CGPoint originalPositon = CGPointMake(self.view.center.x, self.view.center.y +210);
    
    
    if(![self retrieveView:6102] && shiftedUp == YES)
    {
    
    [UIView beginAnimations:@"rearranging tiles" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    self.view.center = originalPositon;
        
        shiftedUp = NO;
    
    [UIView commitAnimations];
    }
    
    if(outfitNameEditOn)
    {
        outfitNameEditOn = NO;
        shiftedUp = NO;
    }

}


-(void)clearViewInScroll: (UIViewInScroll *) scrolltoclear
{
    int scrollcount = [scrolltoclear.subviews count];
    
    for(int x=0; x < scrollcount; ++x)
    {
        UIImageView *removescrollitem = [scrolltoclear.subviews objectAtIndex:0];
        [removescrollitem removeFromSuperview];
        NSLog(@"CLEARED SCROLL");
    }
    
    
}

-(void)clearFilterViewInScroll: (UIViewInScroll *) scrolltoclear
{
    int scrollcount = [scrolltoclear.subviews count];
    
    for(int x=0; x < scrollcount; ++x)
    {
        UIView *removescrollitem = [scrolltoclear.subviews objectAtIndex:0];
        [removescrollitem removeFromSuperview];
        NSLog(@"CLEARED SCROLL");
    }
    
    
}




                                            //START LOAD ARCHIVE

-(void) archiveCatNumbers
{
    lastLowerCategoryNum = [NSNumber numberWithInt:currentcategorylowerscroll];
    lastTopCategoryNum = [NSNumber numberWithInt:currentcategorytopscroll];
    lastTopOverlayCategoryNum = [NSNumber numberWithInt:currentcategorytopoverlayscroll];
    
    lastRightCategoryNum = [NSNumber numberWithInt:currentcategoryrightscroll];
    [NSKeyedArchiver archiveRootObject:lastLowerCategoryNum toFile:pathlastlowercatnum];
    [NSKeyedArchiver archiveRootObject:lastRightCategoryNum toFile:pathlastrightcatnum];
    [NSKeyedArchiver archiveRootObject:lastTopCategoryNum toFile:pathlasttopcatnum];
    
    [NSKeyedArchiver archiveRootObject:lastTopOverlayCategoryNum toFile:pathlasttopoverlaycatnum];
}



-(void) loadAllArchivesWithCats:(int)a :(int)b :(int)c :(int)d
{
    
    NSLog(@"loading ALL ARCHIVES!!!! from %@", pathcloset);
    
  
       [self loadHorizontalArchive:a inViewInScroll:viewInScrollTops]; //top
    
        [self loadVerticalArchive:b inViewInScroll:viewInScrollBottoms]; //right
    
        [self loadHorizontalArchive:c inViewInScroll:viewInScrollShoes]; //lower
    
    
       // [self loadVerticalArchive:d inViewInScroll:viewInScrollTopsOverlay]; //top overlay
 
    
     //[self loadHorizontalArchive:5 inViewInScroll:viewInScrollAccessories];
    
    Category *tempcategory;
    
    tempcategory = [myCloset.categories objectAtIndex:a];
    currenttopscrollcatname = [NSString stringWithString:tempcategory.categoryname];
    NSLog(@"curren top scroll name is %@", currenttopscrollcatname);
    
     
    tempcategory = [myCloset.categories objectAtIndex:c];
    currentlowerscrollcatname = [NSString stringWithString:tempcategory.categoryname];
      NSLog(@"current lower scroll name is %@", currentlowerscrollcatname);
    
    tempcategory = [myCloset.categories objectAtIndex:b];
    currentrightscrollcatname = [NSString stringWithString:tempcategory.categoryname];
      NSLog(@"current right scroll name is %@", currentrightscrollcatname);
    
    
    
    tempcategory = [myCloset.categories objectAtIndex:5];
    currenttopoverlayscrollcatname = [NSString stringWithString:tempcategory.categoryname];
    NSLog(@"current topoverlay scroll name is %@", currentrightscrollcatname);
    

}







-(void) loadVerticalArchive:(int)categorynum inViewInScroll: (UIViewInScroll *) viewinscroll
{
    
    viewinscroll.categorynum = categorynum;
    
    NSLog(@"cat number loaded is %i", viewinscroll.categorynum);
    [self clearViewInScroll:viewinscroll];
    
    
    
    UIImage *retrievedImage;
    ImageRecord *retrievedRecord;
    Category *tempcategory;
    tempcategory = [myCloset.categories objectAtIndex:categorynum];
    
    NSString *searchtag;
   
    BOOL ANDfilter;
    if(viewinscroll.tag == 30000) 
    {
        searchtag = searchtagtop;
        ANDfilter = savedtopandfilter;
       
        
    }
    if(viewinscroll.tag == 30001) 
    {
        searchtag = searchtagright;
        ANDfilter = savedrightandfilter;
       
    }
    if(viewinscroll.tag == 30002)
    {
        searchtag = searchtaglower;
        ANDfilter = savedlowerandfilter;
        
    }
    if(viewinscroll.tag == 30003)
    {
        searchtag = searchtagtopoverlay;
        ANDfilter = savedtopoverlayandfilter;
        
    }
    if(viewinscroll.tag == 30004)
    {
        searchtag = searchtagaccessories;
        ANDfilter = savedaccessoriesandfilter;
        
    }
    
    
    NSString *trimmedsearchtag = [searchtag
                                  stringByReplacingOccurrencesOfString:@", " withString:@","];
    NSArray *searchtagarray = [trimmedsearchtag componentsSeparatedByCharactersInSet:
                               [NSCharacterSet characterSetWithCharactersInString:@","]
                               ];   
    
    
     
    
    
    for(int x = 0; x < [searchtagarray count]; ++x)
    {
        NSString *tempstring = [searchtagarray objectAtIndex:x];
        NSLog(@"%@",tempstring);
    }
    for(int x=0; x < [tempcategory.racksarray count]; ++x)
    {
        Rack *temprack = [tempcategory.racksarray objectAtIndex:x];
        
        if (temprack.shouldLoad == YES)
        {
            NSLog(@"%@ should load!", temprack.rackname);
            
            for (int x=0; x < [temprack.rackitemsarray count]; ++x)
            {
                retrievedRecord = [temprack.rackitemsarray objectAtIndex:x];
                retrievedImage = [[UIImage alloc] initWithContentsOfFile:retrievedRecord.imageFilePath];
               
                
                
                NSString *recordtrimmedsearchtag = [retrievedRecord.additionaltags
                                                    stringByReplacingOccurrencesOfString:@", " withString:@","];
                NSArray *recordsearchtagarray = [recordtrimmedsearchtag componentsSeparatedByCharactersInSet:
                                                 [NSCharacterSet characterSetWithCharactersInString:@","]
                                                 ];  
                
                
                if (!searchtag || [searchtag compare:@""] == NSOrderedSame)
                {
                    UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:retrievedImage];
                    
                    
                    CGFloat yOrigin = ([viewinscroll.subviews count]) * (scrollimageheight + 10);
                    
                    
                    archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
                    archiveImageView.frame = CGRectMake(viewinscroll.frame.size.width/2 - scrollimagewidth/2, yOrigin, scrollimagewidth, scrollimageheight);
                    archiveImageView.fileNumRef = retrievedRecord.fileNumRef;
                    archiveImageView.tag = x+1;
                    archiveImageView.categoryType = retrievedRecord.categoryType;
                    archiveImageView.catname = retrievedRecord.catName;
                    archiveImageView.rackname = retrievedRecord.rackName;
                    
                    
                    [archiveImageView setUserInteractionEnabled:YES];
                    
                    
                    
                    [viewinscroll addSubview:archiveImageView];
                    
                    viewinscroll.frame = CGRectMake(scrollBottoms.frame.size.width/2 - scrollimagewidth/2, outfitDisplay.center.y - scrollBottoms.frame.origin.y - (scrollimageheight/2), scrollimagewidth, ([viewinscroll.subviews count]+4) * (scrollimageheight + 10));
                    
                    
                    UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
                    tempScroll.contentSize = CGSizeMake(scrollimagewidth, ([viewinscroll.subviews count]+6) * (scrollimageheight + 10));

                }
                else
                {
                    int count = 0;
                    
                    for(int x = 0; x < [searchtagarray count]; ++x)
                    {
                        NSLog(@"tag:%@", [searchtagarray objectAtIndex:x]);
                        if (
                            
                            
                            [retrievedRecord.color caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame ||
                            [retrievedRecord.occasion caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame ||
                            [retrievedRecord.brand caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame  ) 
                            
                        /*||
                         [retrievedRecord.additionaltags caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame*/
                        {
                            NSLog(@"compared %@ %@ %@ %@, with %@", retrievedRecord.color, retrievedRecord.occasion, retrievedRecord.brand,
                                  retrievedRecord.additionaltags, [searchtagarray objectAtIndex:x]);
                            
                            count++;
                            NSLog(@"increasing count");
                        }
                        
                        
                        NSLog(@"%i record tag count", [recordsearchtagarray count]);
                        
                        for(int g=0;  g< [recordsearchtagarray count]; g++)
                        {
                            if ( [[searchtagarray objectAtIndex:x] caseInsensitiveCompare:[recordsearchtagarray objectAtIndex:g]] == NSOrderedSame){
                                count++;
                                
                            }
                            NSLog(@"%@ in record searchtag!!", [recordsearchtagarray objectAtIndex:g]);
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    if (count != 0 && ANDfilter == NO)
                    {
                        
                        UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:retrievedImage];
                        
                        
                        CGFloat yOrigin = ([viewinscroll.subviews count]) * (scrollimageheight + 10);
                        
                        
                        archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
                        archiveImageView.frame = CGRectMake(0, yOrigin, scrollimagewidth, scrollimageheight);
                        archiveImageView.fileNumRef = retrievedRecord.fileNumRef;
                        archiveImageView.tag = x+1;
                        archiveImageView.categoryType = retrievedRecord.categoryType;
                        
                        archiveImageView.catname = retrievedRecord.catName;
                        archiveImageView.rackname = retrievedRecord.rackName;
                        
                        [archiveImageView setUserInteractionEnabled:YES];
                        
                        
                        
                        [viewinscroll addSubview:archiveImageView];
                        
                        viewinscroll.frame = CGRectMake(scrollBottoms.frame.size.width/2 - scrollimagewidth/2, outfitDisplay.center.y - scrollBottoms.frame.origin.y - (scrollimageheight/2), scrollimagewidth, ([viewinscroll.subviews count]+4) * (scrollimageheight + 10));
                        
                        
                        UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
                        tempScroll.contentSize = CGSizeMake(scrollimagewidth, ([viewinscroll.subviews count]+6) * (scrollimageheight + 10));
                    }
                    
                    
                    else if(count == [searchtagarray count] && ANDfilter == YES)
                        
                    { 
                        UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:retrievedImage];
                        
                        
                        CGFloat yOrigin = ([viewinscroll.subviews count]) * (scrollimageheight + 10);
                        
                        
                        
                        archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
                        archiveImageView.frame = CGRectMake(0, yOrigin, scrollimagewidth, scrollimageheight);
                        archiveImageView.fileNumRef = retrievedRecord.fileNumRef;
                        archiveImageView.tag = x+1;
                        archiveImageView.categoryType = retrievedRecord.categoryType;
                        
                        archiveImageView.catname = retrievedRecord.catName;
                        archiveImageView.rackname = retrievedRecord.rackName;
                        
                        [archiveImageView setUserInteractionEnabled:YES];
                        
                        
                        
                        [viewinscroll addSubview:archiveImageView];
                        
                        viewinscroll.frame = CGRectMake(scrollBottoms.frame.size.width/2 - scrollimagewidth/2, outfitDisplay.center.y - scrollBottoms.frame.origin.y - (scrollimageheight/2), scrollimagewidth, ([viewinscroll.subviews count]+4) * (scrollimageheight + 10));
                        
                        
                        UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
                        tempScroll.contentSize = CGSizeMake(scrollimagewidth, ([viewinscroll.subviews count]+6) * (scrollimageheight + 10));
                    }
                    
                    
                    
                }
            }
        }
    }
    
    UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
    
    tempScroll.contentOffset = CGPointMake(0, 0);
}


-(void) loadHorizontalArchive: (int) categorynum inViewInScroll: (UIViewInScroll *) viewinscroll
{
    
    viewinscroll.categorynum = categorynum;
    [self clearViewInScroll:viewinscroll];
    
    UIImage *retrievedImage;
    ImageRecord *retrievedRecord;
    Category *tempcategory;
    
    
    tempcategory = [myCloset.categories objectAtIndex:categorynum];
    
    NSLog(@"racksarray count in category is %i", [tempcategory.racksarray count]);
    
    
    
    
    //break searchtagtop into array of strings
    
    NSString *searchtag;
    BOOL ANDfilter;
    
    if(viewinscroll.tag == 30000) 
    {
        searchtag = searchtagtop;
        ANDfilter = savedtopandfilter;
        
    }
    if(viewinscroll.tag == 30001) 
    {
        searchtag = searchtagright;
        ANDfilter = savedrightandfilter;
    }
    if(viewinscroll.tag == 30002)
    {
        searchtag = searchtaglower;
        ANDfilter = savedlowerandfilter;
    }
    if(viewinscroll.tag == 30003)
    {
        searchtag = searchtagtopoverlay;
        ANDfilter = savedtopoverlayandfilter;
        
    }
    if(viewinscroll.tag == 30004)
    {
        searchtag = searchtagaccessories;
        ANDfilter = savedaccessoriesandfilter;
    }
 
    
    NSString *trimmedsearchtag = [searchtag
                               stringByReplacingOccurrencesOfString:@", " withString:@","];
    NSArray *searchtagarray = [trimmedsearchtag componentsSeparatedByCharactersInSet:
                        [NSCharacterSet characterSetWithCharactersInString:@","]
                        ];   

    for(int x = 0; x < [searchtagarray count]; ++x)
    {
        NSString *tempstring = [searchtagarray objectAtIndex:x];
        NSLog(@"%@",tempstring);
    }
    
    
    
    
    
    
    for(int x=0; x < [tempcategory.racksarray count]; ++x)
    {
        Rack *temprack = [tempcategory.racksarray objectAtIndex:x];
        
        if (temprack.shouldLoad == YES)
        {
            NSLog(@"%@ should load!", temprack.rackname);
        
            for (int x=0; x < [temprack.rackitemsarray count]; ++x)
            {
                retrievedRecord = [temprack.rackitemsarray objectAtIndex:x];
                retrievedImage = [[UIImage alloc] initWithContentsOfFile:retrievedRecord.imageFilePath];
                NSLog(@"record path is %@", retrievedRecord.imageFilePath);
                
                NSLog(@"additional tags ARE THE FOLLOWING %@", retrievedRecord.additionaltags);
                
                NSString *recordtrimmedsearchtag = [retrievedRecord.additionaltags
                                                    stringByReplacingOccurrencesOfString:@", " withString:@","];
                NSArray *recordsearchtagarray = [recordtrimmedsearchtag componentsSeparatedByCharactersInSet:
                                                 [NSCharacterSet characterSetWithCharactersInString:@","]
                                                 ];  
                
                
                if (!searchtag || [searchtag compare:@""] == NSOrderedSame)
                {
                    UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:retrievedImage];
                    
                    
                    CGFloat xOrigin = ([viewinscroll.subviews count] * (scrollimagewidth +10));
                    
                    
                    archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
                    archiveImageView.frame = CGRectMake(xOrigin, viewinscroll.frame.size.height/2 - (scrollimageheight/2), scrollimagewidth, scrollimageheight);
                    archiveImageView.fileNumRef = retrievedRecord.fileNumRef;
                    archiveImageView.tag = x+1;
                    archiveImageView.categoryType = retrievedRecord.categoryType;
                    
                    archiveImageView.catname = retrievedRecord.catName;
                    archiveImageView.rackname = retrievedRecord.rackName;
                    
                    [archiveImageView setUserInteractionEnabled:YES];
                    
                    if (categorynum == 5)
                    {
                        archiveImageView.layer.borderColor = [[UIColor grayColor] CGColor];
                        archiveImageView.layer.borderWidth = 1;
                    }
                    
                    [viewinscroll addSubview:archiveImageView];
                    
                    outfitDisplay.backgroundColor = [UIColor whiteColor];
                    
                    viewinscroll.frame = CGRectMake(outfitDisplay.center.x - scrollTops.frame.origin.x - (scrollimagewidth/2), scrollTops.frame.size.height/2 - scrollimageheight/2, ([viewinscroll.subviews count]+4) * (scrollimagewidth+10), scrollimageheight);
                    
                    UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
                    
                    tempScroll.contentSize = CGSizeMake(([viewinscroll.subviews count]+5) * (scrollimagewidth+10), scrollimageheight);
                }
                else
                {
                    int count = 0;
                    
                    for(int x = 0; x < [searchtagarray count]; ++x)
                    {
                        NSLog(@"tag:%@", [searchtagarray objectAtIndex:x]);
                        if (
                            
                            
                            [retrievedRecord.color caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame ||
                            [retrievedRecord.occasion caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame ||
                            [retrievedRecord.brand caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame  )
                            /*||
                            [retrievedRecord.additionaltags caseInsensitiveCompare:[searchtagarray objectAtIndex:x]] == NSOrderedSame*/
                            {
                                NSLog(@"compared %@ %@ %@ %@, with %@", retrievedRecord.color, retrievedRecord.occasion, retrievedRecord.brand,
                                      retrievedRecord.additionaltags, [searchtagarray objectAtIndex:x]);
                                
                                count++;
                                NSLog(@"increasing count");
                            }
                        
                        
                        
                        NSLog(@"%i record tag count", [recordsearchtagarray count]);
                        
                        for(int g=0;  g< [recordsearchtagarray count]; g++)
                        {
                            if ( [[searchtagarray objectAtIndex:x] caseInsensitiveCompare:[recordsearchtagarray objectAtIndex:g]] == NSOrderedSame){
                                count++;
                                
                            }
                            NSLog(@"%@ in record searchtag!!", [recordsearchtagarray objectAtIndex:g]);
                        
                            
                        }
                    }
                                
                
                    if (count != 0 && ANDfilter == NO)
                    {
                                NSLog(@"%i first block", count);
                    
                                 UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:retrievedImage];
        
                        
                        CGFloat xOrigin = ([viewinscroll.subviews count] * (scrollimagewidth +10));
                        

        
                                 archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
                                 archiveImageView.frame = CGRectMake(xOrigin, viewinscroll.frame.size.height/2 - (scrollimageheight/2), scrollimagewidth, scrollimageheight);
                                 archiveImageView.fileNumRef = retrievedRecord.fileNumRef;
                                 archiveImageView.tag = x+1;
                                 archiveImageView.categoryType = retrievedRecord.categoryType;
                        
                        archiveImageView.catname = retrievedRecord.catName;
                        archiveImageView.rackname = retrievedRecord.rackName;
                        
                                 [archiveImageView setUserInteractionEnabled:YES];
                        
                        if (categorynum == 5)
                        {
                            archiveImageView.layer.borderColor = [[UIColor grayColor] CGColor];
                            archiveImageView.layer.borderWidth = 1;
                        }
   
                                 [viewinscroll addSubview:archiveImageView];
                        viewinscroll.frame = CGRectMake(outfitDisplay.center.x - scrollTops.frame.origin.x - (scrollimagewidth/2), scrollTops.frame.size.height/2 - scrollimageheight/2, ([viewinscroll.subviews count]+4) * (scrollimagewidth+10), scrollimageheight);
                        
                        UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
                        
                        tempScroll.contentSize = CGSizeMake(([viewinscroll.subviews count]+5) * (scrollimagewidth+10), scrollimageheight);
                    }
                    
                    
                    else if(count == [searchtagarray count] && ANDfilter == YES)
                        
                    { 
                        
                         NSLog(@"%i second block", count);
                        UIScrollImageView *archiveImageView = [[UIScrollImageView alloc] initWithImage:retrievedImage];
                        
                        CGFloat xOrigin = ([viewinscroll.subviews count] * (scrollimagewidth +10));
                        

                        
                        archiveImageView.contentMode = UIViewContentModeScaleAspectFit;
                        archiveImageView.frame = CGRectMake(xOrigin, viewinscroll.frame.size.height/2 - (scrollimageheight/2), scrollimagewidth, scrollimageheight);
                        archiveImageView.fileNumRef = retrievedRecord.fileNumRef;
                        archiveImageView.tag = x+1;
                        archiveImageView.categoryType = retrievedRecord.categoryType;
                        
                        archiveImageView.catname = retrievedRecord.catName;
                        archiveImageView.rackname = retrievedRecord.rackName;
                        
                        [archiveImageView setUserInteractionEnabled:YES];
                        
                        
                        if (categorynum == 5)
                        {
                            archiveImageView.layer.borderColor = [[UIColor grayColor] CGColor];
                            archiveImageView.layer.borderWidth = 1;
                        }
                        
                        [viewinscroll addSubview:archiveImageView];
                        
                        viewinscroll.frame = CGRectMake(outfitDisplay.center.x - scrollTops.frame.origin.x - (scrollimagewidth/2), scrollTops.frame.size.height/2 - scrollimageheight/2, ([viewinscroll.subviews count]+4) * (scrollimagewidth+10), scrollimageheight);
                        
                        UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
                        
                        tempScroll.contentSize = CGSizeMake(([viewinscroll.subviews count]+5) * (scrollimagewidth+10), scrollimageheight);
                        
                        
                        
                    }

                        
                        
                        
                        
                        
                        
                        
                    
                }
            }
        }
    }
    
    
    UIScrollView *tempScroll = (UIScrollView *) viewinscroll.superview;
    
    tempScroll.contentOffset = CGPointMake(0, 0);
}



//END LOAD ARCHIVE






UIScrollImageView *centerImageviewInScroll;
UIScrollImageView *previoustopImageviewInScroll;
UIScrollImageView *previousbottomImageviewInScroll;
UIScrollImageView *previousshoeImageviewInScroll;
UIScrollImageView *previousoverlayImageviewInScroll;

UIImageView *setImageDisplaytoScrollCenterImage;



-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(organizercontroller.organizerOpen)
    {
        NSLog(@"open 1");
    }
    
    
    if(organizercontroller.organizerOpen == FALSE)
    {
    
    
    NSLog(@"scrollview selftag is %i", scrollView.tag);
    
     NSLog(@"FINISHED LOAD rackscrolls subview count is %i point AA", [organizerController.racksScroll.subviews count]);
    
    NSLog(@"scrolling!");
   
    CGPoint centerScrollPoint = CGPointMake(scrollView.frame.origin.x+ scrollView.frame.size.width/2, scrollView.frame.origin.y+scrollView.frame.size.height/2);
    
    centerImageviewInScroll = [scrollView.superview hitTest:centerScrollPoint withEvent:nil];
    
    centerViewInScroll = [scrollView.superview hitTest:centerScrollPoint withEvent:nil];
    
    
    
    if(scrollView.contentOffset.x == scrollView.frame.size.width || scrollView.contentOffset.x == 0){
        
        
    
    
    if ([centerViewInScroll isKindOfClass:[UIView class]] && scrollView.tag == 89  && centerViewInScroll.tag != 89)
    {
        NSLog(@"89, centerviewinscroll tag is %i, current cat is %i", centerViewInScroll.tag, currentcategorytopscroll);
        
        if(!(currentcategorytopscroll == centerViewInScroll.tag))
        {
            
            
            
            
            topChanged = YES;
            NSLog(@"loading....");
            currentcategorytopscroll = centerViewInScroll.tag;
            
           
                if (currentcategorytopscroll == 0)
                {
                    scrollDisplayTopsOverlay.frame = topsOverlayDisplayFrame;
                    
                    if(menuSecondOn)
                    {
                        [self toggleMenuSecond];
                        
                    }
                   
                }
                else if (currentcategorytopscroll == 1)
                {
                    scrollDisplayTopsOverlay.frame = topsOverlayDisplayWithDress;
                }
                
                
        
        
           
            
     
            
            UILabel *templabel;
            templabel = [centerViewInScroll.subviews objectAtIndex:0];
            currenttopscrollcatname = templabel.text;
            NSLog(@"current topcatname is %@", currenttopscrollcatname);
            
            scrollDisplayTops.categoryType = currentcategorytopscroll;
            
            [self loadHorizontalArchive:currentcategorytopscroll inViewInScroll:viewInScrollTops];
            
            modeChange = YES;
            
            [self clearFilterViewInScroll:viewRacksInTopFilterView];
            [self loadRackFilterListInViewInScroll:viewRacksInTopFilterView withCategory: currentcategorytopscroll];
        
            
            
           
        }
    }
    
    
    
    if ([centerViewInScroll isKindOfClass:[UIView class]] && scrollView.tag == 92  && centerViewInScroll.tag != 92)
    {
        NSLog(@"92, centerviewinscroll tag is %i, current cat is %i", centerViewInScroll.tag, currentcategorytopoverlayscroll);
        
        if(!(currentcategorytopoverlayscroll == centerViewInScroll.tag))
        {
            topOverlayChanged = YES;
            NSLog(@"loading....");
            currentcategorytopoverlayscroll = centerViewInScroll.tag;
            
            UILabel *templabel;
            templabel = [centerViewInScroll.subviews objectAtIndex:0];
            currenttopoverlayscrollcatname = templabel.text;
            NSLog(@"current topoverlaycatname is %@", currenttopoverlayscrollcatname);
            
            scrollDisplayTopsOverlay.categoryType = currentcategorytopoverlayscroll;
            
            [self loadVerticalArchive:currentcategorytopoverlayscroll inViewInScroll:viewInScrollTopsOverlay];
            
            modeChange = YES;
            
            [self clearViewInScroll:viewRacksInTopOverlayFilterView];
            [self loadRackFilterListInViewInScroll:viewRacksInTopOverlayFilterView withCategory: currentcategorytopoverlayscroll];
        }
    }
    
    
    }
        
    if ([centerImageviewInScroll isKindOfClass:[UIScrollImageView class]])
    {

        NSLog(@"%i tag %i filenum at center", centerImageviewInScroll.tag, centerImageviewInScroll.fileNumRef);
        
        
         if (scrollView.tag != 20004)
         {
             centerImageviewInScroll.layer.borderColor = [[UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1] CGColor];
             centerImageviewInScroll.layer.borderWidth = 2;
             
             NSLog(@"setting A");
         }
        
        
        if (scrollView.tag == 20000)
        {
            if (centerImageviewInScroll.fileNumRef != previoustopImageviewInScroll.fileNumRef)
            {
                NSLog(@"previous %i, new %i", previoustopImageviewInScroll.tag, centerImageviewInScroll.tag);
                
                previoustopImageviewInScroll.layer.borderWidth = 0;
            }
            
            
            scrollDisplayTops.fileNumRef = centerImageviewInScroll.fileNumRef;
            scrollDisplayTops.categoryType = centerImageviewInScroll.categoryType;
            scrollDisplayTops.rackname = centerImageviewInScroll.rackname;
            scrollDisplayTops.catname = centerImageviewInScroll.catname;
            
            scrollDisplayTops.image = centerImageviewInScroll.image;
            
          
            
            
           // ImageRecord *temprecord = [self retrieveRecordNum:scrollDisplayTops.fileNumRef FromCat:outfitViewType RackName:scrollDisplayTops.rackname];
            
           // NSLog(@"%@", temprecord.imageFilePath);
            
            //scrollDisplayTops.image = [UIImage imageWithContentsOfFile:temprecord.imageFilePathThumb];
        
             NSLog(@"FINISHED LOAD rackscrolls subview count is %i point BBBB", [organizerController.racksScroll.subviews count]);
              NSLog(@"current item in top is of cat %@  of rack %@", scrollDisplayTops.catname, scrollDisplayTops.rackname);
            
            
            
           
            
            previoustopImageviewInScroll = centerImageviewInScroll;
        
        }
        
        if (scrollView.tag == 20001)
        {
            if (centerImageviewInScroll.fileNumRef != previousbottomImageviewInScroll.fileNumRef)
            {
                NSLog(@"previous %i, new %i", previousbottomImageviewInScroll.tag, centerImageviewInScroll.tag);
                
                previousbottomImageviewInScroll.layer.borderWidth = 0;
            }
            
            
            scrollDisplayBottoms.image = centerImageviewInScroll.image;
    
            
            scrollDisplayBottoms.fileNumRef = centerImageviewInScroll.fileNumRef;
            scrollDisplayBottoms.categoryType = centerImageviewInScroll.categoryType;
            scrollDisplayBottoms.rackname = centerImageviewInScroll.rackname;
            scrollDisplayBottoms.catname = centerImageviewInScroll.catname;
              
            NSLog(@"current item in right is of cat %@  of rack %@", scrollDisplayBottoms.catname, scrollDisplayBottoms.rackname);
            
            
          
            
            previousbottomImageviewInScroll = centerImageviewInScroll;

        }
    
        if (scrollView.tag == 20002)
        {
            
            if (centerImageviewInScroll.fileNumRef != previousshoeImageviewInScroll.fileNumRef)
            {
                NSLog(@"previous %i, new %i", previousshoeImageviewInScroll.tag, centerImageviewInScroll.tag);
                
                previousshoeImageviewInScroll.layer.borderWidth = 0;
            }
        
            scrollDisplayShoes.image = centerImageviewInScroll.image;
            scrollDisplayShoes.fileNumRef = centerImageviewInScroll.fileNumRef;
            scrollDisplayShoes.categoryType = centerImageviewInScroll.categoryType;
            scrollDisplayShoes.rackname = centerImageviewInScroll.rackname;
            scrollDisplayShoes.catname = centerImageviewInScroll.catname;
            
            
            NSLog(@"current item in lower is of cat %@  of rack %@", scrollDisplayShoes.catname, scrollDisplayShoes.rackname);
        
            
               previousshoeImageviewInScroll = centerImageviewInScroll;
            
            
        }
        
        if (scrollView.tag == 20003)
        {
            
            if (centerImageviewInScroll.fileNumRef != previousoverlayImageviewInScroll.fileNumRef)
            {
                NSLog(@"previous %i, new %i", previousoverlayImageviewInScroll.tag, centerImageviewInScroll.tag);
                
                previousoverlayImageviewInScroll.layer.borderWidth = 0;
            }
            
            scrollDisplayTopsOverlay.image = centerImageviewInScroll.image;
            scrollDisplayTopsOverlay.fileNumRef = centerImageviewInScroll.fileNumRef;
            scrollDisplayTopsOverlay.categoryType = centerImageviewInScroll.categoryType;
            scrollDisplayTopsOverlay.rackname = centerImageviewInScroll.rackname;
            scrollDisplayTopsOverlay.catname = centerImageviewInScroll.catname;
            
            previousoverlayImageviewInScroll = centerImageviewInScroll;
            
        }
        
    }
    
    
    
}
    
}






                                        //START CLEAR ARCHIVE

-(void) clearArchive
{
  
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    
    //if([fm removeItemAtPath:pathtops error:nil]) NSLog(@"pathtops archive cleared");
    //if([fm removeItemAtPath:pathbottoms error:nil]) NSLog(@"pathbottoms archive cleared");
    //if([fm removeItemAtPath:pathshoes error:nil]) NSLog(@"shoes archive cleared");
    //if([fm removeItemAtPath:pathoutfits error:nil]) NSLog(@"outfits archive cleared");
    if([fm removeItemAtPath:pathcloset error:nil]) NSLog(@"closets archive cleared");
    
    
    
    
}
-(void) clearUserInfo
{
    
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    
    //if([fm removeItemAtPath:pathtops error:nil]) NSLog(@"pathtops archive cleared");
    //if([fm removeItemAtPath:pathbottoms error:nil]) NSLog(@"pathbottoms archive cleared");
    //if([fm removeItemAtPath:pathshoes error:nil]) NSLog(@"shoes archive cleared");
    //if([fm removeItemAtPath:pathoutfits error:nil]) NSLog(@"outfits archive cleared");
    if([fm removeItemAtPath:pathuserfull error:nil]) NSLog(@"user archive cleared");
     // if([fm removeItemAtPath:pathcloset error:nil]) NSLog(@"user closets cleared");
    
    
    
    
}
                                        //END CLEAR ARCHIVE





-(ImageRecord *) retrieveRecordNum:(int) recordnum FromCat: (int) categorynum RackName:(NSString *)rackname
{
    Category *tempcategory = [myCloset.categories objectAtIndex:categorynum];
    
    for(int x = 0; x <[tempcategory.racksarray count]; x++)
    {
        Rack * temprack = [tempcategory.racksarray objectAtIndex:x];
        
        if ([temprack.rackname compare:rackname] == NSOrderedSame)
        {
            for(int y = 0; y <[temprack.rackitemsarray count]; y++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:y];
                if (temprecord.fileNumRef == recordnum)
                {
                    return temprecord;
                }
            }
        }
        
        
    }
    return  nil;
}

-(void) deleteFile:(NSString *) filepath
{
    NSFileManager *fm = [[NSFileManager alloc] init];
    if([fm removeItemAtPath:filepath error:nil])
    {
        NSLog(@"%@ deleted!", filepath);
    }
}

-(void) deleteFilesItemNum: (int) x
{
    
}

-(void) deleteFilesOutfitNum: (int) x
{
    
}





- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ( [ text isEqualToString: @"\n" ] ) {
        if(textView.superview.tag == 30000)
        {
            searchtagtop = searchtagfieldtop.text;
            topChanged = YES;
        }
        if(textView.superview.tag == 30001)
        {
            searchtagright = searchtagfieldright.text;
            rightChanged = YES;
        }
        if(textView.superview.tag == 30002)
        {
            searchtaglower = searchtagfieldlower.text;
            lowerChanged = YES;
        }
        
        if(textView.superview.tag == 30003)
        {
            searchtagtopoverlay = searchtagfieldtopoverlay.text;
            topOverlayChanged = YES;
        }
        
        if(textView.superview.tag == 30004)
        {
            searchtagaccessories = searchtagfieldaccessories.text;
            accessoriesChanged = YES;
        }

        
        
        
		[ textView resignFirstResponder ];
		return NO;
	}
	return YES;
}


-(User *) retrieveUser: (NSString *) username
{
    for (int x = 0; x< [users count]; x++)
    {
        User *tempuser = [users objectAtIndex:x];
        
        
        NSString *tempusername = tempuser.username;
        
        if([username compare:tempusername] == NSOrderedSame)
        {
            NSLog(@"found %@", tempusername);
            return tempuser;
        }
    }
    NSLog(@"user not found");
    return nil;
}


UIActivityIndicatorView *myIndicator;
    
    
-(void)checkusername
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        myIndicator.center = CGPointMake(160, 260);
        myIndicator.hidesWhenStopped = YES;
        
        [self.view addSubview:myIndicator];
        [myIndicator startAnimating];
        
        
        
        
        [self deactivateAllInView:self.view except:101];
        
        NSString *username = [usernamefield.text lowercaseString];
        NSLog(@"%@ checking",username);
        
        
        NSLog(@"%@", domain);
        NSString *urlString = [NSString stringWithFormat:@"http://%@/checkuser.php", domain];
        
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSString *requestBodyString = [NSString stringWithFormat:@"username=%@&pw=%@&set=check", username, pwfield.text];
        NSLog(@"%@", requestBodyString);
        
        
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
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                [myIndicator stopAnimating];
                
                NSLog(@"something was downloaded");
                
                
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                int z = [responseString intValue];
                NSString *existcountry = [NSString stringWithString:responseString];
                
                NSLog(@"response is %@", responseString);
                NSLog(@"intvalue is %i", z);
                
                if(z==1)
                {
                    if(existing == NO)
                    {
                        NSLog(@"username available, select country");
                        currentUser.username = username;
                        currentUser.password = pwfield.text;
                        [usernamefield removeFromSuperview];
                        [pwfield removeFromSuperview];
                        [pwfieldr removeFromSuperview];
                        
                        
                        [self reactivateAllInView:self.view];
                        
                        NSLog(@"%@ %@", currentUser.username, currentUser.password);
                        [self newUser];
                    }
                    else{
                        [self alertWith:@"Sorry, that username does not exist."];
                    }
                }
                else if(z==2)
                {
                    NSLog(@"username not available or password incorrect");
                    if(existing == NO)
                        [self alertWith:@"Username not available, please try another."];
                    else
                        [self alertWith:@"The password you entered is incorrect. Please try again."];
                    
                    
                    
                }
                else {
                    if (existing == YES)
                    {
                        currentUser.username = username;
                        currentUser.password = pwfield.text;
                        currentUser.country = existcountry;
                        NSLog(@"country is set to %@ %@", currentUser.username, currentUser.country);
                        
                        [usernamefield removeFromSuperview];
                        [pwfield removeFromSuperview];
                        [pwfieldr removeFromSuperview];
                        
                        [self reactivateAllInView:self.view];
                        [self newUser];
                    }
                    else   [self alertWith:@"Username not available, please try another."];
                }
                
            }
            else if ([data length] == 0 && error == nil)
            {
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                
                [myIndicator stopAnimating];
                
                NSLog(@"nothing was downloaded");
                
                
            }
            else if (error != nil)
            {
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                
                [myIndicator stopAnimating];
                
                NSLog(@"Error = %@", error);
                
                [self alertWithBig:@"Sorry, either the server is temporarily down or you do not have an active internet connection. Please try again in 30 minutes.  Thanks."];
                
            }
        }];
        
        

    }


    


-(void) addUser
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
  
    [myIndicator startAnimating];
    
    
    [self deactivateAllInView:self.view except:101];
    
    
    NSString *urlencodedcountry = [currentUser.country
                                   stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    
     NSString *urlString = [NSString stringWithFormat:@"http://%@/checkuser.php", domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    NSString *requestBodyString = [NSString stringWithFormat:@"username=%@&pw=%@&country=%@&set=init", currentUser.username, currentUser.password, urlencodedcountry];
    NSLog(@"%@", requestBodyString);
    
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
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            [myIndicator stopAnimating];
            
            NSLog(@"something was downloaded");
            
            
                 [self reactivateAllInView:self.view];
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            int z = [responseString intValue];
            
            
            if(z==2)
            {
                NSLog(@"not succesful, try again");
            }
            
            if(z==1)
            {
                NSLog(@"%i successful!", z);
                [self newUser];
            }
            
       
            
            
                       
        }
        else if ([data length] == 0 && error == nil)
        {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
            [myIndicator stopAnimating];
            [self reactivateAllInView:self.view];
            
            NSLog(@"nothing was downloaded");
            
                 
            
            
        }
        else if (error != nil)
        {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
            [myIndicator stopAnimating];
            
                 [self reactivateAllInView:self.view];
            
            NSLog(@"Error = %@", error);
            
            [self alertWith:@"Sorry, an internet connection is needed to setup your ClosetFashions account."];
            
        }
    }];

    
}

-(void) textFieldShouldReturn:(UITextField *)textField
{
    
  
    if(textField.tag == 203)
    {
        if(outfitNameEditOn == YES && shiftedUp == YES)
        {
            
            [UIView beginAnimations:@"rearranging tiles" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            CGPoint originalPositon = CGPointMake(self.view.center.x, self.view.center.y +210);
            
            self.view.center = originalPositon;
            
            shiftedUp = NO;
            
            [UIView commitAnimations];
            newOutfitNameSet = textField.text;
        }
    }
    
    if(textField.superview.tag == 30)
    {
        currentUser = [self retrieveUser:textField.text];
        
        if(currentUser)
        {
            NSLog(@"loading with user %@", currentUser.username);
            [self loadWithUser:currentUser];
        }
        
        [textField.superview removeFromSuperview];
    }
    

    if(textField.superview.tag == 30000)
    {
        searchtagtop = searchtagfieldtop.text;
        topChanged = YES;
    }
    if(textField.superview.tag == 30001)
    {
        searchtagright = searchtagfieldright.text;
        rightChanged = YES;
    }
    if(textField.superview.tag == 30002)
    {
        searchtaglower = searchtagfieldlower.text;
        lowerChanged = YES;
    }
    
    if(textField.superview.tag == 30003)
    {
        searchtagtopoverlay = searchtagfieldtopoverlay.text;
        topOverlayChanged = YES;
        
    }
    if(textField.superview.tag == 30004)
    {
        searchtagaccessories = searchtagfieldaccessories.text;
        accessoriesChanged = YES;
    }
    
    if(textField.superview.tag == 38)
    {
        NSLog(@"adding new category");

        
        NSLog(@"%@", textField.text);
        
        
        if ([textField.text compare:@""] == NSOrderedSame) //need to change to any number of blanks
        {
            
        }
        else [self addNewOutfitCategory:textField.text];
        
        [self reactivateAllInView:[self retrieveView:6102]];
        
        [textField.superview removeFromSuperview];
    }
    
    if(!existing)
    {
    
    if(textField.tag == 9005)
    {
        
        
        CGPoint positionWithoutKeyboard = CGPointMake(self.view.center.x, self.view.center.y +180);
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithoutKeyboard;
        
        
        [UIView commitAnimations];
        
        didshiftpw = NO;

    }
    }
    
    
    

        [textField resignFirstResponder];
    
    
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
        
        
        
    }
    
    [outfitCategoryPicker reloadAllComponents];
}



-(void) setAllTag
{
 
    
    if (isTopOpen == YES) {
        
        if(savedtopandfilter == NO)
        {
            savedtopandfilter = YES;
            [topAllButton setSelected:YES];
        }
        else
        {
            savedtopandfilter = NO;
            [topAllButton setSelected:NO];
        }
        
    }
    
    
    if (isRightOpen == YES){ 
        if(savedrightandfilter == NO)
        {
            savedrightandfilter = YES;
            [rightAllButton setSelected:YES];
            
        }
        else
        {
            savedrightandfilter = NO;
            [rightAllButton setSelected:NO];
        }
       
    }
    
    
    if (isLowerOpen == YES) {
        if(savedlowerandfilter == NO)
        {
            savedlowerandfilter = YES;
            [lowerAllButton setSelected:YES];
        }
        else
        {
            savedlowerandfilter = NO;
            [lowerAllButton setSelected:NO];
        }

    }

    if (isTopOverlayOpen == YES) {
        if(savedtopoverlayandfilter == NO)
        {
            savedtopoverlayandfilter = YES;
            [topOverlayAllButton setSelected:YES];
        }
        else
        {
            savedtopoverlayandfilter = NO;
            [topOverlayAllButton setSelected:NO];
        }
    }
    if (isAccessoriesOpen == YES) {
        if(savedaccessoriesandfilter == NO)
        {
            savedaccessoriesandfilter = YES;
            [accessoriesAllButton setSelected:YES];
        }
        else
        {
            savedaccessoriesandfilter = NO;
            [accessoriesAllButton setSelected:NO];
        }
        
    }
}





-(void) clearView: (UIView *) clearview
{
    for (int x = 0; x<[clearview.subviews count]; x++)
    {
        UIView *tempview = [clearview.subviews objectAtIndex:x];
        [tempview removeFromSuperview];
        
    }
}


-(IBAction) filterTop
{
    if([self doesViewAlreadyExist:100] == NO &&
       isTopOpen == NO && isRightOpen == NO && isLowerOpen == NO)
    {
        [self deactivateAllInView:self.view except:89];
        
        topFilterView.layer.zPosition = 1000;
        
        [topFilterView removeFromSuperview];
        [self.view addSubview:topFilterView];

        [filterTopButton removeFromSuperview];
        [self.view addSubview:filterTopButton];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        

        
        topFilterView.frame = CGRectMake(0,21,120,445);
 
        filterTopButton.frame = CGRectMake(119,21,20,40);
        
        [UIView commitAnimations];
        
        isTopOpen = YES;
        
        [filterTopButton setImage:closevertgray forState:UIControlStateNormal];
        [filterTopButton setImage:closevertgraypressed forState:UIControlStateHighlighted];
        

    }
    else
    {
        [self reactivateAllInView:self.view];
        
        topFilterView.layer.zPosition = 0;
        searchtagtop = searchtagfieldtop.text;
        topChanged = YES;
        NSLog(@"%@ IN SEARCHHHH, %@", searchtagfieldtop.text, searchtagtop);
       
        
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        topFilterView.frame = CGRectMake(0,21,0,0);
        
        filterTopButton.frame = CGRectMake(-1,21,20,40);
        
        [UIView commitAnimations];
        
        isTopOpen = NO;
        
        
        [self archiveCatNumbers];
        
        if(topChanged == YES)
        {
            topChanged = NO;
            [self loadHorizontalArchive:currentcategorytopscroll inViewInScroll:viewInScrollTops];
            
          
            
            [self refreshTopDisplay];
            [self refreshRightDisplay];
            
            if(currentcategorytopoverlayscroll == 0)
            {
                
                [self clearFilterViewInScroll:viewRacksInTopOverlayFilterView];
              
                
                
                [self loadRackFilterListInViewInScroll:viewRacksInTopOverlayFilterView withCategory:currentcategorytopoverlayscroll];
                
                
                [self loadVerticalArchive:currentcategorytopoverlayscroll inViewInScroll:viewInScrollTopsOverlay];
            }
           
        }
        
        [filterTopButton setImage:openvertgray forState:UIControlStateNormal];
        [filterTopButton setImage:openvertgraypressed forState:UIControlStateHighlighted];
        
        
        
 
    }
}


-(IBAction) filterRight
{
    if([self doesViewAlreadyExist:100] == NO &&
       isTopOpen == NO && isRightOpen == NO && isLowerOpen == NO)
    {
        
        [self deactivateAllInView:rightFilterView.superview except:90];
        
        rightFilterView.layer.zPosition = 1000;
        
        [rightFilterView removeFromSuperview];
        [self.view addSubview:rightFilterView];
        
        [filterRightButton removeFromSuperview];
        [self.view addSubview:filterRightButton];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        
        
        rightFilterView.frame = CGRectMake(200,21,120,420);
        
        filterRightButton.frame = CGRectMake(279,440,40,20);
        
        [UIView commitAnimations];
        
        isRightOpen = YES;
        
        [filterRightButton setImage:closegray forState:UIControlStateNormal];
        [filterRightButton setImage:closegraypressed forState:UIControlStateHighlighted];
        
        

        
        
    }
    else
    {
        [self reactivateAllInView:self.view];
        rightFilterView.layer.zPosition = 0;
        searchtagright = searchtagfieldright.text;
        rightChanged = YES;
        NSLog(@"%@ IN SEARCHHHH, %@", searchtagfieldright.text, searchtagright);
        
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        rightFilterView.frame = CGRectMake(319,78,0,0);
        
        filterRightButton.frame = CGRectMake(279,77,40,20);
        
        [UIView commitAnimations];
        
        isRightOpen = NO;
        
        
        [self archiveCatNumbers];
        
        if(rightChanged == YES)
        {
            rightChanged = NO;
            [self loadVerticalArchive:currentcategoryrightscroll inViewInScroll:viewInScrollBottoms];
            NSLog(@"refreshing right display");
            [self refreshRightDisplay];
            
        }
       
        
        [filterRightButton setImage:opengray forState:UIControlStateNormal];
        [filterRightButton setImage:opengraypressed forState:UIControlStateHighlighted];
        
    }
}

-(IBAction) filterLower
{
    if([self doesViewAlreadyExist:100] == NO &&
       isTopOpen == NO && isRightOpen == NO && isLowerOpen == NO)
    {
        [self deactivateAllInView:self.view except:91];
        
        
        lowerFilterView.layer.zPosition = 1000;
        
        
        [lowerFilterView removeFromSuperview];
        [self.view addSubview:lowerFilterView];
        
        [filterLowerButton removeFromSuperview];
        [self.view addSubview:filterLowerButton];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        
        
        lowerFilterView.frame = CGRectMake(0,21,120,446);
        
        filterLowerButton.frame = CGRectMake(119,427,20,40);
        
        [UIView commitAnimations];
        
        isLowerOpen = YES;
        
        [filterLowerButton setImage:closevertgray forState:UIControlStateNormal];
        [filterLowerButton setImage:closevertgraypressed forState:UIControlStateHighlighted];
        
    }
    else
    {
        [self reactivateAllInView:self.view];
        
        lowerFilterView.layer.zPosition = 0;
        searchtaglower = searchtagfieldlower.text;
        lowerChanged = YES;
        NSLog(@"%@ IN SEARCHHHH, %@", searchtagfieldlower.text, searchtaglower);
        
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        lowerFilterView.frame = CGRectMake(0,467,0,0);
        
        filterLowerButton.frame = CGRectMake(-1,427,20,40);
        
        [UIView commitAnimations];
        
        isLowerOpen = NO;
        
        
        [self archiveCatNumbers];
        
        if(lowerChanged == YES)
        {
            lowerChanged = NO;
            [self loadHorizontalArchive:currentcategorylowerscroll inViewInScroll:viewInScrollShoes];
             [self refreshLowerDisplay];
        }
        
        
        [filterLowerButton setImage:openvertgray forState:UIControlStateNormal];
        [filterLowerButton setImage:openvertgraypressed forState:UIControlStateHighlighted];
        
        
    }
}


-(IBAction) filterTopOverlay
{
    if([self doesViewAlreadyExist:100] == NO &&
       isTopOpen == NO && isRightOpen == NO && isLowerOpen == NO && isTopOverlayOpen == NO && isAccessoriesOpen == NO)
    {
        
        [self deactivateAllInView:topOverlayFilterView.superview except:92];
        
        topOverlayFilterView.layer.zPosition = 1000;
        [topOverlayFilterView removeFromSuperview];
        [self.view addSubview:topOverlayFilterView];
        
        [filterTopOverlayButton removeFromSuperview];
        [self.view addSubview:filterTopOverlayButton];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        
        
        topOverlayFilterView.frame = CGRectMake(0,21,120,420);
        
        filterTopOverlayButton.frame = CGRectMake(0,440,40,20);
        
        [UIView commitAnimations];
        
        isTopOverlayOpen = YES;
        
        
        
        [filterTopOverlayButton setImage:closegray forState:UIControlStateNormal];
        [filterTopOverlayButton setImage:closegraypressed forState:UIControlStateHighlighted];
        
        
        
        
        
    }
    else
    {
        [self reactivateAllInView:self.view];
        topOverlayFilterView.layer.zPosition = 0;
        searchtagtopoverlay = searchtagfieldtopoverlay.text;
        topOverlayChanged = YES;
        NSLog(@"%@ IN SEARCHHHH, %@", searchtagfieldtopoverlay.text, searchtagtopoverlay);
        
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        topOverlayFilterView.frame = CGRectMake(0,78,0,0);
        
        filterTopOverlayButton.frame = CGRectMake(0,77,40,20);
        
        [UIView commitAnimations];
        
        isTopOverlayOpen = NO;
        
        
        [self archiveCatNumbers];
        
        if(topOverlayChanged == YES)
        {
            topOverlayChanged = NO;
            [self loadVerticalArchive:currentcategorytopoverlayscroll inViewInScroll:viewInScrollTopsOverlay];
            NSLog(@"refreshing topoverlay display");
            [self refreshTopOverlayDisplay];
            
            if(currentcategorytopscroll == 0)
            {
                [self clearFilterViewInScroll:viewRacksInTopFilterView];
                
                [self loadRackFilterListInViewInScroll:viewRacksInTopFilterView withCategory:currentcategorytopscroll];
            
                [self loadHorizontalArchive:currentcategorytopscroll inViewInScroll:viewInScrollTops];
            }
            
        }
        
        
        
        
        [filterTopOverlayButton setImage:opengray forState:UIControlStateNormal];
        [filterTopOverlayButton setImage:opengraypressed forState:UIControlStateHighlighted];
    }
}

-(IBAction) filterAccessories
{
    if([self doesViewAlreadyExist:100] == NO &&
       isTopOpen == NO && isRightOpen == NO && isLowerOpen == NO && isAccessoriesOpen == NO && isAccessoriesOpen == NO)
    {
        
        [self deactivateAllInView:accessoriesFilterView.superview except:93];
        
        accessoriesFilterView.layer.zPosition = 1000;
        [accessoriesFilterView removeFromSuperview];
        [self.view addSubview:accessoriesFilterView];
        
        [filterAccessoriesButton removeFromSuperview];
        [self.view addSubview:filterAccessoriesButton];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        
        
        
        accessoriesFilterView.frame = CGRectMake(0,21,120,446);
        
        filterAccessoriesButton.frame = CGRectMake(119,427,20,40);
        
        [UIView commitAnimations];
        
        isAccessoriesOpen = YES;
        
        
        
        [filterAccessoriesButton setImage:closevertgray forState:UIControlStateNormal];
        [filterAccessoriesButton setImage:closevertgraypressed forState:UIControlStateHighlighted];
        
        
        
        
    }
    else
    {
        
        [self reactivateAllInView:self.view];
        accessoriesFilterView.layer.zPosition = 0;
        searchtagaccessories = searchtagfieldaccessories.text;
        accessoriesChanged = YES;
        NSLog(@"%@ IN SEARCHHHH, %@", searchtagfieldaccessories.text, searchtagaccessories);
        
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        accessoriesFilterView.frame = CGRectMake(0,467,0,0);
        
        filterAccessoriesButton.frame = CGRectMake(-1,427,20,40);
        
        [UIView commitAnimations];
        
        isAccessoriesOpen = NO;
        
        
        [self archiveCatNumbers];
        
        if(accessoriesChanged == YES)
        {
            accessoriesChanged = NO;
            [self loadHorizontalArchive:currentcategoryaccessoriesscroll inViewInScroll:viewInScrollAccessories];
            NSLog(@"refreshing accessories display");
           
            
        }
        
        
        [filterAccessoriesButton setImage:openvertgray forState:UIControlStateNormal];
        [filterAccessoriesButton setImage:openvertgraypressed forState:UIControlStateHighlighted];
        
    }
}


-(void) loadCategoryArchive: (UIScrollView *)scrollview
{
    labelwidth = 120;
    labelheight = 40;
    
    scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"settingcatlabel.jpg"]];
    
    for (int x = 0; x < [myCloset.categories count]; ++x)
    {
    
        NSLog(@"load CategoryArchive");
        Category *tempcategory = [myCloset.categories objectAtIndex:x];
        NSString *tempcategoryname = tempcategory.categoryname;
        UIView *templabelview;
        if(x == 4)
        {
              templabelview = [[UIView alloc] initWithFrame:CGRectMake(1*labelwidth, 0, labelwidth, labelheight)];
        }
        else
              templabelview = [[UIView alloc] initWithFrame:CGRectMake(x*labelwidth, 0, labelwidth, labelheight)];
        
        UILabel *templabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelwidth, labelheight)];
        templabelview.tag = x;
        templabel.text = tempcategoryname;
        NSLog(@"tag %i, cat %@", templabelview.tag, templabel.text);
        
      
        templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:26];
     
        templabel.textColor = [UIColor whiteColor];
        
        templabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"settingcatlabel.jpg"]];
        
        
        templabel.textAlignment = UITextAlignmentCenter;
        [templabelview addSubview:templabel];
        
        
        
        
   
        if(scrollview.tag == 90 || scrollview.tag == 91 || scrollview.tag == 93)
        {
            [scrollview addSubview:templabelview];
        
        
            scrollview.contentSize = CGSizeMake((x+1)*(labelwidth), labelheight);
        }
        
        
        if(scrollview.tag == 89 && (x == 0 || x ==1))
        {
            [scrollview addSubview:templabelview];
            
            scrollview.contentSize = CGSizeMake((2)*(labelwidth), labelheight);
        }
        
        if(scrollview.tag == 92 && (x == 0 || x ==4))
        {
            NSLog(@"addding %@ to %i", templabel.text, scrollview.tag);
            [scrollview addSubview:templabelview];
            
            
            scrollview.contentSize = CGSizeMake((2)*(labelwidth), labelheight);
        }
      
            
            
    }
    
    
    
    if (scrollview.tag == 89 || scrollview.tag == 92)
    {
        scrollview.contentSize = CGSizeMake(2*(labelwidth), labelheight);
    }
    
    if (scrollview.tag == 90 || scrollview.tag == 91 || scrollview.tag == 93)
    {
        scrollview.userInteractionEnabled = NO;
    }
    
    
    
}


-(void) refreshOutfitDisplay
{
    
    NSLog(@"refresh outfit display");
    [self refreshTopDisplay];
    [self refreshTopOverlayDisplay];
    [self refreshRightDisplay];
    [self refreshLowerDisplay];
}

-(void) refreshTopDisplay
{
    NSLog(@"refreshing top");
    CGPoint centerScrollPoint = CGPointMake(scrollTops.frame.origin.x+ scrollTops.frame.size.width/2, scrollTops.frame.origin.y+scrollTops.frame.size.height/2);
    
    centerImageviewInScroll = [scrollTops.superview hitTest:centerScrollPoint withEvent:nil];
    
    
    if ([centerImageviewInScroll isKindOfClass:[UIScrollImageView class]])
    {
    scrollDisplayTops.image = centerImageviewInScroll.image;
    scrollDisplayTops.fileNumRef = centerImageviewInScroll.fileNumRef;
    scrollDisplayTops.categoryType = centerImageviewInScroll.categoryType;
    scrollDisplayTops.rackname = centerImageviewInScroll.rackname;
    scrollDisplayTops.catname = centerImageviewInScroll.catname;
    
    
    NSLog(@"current item in top is of cat %@  of rack %@", scrollDisplayTops.catname, scrollDisplayTops.rackname);
    
    previoustopImageviewInScroll = centerImageviewInScroll;
        
        centerImageviewInScroll.layer.borderColor = [[UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1] CGColor];
        centerImageviewInScroll.layer.borderWidth = 2;
    }
    else{
        scrollDisplayTops.image =  NULL;
    }

}


-(void) refreshRightDisplay
{
    NSLog(@"refreshing right");
    CGPoint centerScrollPoint = CGPointMake(scrollBottoms.frame.origin.x+ scrollBottoms.frame.size.width/2, scrollBottoms.frame.origin.y+scrollBottoms.frame.size.height/2);
    
    centerImageviewInScroll = [scrollBottoms.superview hitTest:centerScrollPoint withEvent:nil];
    
    
    if ([centerImageviewInScroll isKindOfClass:[UIScrollImageView class]])
    {
        scrollDisplayBottoms.image = centerImageviewInScroll.image;
      
        
        scrollDisplayBottoms.fileNumRef = centerImageviewInScroll.fileNumRef;
        scrollDisplayBottoms.categoryType = centerImageviewInScroll.categoryType;
        scrollDisplayBottoms.rackname = centerImageviewInScroll.rackname;
        scrollDisplayBottoms.catname = centerImageviewInScroll.catname;
        
        NSLog(@"current item in right is of cat %@  of rack %@", scrollDisplayBottoms.catname, scrollDisplayBottoms.rackname);
        
        
        previousbottomImageviewInScroll = centerImageviewInScroll;
        
        centerImageviewInScroll.layer.borderColor = [[UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1] CGColor];
        centerImageviewInScroll.layer.borderWidth = 2;
    }
    
    else{
        scrollDisplayBottoms.image =  NULL;
    }

}




-(void) refreshLowerDisplay
{
    if (accessoriesOn == NO)
    {
        
        
        
    
    NSLog(@"refreshing lower");
    CGPoint centerScrollPoint = CGPointMake(scrollShoes.frame.origin.x+ scrollShoes.frame.size.width/2, scrollShoes.frame.origin.y+scrollShoes.frame.size.height/2);
    
    centerImageviewInScroll = [scrollShoes.superview hitTest:centerScrollPoint withEvent:nil];
    
    
    if ([centerImageviewInScroll isKindOfClass:[UIScrollImageView class]])
    {
        scrollDisplayShoes.image = centerImageviewInScroll.image;
        scrollDisplayShoes.fileNumRef = centerImageviewInScroll.fileNumRef;
        scrollDisplayShoes.categoryType = centerImageviewInScroll.categoryType;
        scrollDisplayShoes.rackname = centerImageviewInScroll.rackname;
        scrollDisplayShoes.catname = centerImageviewInScroll.catname;
        
        
        NSLog(@"current item in lower is of cat %@  of rack %@", scrollDisplayShoes.catname, scrollDisplayShoes.rackname);
        
        previousshoeImageviewInScroll = centerImageviewInScroll;
        
        centerImageviewInScroll.layer.borderColor = [[UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1] CGColor];
        centerImageviewInScroll.layer.borderWidth = 2;
    }
    else{
        scrollDisplayShoes.image =  NULL;
    }

    }
}




-(void) refreshTopOverlayDisplay
{
    NSLog(@"refreshing top overlay");
    CGPoint centerScrollPoint = CGPointMake(scrollTopsOverlay.frame.origin.x+ scrollTopsOverlay.frame.size.width/2, scrollTopsOverlay.frame.origin.y+scrollTopsOverlay.frame.size.height/2);
    
    centerImageviewInScroll = [scrollTopsOverlay.superview hitTest:centerScrollPoint withEvent:nil];
    
    
    if ([centerImageviewInScroll isKindOfClass:[UIScrollImageView class]])
    {
        scrollDisplayTopsOverlay.image = centerImageviewInScroll.image;
        
        
        scrollDisplayTopsOverlay.fileNumRef = centerImageviewInScroll.fileNumRef;
        scrollDisplayTopsOverlay.categoryType = centerImageviewInScroll.categoryType;
        scrollDisplayTopsOverlay.rackname = centerImageviewInScroll.rackname;
        scrollDisplayTopsOverlay.catname = centerImageviewInScroll.catname;
        
        NSLog(@"current item in right is of cat %@  of rack %@", scrollDisplayTopsOverlay.catname, scrollDisplayTopsOverlay.rackname);
        
        
        previousbottomImageviewInScroll = centerImageviewInScroll;
        
        centerImageviewInScroll.layer.borderColor = [[UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1] CGColor];
        centerImageviewInScroll.layer.borderWidth = 2;
    }
    
    else{
        scrollDisplayTopsOverlay.image =  NULL;
    }
    
}










-(void) loadRackFilterListInViewInScroll: (UIViewInScroll *) viewinscroll withCategory: (int)categorynum
{
    if(modeChange == YES)
    {
        if(viewinscroll.tag == 37 && categorynum == 1)
        {
            [self dressOn];
            
            
            
        }
        else if (viewinscroll.tag == 37)
        {
            
            [self dressOff];
        }
        
        modeChange = NO;
    }
    
    
    
    
    labelwidth = 120;
    labelheight = 40;
    

    Category *tempcategory;
    NSString *tempname;
    Rack  *temprack;

    
    NSLog(@"%i mycloset count categories", [myCloset.categories count]);
    if ([appDelegate.myCloset.categories count]>0)
    {
        
    tempcategory = [appDelegate.myCloset.categories objectAtIndex:categorynum];
        
        NSLog(@"%i racksarray count", [tempcategory.racksarray count]);
        
        for(int x=0; x < [tempcategory.racksarray count]; ++x)
        {
            CGFloat yOrigin = ([viewinscroll.subviews count]) * (labelheight + 10);
            
            temprack = [tempcategory.racksarray objectAtIndex:x];
            tempname = temprack.rackname;
            
            NSLog(@"temprackname is %@, %i", tempname, temprack.racktype);
            
            UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, labelwidth-10, labelheight)];
            UILabel *templabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, labelwidth, labelheight)];
            
            
            tempview.tag = temprack.racktype;
            templabel.tag = temprack.racktype;
            //templabel.text = [NSString stringWithFormat:@"  %@",tempname];
                              
            templabel.text = tempname;
            templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
            
            templabel.textColor = [UIColor lightGrayColor];
            
            
            NSLog(@"%@, %i", templabel.text, templabel.tag);
            
            if(temprack.shouldLoad == NO)
            {
            templabel.textColor = [UIColor blackColor];
                
             
            //templabel.backgroundColor = [UIColor whiteColor];
            }
            else
            {     
                templabel.textColor = [UIColor blackColor];
                //templabel.backgroundColor = [UIColor blackColor];
                templabel.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcheck.jpg"]];
            }
                
            
            
            
            templabel.userInteractionEnabled = YES;
            
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            
            
            [tap setNumberOfTapsRequired:1];
            [tap setNumberOfTouchesRequired:1];
            
            [templabel addGestureRecognizer:tap];
            
            
     
            
            
            
            
            [tempview addSubview:templabel];
            [viewinscroll addSubview:tempview];
            
            
            
            viewinscroll.frame = CGRectMake(0, 0, labelwidth, [viewinscroll.subviews count] *(labelheight+10));
            UIScrollView *tempscroll = (UIScrollView *) viewinscroll.superview;
            tempscroll.contentSize = CGSizeMake(labelwidth, ([viewinscroll.subviews count]) * (labelheight+10));
            
        }
        
        
    }
    
    
    
}

- (void) dressOn
{
    
    [whitebar1 setHidden: YES];
    [whitebar2 setHidden: YES];
    scrollDisplayTops.image = NULL;
    scrollBottoms.hidden = YES;
    scrollDisplayBottoms.hidden = YES;
    scrollShoes.hidden = NO;
    scrollDisplayShoes.hidden = NO;
    
    
    
    if(overlayOn)
    {
        outfitViewType = 3;
        scrollDisplayTops.frame = topsDisplayFrameDressWithOverlay;
        scrollDisplayShoes.frame = shoesDisplayFrameShiftedWithDress;
    }
    else
    {
        outfitViewType = 1;
        scrollDisplayTops.frame = topsDisplayFrameLarge;
        scrollDisplayShoes.frame = shoesDisplayFrameShifted;
    }
    
    
    outfitView.outfitType = outfitViewType;
    topbottomshoemode = NO;
    topshoemode = YES;
    topbottommode = NO;

}

- (void) dressOff
{
    [whitebar1 setHidden: YES];
    [whitebar2 setHidden: YES];

    scrollDisplayTops.image = NULL;
    scrollBottoms.hidden = NO;
    scrollDisplayBottoms.hidden = NO;
    scrollShoes.hidden = NO;
    scrollDisplayShoes.hidden = NO;
    
 
    
    if(overlayOn)
    {
        outfitViewType = 2;
        scrollDisplayTops.frame = topsDisplayFrameWithOverlay;
        scrollDisplayShoes.frame = shoesDisplayFrame;
        scrollDisplayBottoms.frame = bottomsDisplayFrame;
        scrollDisplayTopsOverlay.frame = topsOverlayDisplayFrame;
        
        
    }
    else
    {
        
        outfitViewType = 0;
        scrollDisplayTops.frame = topsDisplayFrame;
        scrollDisplayShoes.frame = shoesDisplayFrame;
        scrollDisplayBottoms.frame = bottomsDisplayFrame;
  
    }
    
    
    outfitView.outfitType = outfitViewType;
    topbottomshoemode = YES;
    topshoemode = NO;
    topbottommode = NO;
     
   
}



    
   

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    

    UILabel*templabel = (UILabel *) sender.view;
    NSLog(@"sender tag %i", templabel.tag);
    
    
    if(templabel.tag == 50000)
    {
        CGPoint tapPoint = [sender locationInView:outfitView];
        
        UIScrollDisplay *tappedImage = [outfitView hitTest:tapPoint withEvent:nil];
        
        
        if ([tappedImage isKindOfClass:[UIScrollDisplay class]] &&
            (tappedImage.tag < 70000 || tappedImage.tag >70003))
             {
                 NSLog(@"double tapped image is %i", tappedImage.tag);
                 
                 [tappedImage removeFromSuperview];
             }
    }
    
    
    
   
    //if it is a button in the filter menus
    
    if (sender.state == UIGestureRecognizerStateEnded && templabel.tag < 50)   
    {   
        
    
        
        if([self doesViewAlreadyExist:89])
        {
            topChanged = YES;
        }
        if([self doesViewAlreadyExist:90])
        {
            rightChanged = YES;
        }
        if([self doesViewAlreadyExist:91])
        {
            lowerChanged= YES;
        }
      
        
        
        NSLog(@"%@ is tag %i",templabel.text, templabel.tag);

        Rack * temprack = [self findRackForMixerController:templabel.text InCategory:sender.view.tag];
        
        NSLog(@"temprack label is %@", temprack.rackname);
        if (temprack.shouldLoad == YES)
        {
            NSLog(@"IT IS YES");   
            temprack.shouldLoad = NO;
            NSLog(@"switched to NO");  
            
            templabel.textColor = [UIColor blackColor];
            templabel.backgroundColor =  [UIColor whiteColor];
          
       
           
        }
        else if (temprack.shouldLoad == NO)
        {
            NSLog(@"IT IS NO");
            temprack.shouldLoad = YES;
            NSLog(@"switched to YES");  
            
            templabel.textColor = [UIColor blackColor];
            templabel.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcheck.jpg"]];
        }
        
         
        
        [NSKeyedArchiver archiveRootObject:myCloset toFile:pathcloset];
    } 
    
    
    
    //if it is a button in the outfitmode menu
    if (sender.state == UIGestureRecognizerStateEnded && templabel.tag >99 && templabel.tag < 104) 
    {
        if(templabel.tag == 100 && topbottomshoemode == NO)
        {
            
            NSLog(@"100");
            scrollBottoms.hidden = NO;
            scrollDisplayBottoms.hidden = NO;
            scrollShoes.hidden = NO;
            scrollDisplayShoes.hidden = NO;
            
            scrollDisplayTops.frame = topsDisplayFrame;
            
            scrollDisplayShoes.frame = shoesDisplayFrame;
            
            scrollDisplayBottoms.frame = bottomsDisplayFrame;
            
            
            outfitViewType = 0;
            outfitView.outfitType = outfitViewType;
            topbottomshoemode = YES;
            topshoemode = NO;
            topbottommode = NO;
            
            UIView *removeoutfitview = [self retrieveView:100];
            [removeoutfitview removeFromSuperview];
            
          
        }
        if(templabel.tag == 101 && topshoemode == NO)
        {
            NSLog(@"101");
            scrollBottoms.hidden = YES;
            scrollDisplayBottoms.hidden = YES;
            scrollShoes.hidden = NO;
            scrollDisplayShoes.hidden = NO;
            
            
            scrollDisplayTops.frame = topsDisplayFrameLarge;
            
     
            scrollDisplayShoes.frame = shoesDisplayFrameShifted;
            
            outfitViewType = 1;
            outfitView.outfitType = outfitViewType;
            topbottomshoemode = NO;
            topshoemode = YES;
            topbottommode = NO;
            
            UIView *removeoutfitview = [self retrieveView:100];
            [removeoutfitview removeFromSuperview];
            
            
        }
        if(templabel.tag == 102 && topbottommode == NO)
        {
            NSLog(@"102");
            
            
            
            scrollBottoms.hidden = NO;
            scrollDisplayBottoms.hidden = NO;
            scrollShoes.hidden = YES;
            scrollDisplayShoes.hidden = YES;
            
            scrollDisplayTops.frame = topsDisplayFrameHalf;
                        
            scrollDisplayBottoms.frame = bottomsDisplayFrameHalf;
            
            
            outfitViewType = 2;
            outfitView.outfitType = outfitViewType;
            topbottomshoemode = NO;
            topshoemode = NO;
            topbottommode = YES;
            
            UIView *removeoutfitview = [self retrieveView:100];
            [removeoutfitview removeFromSuperview];
            
            
        }
        
        
        
        if(templabel.tag == 103)
        {
            NSLog(@"103");
            
            if(overlayOn == NO)
            {
                overlayOnMode = YES;
                NSLog(@"turning on overlay");
                templabel.text = @"Top Overlay: ON";
                [self loadOverlay];
               
            }
            
            
            if(overlayOn == YES)
            {
                overlayOnMode = NO;
                NSLog(@"turning off overlay");
                templabel.text = @"Top Overlay: OFF";
                
                [self unloadOverlay];
                
            }
   
            overlayOn = overlayOnMode;
            
            
            
            /*if (outfitViewType == 0)
            {
                outfitViewType = 3;
            }
            
            if (outfitViewType == 1)
            {
                outfitViewType = 4;
            }
            
            if (outfitViewType == 2)
            {
                outfitViewType = 5;
            }*/
            
        }
   
    }
}

-(IBAction) toggleAccessories
{
    
    //backDropOn = YES;
    if(accessoriesOn == NO)
    {
 
        [self loadHorizontalArchive:5 inViewInScroll:viewInScrollAccessories];
        
        [scrollAccessories removeFromSuperview];
        [self.view addSubview:scrollAccessories];
        
        [filterAccessoriesButton removeFromSuperview];
        [self.view addSubview:filterAccessoriesButton];
        
        [accessoriesButton setImage:retractmag forState:UIControlStateNormal];
        [accessoriesButton setImage:retractmagpressed forState:UIControlStateHighlighted];
        
        
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        scrollAccessories.layer.borderColor = [[UIColor magentaColor] CGColor];
        scrollAccessories.layer.borderWidth = 1;
        
        scrollAccessories.frame = CGRectMake(0, 425, 330, 57);
        [UIView commitAnimations];
        
        
        
        accessoriesOn = YES;
        
    }
    else if(accessoriesOn == YES)
    {
        [filterLowerButton removeFromSuperview];
        [self.view addSubview:filterLowerButton];
        
        //[accessoriesButton setImage:extendmag forState:UIControlStateNormal];
        //[accessoriesButton setImage:extendmagpressed forState:UIControlStateHighlighted];
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        scrollAccessories.frame = CGRectMake(0, 480,330, 57);
        
        
        
        [UIView commitAnimations];
        
        
        
        accessoriesOn = NO;
    }
    
}


-(IBAction) toggleBackdrop
{
    
    if(accessoriesOn == NO)
    {
        backDropOn = YES;
        
        [self loadHorizontalArchive:5 inViewInScroll:viewInScrollAccessories];
        
        [scrollAccessories removeFromSuperview];
        [self.view addSubview:scrollAccessories];
        
        [filterAccessoriesButton removeFromSuperview];
        [self.view addSubview:filterAccessoriesButton];
        
        [accessoriesButton setImage:retractmag forState:UIControlStateNormal];
        [accessoriesButton setImage:retractmagpressed forState:UIControlStateHighlighted];
        
        
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        scrollAccessories.layer.borderColor = [[UIColor magentaColor] CGColor];
        scrollAccessories.layer.borderWidth = 1;
        
        scrollAccessories.frame = CGRectMake(0, 405, 330, 57);
        [UIView commitAnimations];
        
        
        
        accessoriesOn = YES;
        
    }
    else if(accessoriesOn == YES)
    {
        backDropOn = NO;
        [filterLowerButton removeFromSuperview];
        [self.view addSubview:filterLowerButton];
        
        //[accessoriesButton setImage:extendmag forState:UIControlStateNormal];
        //[accessoriesButton setImage:extendmagpressed forState:UIControlStateHighlighted];
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        scrollAccessories.frame = CGRectMake(0, 460,330, 57);
        
        
        
        [UIView commitAnimations];
        
        
        
        accessoriesOn = NO;
    }
    
}



-(IBAction) toggleMenuTemp
{
    [menuView removeFromSuperview];
    [self.view addSubview:menuView];
    [menuButton removeFromSuperview];
    [self.view addSubview:menuButton];
    
    [topbar removeFromSuperview];
    [bottombar removeFromSuperview];
    [self.view addSubview:topbar];
    [self.view addSubview:bottombar];
    
    
    
    
    if(menuOn == NO)
    {
        [menuButton setImage:closemenu forState:UIControlStateNormal];
        [menuButton setImage:closemenupressed forState:UIControlStateHighlighted];
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        menuView.frame = CGRectMake(-5, 76, 104, 348);
        [UIView commitAnimations];
        
  
        
        menuOn = YES;
        
    }
    else if(menuOn == YES)
    {
        
        [menuButton setImage:openmenu forState:UIControlStateNormal];
        [menuButton setImage:openmenupressed forState:UIControlStateHighlighted];
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        menuView.frame = CGRectMake(-109, 76, 104, 348);
        [UIView commitAnimations];
        
        menuOn = NO;
    }
    
  

}

-(IBAction) toggleMenuSecond
{
    [menuSecondView removeFromSuperview];
    [self.view addSubview:menuSecondView];
    [menuSecondButton removeFromSuperview];
    [self.view addSubview:menuSecondButton];
    
    [topbar removeFromSuperview];
    [bottombar removeFromSuperview];
    [self.view addSubview:topbar];
    [self.view addSubview:bottombar];
    
    
    
    
    if(menuSecondOn == NO)
    {
        [menuSecondButton setImage:closemenu2 forState:UIControlStateNormal];
        [menuSecondButton setImage:closemenu2pressed forState:UIControlStateHighlighted];
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        menuSecondView.frame = CGRectMake(218, 76, 104, 348);
        [UIView commitAnimations];
        
        
        
        menuSecondOn = YES;
        
    }
    else if(menuSecondOn == YES)
    {
        
        [menuSecondButton setImage:openmenu2 forState:UIControlStateNormal];
        [menuSecondButton setImage:openmenu2pressed forState:UIControlStateHighlighted];
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        menuSecondView.frame = CGRectMake(320, 76, 104, 348);
        [UIView commitAnimations];
        
        
        
        menuSecondOn = NO;
    }
    
}


-(IBAction) loadOverlay
{
    
    [filterTopOverlayButton removeFromSuperview];
    [self.view addSubview:filterTopOverlayButton];
    
    if(overlayOn == NO)
    {
        
        [self loadVerticalArchive:currentcategorytopoverlayscroll inViewInScroll:viewInScrollTopsOverlay];
        //top overlay
        
 
        
  
    
        filterTopOverlayButton.hidden = NO;
       
        
        
        if(topshoemode)
        {
            outfitViewType = 3;
            scrollDisplayTops.frame = topsDisplayFrameDressWithOverlay;
            scrollDisplayTopsOverlay.frame = topsOverlayDisplayWithDress;
            scrollDisplayShoes.frame = shoesDisplayFrameShiftedWithDress;
        }
        else
        {
             outfitViewType = 2;
             scrollDisplayTops.frame = topsDisplayFrameWithOverlay;
             scrollDisplayTopsOverlay.frame = topsOverlayDisplayFrame;
            scrollDisplayShoes.frame = shoesDisplayFrame;
        }
        
        if (menuOn == YES)
        {
            [self toggleMenu];
        }
    
    scrollTopsOverlay.hidden = NO;
    
    scrollDisplayTopsOverlay.hidden = NO;
        
    filterTopOverlayButton.hidden = NO;
        
    overlayOn = YES;
        
           [self refreshTopOverlayDisplay];

    }
    else if(overlayOn == YES)
    {
        if(topshoemode)
        {
            outfitViewType = 1;
            scrollDisplayTops.frame = topsDisplayFrameLarge;
            scrollDisplayShoes.frame = shoesDisplayFrameShifted;
        }
        else
        {
            
            outfitViewType = 0;
            scrollDisplayTops.frame = topsDisplayFrame;
            scrollDisplayShoes.frame = shoesDisplayFrame;
        }
        filterTopOverlayButton.hidden = YES;
        
        scrollTopsOverlay.hidden = YES;
        
        scrollDisplayTopsOverlay.hidden = YES;
        
        
        filterTopOverlayButton.hidden = YES;
        
        overlayOn = NO;
    }
   
}




-(IBAction) resetLayout
{
    if(outfitViewType == 0)
    {
        scrollDisplayTops.frame = topsDisplayFrame;
        scrollDisplayShoes.frame = shoesDisplayFrame;
        scrollDisplayBottoms.frame = bottomsDisplayFrame;
        
    }
    if(outfitViewType == 1)
    {
        scrollDisplayTops.frame = topsDisplayFrameLarge;
        scrollDisplayShoes.frame = shoesDisplayFrameShifted;
        scrollDisplayBottoms.frame = bottomsDisplayFrame;
    }
    if(outfitViewType == 2)
    {
        scrollDisplayTops.frame = topsDisplayFrameWithOverlay;
        scrollDisplayTopsOverlay.frame = topsOverlayDisplayFrame;
        scrollDisplayShoes.frame = shoesDisplayFrame;
        scrollDisplayBottoms.frame = bottomsDisplayFrame;
    }
    if(outfitViewType == 3)
    {
        scrollDisplayTops.frame = topsDisplayFrameDressWithOverlay;
        scrollDisplayTopsOverlay.frame = topsOverlayDisplayWithDress;
        scrollDisplayShoes.frame = shoesDisplayFrameShiftedWithDress;
        scrollDisplayBottoms.frame = bottomsDisplayFrame;
    }
}


-(void) unloadOverlay
{
    
    scrollTops.hidden = NO;
    
    scrollTopsOverlay.hidden = YES;
    
    scrollDisplayTopsOverlay.hidden = YES;
    
}



-(Rack *) findRackForMixerController: (NSString *)racktofind InCategory: (int) categorynum
{
    Category *tempcategory;
    

    tempcategory = [myCloset.categories objectAtIndex:categorynum];
    
    
    for (int x = 0; x < [tempcategory.racksarray count]; ++x)
    {
        Rack * temprack;
        temprack = [tempcategory.racksarray objectAtIndex:x];
        NSLog(@"find %@, versus rack %@ ", racktofind, temprack.rackname);
        
        
        
        if ([racktofind compare:temprack.rackname] == NSOrderedSame)
        {
            return temprack;
        }
    }
    return nil;
    
}



/*
- (NSString *)getDayOfTheWeek:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]
                                       initWithDateFormat:@"%A" allowNaturalLanguage:NO] autorelease];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return formattedDateString;
}*/


UISwitch *assignDateSwitch;


- (IBAction)flipAssignDate:(id)sender {
    
    assignDate = NO;
    
    if (assignDateSwitch.on) 
    {
        assignDate = YES;
        
        NSLog(@"assigndate = yes");
        
        NSDate *myDate;
        
        myDate = [NSDate date];
        
        NSLog(@"%@", myDate);
    }
    else
    {
        assignDate = NO;
        NSLog(@"assigndate = no");
    }
}






NSString *newShortOutfitImageFilePath;
NSString *newShortOutfitImageFilePathThumb;

NSString *newOutfitImageFilePath;
NSString *newOutfitImageFilePathThumb;

UIImage *newOutfitImage;
UIImage *newOutfitImageThumb;





UIButton *removeDateButton;


int currentoutfitcategoryselection;





-(IBAction) createOutfit
{
    
    
    
    currentoutfitcategoryselection = 0;
    
        
    
    CGSize size = [outfitView bounds].size;


    
    
    UIGraphicsBeginImageContextWithOptions(size, outfitView.opaque, 3);
    
    [outfitView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    newOutfitImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
  
    
    
    
    UIGraphicsBeginImageContextWithOptions(size, outfitView.opaque, 2);
    
    [outfitView addSubview:verifyBar];
    
    [outfitView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    newOutfitImageThumb = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
      [verifyBar removeFromSuperview];
    
    
    if([self doesViewAlreadyExist:6102] == NO)
    {
        
            selectedDatesArray = [[NSMutableArray alloc] init];
        

            NSLog(@"outfit type %i", outfitViewType);    
            
        int originX = 0;            
        int originY = 20;
        
        
            
            
            
            UIScrollView *newItemView = [[UIScrollView alloc] initWithFrame:CGRectMake(originX, originY, 320, 460)];
            newItemView.tag = 6102;
                
        newItemView.bounces = NO;
        UIImage *woodbg = [UIImage imageNamed:@"wood.png"];
        newItemView.backgroundColor = [UIColor colorWithPatternImage:woodbg];
        newItemView.scrollEnabled = YES;
        newItemView.contentSize = CGSizeMake(320, 880);
    
        
        UILabel *newOutfitHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        
        newOutfitHeader.text = @"NEW OUTFIT";
        newOutfitHeader.textColor = [UIColor blackColor];
        newOutfitHeader.textAlignment = UITextAlignmentCenter;
        newOutfitHeader.font = [UIFont fontWithName:@"Futura" size:40];
        newOutfitHeader.backgroundColor = [UIColor clearColor];
        newOutfitHeader.layer.cornerRadius = 5;
        [newItemView addSubview:newOutfitHeader];
        
        UILabel *newOutfitFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 420, 320, 40)];
        
        newOutfitFooter.text = @"DETAILS";
        newOutfitFooter.textColor = [UIColor blackColor];
        newOutfitFooter.textAlignment = UITextAlignmentCenter;
        newOutfitFooter.font = [UIFont fontWithName:@"Futura" size:30];
        newOutfitFooter.backgroundColor = [UIColor clearColor];
        [newItemView addSubview:newOutfitFooter];
        
        
        
        UILabel *newOutfitFooterB = [[UILabel alloc] initWithFrame:CGRectMake(0, 836, 320, 40)];
        
        newOutfitFooterB.text = @"";
        newOutfitFooterB.textColor = [UIColor whiteColor];
        newOutfitFooterB.textAlignment = UITextAlignmentCenter;
        newOutfitFooterB.font = [UIFont fontWithName:@"Futura" size:30];
        newOutfitFooterB.backgroundColor = [UIColor clearColor];
        
        
        
        [newItemView addSubview:newOutfitFooterB];
        
        UIImageView *newItemPreviewImage = [[UIImageView alloc] initWithImage:newOutfitImage];
        
        newItemPreviewImage.frame = CGRectMake(0, 60, 320, 360);
        newItemPreviewImage.contentMode = UIViewContentModeScaleAspectFit;
        newItemPreviewImage.backgroundColor = [UIColor clearColor];
        newItemPreviewImage.layer.borderWidth = 2;
        newItemPreviewImage.layer.borderColor = [[UIColor clearColor] CGColor];
        
        
        UILabel *bar = [[UILabel alloc] initWithFrame:CGRectMake(0, 470, 320, 36)];
        
        
        bar.backgroundColor = [UIColor clearColor];
        
        
        [newItemView addSubview:bar];
        
        UILabel *outfitCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 478, 150, 20)];
       
        outfitCategoryLabel.text = @"Outfit Category";
        outfitCategoryLabel.textColor = [UIColor blackColor];
        outfitCategoryLabel.font = [UIFont fontWithName:@"Futura" size:16];
        outfitCategoryLabel.backgroundColor = [UIColor clearColor];
        
        
        
        UIView *pickerHolder = [[UIView alloc] initWithFrame:CGRectMake(20, 508, 125, 75)];
        
        outfitCategoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        outfitCategoryPicker.tag = 892;
        outfitCategoryPicker.delegate = self;
        outfitCategoryPicker.showsSelectionIndicator = YES;
        
        //scale size of pickerview for categories
        
        CGAffineTransform t0 = CGAffineTransformMakeTranslation(outfitCategoryPicker.bounds.size.width/2, outfitCategoryPicker.bounds.size.height/2);
        CGAffineTransform s0 = CGAffineTransformMakeScale(0.4, 0.4);
        CGAffineTransform t1 = CGAffineTransformMakeTranslation(-outfitCategoryPicker.bounds.size.width/2, -outfitCategoryPicker.bounds.size.height/2);
        outfitCategoryPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
        
        //scale size of pickerview for categories
        
        [pickerHolder addSubview:outfitCategoryPicker];
        pickerHolder.clipsToBounds = NO;
        
        
        
        
        UIButton *addCatButton = [[UIButton alloc] initWithFrame:CGRectMake(37.5, 608, 90, 36)];
        UIImage *addcat = [UIImage imageNamed:@"addcatbutton.jpg"];
        UIImage *addcatpressed = [UIImage imageNamed:@"addcatbuttonpressed.jpg"];
        [addCatButton setImage:addcat forState:UIControlStateNormal];
        [addCatButton setImage:addcatpressed forState:UIControlStateHighlighted];
        [addCatButton addTarget:self action:@selector(addNewOutfitCategoryCallUp) forControlEvents:UIControlEventTouchUpInside];
        
        
        
   
        UILabel *assignDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 478, 150,20)];
        assignDateLabel.font = [UIFont fontWithName:@"Futura" size:16];
        assignDateLabel.text = @"Wear-On Dates";
        assignDateLabel.textColor = [UIColor blackColor];
        assignDateLabel.backgroundColor = [UIColor clearColor];
     
        UIView *datepickerHolder = [[UIView alloc] initWithFrame:CGRectMake(170, 508, 125, 75)];
        
        assignedDatesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        assignedDatesPicker.tag = 893;
        assignedDatesPicker.delegate = self;
        assignedDatesPicker.showsSelectionIndicator = YES;
        
        assignedDatesPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
        
        assignedDatesPicker.userInteractionEnabled = NO;
        
        [datepickerHolder addSubview:assignedDatesPicker];
        datepickerHolder.clipsToBounds = NO;

   UIButton *addDateButton = [[UIButton alloc] initWithFrame:CGRectMake(191.5, 608,36, 36)];
        
        addDateButton.tag = 1939;
        
        UIImage *add = [UIImage imageNamed:@"add.jpg"];
        UIImage *addpressed = [UIImage imageNamed:@"addpressed.jpg"];
        
        [addDateButton setImage:add forState:UIControlStateNormal];
        [addDateButton setImage:addpressed forState:UIControlStateHighlighted];
       
 
        [addDateButton addTarget:self action:@selector(toggleCalendar) forControlEvents:UIControlEventTouchUpInside];
        
        [newItemView addSubview:addDateButton];
        
        
        removeDateButton = [[UIButton alloc] initWithFrame:CGRectMake(242.5, 608,36, 36)];
        
        UIImage *remove = [UIImage imageNamed:@"removeblue.jpg"];
        UIImage *removepressed = [UIImage imageNamed:@"removebluepressed.jpg"];
        
        [removeDateButton setImage:remove forState:UIControlStateNormal];
        [removeDateButton setImage:removepressed forState:UIControlStateHighlighted];
        
        
        [removeDateButton addTarget:self action:@selector(deleteDate:) forControlEvents:UIControlEventTouchUpInside];
        
        [newItemView addSubview:removeDateButton];

        
        UIButton *cancelOutfitButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 838,90, 36)];
        
        UIImage *cancel = [UIImage imageNamed:@"cancel.jpg"];
        UIImage *cancelpressed = [UIImage imageNamed:@"cancelpressed.jpg"];
        
        [cancelOutfitButton setImage:cancel forState:UIControlStateNormal];
        [cancelOutfitButton setImage:cancelpressed forState:UIControlStateHighlighted];
        
      
        
        [cancelOutfitButton addTarget:self action:@selector(cancelNewOutfit:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [newItemView addSubview:cancelOutfitButton];
        
        
        UIButton *saveOutfitButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 838,90, 36)];
        
        UIImage *save = [UIImage imageNamed:@"confirmsave.jpg"];
        UIImage *savepressed = [UIImage imageNamed:@"confirmsavepressed.jpg"];
        
        [saveOutfitButton setImage:save forState:UIControlStateNormal];
        [saveOutfitButton setImage:savepressed forState:UIControlStateHighlighted];
        
    
        [saveOutfitButton addTarget:self action:@selector(confirmNewOutfit:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [newItemView addSubview:saveOutfitButton];
            
   

                
            [newItemView addSubview:addCatButton];

            [newItemView addSubview:cancelOutfitButton];
            

            [newItemView addSubview:outfitCategoryLabel];
  
            [newItemView addSubview:assignDateLabel];
 
    
        /*    UITextField *newOutfitCategoryField = [[UITextField alloc] initWithFrame:CGRectMake(150, 90, 100, 25)];
            newOutfitCategoryField.backgroundColor = [UIColor whiteColor];
            newOutfitCategoryField.borderStyle = UITextBorderStyleRoundedRect;
            newOutfitCategoryField.delegate = self;
            newOutfitCategoryField.tag = 201;
            newOutfitCategoryField.text = @"";
            newOutfitCategoryField.hidden = YES;
         [newItemView addSubview:newOutfitCategoryField];
*/
    
        
                
        [newItemView addSubview:datepickerHolder];
        
     
        [newItemView addSubview:pickerHolder];
        [newItemView addSubview:newItemPreviewImage];
        
        
        UILabel *bar2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 658, 320, 36)];
        
        
        bar2.backgroundColor = [UIColor clearColor];
        
        
        [newItemView addSubview:bar2];
        
        
        UILabel *outfitNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 666, 150, 20)];
        outfitNameLabel.backgroundColor = [UIColor clearColor];
        outfitNameLabel.text = @"Outfit Name";
        outfitNameLabel.textColor = [UIColor blackColor];
        
        outfitNameLabel.font = [UIFont fontWithName:@"Futura" size:16];
        [newItemView addSubview: outfitNameLabel];
        
        
        outfitNameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 700, 280, 50)];
        outfitNameField.backgroundColor = [UIColor whiteColor];
       
        outfitNameField.borderStyle = UITextBorderStyleRoundedRect;
        outfitNameField.tag = 203;
        outfitNameField.text = @"";
        outfitNameField.delegate = self;
        
        outfitNameField.font = [UIFont fontWithName:@"Futura" size:16];
        
        [newItemView addSubview:outfitNameField];
        
        
        
        [self.view addSubview:newItemView];

    }
    else
    {
        NSLog(@"6102 exists already!");
    }

    
    
    /*NSString *displayOutfitType;
     
     if(outfitViewType == 0)
     {
     displayOutfitType = [NSString stringWithFormat:@"Top, Bottom & Shoes"];
     }
     if(outfitViewType == 1)
     {
     displayOutfitType = [NSString stringWithFormat:@"Top & Shoes"];
     }
     if(outfitViewType == 2)
     {
     displayOutfitType = [NSString stringWithFormat:@"Top & Bottom"];
     }
     
     UILabel *outfitTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 20, 100, 20)];
     outfitTypeLabel.backgroundColor = [UIColor blackColor];
     outfitTypeLabel.text = @"Outfit Type:";
     outfitTypeLabel.textColor = [UIColor whiteColor];
     outfitTypeLabel.font = [UIFont boldSystemFontOfSize:12];
     
     
     
     UILabel *outfitTypeDisplay = [[UILabel alloc] initWithFrame:CGRectMake(150, 40, 125, 25)];
     outfitTypeDisplay.backgroundColor = [UIColor lightGrayColor];
     outfitTypeDisplay.text = displayOutfitType;
     outfitTypeDisplay.textColor = [UIColor whiteColor];
     outfitTypeDisplay.font = [UIFont boldSystemFontOfSize:12];*/
    
    
}




-(void) cancelNewOutfit: (UIButton *) sender
{
    UIView *removeview = sender.superview;
    [removeview removeFromSuperview];
}






- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component 
{
    if(pickerView.tag == 892)
    {
        currentoutfitcategoryselection = row;
        NSLog(@"%i", currentoutfitcategoryselection);

    
    }
    
    if(pickerView.tag == 893)
    {
 
        removeDateButton.tag = row;
        
        
        NSLog(@"deletecatbutton tag is set to %i", removeDateButton.tag);
    }
    if(pickerView.tag == 9004)
    {
        
        currentcountryrow = row;
        

    }
    
    
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    if(pickerView.tag == 892)
    {
        NSUInteger numRows = [myCloset.outfitCategories count];
    
        return numRows;
    }
    if(pickerView.tag == 893)
    {
        NSUInteger numRows = [selectedDatesArray count];
        
        return numRows;
    }
    if(pickerView.tag == 9004)
    {
        
        
        
        
        //NSLocale *userlocale = [NSLocale currentLocale];
        NSLocale *userlocale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
        NSString *usercountryCode = [userlocale objectForKey: NSLocaleCountryCode];
        
        
        NSString *usercountry = [userlocale displayNameForKey: NSLocaleCountryCode value: usercountryCode];
        
        
        
        
        NSArray* countryArray = [NSLocale ISOCountryCodes];
        
        sortedCountryArray = [[NSMutableArray alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
        
        for (NSString *countryCode in countryArray) {
            
            NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
            [sortedCountryArray addObject:displayNameString];
            
        }
        
        [sortedCountryArray sortUsingSelector:@selector(compare:)];
        
        
        [sortedCountryArray insertObject:usercountry atIndex:0];

        NSUInteger numRows = [countryArray count];
        
      
        
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
    
    if (pickerView.tag == 892) 
    {
        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 200, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentLeft];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:40]];
        }
    

        [pickerLabel setText:[myCloset.outfitCategories objectAtIndex:row]];
    
    }
    
    if (pickerView.tag == 893) 
    {
        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 200, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentLeft];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:40]];
        }
        
        NSDate *tempdate = [selectedDatesArray objectAtIndex:row];
        
        int daysToAdd = 1;
        NSDate *newDate1 = [tempdate dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        
       
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
       
         [dateFormatter setDateFormat:@"EEE MM/dd/yy"];
        NSString *weekDay =  [dateFormatter stringFromDate:newDate1];
        
       
   
        
        [pickerLabel setText:weekDay];
        
    }
    
    if (pickerView.tag == 9004) 
    {
        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 250, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentLeft];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:24]];
        }
        
        
        [pickerLabel setText:[sortedCountryArray objectAtIndex:row]];
        
    }
    
    return pickerLabel;
    
    
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component 
{
    int sectionWidth = 300;
    
    return sectionWidth;
}













-(void) deleteDate: (UIButton *) sender
{
    if([selectedDatesArray count] > 0)
    {
        [selectedDatesArray removeObjectAtIndex:sender.tag];
    }
    
    if([selectedDatesArray count] == 0)
    {
        assignedDatesPicker.userInteractionEnabled = NO;
    }
    
    [assignedDatesPicker reloadAllComponents];
    
    sender.tag = 0;
    
    
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



-(void) addNewOutfitCategoryCallUp
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:[self retrieveView:6102] except:38];
        
        
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


-(void) alertWith: (NSString *) alertstring
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = 150;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 150)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        
        
        
        
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 75)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
      
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 100, 54, 36)];
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
        NSLog(@"38 already there!");
        
    }
    
    
}

-(void) alertGetStarted
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = self.view.frame.size.height/2;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, 100, 250, 150)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        
        
        
        
        
        [self.view addSubview:alertView];
        
        
        UILabel *alertHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
        alertHeader.numberOfLines = 0;
        alertHeader.textAlignment = UITextAlignmentCenter;
        alertHeader.text = @"GET STARTED";
        alertHeader.textColor = [UIColor whiteColor];
        alertHeader.font = [UIFont fontWithName:@"Futura" size:22];
        alertHeader.backgroundColor = [UIColor blackColor];
        
        [alertView addSubview:alertHeader];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 210, 50)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = @"Tap Organize to start adding items to your closet!";
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 100, 54, 36)];
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
        NSLog(@"38 already there!");
        
    }
    
    
}


-(void) alertWithBig: (NSString *) alertstring
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = 150;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 225)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        
        
        
        
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 210, 125)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel]; 
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 175, 54, 36)];
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
        NSLog(@"38 already there!");
        
    }
    
    
}




-(void) XaddNewOutfitCategory: (NSString *)name
{
     if(!myCloset.outfitCategories)
     {
         myCloset.outfitCategories = [[NSMutableArray alloc] init];
     } 
    

    [myCloset.outfitCategories addObject:name];
    
    NSLog(@"%@ added to category", name);
   
    if([NSKeyedArchiver archiveRootObject:myCloset toFile:pathcloset] == YES)
    {
        NSLog(@"ARCHIVING CLOSET new outfit category SUCCESSFUL");
    }
    
    [self listOutfitCategories];
    
    [outfitCategoryPicker reloadAllComponents];
}



-(void) listOutfitCategories;
{
    NSLog(@"outfit cat count %i", [myCloset.outfitCategories count]);
    
    
    for(int x = 0; x < [myCloset.outfitCategories count]; x++)
    {
        NSString *tempoutfitcategory = [myCloset.outfitCategories objectAtIndex:x];
        NSLog(@"%@", tempoutfitcategory);
    }

}




-(void) dismissAlert: (UIButton *) sender
{
    
        
    [sender.superview removeFromSuperview];
    [self reactivateAllInView:self.view];
    
    if (shouldTransfer == YES)
    {
        shouldTransfer = NO;
        
        [self switchToTransferHelp];
    }
    
}


NSString *urlencodedrecordstring;

-(void) uploadRecord
{
    
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/record.php", domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    NSString *requestBodyString = urlencodedrecordstring;
    NSLog(@"%@", requestBodyString);
    
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



-(void) confirmNewOutfit: (OutfitRecord *) record
{
    NSLog(@"new outfit category count %i", (int)[record.categories count]);
    NSLog(@"new outfit category date count %i", (int)[record.dates count]);
    
    
    
    
    if([myCloset.outfitCategories count] == 0)
    {
        NSLog(@"Add an outfit category first");
        [self alertWith:@"Please create a category to save to."];
    }
    else
    {
        
       newOutfitNameSet = outfitNameField.text;
    
        pathlastimagenum = [pathhome stringByAppendingPathComponent:@"lastimagenum.arch"];
        
        if(!(lastImageNumArch = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastimagenum]))
        {
            imageFileNum = 1;
        }
        else
        {
            imageFileNum = [lastImageNumArch intValue];
            imageFileNum++;
        }
        
        
  

    newShortOutfitImageFilePath = [NSString stringWithFormat:@"Documents/%do.png",imageFileNum];
    
    newShortOutfitImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dot.png",imageFileNum];
    
    newOutfitImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortOutfitImageFilePath];
        
    newOutfitImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortOutfitImageFilePathThumb];

    

        
    OutfitRecord *newOutfitRecord = record;
    newOutfitRecord.fileNumRef = imageFileNum;
          newOutfitRecord.imageFilePath = newOutfitImageFilePath;
    newOutfitRecord.imageFilePathThumb = newOutfitImageFilePathThumb;
    newOutfitRecord.categories = record.categories;
    newOutfitRecord.dates = record.dates;

    
        NSLog(@"new outfit cat count is %i", [newOutfitRecord.categories count]);
        
        
    newOutfitRecord.outfitTypeNum = outfitViewType;
        
    newOutfitRecord.outfitName = record.outfitName;
        
        NSLog(@"new outfit type is %i", outfitViewType);
        
    if (topbottomshoemode == TRUE)
    {
        newOutfitRecord.toprefnum =  scrollDisplayTops.fileNumRef;
        newOutfitRecord.rightrefnum = [outfitView findMiddleDisplayFileRefNum];
        newOutfitRecord.lowerrefnum = [outfitView findLowerDisplayFileRefNum];
        
        newOutfitRecord.topcatname = scrollDisplayTops.catname;
        newOutfitRecord.rightcatname = scrollDisplayBottoms.catname;
        newOutfitRecord.lowercatname = scrollDisplayShoes.catname;
        
        newOutfitRecord.toprackname = scrollDisplayTops.rackname;
        newOutfitRecord.rightrackname = scrollDisplayBottoms.rackname;
        newOutfitRecord.lowerrackname = scrollDisplayShoes.rackname;
        
        
        NSLog(@"outfit record refnums: %i, %i, %i", newOutfitRecord.toprefnum, newOutfitRecord.rightrefnum, newOutfitRecord.lowerrefnum);
        
        NSLog(@"outfit record cats: %@, %@, %@", newOutfitRecord.topcatname, newOutfitRecord.rightcatname, newOutfitRecord.lowercatname);
        
        NSLog(@"outfit record rack: %@, %@, %@", newOutfitRecord.toprackname, newOutfitRecord.rightrackname, newOutfitRecord.lowerrackname);
        
        
    }
        
    if (topshoemode == TRUE)
    {
        newOutfitRecord.toprefnum = scrollDisplayTops.fileNumRef;
    
        newOutfitRecord.lowerrefnum = scrollDisplayShoes.fileNumRef;
        
        newOutfitRecord.topcatname = scrollDisplayTops.catname;
  
        newOutfitRecord.lowercatname = scrollDisplayShoes.catname;
        
        newOutfitRecord.toprackname = scrollDisplayTops.rackname;
    
        newOutfitRecord.lowerrackname = scrollDisplayShoes.rackname;
        
        NSLog(@"outfit record refnums: %i, %i", newOutfitRecord.toprefnum, newOutfitRecord.lowerrefnum);
        
        NSLog(@"outfit record cats: %@, %@", newOutfitRecord.topcatname,newOutfitRecord.lowercatname);
        
        NSLog(@"outfit record rack: %@, %@", newOutfitRecord.toprackname,newOutfitRecord.lowerrackname);
   
            
    }
        
    if (topbottommode == TRUE)
    {
        newOutfitRecord.toprefnum = scrollDisplayTops.fileNumRef;
        newOutfitRecord.rightrefnum = scrollDisplayBottoms.fileNumRef;
        newOutfitRecord.topcatname = scrollDisplayTops.catname;
        newOutfitRecord.rightcatname = scrollDisplayBottoms.catname;
     
        
        newOutfitRecord.toprackname = scrollDisplayTops.rackname;
        newOutfitRecord.rightrackname = scrollDisplayBottoms.rackname;
   
        
        NSLog(@"outfit record refnums: %i, %i", newOutfitRecord.toprefnum, newOutfitRecord.rightrefnum);
        
        NSLog(@"outfit record cats: %@, %@", newOutfitRecord.topcatname, newOutfitRecord.rightcatname);
        
        NSLog(@"outfit record rack: %@, %@", newOutfitRecord.toprackname, newOutfitRecord.rightrackname);
        
    }
        
        
        if (overlayOn)
        {
           
            newOutfitRecord.topoverlayrefnum = scrollDisplayTopsOverlay.fileNumRef;
            
  
            newOutfitRecord.topoverlaycatname = scrollDisplayTopsOverlay.catname;
            
            
           
            newOutfitRecord.topoverlayrackname = scrollDisplayTopsOverlay.rackname;
            
            
            NSLog(@"outfit overlay refnums: %i", newOutfitRecord.topoverlayrefnum);
            
        }
        
        //add outfit refnum to each date in newOutfitRecord.dates

    NSLog(@"outfit saved in category %@", newOutfitRecord.outfitCategory);
    
        if(!myCloset.outfitsArray)
        {
            myCloset.outfitsArray = [[NSMutableArray alloc] init];
        }
        
        
    
    [myCloset.outfitsArray insertObject:newOutfitRecord atIndex:0];
    

    NSLog(@"saved outfit: %@", newOutfitImageFilePath);
    NSLog(@"saved outfitthumb: %@", newOutfitImageFilePathThumb); 

    
    if([NSKeyedArchiver archiveRootObject:myCloset toFile:pathcloset] == YES)
    {
        NSLog(@"ARCHIVING CLOSET (NEW OUTFIT) SUCCESSFUL");
        
        
        [UIImagePNGRepresentation(newOutfitImage) writeToFile:newOutfitImageFilePath atomically:YES];
        
        
        [UIImagePNGRepresentation(newOutfitImageThumb) writeToFile:newOutfitImageFilePathThumb atomically:YES];
        
        
        
        //newOutfitRecord.dates = [[NSMutableArray alloc] init];
        
        //[newOutfitRecord.dates addObjectsFromArray:selectedDatesArray];
        
        //[selectedDatesArray removeAllObjects];
        
        
        NSLog(@"selected dates  %i, outfit dates %i", [selectedDatesArray count],[newOutfitRecord.dates count]);
        
        //  add dates to datesrecord array, sort, seek dates and add outfit to respective dates   
        
        [myCloset addDates:newOutfitRecord.dates];
        
        [myCloset insertOutfitNum:newOutfitRecord.fileNumRef toDates:newOutfitRecord.dates];

    }
        else
        {
            NSLog(@"archive unsuccessful, outfit not saved");
        }
        
  
    lastImageNumArch = [NSNumber numberWithInt:imageFileNum];
    [NSKeyedArchiver archiveRootObject:lastImageNumArch toFile:pathlastimagenum];
        
        
        
        
        
        //update outfit browser edit state
        
        appDelegate.outfitBrowserController.editMade = TRUE;
        
        
        
        
        
        
    ImageRecord *topitemrecord = [self retrieveRecordNum:newOutfitRecord.toprefnum FromCatName:newOutfitRecord.topcatname RackName:newOutfitRecord.toprackname];
        
    ImageRecord *rightitemrecord = [self retrieveRecordNum:newOutfitRecord.rightrefnum FromCatName:newOutfitRecord.rightcatname RackName:newOutfitRecord.rightrackname];
        
    ImageRecord *loweritemrecord = [self retrieveRecordNum:newOutfitRecord.lowerrefnum FromCatName:newOutfitRecord.lowercatname RackName:newOutfitRecord.lowerrackname];
        
    ImageRecord *topoverlayitemrecord = [self retrieveRecordNum:newOutfitRecord.topoverlayrefnum FromCatName:newOutfitRecord.topoverlaycatname RackName:newOutfitRecord.topoverlayrackname];
        
        NSString * t = topitemrecord.rackName;
        NSString * b = rightitemrecord.rackName;
        NSString * f = loweritemrecord.rackName;
        NSString * o = topoverlayitemrecord.rackName;
        
        NSString * tc = topitemrecord.color;
        NSString * bc = rightitemrecord.color;
        NSString * fc = loweritemrecord.color;
        NSString * oc = topoverlayitemrecord.color;
        
        NSString * tb = topitemrecord.brand;
        NSString * bb = rightitemrecord.brand;
        NSString * fb = loweritemrecord.brand;
        NSString * ob = topoverlayitemrecord.brand;
        
        NSString * to = topitemrecord.occasion;
        NSString * bo = rightitemrecord.occasion;
        NSString * fo = loweritemrecord.occasion;
        NSString * oo = topoverlayitemrecord.occasion;
        
        NSString *recordstring = [NSString stringWithFormat:@"u=%@&t=%@&b=%@&f=%@&o=%@&tc=%@&bc=%@&fc=%@&oc=%@&tb=%@&bb=%@&fb=%@&ob=%@&to=%@&bo=%@&fo=%@&oo=%@", currentUser.username,t,b,f,o,tc,bc,fc,oc,tb,bb,fb,ob,to,bo,fo,oo];
        
        
        urlencodedrecordstring = [recordstring
                                       stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        NSLog(@"uploading outfit record !   %@", urlencodedrecordstring);
        
        [self uploadRecord];
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






HelpController *helpController;

-(IBAction) switchToHelp
{
   
        helpController = [[HelpController alloc] initWithNibName:@"HelpController" bundle:nil];
        

        [self presentModalViewController:helpController animated:YES];

}

-(void) switchToTransferHelp
{
  
    helpController = [[HelpController alloc] initWithNibName:@"HelpController" bundle:nil];
    
    [self presentModalViewController:helpController animated:YES];
    
    for(int x=0; x < 15; x++)
    {
        [helpController nextPage];
    }

    
}



-(IBAction) switchToOutfitBrowser
{
    
    
    outfitBrowserController = [[OutfitBrowserController alloc] initWithNibName:@"OutfitBrowserController" bundle:nil];
    
    
    [self presentModalViewController:outfitBrowserController animated:YES];
    
 
}

-(IBAction) switchToCalendar
{
  
    
    outfitBrowserController = [[OutfitBrowserController alloc] initWithNibName:@"OutfitBrowserController" bundle:nil];
    
    
    [self presentModalViewController:outfitBrowserController animated:YES];
    

    
}


-(IBAction) switchToOrganizer
{
    if(!organizerController)
    {
        organizerController = [[OrganizerController alloc] initWithNibName:@"OrganizerController" bundle:nil];
    }
    
    NSFileManager *filemgr;
    
    filemgr =[NSFileManager defaultManager];
    
    pathhomelitecloset = [pathhome stringByAppendingPathComponent:@"Lite"];
    
    pathliteclosetzip = [pathhome stringByAppendingPathComponent:@"litecloset.zip"];
    
    
    if([filemgr fileExistsAtPath:pathliteclosetzip])
    {
        
         [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        NSLog(@"lite zip exists! open unzip animation !");
        
         [self alertWithBigZip:@"The data from your Lite closet is being added. Please do not leave the app, or the transfer will fail. In such case, you will need to try again. This may take a few minutes. Thanks."];
     
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(organizerSwitch) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stopLiteZipAnimation) userInfo:nil repeats:NO];
        
    }
    else
    {
        [self organizerSwitch];
    }
    

}


-(IBAction) switchToGenius
{
    geniusMode = YES;
    
    if(!organizerController)
    {
        organizerController = [[OrganizerController alloc] initWithNibName:@"OrganizerController" bundle:nil];
    }
    
    NSFileManager *filemgr;
    
    filemgr =[NSFileManager defaultManager];
    
    pathhomelitecloset = [pathhome stringByAppendingPathComponent:@"Lite"];
    
    pathliteclosetzip = [pathhome stringByAppendingPathComponent:@"litecloset.zip"];
    
    
    if([filemgr fileExistsAtPath:pathliteclosetzip])
    {
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        NSLog(@"lite zip exists! open unzip animation !");
        
        [self alertWithBigZip:@"The data from your Lite closet is being added. Please do not leave the app, or the transfer will fail. In such case, you will need to try again. This may take a few minutes. Thanks."];
        
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(organizerSwitch) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stopLiteZipAnimation) userInfo:nil repeats:NO];
        
    }
    else
    {
        [self organizerSwitch];
    }
    
    
    NSLog(@"GENIUS MODE ACTIVE **** GGGGGGGGGGG");
    
    
}


-(void) organizerSwitch
{
    [self presentModalViewController:organizerController animated:YES];
}





-(void) switchToFashionFeed
{
    
    [exclamation setHidden: YES];
    
    
    fashionfeedController = [[FashionFeedController alloc] initWithNibName:@"FashionFeedController" bundle:nil];
    
    [self presentModalViewController:fashionfeedController animated:YES];
    
    
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


















//USE TO SCALE IMAGES DOWN

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}                                                       //END SCALE IMAGES DOWN








-(IBAction) giveScrCount
{
    

    
    for (int x = 0; x<[self.view.subviews count]; ++x)
    {
        int subnum = x;
        UIView *viewTagExtract = [self.view.subviews objectAtIndex:x];
        int tagnum = viewTagExtract.tag;
        NSLog(@"subnum %i tagnum %i", subnum, tagnum);
 
    }
    
    
    UIScrollView *enumScroll;
    enumScroll = [self.view.subviews objectAtIndex:8];
    UIViewInScroll *enumView;
    enumView = [enumScroll.subviews objectAtIndex:0];
    NSLog(@"enumView count %i", [enumView.subviews count]);
    
    for (int y = 0; y < [enumView.subviews count]; ++y)
    {
        
        UIScrollImageView *forimagetag = [enumView.subviews objectAtIndex:y];
        
        int tagnum2 = forimagetag.tag;
        NSLog(@"view number %i is tag #%i", y, tagnum2);
        
    }
    
  

}





-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField.tag == 203)
    {
        
    
        outfitNameEditOn = YES;
        
        UIScrollView *tempscroll = (UIScrollView *) textField.superview;
        
        CGPoint bottomOffset = CGPointMake(0, tempscroll.contentSize.height - tempscroll.bounds.size.height);
        [tempscroll setContentOffset:bottomOffset animated:YES];
        
        
    }
    
    if(!existing)
    {
        
    if (textField.tag == 9005)
    {
        if(!didshiftpw){
        CGPoint positionWithKeyboard = CGPointMake(self.view.center.x, self.view.center.y -180);
        
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithKeyboard;
        
        
        [UIView commitAnimations];
            didshiftpw = YES;
        }
    }
    }
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{

  
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{

    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{

}























//OTHER VIEWCONTROLLER FUNCTIONS

-(void)viewWillUnload
{
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point R", [organizerController.racksScroll.subviews count]);
    NSLog(@"unloading view");
}

- (void)viewDidUnload
{
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point Q", [organizerController.racksScroll.subviews count]);
  
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point P", [organizerController.racksScroll.subviews count]);

    
    
    [super viewWillAppear:animated];
   
    

}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point N", [organizerController.racksScroll.subviews count]);
    
    
    [super viewDidAppear:animated];
    NSLog(@"reload archive state is %i", reloadarchives);
    if(appDelegate.reloadarchives == YES)
    {
        NSLog(@"reload yes");
        reloadarchives = NO;
        [NSKeyedArchiver archiveRootObject:appDelegate.myCloset toFile:pathcloset];
        if(currentcategorytopscroll > [myCloset.categories count]-1 ||
           currentcategoryrightscroll > [myCloset.categories count]-1 ||
           currentcategorylowerscroll > [myCloset.categories count]-1)
        {
            currentcategorytopscroll = 0;
            currentcategoryrightscroll = 2;
            currentcategorylowerscroll = 3;
        }
        
        if(appDelegate.topChanged == YES){
            NSLog(@"loading top filter for reload");
            [self loadTopFilter];
            if(currentcategorytopoverlayscroll == 0)
            {
                [self loadTopOverlayFilter];
            }
        }
       
        if(appDelegate.rightChanged == YES)
            [self loadRightFilter];
       
        if(appDelegate.lowerChanged == YES)
            [self loadLowerFilter];
        
        if(appDelegate.topOverlayChanged == YES)
            [self loadTopOverlayFilter];
        
        if(appDelegate.accessoriesChanged == YES)
            [self loadAccessoriesFilter];
        
        
        
        
        if(accessoriesOn)
            [self toggleAccessories];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loadAllChangedArchives) userInfo:nil repeats:NO];
        
        
        [self refreshOutfitDisplay];
        
            
       
    }
    else NSLog(@"no reload");
     
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(stopLoadAnimation) userInfo:nil repeats:NO];
    
    
}


-(void) loadAllArchives{
    
   
       [self loadAllArchivesWithCats:currentcategorytopscroll :currentcategoryrightscroll :currentcategorylowerscroll :currentcategorytopoverlayscroll];
    
}

-(void) loadAllChangedArchives{
    
    NSLog(@"loading all changed archives");
    if(appDelegate.rightChanged)
    {
        NSLog(@"bottoms have changed for mixer load all changed archives");
    }
    
    if(appDelegate.topChanged == YES){
        [self loadHorizontalArchive:currentcategorytopscroll inViewInScroll:viewInScrollTops]; //top
        appDelegate.topChanged = NO;
        
        if(currentcategorytopoverlayscroll == 0)
        {
            [self loadVerticalArchive:currentcategorytopoverlayscroll inViewInScroll:viewInScrollTopsOverlay];
        }
        
    }
    
    if(appDelegate.rightChanged == YES){
        
        NSLog(@"right changed!");
        
    [self loadVerticalArchive:currentcategoryrightscroll inViewInScroll:viewInScrollBottoms]; //right
        appDelegate.rightChanged = NO;
    }
    
        
    if(appDelegate.lowerChanged == YES){
    [self loadHorizontalArchive:currentcategorylowerscroll inViewInScroll:viewInScrollShoes]; //lower
        appDelegate.lowerChanged = NO;
    }
    
            
    if(appDelegate.topOverlayChanged == YES){
    [self loadVerticalArchive:currentcategorytopoverlayscroll inViewInScroll:viewInScrollTopsOverlay]; //top overlay
        appDelegate.topOverlayChanged = NO;
    }
    
    appDelegate.accessoriesChanged = NO;
    appDelegate.reloadarchives = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point M", [organizerController.racksScroll.subviews count]);
  
    
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    //int x = [organizerController.racksScroll.subviews count];
    //
    //if(x==10)
    //{
    //UIView *tempview = [organizerController.racksScroll.subviews objectAtIndex:x-1];
    //    [tempview removeFromSuperview];
    //}
    
    
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point L", [organizerController.racksScroll.subviews count]);
    if(organizercontroller.organizerOpen)
    {
        NSLog(@"open 3");
    }
	[super viewDidDisappear:animated];
    
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  
        if ( [string isEqualToString: @"\n" ] ) {
        
            
            CGPoint positionWithoutKeyboard = CGPointMake(self.view.center.x, self.view.center.y +180);
            
            
            [UIView beginAnimations:@"rearranging tiles" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            self.view.center = positionWithoutKeyboard;
            
            
            [UIView commitAnimations];
            
        
		[ textField resignFirstResponder ];
		return NO; 
        
        } else return YES;
        

	
    return YES;
    
}

-(IBAction)toggleFilterMenu
{
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    mainViewController = [tabController.viewControllers objectAtIndex:0];
    NSLog(@"opening filter now from mixer");
    
    [mainViewController toggleFilterMenu];
    
        

}

-(IBAction)toggleMenu
{
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    mainViewController = [tabController.viewControllers objectAtIndex:0];
    NSLog(@"opening filter now from mixer");
    
    [mainViewController toggleMenu];
    
    
    
}


- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwinded to mixer controller");
    
    OutfitDetailController *outfitDetailController = [segue sourceViewController];
    
    [self confirmNewOutfit:outfitDetailController.record];
    
}



//END OTHER VIEWCONTROLLER FUNCTIONS









@end
