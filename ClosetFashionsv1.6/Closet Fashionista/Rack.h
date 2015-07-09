//
//  Rack.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rack : NSObject <NSCoding>
{
    NSString *rackname;
    int racktype; //0 tops 1 bottoms or 2 shoes 
    NSMutableArray *rackitemsarray;
    BOOL shoudLoad;
    
}

-(Rack *) initRack;

@property (nonatomic, retain) NSString *rackname;
@property (nonatomic) int racktype;
@property (nonatomic) BOOL shouldLoad;
@property (nonatomic, retain) NSMutableArray *rackitemsarray;


@end
