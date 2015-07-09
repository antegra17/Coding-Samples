//
//  User.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User


@synthesize username, usernumber, closetfile, infobg, infofashion, country,password, firstuse;


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    
        [aCoder encodeObject:username forKey:@"Userusername"];
        [aCoder encodeObject:username forKey:@"Userpassword"];
        [aCoder encodeObject:country forKey:@"Usercountry"];
        [aCoder encodeInt:usernumber forKey:@"Userusernumber"];
        [aCoder encodeInt:firstuse forKey:@"Userfirstuse"];
        [aCoder encodeObject:closetfile forKey:@"Userclosetfile"];
        [aCoder encodeObject:infobg forKey:@"Userinfobg"];
        [aCoder encodeObject:infofashion forKey:@"Userinfofashion"];
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
       firstuse = [aDecoder decodeIntForKey:@"Userfirstuse"];
       username = [aDecoder decodeObjectForKey:@"Userusername"];
       password = [aDecoder decodeObjectForKey:@"Userpassword"];
       usernumber = [aDecoder decodeIntForKey:@"Userusernumber"];
       country = [aDecoder decodeObjectForKey:@"Usercountry"];
       closetfile = [aDecoder decodeObjectForKey:@"Userclosetfile"];
       infobg = [aDecoder decodeObjectForKey:@"Userinfobg"];
       infofashion = [aDecoder decodeObjectForKey:@"Userinfofashion"];
    
    return self;
}

@end
