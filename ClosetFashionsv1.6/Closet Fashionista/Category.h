//
//  Category.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject <NSCoding>
{
NSString *categoryname;
int categorynumber; //0 tops 1 bottoms or 2 shoes, etc.
NSMutableArray *racksarray;
int loadintoselector; //0 top, 2 bottoms, 2 shoes
BOOL shoudLoad;
}

@property (nonatomic, retain) NSString *categoryname;
@property (nonatomic) int categorynumber;
@property (nonatomic, retain) NSMutableArray *racksarray;


@property (nonatomic) int loadintoselector;
@property (nonatomic) BOOL shouldLoad;


@end

