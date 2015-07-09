//
//  ImageRecord.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageRecord.h"

@implementation ImageRecord


@synthesize imageFilePath, imageFilePathThumb, fileNumRef, categoryType, color, brand, occasion, additionaltags, rackName, catName, imageFilePathBest, tagTwo, tagThree;


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:imageFilePath forKey:@"ImageRecordimageFilePath"];
    [aCoder encodeObject:imageFilePathThumb forKey:@"ImageRecordimageFilePathThumb"];
    [aCoder encodeObject:imageFilePathBest forKey:@"ImageRecordimageFilePathBest"];
    [aCoder encodeInt:fileNumRef forKey:@"ImageRecordfileNumRef"];
    [aCoder encodeInt:categoryType forKey:@"ImageRecordcategoryType"];
    [aCoder encodeObject:rackName forKey:@"ImageRecordrackName"];
    [aCoder encodeObject:catName forKey:@"ImageRecordcatName"];
    
    [aCoder encodeObject:color forKey:@"ImageRecordcolor"];
    [aCoder encodeObject:occasion forKey:@"ImageRecordoccasion"];
    [aCoder encodeObject:brand forKey:@"ImageRecordbrand"];
    [aCoder encodeObject:additionaltags forKey:@"ImageRecordadditionaltags"];
    [aCoder encodeObject:tagTwo forKey:@"ImageRecordtagTwo"];
    [aCoder encodeObject:tagThree forKey:@"ImageRecordtagThree"];
  
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    imageFilePath = [aDecoder decodeObjectForKey:@"ImageRecordimageFilePath"];
    imageFilePathThumb = [aDecoder decodeObjectForKey:@"ImageRecordimageFilePathThumb"];
    imageFilePathBest = [aDecoder decodeObjectForKey:@"ImageRecordimageFilePathBest"];
    fileNumRef = [aDecoder decodeIntForKey:@"ImageRecordfileNumRef"];
    categoryType = [aDecoder decodeIntForKey:@"ImageRecordcategoryType"];
    rackName = [aDecoder decodeObjectForKey:@"ImageRecordrackName"];
    catName = [aDecoder decodeObjectForKey:@"ImageRecordcatName"];
    
    
    color = [aDecoder decodeObjectForKey:@"ImageRecordcolor"];
    occasion = [aDecoder decodeObjectForKey:@"ImageRecordoccasion"];
    brand = [aDecoder decodeObjectForKey:@"ImageRecordbrand"];
    additionaltags = [aDecoder decodeObjectForKey:@"ImageRecordadditionaltags"];
    tagTwo = [aDecoder decodeObjectForKey:@"ImageRecordtagTwo"];
    tagThree = [aDecoder decodeObjectForKey:@"ImageRecordtagThree"];
    
    return self;
}





@end
