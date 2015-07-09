//
//  FashionFeedController.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FashionFeedController : UIViewController<UIWebViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate>
{
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *trackerButton;
    IBOutlet UIButton *globalButton;
    IBOutlet UIButton *countryButton;
    IBOutlet UIButton *setCountryButton;
    
    IBOutlet UIButton *refreshButton;
    IBOutlet UIButton *profileButton;
    
}
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *trackerButton;
@property (nonatomic, retain) UIButton *globalButton;
@property (nonatomic, retain) UIButton *countryButton;
@property (nonatomic, retain) UIButton *setCountryButton;
@property (nonatomic, retain) UIButton *refreshButton;
@property (nonatomic, retain) UIButton *profileButton;
-(IBAction) goBack;
-(IBAction) loadGlobal;
-(IBAction) loadTracker;
-(IBAction) loadCountry;
-(IBAction) loadProfile;
-(IBAction) refresh;
-(IBAction) setCountry;
-(void) loadCountry: (NSString *) country;
-(void) getCountries;
-(void) shiftCountrySelect;
-(void) loadEditProfile;
-(void) switchProfileButton;
-(BOOL) doesViewAlreadyExist: (int) findviewtag;
-(void) deactivateAllInView: (UIView *) view except: (int) y and: (int) z;
-(void) deactivateAllInView: (UIView *) view except: (int) y;
-(void) reactivateAllInView: (UIView *) view;
-(void) dismissAlertUpdate: (UIButton *) sender;
-(void)updateProfile;
-(void) update;
-(void) dismissAlert: (UIButton *) sender;
-(void) dismissAlert;
-(UIView *) retrieveView: (int) findviewtag;
@end
