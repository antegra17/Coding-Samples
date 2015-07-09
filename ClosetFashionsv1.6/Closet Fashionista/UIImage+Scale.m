//
//  UIImageView+scale.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (scale)

-(UIImage*)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0,0,size.width, size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
