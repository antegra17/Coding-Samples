//
//  Chart.h
//  PeePaws
//
//  Created by Anthony Tran on 10/13/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chart : UIView

@property (nonatomic, assign) int mode;
@property (nonatomic, assign) int totalTimeFrameWeeks;
@property (nonatomic, assign) BOOL project;

-(void) toggleProject;


@end
