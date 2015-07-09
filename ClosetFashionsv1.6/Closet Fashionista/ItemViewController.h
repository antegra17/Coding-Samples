//
//  ItemViewController.h
//  ClosetFash
//
//  Created by Anthony Tran on 4/18/15.
//
//

#import <UIKit/UIKit.h>
#import "OrganizerController.h"
#import "OutfitBrowserController.h"

@interface ItemViewController : UIViewController

@property (nonatomic, assign) int touchedItemNum;
@property (nonatomic, strong) OrganizerController *organizerController;
@property (nonatomic, strong) OutfitBrowserController *outfitBrowserController;
@property (nonatomic, strong) IBOutlet UIImageView *itemView;
@property (nonatomic, strong) IBOutlet UILabel *itemLabel;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, assign) BOOL isOutfit;
@property (nonatomic, assign) BOOL editMade;

-(IBAction) loadEditor;


@end
