//
//  OutfitRecord.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageRecord.h"

@interface OutfitRecord : NSObject <NSCoding>
{
    int outfitTypeNum;    // 0 = top/right/lower    1= top/lower     2 = topoverlay/top/right/lower   3=topoverlay/top/lower
    
    int fileNumRef;
    
    
    
    NSString *imageFilePath;
    NSString *imageFilePathThumb;
    NSString *outfitCategory;
    
    NSString *outfitName;
    

    int topcatnum;
    int rightcatnum;
    int lowercatnum;
    int topoverlaycatnum;
    
    NSString *toprackname;
    NSString *topoverlayrackname;
    NSString *rightrackname;
    NSString *lowerrackname;
    
    
    NSString *topcatname;
    NSString *topoverlaycatname;
    NSString *rightcatname;
    NSString *lowercatname;
    
    int toprefnum;
    int topoverlayrefnum;
    int rightrefnum;
    int lowerrefnum;
    
    NSMutableArray *dates;
    NSMutableArray *categories;
    
}


@property int outfitTypeNum; // 0-tbs 1-ts 2-otbs 3-ots
@property int fileNumRef;
@property (nonatomic, retain) NSString *outfitName;

@property (nonatomic, retain) NSString *imageFilePath;
@property (nonatomic, retain) NSString *imageFilePathThumb;
@property (nonatomic, retain) NSString *outfitCategory;
@property (nonatomic, retain) NSMutableArray *dates;
@property (nonatomic, retain) NSMutableArray *categories;


@property int toprefnum;
@property int rightrefnum;
@property int lowerrefnum;
@property int topoverlayrefnum;

@property (nonatomic, retain) NSString *toprackname;
@property (nonatomic, retain) NSString *topoverlayrackname;
@property (nonatomic, retain) NSString *rightrackname;
@property (nonatomic, retain) NSString *lowerrackname;

@property (nonatomic, retain) NSString *topcatname;
@property (nonatomic, retain) NSString *topoverlaycatname;
@property (nonatomic, retain) NSString *rightcatname;
@property (nonatomic, retain) NSString *lowercatname;

@property int topcatnum;
@property int topoverlaycatnum;
@property int rightcatnum;
@property int lowercatnum;




@end
