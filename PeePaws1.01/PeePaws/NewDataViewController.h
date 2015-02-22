//
//  NewDataViewController.h
//  PeePaws
//
//  Created by Anthony Tran on 10/10/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDataViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UITextField *weightField;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (nonatomic, assign) int value;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;


- (IBAction)datePickerChanged:(id)sender;

-(IBAction) addNewData;

@end
