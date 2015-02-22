//
//  NewProfilePicView.m
//  PeePaws
//
//  Created by Anthony Tran on 11/2/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "NewProfilePicView.h"

@implementation NewProfilePicView

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"profile pic touched!");
    
    [self.delegate showImageToolBar];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
