//
//  NewProfilePicView.h
//  PeePaws
//
//  Created by Anthony Tran on 11/2/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewProfilePicViewDelegate;

@interface NewProfilePicView : UIImageView

@property (nonatomic, weak) id <NewProfilePicViewDelegate> delegate;


@end

@protocol NewProfilePicViewDelegate <NSObject>

-(void) showImageToolBar;

@end

