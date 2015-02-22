//
//  HomeViewController.h
//  PeePaws
//
//  Created by Anthony Tran on 10/9/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuppyData.h"
#import "HeaderControlView.h"

@interface HomeViewController : UIViewController <UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *puppies;
@property (strong, nonatomic) PuppyData *puppyData;

@property (assign, nonatomic) int value;
@property (strong, nonatomic) IBOutlet UIScrollView *growthView;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *breedLabel;
@property (strong, nonatomic) IBOutlet UILabel *breedLabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *breedLeaderLabel;
@property (strong, nonatomic) HeaderControlView * headerControlView;
@property (assign, nonatomic) BOOL addedPuppy;
@property (strong, nonatomic) IBOutlet UISegmentedControl *timeFrameSelector;
@property (assign, nonatomic) float headerXstartRatio;
@property (assign, nonatomic) float headerWidthRatio;
@property (assign, nonatomic) float headerHeightRatio;
@property (assign, nonatomic) float screenWidth;
@property (assign, nonatomic) float screenHeight;
@property (assign, nonatomic) float headerHeight;
@property (assign, nonatomic) float headerWidth;
@property (assign, nonatomic) float headerStartX;

@property (strong, nonatomic) UIImageView *headerCover;
@property (strong, nonatomic) UIView *headerCoverView;
@property (strong, nonatomic) IBOutlet UIButton *projectButton;
@property (strong, nonatomic) IBOutlet UILabel *projectLabel;

- (void) selectPuppy: (NSString* ) puppyname;
- (void) refreshPuppiesNew;
- (void) refreshPuppies;
- (void)unwindFromModalViewController:(UIStoryboardSegue *)segue;
-(IBAction) selectTimeFrame:(UISegmentedControl *)sender;
-(IBAction) toggleProject;
@end
