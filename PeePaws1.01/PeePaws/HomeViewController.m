//
//  HomeViewController.m
//  PeePaws
//
//  Created by Anthony Tran on 10/9/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "Chart.h"
#import "PuppyData.h"
#import "PuppyProfile.h"
#import "HeaderControlView.h"
#import "NewPuppyViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize puppyData, value, growthView, headerControlView, puppies, addedPuppy, ageLabel, sexLabel, breedLabel, timeFrameSelector, screenWidth, screenHeight, headerXstartRatio, headerHeightRatio, headerWidthRatio, headerHeight, headerWidth, headerStartX, breedLabelTwo, headerCover, headerCoverView, breedLeaderLabel, projectButton, projectLabel;

AppDelegate *appDelegate;
Chart *growthChart;
int currentPuppyIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    value = 1029;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
   
    
    growthView.clipsToBounds = YES;
    [growthView setShowsHorizontalScrollIndicator:NO];
    
    growthChart = [[Chart alloc] initWithFrame:CGRectMake(0, 0, growthView.frame.size.width, growthView.frame.size.height)];
    
    
    growthChart.backgroundColor = [UIColor clearColor];
    growthView.backgroundColor = [UIColor clearColor];

    [growthView addSubview:growthChart];
    
    headerXstartRatio= (float) 65/320;
    headerWidthRatio = (float) 210/320;
    headerHeightRatio = (float) 75/568;
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    headerStartX = screenWidth*headerXstartRatio;
    headerHeight = screenHeight * headerHeightRatio;
    headerWidth = screenWidth * headerWidthRatio;
    
    NSLog(@"xStartRatio %f, screenWidth %f, screenHeight %f, headerWidth %f", headerXstartRatio, screenWidth, screenHeight, headerWidth);
    
    

    [timeFrameSelector setEnabled:NO forSegmentAtIndex:1];
    [timeFrameSelector setEnabled:NO forSegmentAtIndex:2];

    headerControlView = [[HeaderControlView alloc] init];
    headerControlView.frame = CGRectMake(headerStartX,0, headerWidth, 105);
    headerControlView.clipsToBounds = YES;
    headerControlView.backgroundColor = [UIColor grayColor];
    
    [self.navigationController.view addSubview:headerControlView];
    [headerControlView setData];
    
    
    //headerCover Code
    
    headerCoverView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 60)];


    headerCover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    
    [headerCover setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [headerCoverView addSubview:headerCover];
    headerCoverView.clipsToBounds = YES;
    headerCover.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationController.view addSubview:headerCoverView];
    
    [headerCoverView removeFromSuperview];
    //end headerCover COde

   
    [self refreshPuppies];
    
    
    
    addedPuppy = NO;
    
    if([puppies count] >1)
    {
        [self addMenuButton];
        
    }
    else{
        breedLabel.text = @"";
        breedLabelTwo.text = @"";
        breedLeaderLabel.text = @"";
        ageLabel.text = @"";
        sexLabel. text = @"";
    }
    
    
    
    NSLog(@"%f SCREEN HEIGHT",self.view.frame.size.height);

    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    self.tabBarController.tabBar.shadowImage = [UIImage new];
    self.tabBarController.tabBar.translucent = YES;
    
    UITabBarItem *tabBarItem = [[[[self tabBarController]tabBar]items] objectAtIndex:0];
    [tabBarItem setEnabled:FALSE];
    
    
    NSLog(@"growth view size is %f", growthView.frame.size.width);
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor whiteColor], NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:10.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor blackColor],NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:10.0], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
  
    breedLabel.adjustsFontSizeToFitWidth = YES;
    breedLabelTwo.adjustsFontSizeToFitWidth = YES;
    
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor grayColor] };
    [timeFrameSelector setTitleTextAttributes:attrs forState:UIControlStateDisabled];
    
    UIImage *image = [[UIImage imageNamed:@"Eye"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [projectButton setImage:image forState:UIControlStateNormal];
     projectButton.tintColor = [UIColor whiteColor];
    projectButton.alpha = 0.75;
    
    [self.projectLabel setHidden:TRUE];
    
    if(headerControlView.frame.size.height > 105)
    {
        NSLog(@"header view is open");
         [headerControlView tableView:headerControlView.puppySelectionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
}

-(void) addMenuButton{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:10];
    
    
    UIImage *image = [UIImage imageNamed:@"MenuIcon"];
    CGRect frame = CGRectMake(0, 0, 22, 22);
    
    //init a normal UIButton using that image
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [button addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* openMenuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,openMenuButton,nil];
    
}

-(IBAction) selectTimeFrame:(UISegmentedControl *)sender
{
    if (timeFrameSelector.selectedSegmentIndex == 0){
    
        growthChart.mode = 0;
        
        
        [growthChart setNeedsDisplay];
        
    }
        
    if(timeFrameSelector.selectedSegmentIndex == 1){
        
        growthChart.mode = 1;
        [growthChart setNeedsDisplay];
        
    }
            
    if(timeFrameSelector.selectedSegmentIndex == 2){
        
        growthChart.mode = 2;
        [growthChart setNeedsDisplay];
    }
        NSLog(@"%i", growthChart.mode);
       
    
}

-(void)openMenu:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"OpenMenuSegue" sender:sender];
    
}


-(void) refreshPuppies
{
    [puppies removeAllObjects];
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"PuppyData" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *puppiesUnmutable = [context executeFetchRequest:fetchRequest error:&error];
    
   
    
    puppies = [puppiesUnmutable mutableCopy];
    
    NSLog(@"REFRESHED puppy count is %lu", (long)[puppies count]);
    
    currentPuppyIndex = 0;
    puppyData = [puppies objectAtIndex:currentPuppyIndex];
    
    
    for (int x = 0; x < [puppies count]; x++)
    {
        PuppyData *puppy = [puppies objectAtIndex:x];
        
        PuppyProfile *profile = puppy.profile;
        NSLog(@"array contains %@", profile.name);
        if ([profile.name isEqualToString:@"Add Puppy"])
        {
            [puppies removeObjectAtIndex:x];
            [puppies insertObject:puppy atIndex:[puppies count]];
        }
    }
    
    [headerControlView.puppySelectionTableView reloadData];
   
    if([puppies count] > 1)
    {
    
       [headerControlView tableView:headerControlView.puppySelectionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
      
     }
    
    
   
}

-(void) refreshPuppiesNew
{
    
    if([puppies count] > 1)
    {
    
        [headerControlView tableView:headerControlView.puppySelectionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[puppies count]-2 inSection:0]];
    }
    
    else{
    
        [headerControlView tableView:headerControlView.puppySelectionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    
    [headerControlView tableView:headerControlView.puppySelectionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
    
   //headerControlView.frame = CGRectMake(75,0,headerControlView.frame.size.width,10);
    
}


- (void) selectPuppy: (NSString* ) puppyname {
    
    if ([puppyname isEqualToString:@"Add Puppy"])
    {
        
        NewPuppyViewController *newPuppyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewPuppyViewController"];
        
       
        [self.navigationController pushViewController:newPuppyViewController animated:nil];
    }
    else{
    
        for (PuppyData * puppy in puppies)
        {
            PuppyProfile *profile = puppy.profile;
            if ([profile.name isEqualToString:puppyname])
            {
                puppyData = puppy;
            }
        }
        
        [growthChart setNeedsDisplay];
        [growthView setNeedsDisplay];
        growthView.contentSize = growthChart.frame.size;
        
        
        if(([puppyData.profile.breedOne isEqualToString:@"Select 1st Breed"] || [puppyData.profile.breedOne isEqualToString:@"None"]) && ([puppyData.profile.breedTwo isEqualToString:@"Select 2nd Breed"] || [puppyData.profile.breedTwo isEqualToString:@"Unknown"])){
            breedLabel.text = @"";
            breedLabelTwo.text = @"";
            breedLeaderLabel.text = @"";
        }
        else if([puppyData.profile.breedTwo isEqualToString:@"Select 2nd Breed"] || [puppyData.profile.breedTwo isEqualToString:@"None"]){
            breedLabel.text = [NSString stringWithFormat:@"%@", puppyData.profile.breedOne];
            breedLabelTwo.text = @"";
            breedLeaderLabel.text = @"Breed:";
        }
        else if([puppyData.profile.breedOne isEqualToString:@"Select 1st Breed"] || [puppyData.profile.breedOne isEqualToString:@"None"]){
            breedLabel.text = [NSString stringWithFormat:@"%@", puppyData.profile.breedTwo];
            breedLeaderLabel.text = @"Breed:";
        }
        else{
            breedLabel.text = [NSString stringWithFormat:@"%@", puppyData.profile.breedOne];
            breedLabelTwo.text =[NSString stringWithFormat:@"%@", puppyData.profile.breedTwo];
            breedLeaderLabel.text = @"Breeds:";
            
        }
        
        
        
        NSLog(@"gender is %@", puppyData.profile.sex);
        
        sexLabel.text = [NSString stringWithFormat:@"Sex:     %@", puppyData.profile.sex];
        
        NSDate *dateA = puppyData.profile.dob;
        NSDate *dateB = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                   fromDate:dateA
                                                     toDate:dateB
                                                    options:0];
        
        
        int ageInWeeks = (int) components.day / 7;
        
        int remainderDays = components.day % 7;
        
        NSString * ageInWeeksDays = [NSString stringWithFormat:@"Age:    %i weeks %i days", ageInWeeks, remainderDays];
        
        
        NSLog(@" AGE %@", ageInWeeksDays);
        ageLabel.text = ageInWeeksDays;
        
        
        if (ageInWeeks > 12)
        {
            NSLog(@"setting yes");
            [timeFrameSelector setEnabled:YES forSegmentAtIndex:2];
        } else [timeFrameSelector setEnabled:NO forSegmentAtIndex:2];
        
        
        
        if (ageInWeeks > 52)
        {
            NSLog(@"setting yes");
            [timeFrameSelector setEnabled:YES forSegmentAtIndex:1];
        } else [timeFrameSelector setEnabled:NO forSegmentAtIndex:1];
        
       
        
        
    }

    

    if([UIScreen mainScreen].bounds.size.height == 480)
    {
        sexLabel.text = @"";
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
   
    
    
    [growthChart setNeedsDisplay];
    [growthView setNeedsDisplay];
    growthView.contentSize = growthChart.frame.size;
    
    if (addedPuppy == NO)
    {
        NSLog(@"addedpuppy is NO!!!");
        //[self refreshPuppies];
    }
    else NSLog(@"addedpuppy is YESSS!!");
    
   
    
    [headerControlView setUserInteractionEnabled:YES];
    
    if(addedPuppy)
    {
        [self refreshPuppies];
        
        if(self.navigationItem.rightBarButtonItems == nil)
        {
            [self addMenuButton];
        }
         addedPuppy = NO;
    }
    
    [headerControlView setHidden:NO];
    
    
    [self setControlAppearance];
    
    if(headerControlView.frame.size.height > 105)
    {
        [headerControlView tableView:headerControlView.puppySelectionTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    
}

-(void) setControlAppearance
{
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor whiteColor], NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:10.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor blackColor],NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:10.0], NSFontAttributeName, nil] forState:UIControlStateSelected];
}


- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwinding to homecontroller");
    [headerControlView.puppySelectionTableView reloadData];
  
    
    //[self refreshPuppiesNew];

    
}
-(IBAction) toggleProject
{
    if(growthChart.project)
    {
        [projectButton setTintColor:[UIColor whiteColor]];
        [projectLabel  setHidden:TRUE];
    }else{
        [projectButton setTintColor:[UIColor yellowColor]];
        [projectLabel  setHidden:FALSE];
    }
    
    [growthChart toggleProject];
    [growthChart setNeedsDisplay];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
