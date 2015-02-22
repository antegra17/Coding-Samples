//
//  DetailsViewController.h
//  PeePaws
//
//  Created by Anthony Tran on 10/19/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *growthPoints;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addDetailButton;

- (IBAction) unwindFromModalViewController:(UIStoryboardSegue *)segue;



@end
