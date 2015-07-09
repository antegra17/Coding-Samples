//
//  OutfitDetailController.h
//  ClosetFash
//
//  Created by Anthony Tran on 5/6/15.
//
//


#import <UIKit/UIKit.h>
#import "OutfitRecord.h"
#import "OrganizerController.h"
#import "MixerController.h"
#import "TKCalendarMonthTableViewController.h"

@interface OutfitDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource, TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource>

@property (strong, nonatomic) UIImage *outfitImage;
@property (strong, nonatomic) OutfitRecord *record;

@property (strong, nonatomic) IBOutlet UITableView *detailsTable;
@property (strong, nonatomic) IBOutlet UIImageView *outfitImageView;
@property (strong, nonatomic) NSArray *detailCategories;
@property (nonatomic, assign) BOOL isEditingOutfit;


@property (nonatomic, assign) OrganizerController *organizerController;
@property (nonatomic, assign) MixerController *mixerController;

-(IBAction)toggleCalendar;

@end
