//
//  UIOutfitImageView.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutfitRecord.h"
#import "TKCalendarMonthViewController.h"

@interface UIOutfitImageView : UIImageView <UIPickerViewDelegate, TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource, UITextViewDelegate, NSURLConnectionDelegate, UITextFieldDelegate>
{
    int fileNumRef;
    BOOL boolcal;
}

@property int fileNumRef;
@property BOOL boolcal;
-(BOOL) doesViewAlreadyExist: (int) findviewtag;
-(void) closeOutfitDisplay;
-(void) deleteOutfit;
-(void) alertShare;
-(void) pushUpload;
-(void) alertDelete;
-(void) deactivateAllInView: (UIView *) view except: (int) y;
-(void) reactivateAllInView: (UIView *) view;
//-(void)insert: (NSString *) filename;
-(void) alertWithBig: (NSString *) alertstring;
-(UIColor *)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy;
-(void)postUserName: (NSString *) username postNum: (int) postnum description: (NSString *) description;
-(void)updateFBcount: (NSString *) username;

-(void) closeOutfitSelector: (int) outfitnum;
-(OutfitRecord *) retrieveRecord: (int)fileNumRef;

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
