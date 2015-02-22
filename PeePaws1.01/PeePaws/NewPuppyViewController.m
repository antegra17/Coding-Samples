//
//  NewPuppyViewController.m
//  PeePaws
//
//  Created by Anthony Tran on 11/2/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "NewPuppyViewController.h"
#import "PuppyProfile.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HeaderControlView.h"
#import "BreedSelectionController.h"
#import "DateSelectionController.h"
#import "ImageCounter.h"

@interface NewPuppyViewController ()

@end

@implementation NewPuppyViewController

@synthesize newprofilepicview, imageToolBar, nameField, breedOneLabel, breedTwoLabel, birthDateLabel,breedOneSelectionActive, birthDate, gender, genderSelector, editProfileActive, doneButton;


BOOL imageToolBarOpen;
PuppyProfile *newPuppyProfile;
AppDelegate *appDelegate;
NSManagedObjectContext *context;
UINavigationController *homeNavigationController;
HomeViewController *homeViewController;
HeaderControlView *headerControlView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imageToolBarOpen = NO;
    newprofilepicview.delegate = self;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    context = appDelegate.managedObjectContext;
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];
    homeViewController = [homeNavigationController.viewControllers objectAtIndex:0];
    headerControlView = homeViewController.headerControlView;
    [headerControlView setUserInteractionEnabled:NO];
    
    NSLog(@"number of views in homeNav is %ld", [homeNavigationController.viewControllers count]);
    
    breedOneSelectionActive = NO;
    nameField.delegate = self;
    gender = @"Boy";
    nameField.text = @"Enter puppy name";
    
        
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
        
    
    
        [doneButton addTarget:self action:@selector(addPuppy:) forControlEvents:UIControlEventTouchUpInside];
    
    [doneButton setUserInteractionEnabled:NO];
    [doneButton setAlpha:0.25];
    
    newprofilepicview.image  = [UIImage imageNamed:@"addpuppy.png"];
    newprofilepicview.contentMode = UIViewContentModeScaleAspectFit;
    newprofilepicview.backgroundColor = [UIColor clearColor];
    
    
    
    if (editProfileActive)
    {
        NSLog(@"EDITING ACTIVATED");
        
        // assign current puppies values to fields
        
        PuppyProfile *profile  = homeViewController.puppyData.profile;
        
        NSDate *originalBirthdate;
        
        originalBirthdate = profile.dob;
        birthDate = profile.dob;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        
        NSDateComponents *componentsA = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:originalBirthdate];
        
        
        NSInteger yearA = [componentsA year];
        NSInteger monthA = [componentsA month];
        NSInteger dayA = [componentsA day];
  
        
        nameField.text = profile.name;
        [breedOneLabel setTitle:profile.breedOne forState: UIControlStateNormal];
        [breedTwoLabel setTitle:profile.breedTwo forState: UIControlStateNormal];
        
        
          [birthDateLabel setTitle:[NSString stringWithFormat:@"%ld/%ld/%ld", (long)monthA, (long)dayA, (long)yearA] forState: UIControlStateNormal];
       
        
        
        
        NSString  *existingImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:profile.imagePath];
        
        newprofilepicview.image  = [[UIImage alloc] initWithContentsOfFile:existingImageFilePath];
        
        if ([profile.sex isEqualToString:@"Girl"])
        {
            genderSelector.selectedSegmentIndex = 1;
        }
        
        
        //change button to call saveChanges instead of addPuppy
        
        NSLog(@"done button label is %@", doneButton.titleLabel.text);
        
        [doneButton setTitle:@"Save" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(saveChanges:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton setAlpha:1.0];
        [doneButton setUserInteractionEnabled:YES];
        
        self.title = @"Edit Profile";
        [self.navigationController.navigationBar setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
          [UIFont fontWithName:@"Chalkduster" size:15],
          NSFontAttributeName, nil]];
        
    }

    newprofilepicview.layer.borderWidth = 2;
    newprofilepicview.layer.borderColor = [[UIColor whiteColor] CGColor];
   
    
    breedOneLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    breedOneLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    breedTwoLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    breedTwoLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    birthDateLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    birthDateLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor blackColor], NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:13.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor blackColor],NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:13.0], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [imageToolBar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    
    [imageToolBar setBackgroundColor:[UIColor blackColor]];
    [imageToolBar setAlpha:0.5];

    imageToolBar.clipsToBounds = YES;
    
    breedOneLabel.titleLabel.frame = breedOneLabel.frame;
    breedTwoLabel.titleLabel.frame = breedTwoLabel.frame;
    
   
    
    breedOneLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    breedTwoLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    
}

-(void)home:(UIBarButtonItem *)sender {
    [self setSegmentedControllerAppearance];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [homeViewController refreshPuppies];
    NSLog(@"home!");
}

-(void) setSegmentedControllerAppearance
{
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor whiteColor], NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:10.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor blackColor],NSForegroundColorAttributeName,
                                                             [UIFont fontWithName:@"Chalkduster" size:10.0], NSFontAttributeName, nil] forState:UIControlStateSelected];
}

-(void)saveChanges:(UIButton *) sender{
    NSLog(@"saving changes!!!");
    
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"PuppyData" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *puppiesUnmutable = [context executeFetchRequest:fetchRequest error:&error];
    
    PuppyProfile *profile;
    
    for (int x = 0; x < [puppiesUnmutable count]; x++)
    {
        PuppyData *puppy = [puppiesUnmutable objectAtIndex:x];
        
        profile = puppy.profile;
        NSLog(@"array contains %@", profile.name);
        
        if ([profile.name isEqualToString:homeViewController.puppyData.profile.name])
        {
            NSLog(@"matching!");
            profile.dob = birthDate;
     
            profile.name = nameField.text;
            profile.breedOne = breedOneLabel.titleLabel.text;
            profile.breedTwo = breedTwoLabel.titleLabel.text;
            profile.sex = gender;
            
            NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:profile.imagePath];
            
            
            [UIImagePNGRepresentation(newprofilepicview.image) writeToFile:newImageFilePath atomically:YES];
            
            
            break;
        }
 
    }
    
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    
   
    
    [homeViewController selectPuppy:profile.name];
    
    [self setSegmentedControllerAppearance];
    
    
    
    
}

-(IBAction) selectGender:(UISegmentedControl *)sender
{
    if (genderSelector.selectedSegmentIndex == 0)
        gender = @"Boy";
    else gender = @"Girl";
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@"Enter puppy name"])
        textField.text = @"";
        
    [self hideImageToolBar];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""])
    {
        textField.text = @"Enter puppy name";
        [doneButton setAlpha:0.25];
        [doneButton setUserInteractionEnabled:NO];
    }
    else if (![birthDateLabel.titleLabel.text isEqualToString:@"Select Birth Date"])
    {
        [doneButton setUserInteractionEnabled:YES];
        [doneButton setAlpha:1];
        
        
    }
    
}

-(void) addPuppy: (UIButton *) sender{
    
    if(!editProfileActive) //run this whole function only if editprofile is not active e.g. new puppy is being added
    {
    
    NSLog(@"Running addPuppy");
    
    homeViewController.addedPuppy = YES;
    
    NSError *error;
    
    PuppyData *newPuppy = [NSEntityDescription insertNewObjectForEntityForName:@"PuppyData" inManagedObjectContext:context];
    
    PuppyProfile *puppyProfile = [NSEntityDescription insertNewObjectForEntityForName:@"PuppyProfile" inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ImageCounter" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (ImageCounter * imageCounter in fetchedObjects)
    {
        NSLog(@"retrieved image count is %i", [imageCounter.count intValue]);
        int tempImageCount = [imageCounter.count intValue];
        
        tempImageCount++;
        
        imageCounter.count = [NSNumber numberWithInt:tempImageCount];
        
        
        
        NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",tempImageCount];
  
        
        NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
   
        
        [UIImagePNGRepresentation(newprofilepicview.image) writeToFile:newImageFilePath atomically:YES];
        
        puppyProfile.imagePath = [[NSString alloc] initWithString:newShortImageFilePath];
        
        NSLog(@"new puppy PICTURE is at %@", puppyProfile.imagePath);
        
        
    }
    
    puppyProfile.dob = birthDate;
    puppyProfile.name = nameField.text;
    puppyProfile.breedOne = breedOneLabel.titleLabel.text;
    puppyProfile.breedTwo = breedTwoLabel.titleLabel.text;
    puppyProfile.sex = gender;
    
    
    newPuppy.profile = puppyProfile;
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    }
    
      [self setSegmentedControllerAppearance];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) takePhoto: (UIBarButtonItem *) sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self hideImageToolBar];
    
    [self presentViewController:picker animated:YES completion:NULL];

}
-(IBAction) selectPhoto: (UIBarButtonItem *) sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self hideImageToolBar];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    [self reactivateInterface];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    newprofilepicview.image = chosenImage;
    [doneButton setHidden:NO];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [headerControlView.puppySelectionTableView reloadData];
    
   
}

-(void) showImageToolBar
{
    
    [doneButton setHidden:YES];
    [nameField setUserInteractionEnabled:NO];
    [genderSelector setUserInteractionEnabled:NO];
    [breedOneLabel setUserInteractionEnabled:NO];
    [breedTwoLabel setUserInteractionEnabled:NO];
    [birthDateLabel setUserInteractionEnabled:NO];
    
    if (!imageToolBarOpen)
    {
        
        NSLog(@"hi, moving toolbar");
    
        [UIView animateWithDuration:0.5 animations:^{
       
        
            imageToolBar.frame = CGRectMake(imageToolBar.frame.origin.x, imageToolBar.frame.origin.y - imageToolBar.frame.size.height, imageToolBar.frame.size.width, imageToolBar.frame.size.height);
        
            
            
        } ];
        
        imageToolBarOpen = YES;
        [imageToolBar setHidden:NO];
    }

}

-(void) reactivateInterface
{
    [nameField setUserInteractionEnabled:YES];
    [genderSelector setUserInteractionEnabled:YES];
    [breedOneLabel setUserInteractionEnabled:YES];
    [breedTwoLabel setUserInteractionEnabled:YES];
    [birthDateLabel setUserInteractionEnabled:YES];
}

-(IBAction) hideImageToolBar: (UIBarButtonItem *) sender
{
  
    [self reactivateInterface];
    
    if(imageToolBarOpen)
    {
        NSLog(@"hi, closing toolbar");
        
        [UIView animateWithDuration:0.5 animations:^{
        
            [imageToolBar setHidden:YES];
            
        
        imageToolBar.frame = CGRectMake(imageToolBar.frame.origin.x, imageToolBar.frame.origin.y + imageToolBar.frame.size.height, imageToolBar.frame.size.width, imageToolBar.frame.size.height);
        
        
         } ];
    }
    
    imageToolBarOpen = NO;
    [imageToolBar setHidden:YES];
    [doneButton setHidden:NO];
    
}

-(void) hideImageToolBar
{
    [imageToolBar setHidden:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        imageToolBar.frame = CGRectMake(imageToolBar.frame.origin.x, imageToolBar.frame.origin.y + imageToolBar.frame.size.height, imageToolBar.frame.size.width, imageToolBar.frame.size.height);
        
        
    } ];
    
    imageToolBarOpen = NO;
}

-(void) viewDidAppear:(BOOL)animated
{
    if(!editProfileActive)
    {
    [headerControlView setHidden:NO];
    }
    
    NSLog(@"appeared2");
    
}



-(void) viewWillAppear:(BOOL)animated
{
    
    
    NSLog(@"appeared");
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancelled");
    [doneButton setHidden:NO];
    
    [self reactivateInterface];
    
    [headerControlView.puppySelectionTableView reloadData];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    
   
    if ([segue.sourceViewController isKindOfClass:[BreedSelectionController class]]) {
        BreedSelectionController *breedSelectionController = segue.sourceViewController;
        // if the user clicked Cancel, we don't want to change the color
        
        if (breedOneSelectionActive == YES)
        {
            [breedOneLabel setTitle:breedSelectionController.selectedBreed forState:UIControlStateNormal];
        }
        else{
            [breedTwoLabel setTitle:breedSelectionController.selectedBreed forState:UIControlStateNormal];
        }
        
        breedOneSelectionActive = NO;
        
        
        
    }
    
    
    if ([segue.sourceViewController isKindOfClass:[DateSelectionController class]]) {
        DateSelectionController *dateSelectionController = segue.sourceViewController;

        
        
        birthDate = dateSelectionController.birthDate;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
        
        NSDateComponents *componentsA = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:birthDate];
    
     
        NSInteger yearA = [componentsA year];
        NSInteger monthA = [componentsA month];
        NSInteger dayA = [componentsA day];
        
        //birthDateLabel.titleLabel.text = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)monthA, (long)dayA, (long)yearA];
        
        [birthDateLabel setTitle:[NSString stringWithFormat:@"%ld/%ld/%ld", (long)monthA, (long)dayA, (long)yearA] forState: UIControlStateNormal];
        
        if (![nameField.text isEqualToString:@"Enter puppy name"])
             {
                 [doneButton setUserInteractionEnabled:YES];
                 [doneButton setAlpha:1];
                 
             }
        
    }

    
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    [self hideImageToolBar];
    
    NSLog(@"preparation for breed controller segue");
    if([[segue identifier] isEqualToString:@"BreedSelectionOne"])
    {
        NSLog(@"breedselectionONE active");
        breedOneSelectionActive = YES;
    }
    
    if ([segue.destinationViewController isKindOfClass:[BreedSelectionController class]]) {
        
        [headerControlView setHidden:YES];
        
    }
    
    
    if ([segue.destinationViewController isKindOfClass:[HomeViewController class]]) {
        
        NSLog(@"going home!!");
        
    }
    
}


@end
