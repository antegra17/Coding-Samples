//
//  ItemDetailController.h
//  ClosetFash
//
//  Created by Anthony Tran on 4/12/15.
//
//

#import <UIKit/UIKit.h>
#import "ImageRecord.h"
#import "OrganizerController.h"

@interface ItemDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) ImageRecord *existingRecord;

@property (strong, nonatomic) IBOutlet UITableView *detailsTable;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) NSArray *detailCategories;
@property (nonatomic, assign) BOOL isEditingItem;

@property (nonatomic, assign) int currentracknum;
@property (nonatomic, assign) int currentcatnum;
@property (nonatomic, assign) OrganizerController *organizerController;

@end
