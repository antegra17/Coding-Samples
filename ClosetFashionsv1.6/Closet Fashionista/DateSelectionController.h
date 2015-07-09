//
//  DateSelectionController.h
//  PeePaws
//
//  Created by Anthony Tran on 11/23/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelectionController : UIViewController <UIPickerViewDelegate>

@property (nonatomic, strong) NSDate * selectedDate;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UILabel *dateSelectionControllerLabel;

- (IBAction)datePickerChanged:(id)sender;


@end
