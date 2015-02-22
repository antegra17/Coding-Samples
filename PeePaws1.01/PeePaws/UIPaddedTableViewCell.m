//
//  UIPaddedTableViewCell.m
//  PeePaws
//
//  Created by Anthony Tran on 1/8/15.
//  Copyright (c) 2015 Anthony Tran. All rights reserved.
//

#import "UIPaddedTableViewCell.h"
#import <UIKit/UIKit.h>

@implementation UIPaddedTableViewCell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 20;
    frame.size.width -= 40;
    [super setFrame:frame];
    
    self.textLabel.font  = [UIFont fontWithName:@"Chalkduster" size:17.0];
    self.textLabel.textColor =  [UIColor whiteColor];
}

@end
