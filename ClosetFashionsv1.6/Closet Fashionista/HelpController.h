//
//  HelpController.h
//  ClosetFash
//
//  Created by Anthony Tran on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpController : UIViewController
{
    IBOutlet UIButton *goBackButton;
    IBOutlet UIImageView *helpView;
    IBOutlet UIButton *prevButton;
    IBOutlet UIButton *nextButton;
    
}

@property (nonatomic, retain) UIButton *goBackButton;
@property (nonatomic, retain) UIImageView *helpView;

@property (nonatomic, retain) UIButton *prevButton;
@property (nonatomic, retain) UIButton *nextButton;

-(IBAction) goBack;
-(IBAction) previousPage;
-(IBAction) nextPage;

@end
