//
//  HelpController.m
//  ClosetFash
//
//  Created by Anthony Tran on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpController.h"
#import "MixerController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation HelpController

@synthesize goBackButton, helpView, nextButton, prevButton;

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



-(IBAction) goBack
{
    [self dismissModalViewControllerAnimated:YES];
    
}


#pragma mark - View lifecycle


int page;
NSMutableArray *helpImageArray;
MixerController *mixerController;
AppDelegate *appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appDelegate.mixerController;
    
    
    helpImageArray = [[NSMutableArray alloc] init];
    [helpImageArray addObject:@"help1.png"];
    [helpImageArray addObject:@"help2.png"];
    [helpImageArray addObject:@"help3.png"];
    [helpImageArray addObject:@"help4.png"];
    [helpImageArray addObject:@"help5.png"];
    [helpImageArray addObject:@"help6.png"];
    [helpImageArray addObject:@"help7.png"];
    [helpImageArray addObject:@"help8.png"];
    [helpImageArray addObject:@"help9.png"];
    [helpImageArray addObject:@"help10.png"];
    [helpImageArray addObject:@"help11.png"];
    [helpImageArray addObject:@"help12.png"];
    [helpImageArray addObject:@"help13.png"];
     [helpImageArray addObject:@"help14.png"];
     [helpImageArray addObject:@"help15.png"];
    [helpImageArray addObject:@"help22.png"];
    [helpImageArray addObject:@"help23.png"];
    [helpImageArray addObject:@"help24.png"];
    [helpImageArray addObject:@"help25.png"];
    [helpImageArray addObject:@"help26.png"];
    [helpImageArray addObject:@"help27.png"];
    [helpImageArray addObject:@"help28.png"];
    
    
    helpView.layer.borderWidth = 0;
    helpView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    //helpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"help1.png"]];
    helpView.image = [UIImage imageNamed:@"help1.png"];
    
    // Do any additional setup after loading the view from its nib.
    
    page = 0;

    if(mixerController.firstuse == YES)
    {
        goBackButton.hidden = YES;
    }
    else goBackButton.hidden = NO;
    
    
    if([[UIScreen mainScreen] bounds].size.height == 568){

    goBackButton.frame = CGRectMake(5,528,54,36);
    nextButton.frame = CGRectMake(190,527,51,35);
    prevButton.frame = CGRectMake(79,527,51,35);
        
    }
    
}


-(IBAction) nextPage
{
   
    

    
    if (page == 21)
    {
        [self goBack];
        [mixerController alertGetStarted];
    }
    
    if (page == 20 && mixerController.firstuse == NO)
    {
        page++;
        [nextButton setHidden:YES];
        helpView.image = [UIImage imageNamed:[helpImageArray objectAtIndex:page]];
    }
    
    if(page == 20 && mixerController.firstuse == YES)
    {
          page++;
        [nextButton setHidden:NO];
        helpView.image = [UIImage imageNamed:[helpImageArray objectAtIndex:page]];
      
        
    }
    if (page != 20 && page != 21)
    {
        page++;
        
        [prevButton setHidden:NO];
        
        helpView.image = [UIImage imageNamed:[helpImageArray objectAtIndex:page]];
        
        
    }
    
 
    
    
    
    
    NSLog(@"%i", page);
}

-(IBAction) previousPage
{
    
    
    if (page != 0)
    {
        
        page--;
        
        [nextButton setHidden:NO];
        
        helpView.image = [UIImage imageNamed:[helpImageArray objectAtIndex:page]];
    }
    
    if (page == 0)
    {
        [prevButton setHidden:YES];
    }
    
    NSLog(@"%i", page);
    
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
