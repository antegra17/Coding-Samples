//
//  UIScrollView+rackname.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITiledScrollView : UIScrollView 
{
    NSString *loadedrackname;
    NSString *loadedcatname;
}

@property (nonatomic, retain) NSString *loadedrackname;

@property (nonatomic, retain) NSString *loadedcatname;



@end
