//
//  DetailSelectController.h
//  ClosetFash
//
//  Created by Anthony Tran on 4/13/15.
//
//

#import <UIKit/UIKit.h>
#import "OrganizerController.h"
#import "MixerController.h"
#import "OutfitRecord.h"

@interface DetailSelectController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *addDetailButton;


@property (strong, nonatomic) NSString *selectedDetailCatName;
@property (nonatomic, assign) int selectedCatNum;
@property (nonatomic, assign) int selectedDetailCatTableRowNum;
@property (nonatomic, assign) int selectedDetailNum;
@property (strong, nonatomic) NSMutableArray *selectedDetailCat;
@property (strong, nonatomic) NSString *selectedDetailName;

@property (strong, nonatomic) OrganizerController *organizerController;
@property (strong, nonatomic) MixerController *mixerController;

@property (strong, nonatomic) OutfitRecord *outfitRecord;


@end
