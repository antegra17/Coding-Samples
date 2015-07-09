//
//  ItemViewController.m
//  ClosetFash
//
//  Created by Anthony Tran on 4/18/15.
//
//

#import "ItemViewController.h"
#import "ItemDetailController.h"
#import "ImageRecord.h"
#import "OutfitRecord.h"
#import "OutfitDetailController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

@synthesize touchedItemNum, organizerController, outfitBrowserController, itemView, itemLabel, isOutfit, editButton, editMade;

ImageRecord *existingRecord;
OutfitRecord *existingOutfitRecord;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    editMade = NO;
    
    NSLog(@"itemviewcontroller received num %i", self.touchedItemNum);
    
    if(!isOutfit){//for item view
    
        existingRecord = [organizerController retrieveRecord:self.touchedItemNum];
    
        NSLog(@"existing record is num %i", existingRecord.fileNumRef);
    
        UIImage *bestImage = [UIImage imageWithContentsOfFile:existingRecord.imageFilePathBest];
    
        itemView.image = bestImage;
        itemView.contentMode = UIViewContentModeScaleAspectFit;
    
    
        NSString *brandstring;
        NSString *occasionstring;
    
    
    
        if([existingRecord.brand compare:@"N/A"]==NSOrderedSame) brandstring = @"";
        else brandstring = [NSString stringWithFormat:@"by %@",existingRecord.brand];
    
        if([existingRecord.occasion compare:@"N/A"]==NSOrderedSame) occasionstring = @"";
        else occasionstring = [NSString stringWithFormat:@"%@",existingRecord.occasion];
    
    
        NSString *details = [NSString stringWithFormat:@"%@ %@ %@ %@", existingRecord.color, existingRecord.rackName, brandstring, occasionstring];
    
    
        itemLabel.text = details;
    }
    else{//for outfit view
        self.title = @"Outfit View";
        
        existingOutfitRecord = [outfitBrowserController retrieveRecord:touchedItemNum];
        
        NSLog(@"existing record is num %i", existingOutfitRecord.fileNumRef);
        
        UIImage *bestImage = [UIImage imageWithContentsOfFile:existingOutfitRecord.imageFilePath];
        
        itemView.image = bestImage;
        itemView.contentMode = UIViewContentModeScaleAspectFit;
        
        itemLabel.text = existingOutfitRecord.outfitName;
    }
    
    
    // add custom back button to perform unwind segue
    CGRect frameAdd = CGRectMake(0, 0, 50, 30);
    UIButton* backButton = [[UIButton alloc] initWithFrame:frameAdd];
    //[addbutton setBackgroundImage:addimage forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    
    [backButton setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [backButton addTarget:self action:@selector(backToBrowser:) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    backBarButton.tag = 50;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backBarButton,nil];

}

-(void)backToBrowser: (id) sender
{
    [self performSegueWithIdentifier:@"BackToBrowserSegue" sender:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(IBAction) loadEditor
{
    if(!isOutfit)
        [self performSegueWithIdentifier:@"EditItemSegue" sender:nil];
    else
        [self performSegueWithIdentifier:@"EditOutfitSegue" sender:nil];
        
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[outfitBrowserController class]])
    {
        NSLog(@"going back to browser");
    }
    else if([segue.destinationViewController isKindOfClass:[OrganizerController class]])
    {
        NSLog(@"going back to organizer");
    }
    
    else{
    
        if(!isOutfit){ //for item edit
            
            ItemDetailController *itemDetailController = [segue destinationViewController];
    
            itemDetailController.isEditingItem = YES;
            itemDetailController.existingRecord = existingRecord;
            itemDetailController.itemImage = itemView.image;
            itemDetailController.currentcatnum = existingRecord.categoryType;
    
            itemDetailController.organizerController = self.organizerController;
        }
        else{//for outfit edit
            OutfitDetailController *outfitDetailController = [segue destinationViewController];
            outfitDetailController.record = existingOutfitRecord;
            outfitDetailController.isEditingOutfit = YES;
            outfitDetailController.outfitImage = itemView.image;
        }
    }
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[ItemDetailController class]]) {
        NSLog(@"return to item view");
        
        if(!isOutfit){
        }
        else{
            
            
         
        }
        
        
    }
}


@end
