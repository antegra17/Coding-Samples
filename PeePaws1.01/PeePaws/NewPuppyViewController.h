//
//  NewPuppyViewController.h
//  PeePaws
//
//  Created by Anthony Tran on 11/2/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "NewPuppyViewController.h"
#import "NewProfilePicView.h"

@interface NewPuppyViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, NewProfilePicViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet NewProfilePicView *newprofilepicview;
@property (strong, nonatomic) IBOutlet UIToolbar *imageToolBar;
@property (strong, nonatomic) IBOutlet UIButton *breedOneLabel;
@property (strong, nonatomic) IBOutlet UIButton *breedTwoLabel;
@property (strong, nonatomic) IBOutlet UIButton *birthDateLabel;
@property (assign, nonatomic) BOOL breedOneSelectionActive;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSelector;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (assign, nonatomic) BOOL editProfileActive;



//- (IBAction)datePickerChanged:(id)sender;

-(IBAction) takePhoto: (UIBarButtonItem *) sender;
-(IBAction) selectPhoto: (UIBarButtonItem *) sender;
-(IBAction) hideImageToolBar: (UIBarButtonItem *) sender;

- (IBAction)selectGender:(UISegmentedControl *)sender;

-(void) addPuppy: (UIButton *) sender;

-(void) hideImageToolBar;

@end
