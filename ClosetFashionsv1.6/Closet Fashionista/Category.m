
//
//  Category.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Category.h"

@implementation Category

@synthesize categoryname, categorynumber, racksarray, loadintoselector, shouldLoad;

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:categoryname forKey:@"Categorycategoryname"];
    [aCoder encodeInt:categorynumber forKey:@"Categorycategorynumber"];
    [aCoder encodeObject:racksarray forKey:@"Categoryracksarray"];
  
    
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    categoryname = [aDecoder decodeObjectForKey:@"Categorycategoryname"];
    categorynumber = [aDecoder decodeIntForKey:@"Categorycategorynumber"];
    racksarray = [aDecoder decodeObjectForKey:@"Categoryracksarray"];
    
    
    return self;
}

@end
