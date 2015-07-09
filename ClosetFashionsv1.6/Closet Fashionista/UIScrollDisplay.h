//
//  scrollDisplay.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIScrollDisplay : UIImageView
{
    int fileNumRef, categoryType;
    
    NSString *catname;
    NSString *rackname;

}

@property int fileNumRef;
@property int categoryType;


@property (nonatomic, retain) NSString *catname;
@property (nonatomic, retain) NSString *rackname;

@end
