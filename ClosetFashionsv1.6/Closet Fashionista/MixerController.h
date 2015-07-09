//
//  MixerController.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIOutfitView.h"
#import "UIScrollDisplay.h"
#import "OutfitBrowserController.h"
#import "OrganizerController.h"
#import "UIViewInScroll.h"
#import "User.h"
#import "FashionFeedController.h"
#import "TKCalendarMonthViewController.h"




@interface MixerController : UIViewController <UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource>
{
    UIActivityIndicatorView *myLoadIndicator;
   

    IBOutlet UIButton *createButton;
    IBOutlet UIButton *helpButton;
    IBOutlet UIButton *switchToOrganizerButton;
    IBOutlet UIButton *filterTopButton;
    IBOutlet UIButton *filterRightButton;
    IBOutlet UIButton *filterLowerButton;
    IBOutlet UIButton *filterTopOverlayButton;
    IBOutlet UIButton *filterAccessoriesButton;
    
    
    
    IBOutlet UIButton *loadOutterwearButton;
    NSString *domain;
    
    IBOutlet UIOutfitView *outfitView;
    
    IBOutlet UIScrollView *scrollTops;
    IBOutlet UIScrollDisplay *scrollDisplayTops;
    
    IBOutlet UIScrollView *scrollShoes;
    IBOutlet UIScrollDisplay *scrollDisplayShoes;
    
    IBOutlet UIScrollView *scrollBottoms;
    IBOutlet UIScrollDisplay *scrollDisplayBottoms;
    
    
    IBOutlet UIScrollView *scrollTopsOverlay;
    IBOutlet UIScrollDisplay *scrollDisplayTopsOverlay;
    
    
    IBOutlet UIScrollView *scrollAccessories;
  
    
    
    
    
    
    IBOutlet UIView *outfitDisplay;
    
    NSMutableArray *sortedCountryArray;
    
    OutfitBrowserController *outfitBrowserController;
    OrganizerController *organizerController;
    FashionFeedController *fashionfeedController;
    Closet *myCloset;
    
    User *currentUser;
    NSString *pathuserfull;
    NSString *pathcloset;
    BOOL reloadarchives;
    BOOL activecountriesloaded;
    BOOL firstuse;
    
    IBOutlet UIImageView *whitebar1;
    IBOutlet UIImageView *whitebar2;
    
    IBOutlet UIImageView *exclamation;
    
    IBOutlet UIView *menuView;
    IBOutlet UIView *menuSecondView;
    IBOutlet UIButton *menuButton;
    IBOutlet UIButton *menuSecondButton;
    IBOutlet UIButton *accessoriesButton;
      IBOutlet UIButton *createZipButton;
    
    IBOutlet UIButton *geniusButton;
    
    
    BOOL topChanged;
    BOOL topOverlayChanged;
    BOOL accessoriesChanged;
    BOOL rightChanged;
    BOOL lowerChanged;
    BOOL shiftedUp;
    BOOL backDropOn;
    
    BOOL closetRestored;
    BOOL geniusMode;

    UIImageView *backDropView;
    
    IBOutlet UIImageView *topbar;
    IBOutlet UIImageView *bottombar;
    

  
}


@property (nonatomic, retain) UIImageView* topbar;
@property (nonatomic, retain) UIImageView* bottombar;

@property (nonatomic) BOOL topChanged;
@property (nonatomic) BOOL topOverlayChanged;
@property (nonatomic) BOOL accessoriesChanged;
@property (nonatomic) BOOL rightChanged;
@property (nonatomic) BOOL lowerChanged;
@property (nonatomic) BOOL backDropOn;
@property (nonatomic) BOOL closetRestored;
@property (nonatomic) BOOL geniusMode;

@property (nonatomic, retain) UIImageView* backDropView;


@property (nonatomic, retain) UIView* menuView;
@property (nonatomic, retain) UIButton* menuButton;
@property (nonatomic, retain) UIView* menuSecondView;
@property (nonatomic, retain) UIButton* menuSecondButton;
@property (nonatomic, retain) UIButton* accessoriesButton;
@property (nonatomic, retain) UIButton* createZipButton;
@property (nonatomic, retain) UIButton* geniusButton;

@property (nonatomic, retain) UIImageView* whitebar1;
@property (nonatomic, retain) UIImageView* whitebar2;

@property (nonatomic, retain) UIImageView* exclamation;


@property (nonatomic) BOOL firstuse;

@property (nonatomic) BOOL reloadarchives;
@property (nonatomic) BOOL activecountriesloaded;

@property (nonatomic, retain) UIActivityIndicatorView *myLoadIndicator;
@property (nonatomic, retain) Closet *myCloset;
@property (nonatomic, retain) User *currentUser;
@property (nonatomic, retain) NSString *pathuserfull;
@property (nonatomic, retain) NSString *pathcloset;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSMutableArray *sortedCountryArray;
@property (nonatomic, retain) UIButton* createButton;


@property (nonatomic, retain) UIButton* filterTopButton;
@property (nonatomic, retain) UIButton* filterRightButton;
@property (nonatomic, retain) UIButton* filterLowerButton;
@property (nonatomic, retain) UIButton* filterTopOverlayButton;
@property (nonatomic, retain) UIButton* filterAccessoriesButton;


@property (nonatomic, retain) UIButton* loadOutterwearButton;
@property (nonatomic, retain) UIButton* helpButton;

@property (nonatomic,retain) UIOutfitView *outfitView;

@property (nonatomic,retain) UIScrollView *scrollTops;
@property (nonatomic,retain) UIScrollView *scrollBottoms;
@property (nonatomic,retain) UIScrollView *scrollShoes;
@property (nonatomic,retain) UIScrollView *scrollTopsOverlay;
@property (nonatomic,retain) UIScrollView *scrollAccessories;

@property (nonatomic,retain) UIScrollDisplay *scrollDisplayTops;
@property (nonatomic,retain) UIScrollDisplay *scrollDisplayTopsOverlay;
@property (nonatomic,retain) UIScrollDisplay *scrollDisplayBottoms;
@property (nonatomic,retain) UIScrollDisplay *scrollDisplayShoes;


@property (nonatomic, retain) UIView *outfitDisplay;

@property (nonatomic, retain) OutfitBrowserController *outfitBrowserController;
@property (nonatomic, retain) OrganizerController *organizerController;

@property (nonatomic, retain) FashionFeedController *fashionfeedController;

-(IBAction) resetLayout;
-(IBAction) toggleAccessories;
-(IBAction) switchToFashionFeed;
-(User *) retrieveUser: (NSString *) username;
-(void) loadLogin;
-(void) newUser;
-(void) nextSignUp;
-(void) checkusername;

-(void) addUser;
-(void) loadWithUser: (User *) user;
-(void) openCloset;
- (void)toggleCalendar;
-(ImageRecord *) retrieveRecordNum:(int) recordnum FromCat: (int) categorynum RackName:(NSString *)rackname;
-(void) alertWith: (NSString *) alertstring;
-(void) alertWithBig: (NSString *) alertstring;
-(void) alertWithBigZip: (NSString *) alertstring;
-(void) dismissAlert: (UIButton *) sender;

-(void) textFieldShouldReturn:(UITextField *)textField;
-(void) deleteFile:(NSString *) filepath;
-(void) deleteFilesItemNum: (int) x;
-(void) deleteFilesOutfitNum: (int) x;
-(void) loadAllArchives;
-(void) loadAllChangedArchives;
-(void) clearArchive;

-(void) cancelNewOutfit: (UIButton *) sender;
-(void)clearViewInScroll: (UIViewInScroll *) scrolltoclear;

-(void)clearFilterViewInScroll: (UIViewInScroll *) scrolltoclear;

-(void) loadVerticalArchive:(int)categorynum inViewInScroll: (UIViewInScroll *) viewinscroll;
-(void) loadHorizontalArchive:(int)categorynum inViewInScroll: (UIViewInScroll *) viewinscroll;

-(void) loadCategoryArchive: (UIScrollView *)scrollview;

-(void) loadRackFilterListInViewInScroll: (UIViewInScroll *) viewinscroll withCategory: (int) categorynum;

-(void) loadAllArchivesWithCats: (int)a : (int)b : (int)c : (int)d;

- (void)handleTap:(UITapGestureRecognizer *)sender forCategory: (int) categorynum;
-(Rack *) findRackForMixerController: (NSString *)racktofind InCategory: (int) categorynum;

-(BOOL) doesViewAlreadyExist: (int) findviewtag;
-(UIView *) retrieveView: (int) findviewtag;

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

-(IBAction) loadOverlay;

-(void) unloadOverlay;

-(void) listOutfitCategories;
-(void) addNewOutfitCategory: (NSString *)name;
-(void) loadTopFilter;
-(void) loadRightFilter;
-(void) loadLowerFilter;
-(void) clearView: (UIView *) clearview;

-(void) dressOn;
-(void) dressOff;
-(void) refreshOutfitDisplay;
-(void) refreshTopDisplay;
-(void) refreshRightDisplay;
-(void) refreshLowerDisplay;

-(void) clearUserInfo;
//- (void)toggleCalendar;

-(void) deactivateAllInView: (UIView *) view except: (int) x;
-(void) reactivateAllInView: (UIView *) view;



-(IBAction) filterTop;

-(IBAction) filterRight;

-(IBAction) filterLower;
-(IBAction) filterTopOverlay;
-(IBAction) filterAccessories;

-(IBAction) switchToHelp;
-(IBAction) createOutfit;
-(IBAction) switchToOutfitBrowser;
-(IBAction) switchToCalendar;
-(IBAction) switchToOrganizer;

-(IBAction) switchToGenius;

-(IBAction) toggleMenuSecond;
-(void) alertGetStarted;

-(void) createLiteDirectory;

-(IBAction) userTapBackup;
-(IBAction) userTapRestore;

-(void) checkForActivity;

-(IBAction) toggleFilterMenu;
-(IBAction) toggleMenu;

@end
