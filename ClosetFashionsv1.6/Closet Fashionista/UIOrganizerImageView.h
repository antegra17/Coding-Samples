//
//  UIOrganizerImageView.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIOrganizerImageView : UIImageView <UITextFieldDelegate, UIPickerViewDelegate>
{
    int fileNumRef;
    int categoryType; //type 0 = top, type 1 = bottom, type 2 = shoes
    NSString *rackName;
    
}


@property int fileNumRef;
@property int categoryType;
@property (nonatomic, retain) NSString * rackName;

-(void) loadEditDetails: (UIButton *) sender;
-(void) suggestOutfit: (UIButton *) sender;

@end
