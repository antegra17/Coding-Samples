//
//  DateRecord.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DateRecord.h"

@implementation DateRecord


@synthesize outfitRefNumsArray, date;


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:date forKey:@"DateRecorddate"];
    [aCoder encodeObject:outfitRefNumsArray forKey:@"DateRecordoutfitrefnumsArray"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
   
    date = [aDecoder decodeObjectForKey:@"DateRecorddate"];
    outfitRefNumsArray = [aDecoder decodeObjectForKey:@"DateRecordoutfitrefnumsArray"];
    
    return self;
}





@end
