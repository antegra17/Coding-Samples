//
//  DateRecord.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateRecord : NSObject <NSCoding>
{
    
    NSDate *date;
    NSMutableArray *outfitRefNumsArray;

}


@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSMutableArray *outfitRefNumsArray;



@end
 