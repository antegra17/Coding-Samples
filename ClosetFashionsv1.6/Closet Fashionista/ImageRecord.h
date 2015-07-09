//
//  ImageRecord.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageRecord : NSObject <NSCoding>
{
    NSString *imageFilePathBest;
    NSString *imageFilePathThumb;
    NSString *imageFilePath;
    int fileNumRef;
    int categoryNum;
    int categoryType;
    
    
    NSString *rackName;
    
    NSString *catName;
  
    
    NSString *color;
    NSString *brand;
    NSString *occasion;
    NSString *additionaltags;
    NSString *tagTwo;
    NSString *tagThree;
    
}

@property (nonatomic, retain) NSString *imageFilePath;
@property (nonatomic, retain) NSString *imageFilePathBest;

@property (nonatomic, retain) NSString *imageFilePathThumb;
@property int fileNumRef;
@property int categoryType;

@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *brand;

@property (nonatomic, retain) NSString *occasion;
@property (nonatomic, retain) NSString *additionaltags;
@property (nonatomic, retain) NSString *tagTwo;
@property (nonatomic, retain) NSString *tagThree;

@property (nonatomic, retain) NSString *rackName;
@property (nonatomic, retain) NSString *catName;


@end
 