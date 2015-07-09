//
//  User.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *username;
    NSString *password;
    NSString *country;
    int usernumber;
    int firstuse;
    NSString *closetfile;
    NSString *infobg;
    NSString *infofashion;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *closetfile;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *infobg;
@property (nonatomic, retain) NSString *infofashion;
@property int usernumber;
@property int firstuse;

@end
