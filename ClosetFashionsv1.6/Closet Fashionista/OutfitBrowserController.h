//
//  OutfitBrowser.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageRecord.h"
#import "UIViewInScroll.h"
#import "UITiledScrollView.h"
#import "TKCalendarMonthViewController.h"
@class MixerController;
#import "OrganizerController.h"

@interface OutfitBrowserController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource>
{
    
    UITiledScrollView *outfitsScroll;

    UIScrollView *outfitCategoryScroll;
    NSDate *currentSelectedDate;
    MixerController *mixerController;
    
    
}

@property (nonatomic, retain) UITiledScrollView *outfitsScroll;
@property (nonatomic, retain) UIScrollView *outfitCategoryScroll;
@property (nonatomic, retain) UIButton *goBackButton;
@property (nonatomic, retain) UIButton *calendarViewButton;
@property (nonatomic, retain) UIButton *addCatButton;
@property (nonatomic, retain) UIButton *removeCatButton;



@property (nonatomic, retain) NSDate *currentSelectedDate;
@property (nonatomic, retain) MixerController *mixerController;
@property (nonatomic, assign) BOOL editMade;

-(void) getCurrentCat;
-(void) deleteAllOutfitsOfCategory: (NSString *) catname;
-(void) reactivateAllInView: (UIView *) view;
-(void) deactivateAllInView: (UIView *) view except: (int) y;
-(BOOL) doesViewAlreadyExist: (int) findviewtag;


-(UIView *) retrieveView: (int) findviewtag;

-(void) viewOutfit: (int) touchedItemNum;
-(OutfitRecord *) retrieveRecord: (int)fileNumRef;


-(void) clearScrollView: (UIView *) scrolltoclear;
-(void) loadArchive;
-(void) loadOutfitsFromDate: (NSDate *) loaddate;

-(void) loadVerticalArchiveInViewInScroll: (UIScrollView *) scrollview;
-(void) loadImagesInOutfitsScroll;

-(void)clearViewInScroll: (UIViewInScroll *) scrolltoclear;
-(void) outfitsScrollLoader;

-(ImageRecord *) retrieveRecordNum:(int) recordnum FromCatName: (NSString *) catname RackName:(NSString *)rackname;

-(void) addNewOutfitCategory: (NSString *)name;
-(void)deleteOutfitCategory: (UIButton*)sender;
-(void)deleteOutfitNum:(int)x;
-(void)deleteOutfitCategoryComplete:(NSString *) cat;
-(void) closeOutfitSelector;
-(void) reloadOutfitBrowser;


@end

