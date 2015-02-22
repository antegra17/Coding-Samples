//
//  ImageCounter.h
//  PeePaws
//
//  Created by Anthony Tran on 11/25/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageCounter : NSManagedObject

@property (nonatomic, retain) NSNumber * count;

@end
