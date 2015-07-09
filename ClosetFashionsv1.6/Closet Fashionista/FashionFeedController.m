//
//  FashionFeedController.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FashionFeedController.h"
#import "AppDelegate.h"
#import "MixerController.h"

#import <QuartzCore/QuartzCore.h>

@implementation FashionFeedController

@synthesize backButton, trackerButton, globalButton, countryButton, refreshButton, profileButton, setCountryButton;

AppDelegate *appdelegate;
MixerController *mixerController;


int currentloaded;
UIActivityIndicatorView *myIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


UIWebView *fashionfeed;
UIView *countryPickerHolder;
UIPickerView *countryPicker;
int currentcountryrow;
UIImage *retractmag;
UIImage *retractmagpressed;

UIImage *extendmag;
UIImage *extendmagpressed;

NSArray *activecountries;
NSMutableArray *activecountriesfinal;

int newcountryrow;

BOOL isCountryOpen;
BOOL ctyvisible;
BOOL shifted;


CGRect originalframe;

NSString *domain;

NSString *usercountry;
NSString *urlencodedcountry;

- (void)viewDidLoad
{
    isCountryOpen = NO;
    ctyvisible = NO;
    shifted = NO;
    
    
    [super viewDidLoad];
    
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appdelegate.mixerController;
    
    NSLog(@"domain is %@", mixerController.domain);

    domain = mixerController.domain;
    

                               
    // Do any additional setup after loading the view from its nib.
    
    
    retractmag = [UIImage imageNamed:@"retractmag.jpg"];
    retractmagpressed = [UIImage imageNamed:@"retractmagpressed.jpg"];
                         
    extendmag = [UIImage imageNamed:@"extendmag.jpg"];
    extendmagpressed = [UIImage imageNamed:@"extendmagpressed.jpg"];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    self.view.tag = 34949;
    int feedheight;
    
    
    
    if([[UIScreen mainScreen] bounds].size.height == 568){
        feedheight = 532;
    }
    else{
        feedheight = 444;
    }
    
    
    
    
    UIScrollView *fashionfeedScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, feedheight)];
    
    fashionfeedScroll.showsVerticalScrollIndicator = NO;
    
    
    fashionfeedScroll.backgroundColor  = [UIColor blackColor];
    fashionfeedScroll.tag = 39449494;
    
    fashionfeed = [[UIWebView alloc] init];
    fashionfeed.frame = CGRectMake(0, 0, 320, feedheight);
      fashionfeed.delegate = self;
    
    fashionfeed.backgroundColor = [UIColor blackColor];
    

    backButton.tag = 93494;
    
    
    countryPickerHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 424, 320, 0)];
    
    //end position  (0, 225, 320, 200)
    //start position CGRectMake(0, 424, 320, 0)
    
    countryPickerHolder.tag = 5000;
    
    //countryPickerHolder.layer.borderColor = [[UIColor blackColor] CGColor];
    //countryPickerHolder.layer.borderWidth = 2;
    //countryPickerHolder.backgroundColor = [UIColor redColor];
    
    
    countryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 12, 0, 0)];
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
    
    [countryPickerHolder addSubview:countryPicker];
    [self.view addSubview:countryPickerHolder];
    currentcountryrow=0;
   
 
    

    
   // NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docPath = [docPaths objectAtIndex:0];

    
    
    /*NSString *Html = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fashionfeed" ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];
    [Html writeToFile:[docPath stringByAppendingPathComponent:@"fashionfeed.html"] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    

    [fashionfeed loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[docPath stringByAppendingPathComponent:@"fashionfeed.html"]]]];*/
    

    
    
    [backButton removeFromSuperview];
    [self.view addSubview:backButton];
    [globalButton removeFromSuperview];
    [self.view addSubview:globalButton];
    [trackerButton removeFromSuperview];
    [self.view addSubview:trackerButton];
    [countryButton removeFromSuperview];
    [self.view addSubview:countryButton];
    [refreshButton removeFromSuperview];
    [self.view addSubview:refreshButton];
    [profileButton removeFromSuperview];
    [self.view addSubview:profileButton];
    [setCountryButton removeFromSuperview];
    [self.view addSubview:setCountryButton];
  
    originalframe = setCountryButton.frame;
    

    
    currentcountryrow = 0;
    
    
    myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	myIndicator.center = CGPointMake(160, 240);
	myIndicator.hidesWhenStopped = YES;
    
    [self.view addSubview:myIndicator];
    
    [self loadTracker];
    
       
        NSLocale *userlocale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
        NSString *usercountryCode = [userlocale objectForKey: NSLocaleCountryCode];
        
        
        usercountry = [userlocale displayNameForKey: NSLocaleCountryCode value: usercountryCode];
        
        urlencodedcountry = [usercountry
                             stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    [fashionfeedScroll addSubview:fashionfeed];
    
    [self.view addSubview:fashionfeedScroll];
 
}



-(void)getCountries
{
    
    [myIndicator startAnimating];
    
    
   NSString *urlString = [NSString stringWithFormat:@"http://%@/returncountries.php", domain];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
    NSString *requestBodyString = [NSString stringWithFormat:@""];
    
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
            [myIndicator stopAnimating];
            NSLog(@"something was downloaded");
            NSLog(@"requeststring is %@", requestBodyString);
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"reponse is %@", responseString);
            
            
         
            activecountries = [responseString componentsSeparatedByCharactersInSet:
                               [NSCharacterSet characterSetWithCharactersInString:@","]
                               ];  
           
            
            
            activecountriesfinal = [[NSMutableArray alloc] init];
            
            
            NSLocale *userlocale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
            NSString *usercountryCode = [userlocale objectForKey: NSLocaleCountryCode];
            
            
            NSString *usercountry = [userlocale displayNameForKey: NSLocaleCountryCode value: usercountryCode];
            
        
            
           
                [activecountriesfinal addObject:usercountry];
            
            
            
            for(int a = 0; a<[activecountries count]; a++)
            {
                NSString *tempcountry = [activecountries objectAtIndex:a];
              
                NSLog(@"temp country is %@", tempcountry);
                 
                [activecountriesfinal addObject:tempcountry];
            }
            
            [countryPicker reloadAllComponents];
            mixerController.activecountriesloaded = YES;
            
        
           
            
        }
        else if ([data length] == 0 && error == nil)
        {
            NSLog(@"nothing was downloaded");
            [myIndicator stopAnimating];
            
            
        }
        else if (error != nil)
        {
            NSLog(@"Error = %@", error);
            [myIndicator stopAnimating];
           
        }
    }];

    
    
    
    
    
    
}

-(void)setCountry
{
     
    [self shiftCountrySelect];
    
}

-(void) shiftCountrySelect
{
    shifted = NO;
    
    
    
    if (isCountryOpen == NO)
    {            
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        countryPickerHolder.frame = CGRectMake(0, 230, 320, 200);
        
        CGRect newframe = CGRectMake(originalframe.origin.x, originalframe.origin.y-193, originalframe.size.width, originalframe.size.height);
        setCountryButton.frame = newframe;
        
        [UIView commitAnimations];
        [setCountryButton setImage:retractmag forState:UIControlStateNormal];
        [setCountryButton setImage:retractmagpressed forState:UIControlStateHighlighted];
        
        
        isCountryOpen = YES;
        shifted = YES;
    }
    
    if (isCountryOpen == YES && shifted == NO)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        countryPickerHolder.frame = CGRectMake(0, 424, 320, 0);
        
        CGRect oldframe = CGRectMake(originalframe.origin.x, countryButton.frame.origin.y-18, originalframe.size.width, originalframe.size.height);
        setCountryButton.frame = oldframe;
        [UIView commitAnimations];
        isCountryOpen = NO;
        
        [self loadCountry: [activecountriesfinal objectAtIndex:currentcountryrow]];
        [setCountryButton setImage:extendmag forState:UIControlStateNormal];
        [setCountryButton setImage:extendmagpressed forState:UIControlStateHighlighted];
        
    }
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component 
{
    if(pickerView.tag == 9004)
    {
        currentcountryrow = row;
    }
    if(pickerView.tag == 9008)
    {
        newcountryrow = row;
    }
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{

    if(pickerView.tag == 9004)
    {

        
        NSUInteger numRows = [activecountriesfinal count];
        
        return numRows;
    }
    if(pickerView.tag == 9008)
    {
        NSArray* countryArray = [NSLocale ISOCountryCodes];
        
        mixerController.sortedCountryArray = [[NSMutableArray alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
        
        for (NSString *countryCode in countryArray) {
            
            NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
            [mixerController.sortedCountryArray addObject:displayNameString];
            
        }
        
        
        
        [mixerController.sortedCountryArray sortUsingSelector:@selector(compare:)];
        
        [mixerController.sortedCountryArray insertObject:mixerController.currentUser.country atIndex:0];
        NSUInteger numRows = [mixerController.sortedCountryArray count];
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
        
        
        //[pickerLabel setText:[mixerController.sortedCountryArray objectAtIndex:row]];
        [pickerLabel setText:[activecountriesfinal objectAtIndex:row]];
    }
    
    
    if (pickerView.tag == 9008) 
    {
        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 250, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentLeft];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:24]];
        }
        
        
        [pickerLabel setText:[mixerController.sortedCountryArray objectAtIndex:row]];
    }
    return pickerLabel;
    
    
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component 
{
    int sectionWidth = 300;
    
    return sectionWidth;
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



-(IBAction) goBack
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [myIndicator stopAnimating];
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void) loadPage: (NSString *) address
{
    //[[NSURLCache sharedURLCache] removeAllCachedResponses];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    myIndicator.center = CGPointMake(160, 240);
    [myIndicator startAnimating];
   
    
    NSString *urlString; 
    urlString = [address lowercaseString];
    
    NSLog(@"%@",urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];

    
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    [fashionfeed loadRequest:request];

    
    //[fashionfeed loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    fashionfeed.delegate = self;
    
    
}


-(IBAction) loadTracker
{
    if(shifted == YES)
    {
        [self shiftCountrySelect];
    }
    NSString *address = [NSString stringWithFormat:@"http://%@/feed.php?cuser=%@", domain, mixerController.currentUser.username];
    
    
    

    [self loadPage:address];
    
  
    
    currentloaded = 0;
    
    [setCountryButton setHidden:YES];
    [self switchProfileButton];
    
}

-(IBAction) loadGlobal
{
    if(shifted == YES)
    {
        [self shiftCountrySelect];
    }
    NSString *address = [NSString stringWithFormat:@"http://%@/feed.php?cuser=%@&mode=global", domain, mixerController.currentUser.username];
    
    
    [self loadPage:address];
 
    
    currentloaded = 1;
     [setCountryButton setHidden:YES];
    [self switchProfileButton];
    
}

         
-(void) loadCountry: (NSString *) country
{

    NSString *thisurlencodedcountry = [country
                                   stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *address = [NSString stringWithFormat:@"http://%@/feed.php?cuser=%@&mode=cty&country=%@", domain, mixerController.currentUser.username, thisurlencodedcountry];
  
    
    [self loadPage:address];
    
    currentloaded = 2;
    
    [setCountryButton setHidden:NO];
    
    [self switchProfileButton];
    
    
}
         
         
-(IBAction) loadCountry
{
    if(shifted == YES)
    {
        [self shiftCountrySelect];
    }
    
    if(mixerController.activecountriesloaded == NO)
    {
        [self getCountries];
  
    }
    
 
    
    NSString *address = [NSString stringWithFormat:@"http://%@/feed.php?cuser=%@&mode=cty&country=%@", domain,mixerController.currentUser.username, urlencodedcountry];
    
    
    
  
    
    [self loadPage:address];
    
    currentloaded = 2;
    
    [setCountryButton setHidden:NO];
    [self switchProfileButton];
    
    
}


-(IBAction) loadProfile
{
    if(shifted == YES)
    {
        [self shiftCountrySelect];
    }
        
    
    if (currentloaded != 3)
    {
    NSString *address = [NSString stringWithFormat:@"http://%@/feed.php?cuser=%@&guser=%@&mode=profile", domain, mixerController.currentUser.username,mixerController.currentUser.username];
    
    
    [self loadPage:address];
    
    currentloaded = 3;
    
        [setCountryButton setHidden:YES];
    [self switchProfileButton];
    }
    else
    {
        [self loadEditProfile];
    }

    
}



UITextView *aboutfield;
UITextView *preffield;
NSString *aboutstring;
NSString *prefstring;

UIView *editCountryView;
UIPickerView *editcountryPicker;

-(void) loadEditProfile
{
    
        if([self doesViewAlreadyExist:38] == NO && [mixerController.currentUser.username compare:@"unregistered"] != NSOrderedSame)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        
        
        UIView *editProfileView = [[UIView alloc] initWithFrame:CGRectMake(20,20,280,420)];
        
        editProfileView.backgroundColor = [UIColor whiteColor];
        
        
        editProfileView.tag = 38;
        
        editProfileView.layer.borderColor = [[UIColor blackColor] CGColor];
        editProfileView.layer.borderWidth = 2;
        
    
        
        
        [self.view addSubview:editProfileView];
        
        
    
        
        UILabel *aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 240, 20)];
        aboutLabel.text = @"Tell the world a little about yourself:";
        aboutLabel.textColor = [UIColor blackColor];
        aboutLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
        
        [editProfileView addSubview:aboutLabel];
        
        
        
        aboutfield = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 240, 100)];
        aboutfield.backgroundColor = [UIColor whiteColor];
        
        aboutfield.layer.borderColor = [[UIColor grayColor] CGColor];
        aboutfield.layer.borderWidth = 2;
        aboutfield.layer.cornerRadius = 5;
        
        aboutfield.tag = 777;
        aboutfield.text = mixerController.currentUser.infobg;
        aboutfield.delegate = self;
        
        aboutfield.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
        
        [editProfileView addSubview:aboutfield];
        
        UILabel *prefLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 240, 20)];
        prefLabel.text = @"Your favorite fashion styles/brands:";
        prefLabel.textColor = [UIColor blackColor];
        prefLabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:16];
        
        [editProfileView addSubview:prefLabel];
        
        preffield = [[UITextView alloc] initWithFrame:CGRectMake(20, 200, 240, 100)];
        preffield.backgroundColor = [UIColor whiteColor];
        
        preffield.layer.borderColor = [[UIColor grayColor] CGColor];
        preffield.layer.borderWidth = 2;
        preffield.layer.cornerRadius = 5;
        
        preffield.tag = 778;
        preffield.text = mixerController.currentUser.infofashion;
        preffield.delegate = self;
        
        preffield.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
        
        [editProfileView addSubview:preffield];
        
                
        
        UIImage *save= [UIImage imageNamed:@"savechange.jpg"];
        UIImage *savepressed = [UIImage imageNamed:@"savechangepressed.jpg"];
        
        UIImage *cancel = [UIImage imageNamed:@"cancel.jpg"];
        UIImage *cancelpressed = [UIImage imageNamed:@"cancelpressed.jpg"];
        
        
        UIImage *editcty = [UIImage imageNamed:@"editcountry.jpg"];
        UIImage *editctypressed = [UIImage imageNamed:@"editcountrypressed.jpg"];
        
        
        UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 370, 90, 36)];
        saveButton.tag=66;
        
        [saveButton setImage:save  forState:UIControlStateNormal];
        [saveButton setImage:savepressed forState:UIControlStateHighlighted];
        
        [saveButton addTarget:self action:@selector(dismissAlertUpdate:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 370, 90, 36)];
        
        
        cancelButton.tag= 38;
        [cancelButton setImage:cancel forState:UIControlStateNormal];
        [cancelButton setImage:cancelpressed forState:UIControlStateHighlighted];
        
        [cancelButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *editCtyButton = [[UIButton alloc] initWithFrame:CGRectMake(95, 320, 90, 36)];
        editCtyButton.tag=66;
        
        [editCtyButton setImage:editcty  forState:UIControlStateNormal];
        [editCtyButton setImage:editctypressed forState:UIControlStateHighlighted];
        
        [editCtyButton addTarget:self action:@selector(loadCtyEdit) forControlEvents:UIControlEventTouchUpInside];
        
        
        [editProfileView addSubview:saveButton];
        [editProfileView addSubview:cancelButton];
        [editProfileView addSubview:editCtyButton];
        
    
        
        
        
        
        
        
        
        
        currentcountryrow = 0;
        
        editCountryView = [[UIView alloc] initWithFrame:CGRectMake(0,180,320,290)];
        
        editCountryView.backgroundColor = [UIColor blackColor];
        
        
        editCountryView.tag = 39;
        
        editCountryView.layer.borderColor = [[UIColor blackColor] CGColor];
        editCountryView.layer.borderWidth = 2;
        [self.view addSubview:editCountryView];        
        
        
        
        
        
        
        editcountryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,10, 0, 0)];
        editcountryPicker.tag = 9008;
        editcountryPicker.delegate = self;
        editcountryPicker.showsSelectionIndicator = YES;
        
        
        
        // scale size of pickerview for categories
        
        CGAffineTransform t0 = CGAffineTransformMakeTranslation(countryPicker.bounds.size.width/1.0, countryPicker.bounds.size.height/1.0);
        CGAffineTransform s0 = CGAffineTransformMakeScale(0.9,0.9);
        CGAffineTransform t1 = CGAffineTransformMakeTranslation(-countryPicker.bounds.size.width/1.0, -countryPicker.bounds.size.height/1.0);
        countryPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
        
        //scale size of pickerview for categories
        
        //[countryPickerHolder addSubview:countryPicker];
        
        //countryPickerHolder.clipsToBounds = NO;
        
        [editCountryView addSubview:editcountryPicker];
        
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(133, 230, 54, 36)];
        okayButton.tag = 55;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlertCty) forControlEvents:UIControlEventTouchUpInside];
        
        
        [editCountryView addSubview:okayButton];
        editCountryView.hidden = YES;

        ctyvisible = NO;
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}



-(void) loadCtyEdit
{
    if(!ctyvisible)
    {
        [self deactivateAllInView:self.view except:39];
        UIView *tempview = [self retrieveView:39];
        tempview.userInteractionEnabled = YES;
        editCountryView.hidden = NO;

    }
}

-(void) webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [myIndicator stopAnimating];
    
}


NSString *newcountry;


-(void)updateProfile
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	myIndicator.center = CGPointMake(140, 210);
	myIndicator.hidesWhenStopped = YES;
     [myIndicator startAnimating];
    
    UIView *tempview = [self retrieveView:38];
    [tempview addSubview:myIndicator];
    
    [self deactivateAllInView:tempview except:38];
    
    NSString *urlencodedcountry = [newcountry
                                   stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/profileupdate.php", domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
    
    NSString *prefstringclean = [prefstring stringByReplacingOccurrencesOfString:@"&" withString:@"1-9-1"];
    NSString *aboutstringclean = [aboutstring stringByReplacingOccurrencesOfString:@"&" withString:@"1-9-1"];
    
    NSString *requestBodyString = [NSString stringWithFormat:@"cuser=%@&about=%@&pref=%@&country=%@", mixerController.currentUser.username, aboutstringclean, prefstringclean,urlencodedcountry];
    
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"]; // added from first suggestion 
    //NSURLResponse *response = NULL;
    //NSError *requestError = NULL;
    //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    
    //NSLog(@"%@", requestBodyString);
    
    //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error){ 
        
        if ([data length] > 0 && error == nil)
        {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [myIndicator stopAnimating];
            [self dismissAlert];
            NSLog(@"something was downloaded");
            
            
            
            NSLog(@"requeststring is %@", requestBodyString);
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"reponse is %@", responseString);
            
            mixerController.currentUser.infobg = aboutstring;
            mixerController.currentUser.infofashion = prefstring;
            mixerController.currentUser.country = newcountry;
            
            [NSKeyedArchiver archiveRootObject:mixerController.currentUser toFile:mixerController.pathuserfull];
            
            currentloaded = -1;
            [self loadProfile];
           
           
            
        }
        else if ([data length] == 0 && error == nil)
        {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            [myIndicator stopAnimating];
            [self dismissAlert];
            NSLog(@"nothing was downloaded");
           
            
        }
        else if (error != nil)
        {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            [myIndicator stopAnimating];
            [self dismissAlert];
            NSLog(@"Error = %@", error);
         
        }
    }];
    
    

    
    
     
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


-(void) dismissAlertUpdate: (UIButton *) sender
{
    aboutstring = aboutfield.text;
    prefstring = preffield.text;
    newcountry = [mixerController.sortedCountryArray objectAtIndex:newcountryrow];
    
    [self updateProfile];
    
    //[sender.superview removeFromSuperview];
    //[self reactivateAllInView:self.view];
 
}

-(void) dismissAlert
{
    //[self loadProfile];
    [self refresh];
    [self reactivateAllInView:self.view];
    UIView *temp = [self retrieveView:38];
    [temp removeFromSuperview];
 
}

-(void) dismissAlertCty
{

    [self reactivateAllInView:self.view];
    //UIView *temp = [self retrieveView:39];
    
    //temp.hidden = YES;
    editCountryView.hidden = YES;
    
    [self deactivateAllInView:self.view except:38 and:39];
    ctyvisible= NO;
}

-(void) deactivateAllInView: (UIView *) view except: (int) y and: (int) z
{
    
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        
        
        if (tempview.tag != y && tempview.tag != z)
        {
            
            tempview.userInteractionEnabled = NO;
            NSLog(@"%i deactivated", tempview.tag);
        }
        
    }
}



-(IBAction) refresh;
{
    
    if (currentloaded == 0) [self loadTracker];
    if (currentloaded == 1) [self loadGlobal];
    if (currentloaded == 2) [self loadCountry];
    if (currentloaded == 3) {
        currentloaded = -1;
       [self loadProfile];
    }
}




-(void) switchProfileButton
{
    
    if(currentloaded == 3)
    {
    UIImage *editprofile = [UIImage imageNamed:@"editprofile.jpg"];
    UIImage *editprofilepressed = [UIImage imageNamed:@"editprofilepressed.jpg"];
    
    [profileButton setImage:editprofile forState:UIControlStateNormal];
    [profileButton setImage:editprofilepressed forState:UIControlStateHighlighted];
    }
    else
    {
        UIImage *profile = [UIImage imageNamed:@"profile.jpg"];
        UIImage *profilepressed = [UIImage imageNamed:@"profilepressed.jpg"];
        
        [profileButton setImage:profile forState:UIControlStateNormal];
        [profileButton setImage:profilepressed forState:UIControlStateHighlighted];
    }
    
    
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
	if ( [ text isEqualToString: @"\n" ] ) {
  
        
		[ textView resignFirstResponder ];
		return NO;
	}
	return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 778)
    {
        CGPoint positionWithKeyboard = CGPointMake(self.view.center.x, self.view.center.y -180);
        
       
            [UIView beginAnimations:@"rearranging tiles" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            self.view.center = positionWithKeyboard;
            
            
            [UIView commitAnimations];
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 778)
    {
        CGPoint positionWithoutKeyboard = CGPointMake(self.view.center.x, self.view.center.y +180);
        
        
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithoutKeyboard;
        
        
        [UIView commitAnimations];
    }
}

 -(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
     
     
      NSString *requeststring = [[inRequest URL] absoluteString];
      NSLog(@"requeststring caught is %@", requeststring);
     [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
     
     if([requeststring compare:@"catch:stopactivity"]== NSOrderedSame)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     }
     
     return YES;
 }




/* for catching clicks in webpage
 -(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
 
 if ( [[[inRequest URL] scheme] isEqualToString:@"like"] ) {
 
 
 
 NSString *requeststring = [[inRequest URL] absoluteString];
 
 NSString *userandfilenum = [requeststring substringWithRange:NSMakeRange(5, [requeststring length]-5)];
 
 NSLog(@"%@", userandfilenum);
 
 NSString *username;
 NSString *filenum;
 
 
 NSString *separatorString = @"-";
 
 NSArray *split = [userandfilenum componentsSeparatedByString:separatorString];
 
 username = [split objectAtIndex:0];
 filenum = [split objectAtIndex:1];
 
 int filenumint = [filenum intValue];
 
 NSLog(@"%@, %i", username, filenumint);
 
 //[self likeFromUserName:mixerController.currentUser toUserName:username itemnum:filenumint];
 
 return NO;
 }
 
 
 if ( [[[inRequest URL] scheme] isEqualToString:@"comment"] ) {
 
 NSLog(@"Comment");
 
 return NO;
 }
 
 return YES;
 }
 */

@end
