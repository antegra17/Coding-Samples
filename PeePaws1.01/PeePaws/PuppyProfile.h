//
//  PuppyProfile.h
//  PeePaws
//
//  Created by Anthony Tran on 10/18/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PuppyData;

@interface PuppyProfile : NSManagedObject

@property (nonatomic, retain) NSDate * dob;
@property (nonatomic, retain) NSString * breedOne;
@property (nonatomic, retain) NSString * breedTwo;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) PuppyData *data;

@end
