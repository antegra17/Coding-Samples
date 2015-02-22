//
//  PuppyData.h
//  PeePaws
//
//  Created by Anthony Tran on 10/18/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PuppyProfile;
@class GrowthDataPoint;

@interface PuppyData : NSManagedObject

@property (nonatomic, retain) PuppyProfile *profile;
@property (nonatomic, retain) NSSet *growthdata;
@end

@interface PuppyData (CoreDataGeneratedAccessors)

- (void)addGrowthdataObject:(GrowthDataPoint *)value;
- (void)removeGrowthdataObject:(GrowthDataPoint *)value;
- (void)addGrowthdata:(NSSet *)values;
- (void)removeGrowthdata:(NSSet *)values;

@end
