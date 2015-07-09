//
//  UIOutfitView.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutfitRecord.h"

@interface UIOutfitView : UIImageView
{
    int outfitType;
    OutfitRecord *createNewOutfit;
}

@property int outfitType;

-(int) findTopDisplayFileRefNum;

-(int) findMiddleDisplayFileRefNum;

-(int) findLowerDisplayFileRefNum;
-(int) findTopOverlayDisplayFileRefNum;


-(OutfitRecord *)OutfitTBwithTop:(ImageRecord *)T Bottom:(ImageRecord *)B;


-(OutfitRecord *)OutfitTSwithTop:(ImageRecord *)T Shoes:(ImageRecord *)S;


-(OutfitRecord *)OutfitTBSwithTop:(ImageRecord *)T Bottom:(ImageRecord *)B Shoes:(ImageRecord *)S;



@end
