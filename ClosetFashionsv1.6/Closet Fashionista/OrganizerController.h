//
//  Organizer.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rack.h"
#import "Closet.h"
#import "Category.h"
#import "ImageRecord.h"
#import "UIScrollImageView.h"
#import "UIViewInScroll.h"
#import "UITiledScrollView.h"

@interface OrganizerController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UITextViewDelegate>
{
    UIView *scrollcontain;
    IBOutlet UIButton *addRackButton;
    IBOutlet UIButton *deleteRackButton;
    IBOutlet UIButton *goBackButton;
    IBOutlet UIButton *addItemButton;
    IBOutlet UIButton *addNewCategoryButton;
    IBOutlet UIButton *deleteCategoryButton;
    
    UIScrollView *rackTypeScroll;
    UIScrollView *racksScroll;
    
    UITiledScrollView *tileScroll;
    
    IBOutlet UIButton *trash;
    
    IBOutlet UIView *geniusHub;
    IBOutlet UIToolbar *imageToolBar;
    
    UILabel *geniusHubLabel;
    
    BOOL newitem;
    BOOL changedrack;
    BOOL organizerOpen;
    BOOL geniusMode;
    
    NSString *currenteditrack;
    int currenteditcat;
    
    
    UIImageView *croppedImage;
    UIImage *tempCropped;
    CGImageRef imageRef;
    
    UIImageView *cropperView;
    
    ImageRecord *geniusItemBase;
    ImageRecord *geniusItemOne;
    ImageRecord *geniusItemTwo;
    
    BOOL geniusItemOneFound;
    BOOL geniusItemTwoFound;
    
    
    NSString *currentMatchCat;
    
    NSString *startingMatchCat;
    
  
}
@property (nonatomic) UIView *scrollcontain;
@property (nonatomic) UIImageView *croppedImage;
@property (nonatomic) UIImage *tempCropped;
@property (nonatomic) UIImageView *cropperView;

@property (nonatomic) CGImageRef imageRef;


@property int currenteditcat;
@property (nonatomic, retain) NSString* currenteditrack;
@property BOOL newitem;
@property BOOL changedrack;
@property BOOL organizerOpen;
@property BOOL geniusMode;
@property BOOL geniusItemOneFound;
@property BOOL geniusItemTwoFound;
@property (nonatomic, retain) UIButton *addRackButton;
@property (nonatomic, retain) UIButton *deleteRackButton;
@property (nonatomic, retain) UIButton *goBackButton;
@property (nonatomic, retain) UIButton *addItemButton;
@property (nonatomic, retain) UIButton *addNewCategoryButton;
@property (nonatomic, retain) UIButton *deleteCategoryButton;

@property (nonatomic, retain) UITextField *input;
@property (nonatomic, retain) UIScrollView *rackTypeScroll;
@property (nonatomic, retain) UIScrollView *racksScroll;

@property (nonatomic, retain) UITiledScrollView *tileScroll;

@property (nonatomic, retain) UIButton *trash;

@property (nonatomic, retain) UIView *geniusHub;
@property (nonatomic, retain) UILabel *geniusHubLabel;
@property (nonatomic, retain) ImageRecord *geniusItemBase;
@property (nonatomic, retain) ImageRecord *geniusItemOne;
@property (nonatomic, retain) ImageRecord *geniusItemTwo;

@property (nonatomic, copy) NSString *currentMatchCat;
@property (nonatomic, copy) NSString *startingMatchCat;
@property (nonatomic, assign) BOOL _imageToolBarOpen;

-(void) giveScrCount;
-(void) addNewRack;
-(void) deleteRack: (NSString *) rackname;
-(IBAction) alertDelete;
-(void) dismissAlert;
-(IBAction) addNewItemToRack;
-(void) alertNewItem;
-(IBAction) goBack;
-(IBAction) addNewCategoryCallUp;
-(void) addNewDetailCallUp: (UIButton *)sender;
-(IBAction) deleteCategory;
-(void) deactivateAllInView: (UIView *) view except: (int) y;
-(void) deactivateAllInView: (UIView *) view except: (int) y and: (int) z;

-(void) reactivateAllInView: (UIView *) view;
-(IBAction) addNewOutfitRackCallUp;
-(void) addItem: (ImageRecord *) record toCat: (NSString *) catname toRack: (NSString *) rackname;
-(int) findRowOf: (NSString *) detail inArray: (NSMutableArray *) array;
-(int) findRowOf: (NSString *) catname inCatArray: (NSMutableArray *) catarray;
-(int) findRowOf: (NSString *) rackname inRackArray: (NSMutableArray *) rackarray;

-(void) cancelNewItem: (UIButton *) sender;
-(UIView *) retrieveView: (int) findviewtag fromView: (UIView *) view;
-(UITextField *) retrieveTextField: (int) findviewtag fromView: (UIView *) view;
-(UITextView *) retrieveTextView: (int) findviewtag fromView: (UIView *) view;

-(void) proceedWithImageSelectionAlbum;
-(void) proceedWithImageSelectionCamera;
-(ImageRecord *) retrieveRecordNum:(int) recordnum FromCat: (int) categorynum RackName:(NSString *)rackname;

-(void) confirmNewItem:(UIButton *)sender;
-(void) confirmEditItem:(UIButton *) sender;
-(BOOL) doesViewAlreadyExist: (int) findviewtag;
-(void) tileScrollLoader;
-(NSString *) getCurrentRackName;
-(int) getCurrentCategoryNumber;
-(ImageRecord *) findRecordFileNum: (int) filenum inRack:(Rack *) rack;
-(int)findPositionOfRecordFileNum: (int) filenum inRack:(Rack *) rack;

-(UIView *) retrieveView: (int) findviewtag;
-(void) loadItemEditor: (UIImage *) image fileNumRef: (int) filenum label: (UILabel *)label;

-(void)clearScroll: (UIScrollView *) scrolltoclear;
-(void)clearViewInScroll: (UIScrollView *) scrolltoclear;
-(void) loadVerticalArchiveInViewInScroll: (UIScrollView *) scrollview;
-(void) loadCategoryArchive;
-(void) alertWith: (NSString *) alertstring;

-(void)loadImagesInTileScroll;
-(Rack *) findRack: (NSString *)racktofind InCategory: (int) currentcategorynum;
-(Rack *) findRack: (NSString *)rackname InCat: (NSString *) catname;

-(Rack *) findRackForMixerController: (NSString *)racktofind InCategory: (int) currentcategorynum;
-(void) textFieldShouldReturn:(UITextField *)textField;
-(void) addNewRackToCategory: (NSString *) rackname;

-(void) deleteRack: (NSString *) rack fromCategory: (Category *) category;

-(void) deleteAllItemsFromRack: (Rack *) rack;
-(void) listRacksInCategory: (NSMutableArray *) category;
-(void) alertWithAlt: (NSString *) alertstring;
-(BOOL) doesViewAlreadyExist: (int) findviewtag in: (UIView *) view;

-(void) deleteItemFileNum:(int)filenum FromCat: (NSString *) catname Rack:(NSString *) rackname;
-(void) deleteItemFileNum: (int) filenum FromRack: (Rack *) rack;
-(void) listItemsInRack: (Rack *) rack;

-(IBAction)selectExistingPicture;
-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo;

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;                            
-(void)setCurrentRackLabel;
-(void) updateItemInOutfits: (int) filenumref newCat: (NSString *) newcat newRack: (NSString *) newrack;

-(void) addLiteCloset;
-(void) backupLiteCloset;

-(void) restoreFullCloset;
-(void) clearCloset;

-(BOOL) checkForMatchItemA: (NSString *)itemA ItemB: (NSString *)itemB ColorA: (NSString *) colorA ColorB:(NSString *) colorB Cat: (NSString *) catB ColorBar: (int) x;


-(void) stepThroughClosetFind: (NSString *) cat;


-(void) showImageToolBar;
-(IBAction) hideImageToolBar;

-(void) saveItem: (ImageRecord *) record withImage: (UIImage *) newImage;
-(void) saveEditItem:(ImageRecord *)record;
-(void) editItem: (int) touchedItemNum;
-(ImageRecord *) retrieveRecord: (int)filenumref;


@end
