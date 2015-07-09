//
//  ClipView.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ClipView.h"


@implementation ClipView



-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self pointInside:point withEvent:event])
    {
        UIView *tempview = self.superview;
     
        
        for(int x = 0; x<[tempview.subviews count]; ++x)
        {
            NSLog(@"tempview tag %i", tempview.tag);
            UIView *tempview2 = [tempview.subviews objectAtIndex:x];
            if (tempview2.tag == 20000) return [tempview2.subviews objectAtIndex:0];
        }
        
    }
    return nil;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
