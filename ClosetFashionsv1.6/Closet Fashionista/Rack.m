//
//  Rack.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Rack.h"

@implementation Rack
@synthesize rackname, racktype, rackitemsarray, shouldLoad;

-(Rack *) initRack
{
    rackitemsarray = [[NSMutableArray alloc] init];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:rackname forKey:@"Rackrackname"];
    [aCoder encodeInt:racktype forKey:@"Rackracktype"];
    [aCoder encodeObject:rackitemsarray forKey:@"Rackrackitemsarray"];
    [aCoder encodeBool:shouldLoad forKey:@"Rackrackshouldload"];
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    rackname = [aDecoder decodeObjectForKey:@"Rackrackname"];
    racktype = [aDecoder decodeIntForKey:@"Rackracktype"];
    rackitemsarray = [aDecoder decodeObjectForKey:@"Rackrackitemsarray"];
    shouldLoad = [aDecoder decodeBoolForKey:@"Rackrackshouldload"];
    
    return self;
}


@end
