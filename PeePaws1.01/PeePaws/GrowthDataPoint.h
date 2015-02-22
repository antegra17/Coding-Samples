//
//  GrowthDataPoint.h
//  PeePaws
//
//  Created by Anthony Tran on 10/18/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PuppyData;

@interface GrowthDataPoint : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) PuppyData *data;

@end
