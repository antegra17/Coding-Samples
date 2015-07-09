//
//  UIViewInScroll.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollImageView.h"

@interface UIViewInScroll : UIView
{
    int categorynum;
    BOOL addselectionmode;
   
}

@property int categorynum;
@property BOOL addselectionmode;

@end
