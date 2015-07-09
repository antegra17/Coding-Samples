//
//  OutfitRecord.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OutfitRecord.h"

@implementation OutfitRecord
@synthesize outfitTypeNum, imageFilePath, fileNumRef, outfitCategory, toprefnum, lowerrefnum, rightrefnum, topcatnum, rightcatnum, lowercatnum, toprackname, rightrackname, lowerrackname, topcatname, rightcatname, lowercatname, dates, outfitName, imageFilePathThumb, topoverlaycatname, topoverlaycatnum, topoverlayrackname, topoverlayrefnum, categories;


-(void) encodeWithCoder:(NSCoder *)aCoder
{
   
    [aCoder encodeInt:fileNumRef forKey:@"OutfitRecordfileNumRef"];
    [aCoder encodeInt:outfitTypeNum forKey:@"OutfitRecordoutfitTypeNum"];
    
    [aCoder encodeObject:outfitName forKey:@"OutfitRecordoutfitName"];
    
    
    [aCoder encodeObject:imageFilePath forKey:@"OutfitRecordimageFilePath"];
    [aCoder encodeObject:imageFilePathThumb forKey:@"OutfitRecordimageFilePathThumb"];
    [aCoder encodeObject:outfitCategory forKey:@"OutfitRecordoutfitCategory"];
    
    [aCoder encodeInt:toprefnum forKey:@"OutfitRecordtoprefnum"];
    [aCoder encodeInt:lowerrefnum forKey:@"OutfitRecordlowerrefnum"];
    [aCoder encodeInt:rightrefnum forKey:@"OutfitRecordrightrefnum"];
    [aCoder encodeInt:topoverlayrefnum forKey:@"OutfitRecordtopoverlayrefnum"];
    
    [aCoder encodeInt:topcatnum forKey:@"OutfitRecordtopcatnum"];
    [aCoder encodeInt:lowercatnum forKey:@"OutfitRecordlowercatnum"];
    [aCoder encodeInt:rightcatnum forKey:@"OutfitRecordrightcatnum"];
    [aCoder encodeInt:rightcatnum forKey:@"OutfitRecordtopoverlaycatnum"];
    
    [aCoder encodeObject:toprackname forKey:@"OutfitRecordtoprackname"];
    [aCoder encodeObject:rightrackname forKey:@"OutfitRecordrightrackname"];
    [aCoder encodeObject:lowerrackname forKey:@"OutfitRecordlowerrackname"];
    [aCoder encodeObject:topoverlayrackname forKey:@"OutfitRecordtopoverlayrackname"];


    [aCoder encodeObject:topcatname forKey:@"OutfitRecordtopcatname"];
    [aCoder encodeObject:rightcatname forKey:@"OutfitRecordrightcatname"];
    [aCoder encodeObject:lowercatname forKey:@"OutfitRecordlowercatname"];
     [aCoder encodeObject:topoverlaycatname forKey:@"OutfitRecordtopoverlaycatname"];
    
    [aCoder encodeObject:dates forKey:@"OutfitRecorddates"];
    [aCoder encodeObject:categories forKey:@"OutfitRecordcategories"];
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
  
    fileNumRef = [aDecoder decodeIntForKey:@"OutfitRecordfileNumRef"];
    outfitTypeNum = [aDecoder decodeIntForKey:@"OutfitRecordoutfitTypeNum"];
    outfitName = [aDecoder decodeObjectForKey:@"OutfitRecordoutfitName"];
    
    imageFilePath = [aDecoder decodeObjectForKey:@"OutfitRecordimageFilePath"];
        imageFilePathThumb = [aDecoder decodeObjectForKey:@"OutfitRecordimageFilePathThumb"];
    outfitCategory = [aDecoder decodeObjectForKey:@"OutfitRecordoutfitCategory"];
    
    toprackname = [aDecoder decodeObjectForKey:@"OutfitRecordtoprackname"];
    rightrackname = [aDecoder decodeObjectForKey:@"OutfitRecordrightrackname"];
    lowerrackname = [aDecoder decodeObjectForKey:@"OutfitRecordlowerrackname"];
    topoverlayrackname = [aDecoder decodeObjectForKey:@"OutfitRecordtopoverlayrackname"];
    
    topcatname = [aDecoder decodeObjectForKey:@"OutfitRecordtopcatname"];
    rightcatname = [aDecoder decodeObjectForKey:@"OutfitRecordrightcatname"];
    lowercatname = [aDecoder decodeObjectForKey:@"OutfitRecordlowercatname"];
    topoverlaycatname = [aDecoder decodeObjectForKey:@"OutfitRecordtopoverlaycatname"];
    
    toprefnum = [aDecoder decodeIntForKey:@"OutfitRecordtoprefnum"];
    lowerrefnum = [aDecoder decodeIntForKey:@"OutfitRecordlowerrefnum"];
    rightrefnum = [aDecoder decodeIntForKey:@"OutfitRecordrightrefnum"];
    topoverlayrefnum = [aDecoder decodeIntForKey:@"OutfitRecordtopoverlayrefnum"];
    
    topcatnum = [aDecoder decodeIntForKey:@"OutfitRecordtopcatnum"];
    lowercatnum = [aDecoder decodeIntForKey:@"OutfitRecordlowercatnum"];
    rightcatnum = [aDecoder decodeIntForKey:@"OutfitRecordrightcatnum"];
    rightcatnum = [aDecoder decodeIntForKey:@"OutfitRecordtopoverlaycatnum"];
    
    dates = [aDecoder decodeObjectForKey:@"OutfitRecorddates"];
    categories = [aDecoder decodeObjectForKey:@"OutfitRecordcategories"];

    return self;
}
@end
