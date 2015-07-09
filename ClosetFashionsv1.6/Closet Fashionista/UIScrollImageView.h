//
//  UIImageViewDrag.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIScrollImageView : UIImageView
{
    int fileNumRef;
    int categoryType; //type 0 = top, type 1 = bottom, type 2 = shoes
    
    NSString *catname;
    NSString *rackname;
    
    
}


@property int fileNumRef;
@property int categoryType;

@property (nonatomic, retain) NSString *catname;
@property (nonatomic, retain) NSString *rackname;
- (void)handleTap:(UITapGestureRecognizer *)sender;

@end
