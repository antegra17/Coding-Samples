//
//  DateSelectionController.m
//  PeePaws
//
//  Created by Anthony Tran on 11/23/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "DateSelectionController.h"

@interface DateSelectionController ()

@end

@implementation DateSelectionController

@synthesize datePicker, dateSelectionControllerLabel, selectedDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedDate = [datePicker date];
    // Do any additional setup after loading the view.
    
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
    
    
    
    //self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,newBackButton,nil];
}

-(void)home:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)datePickerChanged:(id)sender {
    
    selectedDate = [datePicker date];
    
    NSLog(@"%@", selectedDate);
    
    
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
