//
//  NewDataViewController.m
//  PeePaws
//
//  Created by Anthony Tran on 10/10/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "NewDataViewController.h"
#import "HomeViewController.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"
#import "PuppyProfile.h"
#import "GrowthDataPoint.h"



@interface NewDataViewController ()


@end

@implementation NewDataViewController

@synthesize value, datePicker, ageLabel, weightField, doneButton;

UIStoryboard *mainStoryBoard;
AppDelegate *appDelegate;

HomeViewController *homeViewController;
DetailsViewController *detailsViewController;
UINavigationController *homeNavigationController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    value = 2029;
    // Do any additional setup after loading the view.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];
    homeViewController = [homeNavigationController.viewControllers objectAtIndex:0];
    //detailsViewController =[homeNavigationController.viewControllers objectAtIndex:2];
    
    homeViewController.addedPuppy = NO;
    
    
    weightField.delegate = self;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:5];
    
    
    UIImage *image = [UIImage imageNamed:@"BackArrow"];
    CGRect frame = CGRectMake(0, 0, 22, 22);
    
    //init a normal UIButton using that image
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [button addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* newBackButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,newBackButton,nil];
    
    NSDate *dateA = homeViewController.puppyData.profile.dob;
    NSDate *dateB = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:dateA
                                                 toDate:dateB
                                                options:0];
    
    
    int ageInWeeks = (int) components.day / 7;
    
    int remainderDays = components.day % 7;
    
    NSString * ageInWeeksDays = [NSString stringWithFormat:@"%i weeks %i days", ageInWeeks, remainderDays];
    
    ageLabel.text = ageInWeeksDays;
    
    [doneButton setUserInteractionEnabled:NO];
    [doneButton setAlpha:0.25];
    
    
    
}

-(void) home: (UIBarButtonItem *) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) addNewData
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    [f setMaximumFractionDigits:2];
    NSNumber *newGrowthWeight = [f numberFromString:self.weightField.text];
    
   // NSError *error;
   //
   // NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
   // NSEntityDescription *entity = [NSEntityDescription
   //                                entityForName:@"PuppyData" inManagedObjectContext:appDelegate.managedObjectContext];
   // [fetchRequest setEntity:entity];
   //  NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
   
    
    
    NSDate *dob = homeViewController.puppyData.profile.dob;
    NSDate *dateB = [datePicker date];
   
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    
    
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:dateB];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *dateC = [calendar dateFromComponents:components];
    
    
    GrowthDataPoint *dataPoint = [NSEntityDescription insertNewObjectForEntityForName:@"GrowthDataPoint"
                                                                           inManagedObjectContext:appDelegate.managedObjectContext];
    dataPoint.weight = newGrowthWeight;
    dataPoint.date = dateC;
    NSLog(@"newdate is %@", dateC);
    
    BOOL dateExists = NO;
    
    for (GrowthDataPoint * olddatapoint in detailsViewController.growthPoints)
    {
         NSDateComponents *componentsA = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:olddatapoint.date];
        NSDateComponents *componentsB= [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateC];
        
        
        NSInteger yearA = [componentsA year];
        NSInteger monthA = [componentsA month];
        NSInteger dayA = [componentsA day];
        NSInteger yearB = [componentsB year];
        NSInteger monthB = [componentsB month];
        NSInteger dayB= [componentsB day];
        
        if (yearA == yearB && monthA == monthB && dayA == dayB)
        {
            
            NSLog(@"%ld, %ld, %ld, %ld,%ld, %ld", yearA, yearB, monthA, monthB, dayA,dayB);
            NSLog(@"don't add!");
            dateExists = YES;
        }
        
        
        
        
    }
    
    if (!dateExists){
        [homeViewController.puppyData addGrowthdataObject:dataPoint];
    }
    
    
    [appDelegate saveContext];
    
        
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"date picked");
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        NSLog(@"entered value %@", textField.text);
       
    }
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)  textFieldShouldBeginEditing:(UITextField *)textField
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    [f setMaximumFractionDigits:2];
    NSNumber *newGrowthWeight = [f numberFromString:self.weightField.text];
    
    NSLog(@"%@", newGrowthWeight);
    
    if (newGrowthWeight != NULL)
    {
        [doneButton setUserInteractionEnabled:YES];
        [doneButton setAlpha:1];
    }else{
        [doneButton setUserInteractionEnabled:NO];
        [doneButton setAlpha:0.25];
    }
    return YES;

}


-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    [f setMaximumFractionDigits:2];
    NSNumber *newGrowthWeight = [f numberFromString:self.weightField.text];
    
    NSLog(@"%@", newGrowthWeight);
    
    if (newGrowthWeight != NULL)
    {
        [doneButton setUserInteractionEnabled:YES];
        [doneButton setAlpha:1];
    }else{
        [doneButton setUserInteractionEnabled:NO];
        [doneButton setAlpha:0.25];
    }
    
    
    
}

- (IBAction)datePickerChanged:(id)sender {
    

    NSDate *dateA = homeViewController.puppyData.profile.dob;
    NSDate *dateB = [datePicker date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:dateA
                                                 toDate:dateB
                                                options:0];
    
    
    int ageInWeeks = (int) components.day / 7;
    
    int remainderDays = components.day % 7;
    
    NSString * ageInWeeksDays = [NSString stringWithFormat:@"%i weeks %i days", ageInWeeks, remainderDays];
    
    ageLabel.text = ageInWeeksDays;
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
