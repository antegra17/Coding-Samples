//
//  Organizer.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OrganizerController.h"
#import "MixerController.h"
#import "AppDelegate.h"
#import "ClipView.h"
#import "ImageRecord.h"
#import "UITiledScrollView.h"
#import "UIOrganizerImageView.h"
#import "UIViewInScroll.h"
#import "Category.h"
#import <QuartzCore/QuartzCore.h>

#import "UICropper.h"


//#import "SSZipArchive.h"
#import "ZipArchive/ZipArchive.h"

#import "ItemDetailController.h"
#import "ItemViewController.h"

@implementation OrganizerController 

@synthesize addRackButton, deleteRackButton, goBackButton, rackTypeScroll, input, racksScroll, addItemButton, tileScroll, trash, addNewCategoryButton, deleteCategoryButton, newitem, changedrack, currenteditrack, currenteditcat, croppedImage, imageRef, cropperView, tempCropped, scrollcontain, organizerOpen, geniusMode, geniusHub, geniusHubLabel,currentMatchCat, geniusItemBase, geniusItemOne, geniusItemTwo, geniusItemOneFound, geniusItemTwoFound, startingMatchCat, _imageToolBarOpen;


ImageRecord *tempMatch;
BOOL geniusBaseMatchingItemTwo;
BOOL outfitComplete;



int categoryTypeSelector; // 0, tops, 1, bottoms, or 2, shoes
NSString *pathhome;
NSString *pathcloset;
int imageFileNum;
NSNumber *lastImageNumArch;

NSString *pathhome;
NSString *pathtops;
NSString *pathbottoms;
NSString *pathshoes;


int currentcolornum;
int currentoccasionnum;
int currentbrandnum;
int currentcatnum;
int currentracknum;

int *currenteditcatnum;
NSString *currenteditrack;

ClipView *clipview;

float labelwidth;
float labelheight;

NSString *pathlastimagenum;



UIViewInScroll *viewInTileScroll;

float catlabelheight;
float catlabelwidth;
AppDelegate *appDelegate;
MixerController *mixerController;


UIImage *tempnewimage;
Closet *myCloset;


OrganizerController *organizercontroller;

BOOL rearrange;
BOOL shiftlocked;
BOOL shiftedUp;

BOOL fromCamera;

#pragma mark - View lifecycle

UIActivityIndicatorView *myIndicator;

UIImageView *geniusItemViewOne;
UIImageView *geniusItemViewTwo;




- (void)viewDidLoad
{
    organizerOpen = TRUE;
    _imageToolBarOpen = FALSE;
    
    
    if(organizerOpen)
    {
        NSLog(@"open 2");
    }
    
    fromCamera = FALSE;
    shiftlocked = FALSE;
    
    
    newitem = FALSE;
    changedrack = FALSE;
    
    rearrange = NO;
    mixerController.reloadarchives = YES;
    
    geniusMode = NO;
    
    geniusHubLabel = [[UILabel alloc] initWithFrame: CGRectMake(0,0, geniusHub.frame.size.width, 100)];
    geniusHubLabel.text = @"Pick one item and Closet Genius will recommend an oufit!\n";
    
    geniusHubLabel.textColor = [UIColor blackColor];
    geniusHubLabel.backgroundColor = [UIColor whiteColor];
    geniusHubLabel.font = [UIFont fontWithName:@"Futura" size:12];
    geniusHubLabel.textAlignment = UITextAlignmentLeft;
    geniusHubLabel.numberOfLines = 0;
    geniusHubLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    [geniusHub addSubview:geniusHubLabel];
    
    geniusItemViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0,35, 100,100)];
    geniusItemViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(100,35, 100,100)];
    
    [geniusHub addSubview:geniusItemViewOne];
    
    [geniusHub addSubview:geniusItemViewTwo];
    
    
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appDelegate.mixerController;
    
    organizercontroller = appDelegate.mixerController.organizerController;
    
    //pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //pathcloset = [pathhome stringByAppendingPathComponent:mixerController.currentUser.closetfile];
    
    pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
 
    pathcloset = [pathhome stringByAppendingPathComponent:@"closet.arch"];
    

    
    NSLog(@"organizer closet path is %@", pathcloset);
    
    myCloset = appDelegate.myCloset;
    
    //myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathcloset];
    
    NSLog(@"organizer my closet categories count %li", [myCloset.categories count]);
    
    
    catlabelheight = self.view.frame.size.height/7-30;
    catlabelwidth = self.view.frame.size.width - 95;
    
    

    rackTypeScroll = [[UIScrollView alloc] init];
    rackTypeScroll.frame = CGRectMake(0, 75, 223, 50);
    rackTypeScroll.pagingEnabled=YES;
    rackTypeScroll.scrollEnabled=YES;
    rackTypeScroll.userInteractionEnabled = YES;
    rackTypeScroll.bounces = YES;
    rackTypeScroll.alwaysBounceHorizontal =YES;
    rackTypeScroll.alwaysBounceVertical = NO;
    
    
    [self.view addSubview:rackTypeScroll];


   
    

    racksScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(227, 115, 85, 312)];
    racksScroll.backgroundColor = [UIColor blackColor];
    
    racksScroll.pagingEnabled=NO;
    racksScroll.showsHorizontalScrollIndicator = NO;
    racksScroll.showsVerticalScrollIndicator =YES;
    racksScroll.scrollEnabled=YES;
    racksScroll.userInteractionEnabled = YES;
    racksScroll.bounces = YES;
    racksScroll.alwaysBounceHorizontal =NO;
    racksScroll.alwaysBounceVertical = YES;
    racksScroll.tag = 30000;
    
    scrollcontain = [[UIView alloc] init];
    scrollcontain.backgroundColor = [UIColor blackColor];
    
    racksScroll.pagingEnabled = YES;
    racksScroll.clipsToBounds = NO;
    
    clipview = [[ClipView alloc] init];
    
    
    scrollcontain.tag = 20000;
    clipview.tag = 8888;
    
    
    [scrollcontain addSubview:racksScroll];
    
    [self.view addSubview:clipview];
  
    [self.view addSubview:scrollcontain];
    
    rackTypeScroll.delegate = self;
    racksScroll.delegate = self;
    self.view.tag = 1000000000;
    rackTypeScroll.tag = 10000;
    racksScroll.tag = 20000;

    tileScroll = [[UITiledScrollView alloc] initWithFrame:CGRectMake(0, 150, 200, 300)];
    tileScroll.backgroundColor = [UIColor greenColor];
    tileScroll.pagingEnabled=NO;
    tileScroll.showsHorizontalScrollIndicator = NO;
    tileScroll.showsVerticalScrollIndicator =NO;
    tileScroll.scrollEnabled=YES;
    tileScroll.userInteractionEnabled = YES;
    tileScroll.bounces = YES;
    tileScroll.alwaysBounceHorizontal =NO;
    tileScroll.alwaysBounceVertical = YES;
    tileScroll.tag = 30000;
    
    viewInTileScroll = [[UIViewInScroll alloc] initWithFrame:CGRectMake(0, 0, tileScroll.frame.size.width, tileScroll.frame.size.height)];
    viewInTileScroll.backgroundColor = [UIColor redColor];

    viewInTileScroll.tag = 64321;
    
    
    [tileScroll addSubview:viewInTileScroll];
    [self.view addSubview:tileScroll];
    
    
    labelwidth = self.view.frame.size.width/4;
    labelheight = 24;
    
    [self loadCategoryArchive];
    
    categoryTypeSelector = 0;
    
    
    [self loadVerticalArchiveInViewInScroll:racksScroll];
    [self loadImagesInTileScroll];
    
    currentcolornum =0;
    currentoccasionnum =0;
    currentbrandnum =0;
    currentcatnum   =0;
    currentracknum  =0;
  
    pathlastimagenum = [pathhome stringByAppendingPathComponent:@"lastimagenum.arch"];
    

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
     NSLog(@"FINISHED LOAD rackscrolls subview count is %i point A", [racksScroll.subviews count]);
    
    if (mixerController.geniusMode == YES)
    {
        
        geniusMode = YES;
        
        [geniusHub setHidden:NO];
 
    }
    
    
}

-(ImageRecord *) retrieveRecord: (int)filenumref
{
    Closet *tempcloset = appDelegate.myCloset;
    
    for (int x = 0; x < [tempcloset.categories count]; ++x)
    {
        Category * tempcategory = [tempcloset.categories objectAtIndex:x];
        
        for (int y =0; y < [tempcategory.racksarray count]; y++)
        {
            Rack *temprack = [tempcategory.racksarray objectAtIndex:y];
            for (int z = 0; z < [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                if(temprecord.fileNumRef == filenumref)
                {
                    
                    
                    
                    NSLog(@"found %i in %@ in %@", temprecord.fileNumRef, temprack.rackname, tempcategory.categoryname);
                    NSLog(@"%@, %@, %@, %@, tag 2 is %@", temprecord.color, temprecord.occasion, temprecord.brand, temprecord.additionaltags,temprecord.tagTwo );
                    return temprecord;
                }
            }
        }
    }
    
    return nil;
}


-(ImageRecord *) retrieveRecordNum:(int) recordnum FromCat: (int) categorynum RackName:(NSString *)rackname
{
    Category *tempcategory = [mixerController.myCloset.categories objectAtIndex:categorynum];
    
    for(int x = 0; x <[tempcategory.racksarray count]; x++)
    {
        Rack * temprack = [tempcategory.racksarray objectAtIndex:x];
        
        if ([temprack.rackname compare:rackname] == NSOrderedSame)
        {
            for(int y = 0; y <[temprack.rackitemsarray count]; y++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:y];
                if (temprecord.fileNumRef == recordnum)
                {
                    NSLog(@"return recording from retrieverecordnum method");
                    return temprecord;
                }
            }
        }
   
        
    }
    return  nil;
}




-(void) loadCategoryArchive
{
    
    
    
    [self clearScroll:rackTypeScroll];
    
    NSLog(@"%i", [myCloset.categories count]);
    
    for (int x = 0; x < 6; ++x)
    {
        NSLog(@"%i", [myCloset.categories count]);
        NSLog(@"load CategoryArchive");
        Category *tempcategory = [myCloset.categories objectAtIndex:x];
        NSString *tempcategoryname = tempcategory.categoryname;
        UIView *templabelview = [[UIView alloc] initWithFrame:CGRectMake(x*223, 0, 223, 50)];
        UILabel *templabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 230, 50)];
        templabelview.tag = x;
        templabel.text = tempcategoryname;
        NSLog(@"tag %i, cat %@", templabelview.tag, templabel.text);
      
        templabel.font = [UIFont fontWithName:@"Futura" size:24];
    
        
        templabel.backgroundColor = [UIColor blackColor];
        
        templabel.textColor = [UIColor whiteColor];
        templabel.textAlignment = UITextAlignmentLeft;
        [templabelview addSubview:templabel];
        
        [rackTypeScroll addSubview:templabelview];
        
        rackTypeScroll.backgroundColor = [UIColor blackColor];
        
        NSLog(@"racktypescroll label count is %ld", [rackTypeScroll.subviews count]);
    
        
        rackTypeScroll.contentSize = CGSizeMake((x+1)*(223), 50);
    }
    
    
}











-(IBAction) addNewCategoryCallUp
{
    
    [myCloset addNewCategoryCallUp];
}



















UIView  *currentLabelInScroll;


Category *tempcategory;
Rack * temprack;

UILabel *currentracklabel;

int currentcategorynum;


-(NSString *) getCurrentCategory
{
    CGPoint centerScrollPoint = CGPointMake(rackTypeScroll.frame.origin.x+ rackTypeScroll.frame.size.width/2, 
                                            rackTypeScroll.frame.origin.y+rackTypeScroll.frame.size.height/2);
    
    NSLog(@"centerpoint %f, %f", centerScrollPoint.x, centerScrollPoint.y);
    
    
    currentLabelInScroll = [self.view hitTest:centerScrollPoint withEvent:nil];
    
    NSLog(@"class is %@", [currentLabelInScroll class]);
    
    
    
    if ([currentLabelInScroll isKindOfClass:[UIView class]])
    {
        UILabel *currentcat = [currentLabelInScroll.subviews objectAtIndex:0];
        NSLog(@"%@*************", currentcat.text);
        return currentcat.text;
    }
    
    return nil;
}


-(int) getCurrentCategoryNumber
{
    CGPoint centerScrollPoint = CGPointMake(rackTypeScroll.frame.origin.x+ rackTypeScroll.frame.size.width/2, 
                                            rackTypeScroll.frame.origin.y+ rackTypeScroll.frame.size.height/2);
    
    NSLog(@"centerpoint %f, %f", centerScrollPoint.x, centerScrollPoint.y);
    
    currentLabelInScroll = [self.view hitTest:centerScrollPoint withEvent:nil];
    
    NSLog(@"class is %@", [currentLabelInScroll class]);
    
    
    if ([currentLabelInScroll isKindOfClass:[UIView class]])
    {
        NSLog(@"currentlabel tag %i", currentLabelInScroll.tag);
        currentcategorynum = currentLabelInScroll.tag;
        return currentLabelInScroll.tag;
    }
    
    return 1000000;
}

-(NSString *) getCurrentRackName
{
    
    CGPoint centerScrollPoint = CGPointMake(racksScroll.frame.origin.x+  racksScroll.frame.size.width/2, 
                                            racksScroll.frame.origin.y+ labelheight/2);
    
    
    currentLabelInScroll = [scrollcontain hitTest:centerScrollPoint withEvent:nil];
    
    UILabel *racklabel;
    
    
    NSLog(@"seekng rackname...");
    
    
    if ([currentLabelInScroll isKindOfClass:[UIView class]] && currentLabelInScroll.tag == 999)
    {   
        racklabel = [currentLabelInScroll.subviews objectAtIndex:0];
        
        NSLog(@"get current rack label is %@", racklabel.text);
        
        return racklabel.text;
    }
    
    return nil;
    


}





-(void) scrollViewDidScroll:(UIScrollView *)scrollview
{
    NSLog(@"scrolling view is tag %li", (long)scrollview.tag);
     NSLog(@"FINISHED LOAD rackscrolls subview count is %i point AAA", [racksScroll.subviews count]);

    if (scrollview.tag == 10000)
    {
        
    
        
        CGPoint centerScrollPoint = CGPointMake(scrollview.frame.origin.x+ scrollview.frame.size.width/2, 
                                                scrollview.frame.origin.y+scrollview.frame.size.height/2);
        
          NSLog(@"centerpoint %f, %f", centerScrollPoint.x, centerScrollPoint.y);
        
       
        currentLabelInScroll = [self.view hitTest:centerScrollPoint withEvent:nil];
        
        NSLog(@"class is %@", [currentLabelInScroll class]);
        
        
        int offset = (int) scrollview.contentOffset.x;
        int width = (int) scrollview.frame.size.width;
        
        NSLog(@"offset %i", offset);
        NSLog(@"height %i", width);
        
        if(offset%width == 0){
            
            
        
        if ([currentLabelInScroll isKindOfClass:[UIView class]])
        {
            
            NSLog(@"FOUND ******** CATEGORY label %i", currentLabelInScroll.tag);
            if (categoryTypeSelector != currentLabelInScroll.tag)
            {
                categoryTypeSelector = currentLabelInScroll.tag;
                if (categoryTypeSelector  != 10000)
                {
                    [self loadVerticalArchiveInViewInScroll:racksScroll];
                    [self loadImagesInTileScroll];
                }
                
            }
        }
        NSLog(@"current catselector is %i", categoryTypeSelector);
            
            currentcatnum = categoryTypeSelector;
        
        
        }
        
        
    }
    
    
    if (scrollview.tag == 20000)
    {
       
        [self getCurrentRack];
            
    }
    
    
}



int offset;
int height;


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    offset = (int) scrollView.contentOffset.y;
    height = (int) scrollView.frame.size.height;
    NSLog(@"end decelerate");
    
    
    
    if (scrollView.tag == 20000)
    {
        NSLog(@"ended scrolling");
        NSLog(@"offset %i", offset);
        NSLog(@"height %i", height);
        
        
        if(offset%height == 0 || offset == 0)
        { [self loadImagesInTileScroll];}
        
        
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    offset = (int) scrollView.contentOffset.y;
    height = (int) scrollView.frame.size.height;
    NSLog(@"end decelerate");
    
    
    if (scrollView.tag == 20000)
    {
        NSLog(@"ended scrolling");
        
        
        if(offset%height == 0 || offset == 0)
        { [self loadImagesInTileScroll];}
        
        
    }
}


-(void)setCurrentRackLabel
{
    CGPoint centerScrollPoint = CGPointMake(racksScroll.frame.origin.x+  racksScroll.frame.size.width/2, 
                                            racksScroll.frame.origin.y+ labelheight/2);
    
    
    currentLabelInScroll = [scrollcontain hitTest:centerScrollPoint withEvent:nil];
    
    if(currentLabelInScroll.tag == 999)
    {
        currentracklabel = [currentLabelInScroll.subviews objectAtIndex:0];
    }
    
}


-(void)getCurrentRack
{
    CGPoint centerScrollPoint = CGPointMake(racksScroll.frame.origin.x+  racksScroll.frame.size.width/2,
                                            racksScroll.frame.origin.y+ labelheight/2);
    
    
    currentLabelInScroll = [scrollcontain hitTest:centerScrollPoint withEvent:nil];
    
    
    
    if ([currentLabelInScroll isKindOfClass:[UIView class]] && currentLabelInScroll.tag == 999)
    {
        currentracklabel = [currentLabelInScroll.subviews objectAtIndex:0];
        
        NSLog(@"label at center reads %@", currentracklabel.text);
        
        for(int x = 0; x < [racksScroll.subviews count]; ++x)
        {
            UIView *tempview = [racksScroll.subviews objectAtIndex:x];
            
            if([tempview.subviews count] != 0)
            {
            
                UILabel *templabel = [tempview.subviews objectAtIndex:0];
                templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:12];
                templabel.textColor = [UIColor lightGrayColor];
                templabel.backgroundColor = [UIColor blackColor];
            }
        }
        
        
        
        currentracklabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
        currentracklabel.textColor = [UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1];
        currentracklabel.backgroundColor = [UIColor blackColor];
        
    }

}





-(void)loadImagesInTileScroll
{
   
    
    
    CGPoint centerScrollPoint = CGPointMake(racksScroll.frame.origin.x+  racksScroll.frame.size.width/2, 
                                            racksScroll.frame.origin.y+ labelheight/2);
    
    
    currentLabelInScroll = [scrollcontain hitTest:centerScrollPoint withEvent:nil];
    

    
    if ([currentLabelInScroll isKindOfClass:[UIView class]] && currentLabelInScroll.tag == 999)
    {   
        currentracklabel = [currentLabelInScroll.subviews objectAtIndex:0];
        
        NSLog(@"label at center reads %@", currentracklabel.text);
        
        NSLog(@"rackscrolls subview count is %i", [racksScroll.subviews count]);
        
        for(int x = 0; x < [racksScroll.subviews count]; ++x)
        {
            NSLog(@"TEST %i", x);
            UIView *tempview = [racksScroll.subviews objectAtIndex:x];
            
            if([tempview.subviews count] != 0)
            {
                UILabel *templabel = [tempview.subviews objectAtIndex:0];
                NSLog(@"TEST %@", templabel.text);
                templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:12];
                templabel.textColor = [UIColor lightGrayColor];
                templabel.backgroundColor = [UIColor blackColor];
            }
        
        }
        
        
        
        currentracklabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
        currentracklabel.textColor = [UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1];
        currentracklabel.backgroundColor = [UIColor blackColor];
  
        [self tileScrollLoader];
    }
    else [self clearViewInScroll:viewInTileScroll];
    
    
 
 
}





            
-(void) tileScrollLoader
{
    
    NSLog(@"loading tiles with closet identity %@", myCloset.closetIdentity);
    
    
    NSLog(@"current rack in tile scroll is %@", tileScroll.loadedrackname);
    
    NSLog(@"tilescrollloader called");
    
    tileScroll.scrollEnabled = YES;
    
    tempcategory = [myCloset.categories objectAtIndex:categoryTypeSelector];
 
    
    for (int x = 0; x < [tempcategory.racksarray count]; ++x)
    {
        temprack = [tempcategory.racksarray objectAtIndex:x];
        NSLog(@"find %@, versus rack %@ ", currentracklabel.text, temprack.rackname);
        

        
        if ([currentracklabel.text compare:temprack.rackname] == NSOrderedSame)
        {
        
            if([tileScroll.loadedrackname compare:currentracklabel.text] == NSOrderedSame &&
               [viewInTileScroll.subviews count] == [temprack.rackitemsarray count] && rearrange == NO)
            {
                NSLog(@"doing nothing");
            }
            else
            {
                
                NSLog(@"loading rack items %@ count is %i", temprack.rackname, [temprack.rackitemsarray count]);
                rearrange = NO;
                
                [self clearViewInScroll:viewInTileScroll];
            
                int ymult = -1;
                int xmult = 0;
            
                for (int x = 0; x < [temprack.rackitemsarray count]; ++x)
                {
                    if(x % 3 == 0)
                    {
                        xmult = 0;
                        ++ymult;
                    }
                    if(x % 3 == 1)
                    {
                        xmult = 1;
                    }
                    if(x % 3 == 2)
                    {
                        xmult = 2;
                    }
                
                
                    ImageRecord *retrieveitem = [temprack.rackitemsarray objectAtIndex:x];
                    NSLog(@"loading %@", retrieveitem.imageFilePath); 
                    UIImage *retrieveitemimage = [UIImage imageWithContentsOfFile:retrieveitem.imageFilePath];
                    
                    UIOrganizerImageView *itemimageview = [[UIOrganizerImageView alloc] initWithImage:retrieveitemimage];
                
                    NSLog(@"item record filenumref %i", retrieveitem.fileNumRef);
                
                    itemimageview.fileNumRef = retrieveitem.fileNumRef;
                
                    if(categoryTypeSelector == 3 || categoryTypeSelector == 5)
                    {
                        itemimageview.frame = CGRectMake(
                                                         (xmult * tileScroll.frame.size.width/3 +3.5), 
                                                         (ymult * 55)+10, 
                                                         66.5, 
                                                         50); 
                    }
                    else{
                    itemimageview.frame = CGRectMake(
                                                 (xmult * tileScroll.frame.size.width/3 +10), 
                                                 (ymult * 75) + 10,
                                                 tileScroll.frame.size.width/5 + 10, 
                                                 tileScroll.frame.size.height/5);
                        
                        NSLog(@"%f tile height amount y", tileScroll.frame.size.height/5 );
                    }
                    
                    
                    
                    itemimageview.rackName = temprack.rackname;
                    itemimageview.categoryType = categoryTypeSelector;
                
                    itemimageview.backgroundColor = [UIColor whiteColor];
                    
                    itemimageview.layer.borderColor = [[UIColor blackColor] CGColor];
                    itemimageview.layer.borderWidth = 1;
                
                
                
                    itemimageview.contentMode = UIViewContentModeScaleAspectFit;
                    itemimageview.userInteractionEnabled = YES;
                
                
                
          
                    [viewInTileScroll addSubview:itemimageview];
             
                    if(categoryTypeSelector==3)
                    {
                    
                    tileScroll.contentSize = CGSizeMake(tileScroll.frame.size.width, (ymult+1) * (itemimageview.frame.size.height+10));
                        
                        
                    }
                    else{
                        
                        tileScroll.contentSize = CGSizeMake(tileScroll.frame.size.width, (ymult+1) * (itemimageview.frame.size.height+25));
                        
                    }
                    viewInTileScroll.frame = CGRectMake(0, 0, tileScroll.contentSize.width, tileScroll.contentSize.height);
                        
                    
                
                }
            
            }
        }
    }

        
        if(currentracklabel.text)
        {
            tileScroll.loadedrackname = [NSString stringWithString: currentracklabel.text];
            tileScroll.tag = currentracklabel.tag;
        }
        NSLog(@"current rack in tile scroll is %@, %i", tileScroll.loadedrackname, tileScroll.tag);
 
}


-(Rack *) findRack: (NSString *)racktofind InCategory:  (int) currentcategorynum
{
    Category *tempcategory;
    Closet *tempcloset = mixerController.myCloset;
    
    tempcategory = [tempcloset.categories objectAtIndex:categoryTypeSelector];
    
    
    for (int x = 0; x < [tempcategory.racksarray count]; ++x)
    {
        temprack = [tempcategory.racksarray objectAtIndex:x];
        NSLog(@"find %@, versus rack %@ ", racktofind, temprack.rackname);
        
        
        
        if ([racktofind compare:temprack.rackname] == NSOrderedSame)
        {
            return temprack;
        }
    }
    return nil;
}

-(Rack *) findRack: (NSString *)rackname InCat: (NSString *) catname
{
    for(int y=0; y<[myCloset.categories count]; y++)
    {
        
        Category *tempcategory = [myCloset.categories objectAtIndex:y];
        
        if([catname compare:tempcategory.categoryname] == NSOrderedSame)
        {
            
            for (int x = 0; x < [tempcategory.racksarray count]; ++x)
            {
                Rack * temprack;
                temprack = [tempcategory.racksarray objectAtIndex:x];
                
                
                
                if ([rackname compare:temprack.rackname] == NSOrderedSame)
                {
                    return temprack;
                }
                
                
            }
            
        }
        
        
    }
    
    NSLog(@"cannot find rack!!!!!!");
    return nil;
}

-(void) deleteItemFileNum:(int)filenum FromCat: (NSString *) catname Rack:(NSString *) rackname
{
    Rack *temprack = [self findRack:rackname InCat:catname];
    
    NSLog(@"going to try to find in %@, count %i", temprack.rackname, [temprack.rackitemsarray count]);
    
    
    
    for (int x = 0; x < [temprack.rackitemsarray count]; ++x)
    {
        ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:x];
        NSLog(@"looking for %i compare with %i", filenum, temprecord.fileNumRef);
         
        if(filenum == temprecord.fileNumRef)
        {
            
            [temprack.rackitemsarray removeObjectAtIndex:x];
            NSLog(@"%i REMOVED FROM %@", temprecord.fileNumRef, temprack.rackname);
        }
    }
    
    
    rearrange = YES;
    
    [myCloset saveClosetArchive];
    
    [self loadImagesInTileScroll];
    
    
    
    currentcategorynum = categoryTypeSelector;
    
    NSLog(@"%i category item being deleted", currentcategorynum);
    if(currentcategorynum == 0 || currentcategorynum == 1) mixerController.topChanged = YES;
    if(currentcategorynum == 2) mixerController.rightChanged = YES;
    if(currentcategorynum == 3) mixerController.lowerChanged = YES;
    if(currentcategorynum == 4) mixerController.topOverlayChanged = YES;
    if(currentcategorynum == 5) mixerController.accessoriesChanged = YES;
}



-(ImageRecord *) findRecordFileNum: (int) filenum inRack:(Rack *) rack;
{
    
    for (int x = 0; x<[rack.rackitemsarray count]; ++x)
    {
        ImageRecord *temprecord = [rack.rackitemsarray objectAtIndex:x];
        if(temprecord.fileNumRef == filenum)
        {
            return temprecord;
        }
            
    }
    return nil;
}

-(int)findPositionOfRecordFileNum: (int) filenum inRack:(Rack *) rack;
{
    
    for (int x = 0; x<[rack.rackitemsarray count]; ++x)
    {
        ImageRecord *temprecord = [rack.rackitemsarray objectAtIndex:x];
        if(temprecord.fileNumRef == filenum)
        {
            return x;
        }
        
    }
    return nil;
}
            



-(void)clearScroll: (UIViewInScroll *) scrolltoclear
{
    int scrollcount = [scrolltoclear.subviews count];
    
    for(int x=0; x < scrollcount; ++x)
    {
        UIView *removescrollitem = [scrolltoclear.subviews objectAtIndex:0];
        [removescrollitem removeFromSuperview];
        
    }
    NSLog(@"CLEARED SCROLL");
    
    
}




-(void) loadVerticalArchiveInViewInScroll: (UIScrollView *) scrollview
{
    [self clearViewInScroll:scrollview];
    
    
    
    
    labelwidth = self.view.frame.size.width/4;
    labelheight = 24;
    
    scrollview.frame = CGRectMake(0, 0, labelwidth, ((labelheight+10)));
    
    scrollcontain.frame = CGRectMake(228, 80, scrollview.frame.size.width, scrollview.frame.size.height*10-30);
    
    scrollcontain.backgroundColor = [UIColor blackColor];
    scrollcontain.clipsToBounds = YES;
    scrollview.contentSize = CGSizeMake(labelwidth, ([scrollview.subviews count]) * (labelheight+10));
    
    
    
    
    Category *tempcategory;
    NSString *tempname;

    
    
    NSLog(@"%i mycloset count categories", [myCloset.categories count]);
    if ([myCloset.categories count]>0)
    {
        
        NSLog(@"cat type selector is %i", categoryTypeSelector);
    
    tempcategory = [myCloset.categories objectAtIndex:categoryTypeSelector];
    
    NSLog(@"cleared for reload after add, loading racks of cat %@", tempcategory.categoryname);
    
    
    
    NSLog(@"%i racksarray count", [tempcategory.racksarray count]);
    for(int x=0; x < [tempcategory.racksarray count]; ++x)
    {
        CGFloat yOrigin = ([scrollview.subviews count]) * (labelheight + 10);
        
        temprack = [tempcategory.racksarray objectAtIndex:x];
        tempname = temprack.rackname;
        
        NSLog(@"temprackname is %@", tempname);

        UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, labelwidth, labelheight)];
        UILabel *templabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelwidth, labelheight)];

        
        tempview.tag = 999;
        templabel.tag = x;
        

        templabel.text = tempname;
        templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:12];
        templabel.textColor = [UIColor lightGrayColor];
        templabel.backgroundColor = [UIColor blackColor];
        
        
        if (x == 0) {
            
            
            templabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:14];
            templabel.textColor = [UIColor colorWithRed:0.95 green:0.52 blue:1.00 alpha:1];
            templabel.backgroundColor = [UIColor blackColor];
        }
        
        [tempview addSubview:templabel];
        
        NSLog(@"scrollview label %i count before add ", [scrollview.subviews count]);
        [scrollview addSubview:tempview];
       
 
        
        scrollview.frame = CGRectMake(0, 5, labelwidth, ((labelheight+10)));
        scrollcontain.frame = CGRectMake(228, 82, scrollview.frame.size.width, scrollview.frame.size.height*10 -30);
        scrollcontain.clipsToBounds = YES;
        scrollview.contentSize = CGSizeMake(labelwidth, ([scrollview.subviews count]) * (labelheight+10));
        
        clipview.frame = CGRectMake(228, 82, scrollview.frame.size.width, scrollview.frame.size.height*10-15);
        [self.view bringSubviewToFront:clipview];
        clipview.backgroundColor = [UIColor clearColor];
    }
    
       
    [self loadImagesInTileScroll];
        
    }
    
    
 
    [self setCurrentRackLabel];
}






-(BOOL) doesViewAlreadyExist: (int) findviewtag
{
    for(int x = 0; x < [self.view.subviews count]; ++x)
    {
        UIView *tempview = [self.view.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return TRUE;
        }
        
    }
    return FALSE;
}

-(BOOL) doesViewAlreadyExist: (int) findviewtag in: (UIView *) view
{
    for(int x = 0; x < [view.subviews count]; ++x)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return TRUE;
        }
        
    }
    return FALSE;
}





-(void) giveScrCount
{
    
    
    NSLog(@"subview count%i", [self.view.subviews count]);
    for (int x = 0; x<[self.view.subviews count]; ++x)
    {
        int subnum = x;
        UIView *viewTagExtract = [self.view.subviews objectAtIndex:x];
        int tagnum = viewTagExtract.tag;
        NSLog(@"subnum %i tagnum %i", subnum, tagnum);
        
        
        
    }

}

-(void)clearViewInScroll: (UIViewInScroll *) scrolltoclear;
{
    int scrollcount = [scrolltoclear.subviews count];
    
    for(int x=0; x < scrollcount; ++x)
    {
        UIImageView *removescrollitem = [scrolltoclear.subviews objectAtIndex:0];
        [removescrollitem removeFromSuperview];
        NSLog(@"CLEARED SCROLL");
    }
    
    
}


UIPickerView * colorsPicker;
UIPickerView * occasionsPicker;
UIPickerView * brandsPicker;
UIPickerView * categoryPicker;
UIPickerView * rackPicker;


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{

        
    if ( [ text isEqualToString: @"\n" ] ){
        
    [ textView resignFirstResponder ];
     return NO;
    }
    
    else return YES;
}





-(void) textFieldShouldReturn:(UITextField *)textField
{
    

    if(textField.superview.tag == 6102) //newitem view (tags field)
    {
      
        [textField resignFirstResponder];
        
        
    }
    else if (textField.superview.tag == 38) //enterrackview
    {
   
        [textField resignFirstResponder];
        
        
        [textField.superview removeFromSuperview];
    
        
    
        NSLog(@"textfield contains%@", textField.text);
    
        if ([textField.text compare:@""] == NSOrderedSame) //need to change to any number of blanks
        {
   
        }
        else  [self addNewRackToCategory:textField.text];
        
        [self reactivateAllInView:self.view];
        
        
  
    }
    else if (textField.superview.tag == 89) //enterdetail view
    {
        
        
      
        [textField resignFirstResponder];
        
        
        [textField.superview removeFromSuperview];
        [self reactivateAllInView:self.view];
        
        NSLog(@"user entered %@", textField.text);
        
        if ([textField.text compare:@""] == NSOrderedSame) //need to change to any number of blanks
        {
          
            
        }
        else
        {
            NSLog(@"textfield tag is %i", textField.tag );
            
            NSString *descat;
            if(textField.tag == 1)
            {
                [myCloset addNewCategory:textField.text];
            }
            if(textField.tag == 2)
            {
                [myCloset addNewRack:textField.text toCatNum:currentcatnum];
                
                
    
            }
            if (textField.tag == 3)
            {
                descat = @"occasions";
                
            }
            if (textField.tag == 4)
            {
                descat = @"colors";
                
            }
            if (textField.tag == 5)
            {
                descat = @"brands";
                
            }
            NSLog(@"%@", descat);
            
      
            if (textField.tag > 2)
            {
                [mixerController.myCloset addItem:textField.text toDescriptionCat:descat];
            }
            
            [categoryPicker reloadAllComponents];
            [rackPicker reloadAllComponents];
            [colorsPicker reloadAllComponents]; 
            [occasionsPicker reloadAllComponents];
            [brandsPicker reloadAllComponents];
        }
       
        
        
   
    }
    
   

}


-(IBAction) addNewRack
{
    
    
    if([self doesViewAlreadyExist:69] == NO)
    {
        if([myCloset.categories count] > 0)
        {
      
            
            NSLog(@"category selector is currently %i", categoryTypeSelector);    
    
            int originX = self.view.frame.size.width/2 - 100;
            int originY = self.view.frame.size.height/2 - 75;
            
    
   
            UIView *enterRackNameView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 100)];
            enterRackNameView.tag = 69;
    
            [self.view addSubview:enterRackNameView];
 
    
            UITextField *newrackfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 100, 25)];
            newrackfield.backgroundColor = [UIColor whiteColor];
            newrackfield.userInteractionEnabled = YES;
            newrackfield.font = [UIFont fontWithName:@"Futura" size:18];
            newrackfield.borderStyle = UITextBorderStyleRoundedRect;
            newrackfield.delegate = self;
    
            [enterRackNameView addSubview:newrackfield];
        }
    }
    else
    {
        NSLog(@"69 exists already!");
    }
 
    
}

-(void) deactivateAllInView: (UIView *) view except: (int) y
{
    
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        
        
        if (tempview.tag != y)
        {
            
            tempview.userInteractionEnabled = NO;
            NSLog(@"%i deactivated", tempview.tag);
        }
        
    }
}

-(void) deactivateAllInView: (UIView *) view except: (int) y and: (int) z
{
    
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        
        
        if (tempview.tag != y && tempview.tag != z)
        {
            
            tempview.userInteractionEnabled = NO;
            NSLog(@"%i deactivated", tempview.tag);
        }
        
    }
}


-(void) reactivateAllInView: (UIView *) view
{
    for (int x = 0; x<[view.subviews count]; x++)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
            tempview.userInteractionEnabled = YES;
        NSLog(@"reactivating %i", tempview.tag);
    }
}


-(IBAction) addNewOutfitRackCallUp
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        
        
        
        int originX = self.view.frame.size.width/2 - 100;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *enterCategoryNameView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 125)];
        
        
        
        enterCategoryNameView.backgroundColor = [UIColor whiteColor];
        
        
        enterCategoryNameView.tag = 38;
        
        enterCategoryNameView.layer.borderColor = [[UIColor grayColor] CGColor];
        enterCategoryNameView.layer.borderWidth = 2;
        
        
        
        
        
        [self.view addSubview:enterCategoryNameView];
        
        UILabel *addrackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        
        addrackLabel.backgroundColor = [UIColor blackColor];
        addrackLabel.numberOfLines = 0;
        
        NSString *currentcatname = [self getCurrentCategory];
        NSString *newrackstring = [NSString stringWithFormat:@"NEW TYPE", currentcatname];
        addrackLabel.text = newrackstring;
        addrackLabel.textColor = [UIColor whiteColor];
        addrackLabel.font = [UIFont fontWithName:@"Futura" size:22];
        addrackLabel.textAlignment = UITextAlignmentCenter;
        
        [enterCategoryNameView addSubview:addrackLabel];
        
        
        
        
        UITextField *newcategoryfield = [[UITextField alloc] initWithFrame:CGRectMake(25, 60, 150, 40)];
        newcategoryfield.backgroundColor = [UIColor whiteColor];
        newcategoryfield.font = [UIFont fontWithName:@"Futura" size:16];
        newcategoryfield.userInteractionEnabled = YES;
        newcategoryfield.borderStyle = UITextBorderStyleRoundedRect;
        newcategoryfield.delegate = self;
        
        [enterCategoryNameView addSubview:newcategoryfield];
        
        [self deactivateAllInView:self.view except:38];
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}



-(IBAction) alertDelete
{   
    
    [self setCurrentRackLabel];
    
    if (currentLabelInScroll.tag == 999)
    {
        
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 125)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        
        
        
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 210, 50)];
        alertLabel.numberOfLines = 0;
        
        
        NSString *currentcatname = [self getCurrentCategory];
        NSString *deletetypestring = [NSString stringWithFormat:@"Remove %@? ", currentracklabel.text];
        
        
        alertLabel.text = deletetypestring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:16];
        alertLabel.textAlignment = UITextAlignmentCenter;
    
        
        [alertView addSubview:alertLabel];
        
        
        
        UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
        UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
        
        UIImage *no = [UIImage imageNamed:@"no.jpg"];
        UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
        
        UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 70, 54, 36)];
        yesButton.tag=66;
        
        [yesButton setImage:yes forState:UIControlStateNormal];
        [yesButton setImage:yespressed forState:UIControlStateHighlighted];
        
        [yesButton addTarget:self action:@selector(deleteRack) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(131, 70, 54, 36)];
        
        
        noButton.tag= 77;
        [noButton setImage:no forState:UIControlStateNormal];
        [noButton setImage:nopressed forState:UIControlStateHighlighted];
        
        [noButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [alertView addSubview:yesButton];
        [alertView addSubview:noButton];
        
        [self deactivateAllInView:self.view except:38];
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    }
}

-(void) alertWith: (NSString *) alertstring
{
    
    
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        [self deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = self.view.frame.size.height/2;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 150)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        
        
        
        
        
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 180, 75)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 100, 54, 36)];
        okayButton.tag = 55;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:okayButton];
        
        /*    UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
         UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
         
         UIImage *no = [UIImage imageNamed:@"no.jpg"];
         UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
         
         UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         yesButton.frame = CGRectMake(40, 55, 54, 36);
         yesButton.tag=66;
         
         [yesButton setImage:yes forState:UIControlStateNormal];
         [yesButton setImage:yespressed forState:UIControlStateHighlighted];
         
         [yesButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
         
         UIButton *noButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         noButton.frame = CGRectMake(106, 55, 54, 36);
         
         
         noButton.tag= 77;
         [noButton setImage:no forState:UIControlStateNormal];
         [noButton setImage:nopressed forState:UIControlStateHighlighted];
         
         [noButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
         
         
         [removeCategoryView addSubview:yesButton];
         [removeCategoryView addSubview:noButton];*/
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}

-(void) alertWithAlt: (NSString *) alertstring
{
 
    
    if([self doesViewAlreadyExist:39] == NO)
    {
       
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = self.view.frame.size.height/2;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 150)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 39;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        
       
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 180, 75)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel];
        
        UIImage *okay = [UIImage imageNamed:@"okay.jpg"];
        UIImage *okaypressed = [UIImage imageNamed:@"okaypressed.jpg"];
        
        
        
        UIButton *okayButton = [[UIButton alloc] initWithFrame:CGRectMake(98, 100, 54, 36)];
        okayButton.tag = 55;
        
        [okayButton setImage:okay forState:UIControlStateNormal];
        [okayButton setImage:okaypressed forState:UIControlStateHighlighted];
        
        [okayButton addTarget:self action:@selector(dismissAlertAlt:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:okayButton];
        
        /*    UIImage *yes = [UIImage imageNamed:@"yes.jpg"];
         UIImage *yespressed = [UIImage imageNamed:@"yespressed.jpg"];
         
         UIImage *no = [UIImage imageNamed:@"no.jpg"];
         UIImage *nopressed = [UIImage imageNamed:@"nopressed.jpg"];
         
         UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         yesButton.frame = CGRectMake(40, 55, 54, 36);
         yesButton.tag=66;
         
         [yesButton setImage:yes forState:UIControlStateNormal];
         [yesButton setImage:yespressed forState:UIControlStateHighlighted];
         
         [yesButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
         
         UIButton *noButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         noButton.frame = CGRectMake(106, 55, 54, 36);
         
         
         noButton.tag= 77;
         [noButton setImage:no forState:UIControlStateNormal];
         [noButton setImage:nopressed forState:UIControlStateHighlighted];
         
         [noButton addTarget:self action:@selector(deleteOutfitCategory:) forControlEvents:UIControlEventTouchUpInside];
         
         
         [removeCategoryView addSubview:yesButton];
         [removeCategoryView addSubview:noButton];*/
        
        
        [self deactivateAllInView:self.view except:39];
        
        
    }
    else
    {
        NSLog(@"39 already there!");
        
    }
    
    
}


UIActivityIndicatorView *myZipIndicator;

-(void) alertWithBigZip: (NSString *) alertstring
{
    
    if([mixerController doesViewAlreadyExist:38] == NO)
    {
        [mixerController deactivateAllInView:self.view except:38];
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = 150;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 225)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        
        alertView.layer.cornerRadius = 5;
        
        
        myZipIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        myZipIndicator.center = CGPointMake(125, 140);
        myZipIndicator.hidesWhenStopped = YES;
        myZipIndicator.backgroundColor = [UIColor lightGrayColor];
        
        myZipIndicator.layer.cornerRadius = 5;
        
        [alertView addSubview:myZipIndicator];
        
        
        
        [myZipIndicator startAnimating];
        
        
        [mixerController.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 210, 80)];
        alertLabel.numberOfLines = 0;
        alertLabel.text = alertstring;
        alertLabel.textColor = [UIColor blackColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:14];
        
        [alertView addSubview:alertLabel];
        
        
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}


-(void) alertNewItem
{
    
   
    [clipview removeFromSuperview];
    
    if([self doesViewAlreadyExist:38] == NO)
    {
        
       
        
        
        int originX = self.view.frame.size.width/2 - 125;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 250, 150)];
        
        alertView.backgroundColor = [UIColor whiteColor];
        
        
        alertView.tag = 38;
        
        alertView.layer.borderColor = [[UIColor blackColor] CGColor];
        alertView.layer.borderWidth = 2;
        alertView.layer.cornerRadius = 5;
        
        
        [self.view addSubview:alertView];
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
        alertLabel.numberOfLines = 0;
        alertLabel.backgroundColor = [UIColor blackColor];
        
        alertLabel.textAlignment = UITextAlignmentCenter;
        
        
        //NSString *currentcatname = [self getCurrentCategory];
        NSString *deletetypestring = [NSString stringWithFormat:@"NEW ITEM"];
        
        
        alertLabel.text = deletetypestring;
        alertLabel.textColor = [UIColor whiteColor];
        alertLabel.font = [UIFont fontWithName:@"Futura" size:22];
        
        [alertView addSubview:alertLabel];
        
        
        
        UIImage *album = [UIImage imageNamed:@"album.jpg"];
        UIImage *albumpressed = [UIImage imageNamed:@"albumpressed.jpg"];
        
        UIImage *camera = [UIImage imageNamed:@"camera.jpg"];
        UIImage *camerapressed = [UIImage imageNamed:@"camerapressed.jpg"];
        
        UIButton *albumButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 55, 90, 36)];
        albumButton.tag=66;
        
        [albumButton setImage:album forState:UIControlStateNormal];
        [albumButton setImage:albumpressed forState:UIControlStateHighlighted];
        
        [albumButton addTarget:self action:@selector(proceedWithImageSelectionAlbum) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 55, 90, 36)];
        
        
        cameraButton.tag= 77;
        [cameraButton setImage:camera forState:UIControlStateNormal];
        [cameraButton setImage:camerapressed forState:UIControlStateHighlighted];
        
        [cameraButton addTarget:self action:@selector(proceedWithImageSelectionCamera) forControlEvents:UIControlEventTouchUpInside];
        
        
        [alertView addSubview:albumButton];
        [alertView addSubview:cameraButton];
        
        [self deactivateAllInView:self.view except:38];
        
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 100, 90, 36)];
        UIImage *cancel = [UIImage imageNamed:@"cancel.jpg"];
        UIImage *cancelpressed = [UIImage imageNamed:@"cancelpressed.jpg"];
        cancelButton.tag = 456;
        [cancelButton setImage:cancel forState:UIControlStateNormal];
        [cancelButton setImage:cancelpressed forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:cancelButton];
        
    }
    else
    {
        NSLog(@"38 already there!");
        
    }
    
    
}




-(void) addNewRackToCategory: (NSString *) rackname
{
    if([myCloset.categories count] > 0)
    {
  
        Rack * newrack = [[Rack alloc] init];
    
    
    
        newrack.rackname = rackname;  //need to allocate memory? noo...
        newrack.racktype = categoryTypeSelector;
        newrack.shouldLoad = YES;
    
    
        Category *tempcategory = [myCloset.categories objectAtIndex:categoryTypeSelector];
    
        NSLog(@"adding new rack called %@ to %@, %i", rackname, tempcategory.categoryname, categoryTypeSelector);
        
        
        
        currentcategorynum = categoryTypeSelector;
        
        if(currentcategorynum == 0 || currentcategorynum == 1) mixerController.topChanged = YES;
        if(currentcategorynum == 2) mixerController.rightChanged = YES;
        if(currentcategorynum == 3) mixerController.lowerChanged = YES;
        if(currentcategorynum == 4) mixerController.topOverlayChanged = YES;
        if(currentcategorynum == 5) mixerController.accessoriesChanged = YES;
    
        if(!tempcategory.racksarray)
        {
            tempcategory.racksarray = [[NSMutableArray alloc] init];
        }
    
        [tempcategory.racksarray addObject:newrack];
        
        
        [myCloset sortRackArray:tempcategory.racksarray];
   
        [myCloset saveClosetArchive];
        [self loadVerticalArchiveInViewInScroll:racksScroll];
    
    }
    
}


-(IBAction) deleteCategory
{
    Category *cat = [myCloset.categories objectAtIndex:categoryTypeSelector];
    
    if(![myCloset isItFixed:cat.categoryname])
    {
        [myCloset deleteCategory:categoryTypeSelector];
        
        [myCloset saveClosetArchive];
     
        [self loadCategoryArchive];
     
        [self loadVerticalArchiveInViewInScroll:racksScroll];
    }
    else
    {
        NSLog(@"cannot delete!");
    }
}
-(void) dismissAlert: (UIButton *) sender
{
    
    
    [sender.superview removeFromSuperview];
    [self reactivateAllInView:self.view];

    
}

-(void) dismissAlert
{
    
    UIView *retrieveview= [self retrieveView:38];
    [retrieveview removeFromSuperview];
    [self reactivateAllInView:self.view];
    [self.view addSubview:clipview];
}
-(void) dismissAlertAlt: (UIButton *)sender
{ 
    
    [sender.superview removeFromSuperview];
 
   
  
    [self reactivateAllInView:self.view];
    
}




-(void) deleteRack: (NSString *) rackname
{
    
    if(![myCloset isItFixed:rackname])
    {
        Category *tempcategory = [myCloset.categories objectAtIndex:categoryTypeSelector];

   
        
            NSLog(@"current rack label %@", currentracklabel.text);
      
        
        
        Rack *temprack = [self findRack:rackname InCategory:categoryTypeSelector];
        
        int numitemsinrack = (int)[temprack.rackitemsarray count];
       
            
        [organizercontroller deleteAllItemsFromRack:temprack];
            
        
                    
        [self deleteRack:rackname fromCategory:tempcategory];
        
        
    }
    else
    {
        NSLog(@"cannot delete!");
    }
    
    

}


-(void) deleteRack: (NSString *) rackname fromCategory: (Category *) category
{


    for (int x = 0; x < [category.racksarray count]; ++x)
    {
        Rack * tempRack = [category.racksarray objectAtIndex:x];
        NSLog(@"find %@, deleting rack %@ from", rackname, tempRack.rackname);
        if ([rackname compare:tempRack.rackname] == NSOrderedSame)
        {
            [category.racksarray removeObjectAtIndex:x];
        }
    }
    
    [myCloset saveClosetArchive];
    [self loadVerticalArchiveInViewInScroll:racksScroll];
    
    
    
    currentcatnum = [self getCurrentCategoryNumber];
    
    if(currentcatnum == 0 || currentcatnum == 1) mixerController.topChanged = YES;
    if(currentcatnum == 2) mixerController.rightChanged = YES;
    if(currentcatnum == 3) mixerController.lowerChanged = YES;
    if(currentcatnum == 4) mixerController.topOverlayChanged = YES;
    if(currentcatnum == 5) mixerController.accessoriesChanged = YES;
    
}


-(void) listRacksInCategory: (Category *) category
{
    
    for (int x = 0; x < [category.racksarray count]; ++x)
    {
        NSLog(@"cat %i count %i", x, [category.racksarray count]);
        Rack * temprack = [category.racksarray objectAtIndex:x];
        NSLog(@"%@ type %i", temprack.rackname, temprack.racktype);
    }
}





-(IBAction) addNewItemToRack
{
    
   
   
        Category *testforexistenceofrack = [myCloset.categories objectAtIndex:categoryTypeSelector];
    NSLog(@"existence of rackk???  %i", categoryTypeSelector);
    
        if([testforexistenceofrack.racksarray count] > 0)
        {
            NSLog(@"select existing picture");
            [self alertNewItem];
        }else
        {
            [self alertWith:@"Please create a Type first."];
        }
        
    
   

}


-(void) deleteItemFileNum: (int) filenum FromRack: (Rack *) rack
{
    
    
    for (int x = 0; x < [rack.rackitemsarray count]; x++)
    {
       
        
        ImageRecord *temprecord = [rack.rackitemsarray objectAtIndex:x];
        if(filenum == temprecord.fileNumRef)
        {
             NSLog(@"%i removed", temprecord.fileNumRef);
            [rack.rackitemsarray removeObjectAtIndex:x];
            [mixerController deleteFile:temprecord.imageFilePath];
            [mixerController deleteFile:temprecord.imageFilePathThumb];
            [mixerController deleteFile:temprecord.imageFilePathBest];
        }
        
    }
    
    
    rearrange = YES;
    
    [myCloset saveClosetArchive];
    
    
    currentcategorynum = [self getCurrentCategoryNumber];
    if(currentcategorynum == 0 || currentcategorynum == 1) mixerController.topChanged = YES;
    if(currentcategorynum == 2) mixerController.rightChanged = YES;
    if(currentcategorynum == 3) mixerController.lowerChanged = YES;
    if(currentcategorynum == 4) mixerController.topOverlayChanged = YES;
    if(currentcategorynum == 5) mixerController.accessoriesChanged = YES;
    
    [self loadImagesInTileScroll];
    
    
}


-(void) deleteAllItemsFromRack: (Rack *) rack
{
    int numitemsinrack = [rack.rackitemsarray count];
    
    for (int x = 0; x < numitemsinrack; x++)
    {
        NSLog(@"%i", numitemsinrack);
        
        ImageRecord *temprecord = [rack.rackitemsarray objectAtIndex:0];
      
            NSLog(@"%i removed", temprecord.fileNumRef);
            [rack.rackitemsarray removeObjectAtIndex:0];
            [mixerController deleteFile:temprecord.imageFilePath];
            [mixerController deleteFile:temprecord.imageFilePathThumb];
            [mixerController deleteFile:temprecord.imageFilePathBest];

    }
    rearrange = YES;
    [myCloset saveClosetArchive];
    [self loadImagesInTileScroll];
    
    currentcategorynum = [self getCurrentCategoryNumber];
    if(currentcategorynum == 0 || currentcategorynum == 1) mixerController.topChanged = YES;
    if(currentcategorynum == 2) mixerController.rightChanged = YES;
    if(currentcategorynum == 3) mixerController.lowerChanged = YES;
    if(currentcategorynum == 4) mixerController.topOverlayChanged = YES;
    if(currentcategorynum == 5) mixerController.accessoriesChanged = YES;
}


-(void) listItemsInRack: (Rack *) rack
{
    
}


-(IBAction) goBack
{
    organizerOpen = FALSE;
    geniusMode = NO;
    mixerController.geniusMode = NO;
    
      [geniusHub setHidden:YES];
    [self dismissModalViewControllerAnimated:YES];
    
    
}


-(IBAction)selectExistingPicture
{
    
    
    if([myCloset.categories count] == 0)
    {
        NSLog(@"create a category first!"); 
    }
    else if ([myCloset.categories count] > 0)
    {
        Category * tempcategory = [myCloset.categories objectAtIndex:categoryTypeSelector];
        
        if([tempcategory.racksarray count] == 0)
        {
            NSLog(@"create a rack first!");
            [self alertWith:@"Please create a Type first."];
            
        }
        else
        {
           [self showImageToolBar];
        }
    }
}

-(IBAction) proceedWithImageSelectionCamera
{
    fromCamera = YES;
    
    NSLog(@"camera available?");
    
    
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
    }
    else NSLog(@"camera not available");
    
}

-(IBAction) proceedWithImageSelectionAlbum
{
    fromCamera = NO;
    
    
    
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
        NSLog(@"allowing user to pick image");
    }
    
}



UIButton* removeColorButton;
UIButton* removeoccasionButton;
UIButton* removeBrandButton;

   ImageRecord *tempimagerecordedit;



-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
  
 
    
    [picker dismissModalViewControllerAnimated:YES];
    
        newitem = TRUE;
        //[self loadItemEditor:image fileNumRef:0 label:nil];
    

    [self performSegueWithIdentifier:@"ItemDetailsSegue" sender:image];
    
    
      [self hideImageToolBar];
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
  
    
    if ([segue.destinationViewController isKindOfClass:[ItemDetailController class]]) {
        
        NSLog(@"going to item detail controller with rack num%i", currentracknum);
        
        ItemDetailController *itemDetailController = segue.destinationViewController;
        
        itemDetailController.itemImage = sender;
        itemDetailController.currentracknum = (int) currentracklabel.tag;
        itemDetailController.currentcatnum = categoryTypeSelector;
        itemDetailController.organizerController = self;
    }
    
    if ([segue.destinationViewController isKindOfClass:[ItemViewController class]]) {
        
        NSNumber *sentNumber = (NSNumber *)sender;
        NSLog(@"sent  item is number %i",[sentNumber intValue]);
        
        ItemViewController *itemViewController = segue.destinationViewController;
        
        itemViewController.touchedItemNum = [sentNumber intValue];
        
        itemViewController.organizerController = self;
    }
    
    
}


- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[ItemDetailController class]]) {
        //ItemDetailController *itemDetailController = segue.sourceViewController;
        
        
    }
}


-(void) useCrop
{
    
}
-(void) exitCrop
{
    
}


int filenumrefedit;
UILabel* passedDetailsLabel;


UIView *newItemView;

-(void) loadItemEditor: (UIImage *) image fileNumRef: (int) filenum label:(UILabel *)label
{
   
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point W", [racksScroll.subviews count]);
    
    [clipview removeFromSuperview];
    
    filenumrefedit = filenum;
    passedDetailsLabel = label;
    

    
    if([self doesViewAlreadyExist:6102] == NO)
    {
        
        
        if([myCloset.categories count] > 0)
        {
            
            NSLog(@"category selector is currently %i", categoryTypeSelector);    
            
            int originX = 0;
            int originY = 20;
            
           
           
            
            
            newItemView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, self.view.frame.size.width, self.view.frame.size.height)];
            newItemView.tag = 6102;
                        
            UIImage *woodbg = [UIImage imageNamed:@"wood.png"];
            
            
            newItemView.backgroundColor = [UIColor colorWithPatternImage:woodbg];
            newItemView.layer.cornerRadius = 5;
            
            
            myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            myIndicator.center = CGPointMake(160, 230);
            myIndicator.hidesWhenStopped = YES;
            
            [newItemView addSubview:myIndicator];
           
            
            
            //UILabel *newItemHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)]];
            //[newItemView addSubview: newItemHeader];
            
            
            
            UIImageView *newItemPreviewImage = [[UIImageView alloc] initWithImage:image];
            newItemPreviewImage.frame = CGRectMake(25, 15, 111, 111);
            newItemPreviewImage.contentMode = UIViewContentModeScaleAspectFit;
            
            newItemPreviewImage.layer.borderColor = [[UIColor blackColor] CGColor];
            newItemPreviewImage.layer.borderWidth = 2;
          
            
            UIImage *confirmsave;
            UIImage *confirmsavepressed;
            if (newitem == TRUE)
            {
            
                confirmsave = [UIImage imageNamed:@"confirmsave.jpg"];
                confirmsavepressed = [UIImage imageNamed:@"confirmsavepressed.jpg"];
            }
            else
            {
                confirmsave = [UIImage imageNamed:@"savechange.jpg"];
                confirmsavepressed = [UIImage imageNamed:@"savechangepressed.jpg"];
            }
          

            UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(46, 370, 90, 36)];
            
            [confirmButton setImage:confirmsave forState:UIControlStateNormal];
            [confirmButton setImage:confirmsavepressed forState:UIControlStateHighlighted];
            [confirmButton addTarget:self action:@selector(confirmItemDetails:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIImage *cancel = [UIImage imageNamed:@"cancel.jpg"];
            UIImage *cancelpressed = [UIImage imageNamed:@"cancelpressed.jpg"];
            
            UIButton *cancelNewItemButton = [[UIButton alloc] initWithFrame:CGRectMake(46, 410, 90, 36)];
            [cancelNewItemButton setImage:cancel forState:UIControlStateNormal];
            [cancelNewItemButton setImage:cancelpressed forState:UIControlStateHighlighted];
            
            [cancelNewItemButton addTarget:self action:@selector(cancelNewItem:) forControlEvents:UIControlEventTouchUpInside];
            

            
          
            
            tempnewimage = image;
       
            
            
            
            
            [newItemView addSubview:cancelNewItemButton];
            [newItemView addSubview:confirmButton];
  
            UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 15, 100, 20)];
            categoryLabel.backgroundColor = [UIColor clearColor];
            categoryLabel.text = @"Category";
            categoryLabel.textColor = [UIColor blackColor];
            categoryLabel.font = [UIFont fontWithName:@"Futura" size:16];
            
            UILabel *rackLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 135, 100, 20)];
            rackLabel.backgroundColor = [UIColor clearColor];
            rackLabel.text = @"Type";
            rackLabel.textColor = [UIColor blackColor];
            rackLabel.font = [UIFont fontWithName:@"Futura" size:16];
            
            UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 135, 100, 20)];
            colorLabel.backgroundColor = [UIColor clearColor];
            colorLabel.text = @"Color";
            colorLabel.textColor = [UIColor blackColor];
            colorLabel.font = [UIFont fontWithName:@"Futura" size:16];
            
            
            UILabel *occasionLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 255, 100, 20)];
            occasionLabel.backgroundColor = [UIColor clearColor];
            occasionLabel.text = @"Occasion";
            occasionLabel.textColor = [UIColor blackColor];
            occasionLabel.font = [UIFont fontWithName:@"Futura" size:16];
            
            
            UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 255, 100, 20)];
            brandLabel.backgroundColor = [UIColor clearColor];
            brandLabel.text = @"Brand";
            brandLabel.textColor = [UIColor blackColor];
            brandLabel.font = [UIFont fontWithName:@"Futura" size:16];
            
            
            UILabel *additionalLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 365, 150, 20)];
            additionalLabel.backgroundColor = [UIColor clearColor];
            additionalLabel.text = @"Additional Tags";
            additionalLabel.textColor = [UIColor blackColor];
          
            additionalLabel.font = [UIFont fontWithName:@"Futura" size:16];
            
            UILabel *commaLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 440, 100, 20)];
            commaLabel.backgroundColor = [UIColor clearColor];
            commaLabel.text = @"(comma-separated)";
            commaLabel.textColor = [UIColor blackColor];
            
            commaLabel.font = [UIFont fontWithName:@"Futura" size:10];
            
            [newItemView addSubview:categoryLabel];
            [newItemView addSubview:rackLabel];
            [newItemView addSubview:colorLabel];
            [newItemView addSubview:occasionLabel];
            [newItemView addSubview:brandLabel];
            [newItemView addSubview:additionalLabel];
            [newItemView addSubview:commaLabel];
            

            
            
            UIImage *add = [UIImage imageNamed:@"add.jpg"];
            UIImage *addpressed = [UIImage imageNamed:@"addpressed.jpg"];
            
            UIImage *remove = [UIImage imageNamed:@"removeblue.jpg"];
            UIImage *removepressed = [UIImage imageNamed:@"removebluepressed.jpg"];
            
            

            
            
  //ADD REMOVE DETAILS BUTTONS  
            
        
            
            UIButton *addRackButtonDetail = [[UIButton alloc] initWithFrame:CGRectMake(237, 135, 25,25)];
            addRackButtonDetail.tag = 2;
            [addRackButtonDetail setImage:add forState:UIControlStateNormal];
            [addRackButtonDetail setImage:addpressed forState:UIControlStateHighlighted];
            [addRackButtonDetail addTarget:self action:@selector(addNewDetailCallUp:) forControlEvents:UIControlEventTouchUpInside];
            [newItemView addSubview:addRackButtonDetail];
            
            
            
            UIButton *addoccasionButton = [[UIButton alloc] initWithFrame:CGRectMake(237, 255, 25,25)];
            addoccasionButton.tag = 3;
            [addoccasionButton setImage:add forState:UIControlStateNormal];
            [addoccasionButton setImage:addpressed forState:UIControlStateHighlighted];
            [addoccasionButton addTarget:self action:@selector(addNewDetailCallUp:) forControlEvents:UIControlEventTouchUpInside];
            
            [newItemView addSubview:addoccasionButton];
            
            UIButton *removeoccasionButton = [[UIButton alloc] initWithFrame:CGRectMake(272, 255, 25,25)];
            removeoccasionButton.tag = 3;
            [removeoccasionButton setImage:remove forState:UIControlStateNormal];
            [removeoccasionButton setImage:removepressed forState:UIControlStateHighlighted];
            [removeoccasionButton addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
            
            [newItemView addSubview:removeoccasionButton];

            
            
            UIButton *addColorButton = [[UIButton alloc] initWithFrame:CGRectMake(77, 135, 25,25)];
            addColorButton.tag = 4;
            [addColorButton setImage:add forState:UIControlStateNormal];
            [addColorButton setImage:addpressed forState:UIControlStateHighlighted];
            [addColorButton addTarget:self action:@selector(addNewDetailCallUp:) forControlEvents:UIControlEventTouchUpInside];
            [newItemView addSubview:addColorButton];
            
            
            removeColorButton = [[UIButton alloc] initWithFrame:CGRectMake(112, 135, 25,25)];
            removeColorButton.tag = 4;
            [removeColorButton setImage:remove forState:UIControlStateNormal];
            [removeColorButton setImage:removepressed forState:UIControlStateHighlighted];
            [removeColorButton addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
            [newItemView addSubview:removeColorButton];
            
            
            UIButton *addBrandButton = [[UIButton alloc] initWithFrame:CGRectMake(77, 255, 25,25)];
            addBrandButton.tag = 5;
            [addBrandButton setImage:add forState:UIControlStateNormal];
            [addBrandButton setImage:addpressed forState:UIControlStateHighlighted];
            [addBrandButton addTarget:self action:@selector(addNewDetailCallUp:) forControlEvents:UIControlEventTouchUpInside];
            
            [newItemView addSubview:addBrandButton];
            
       
            
            UIButton *removeBrandButton = [[UIButton alloc] initWithFrame:CGRectMake(112, 255, 25,25)];
            [removeBrandButton setImage:remove forState:UIControlStateNormal];
            [removeBrandButton setImage:removepressed forState:UIControlStateHighlighted];
             removeBrandButton.tag = 5;
            
            [removeBrandButton addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
            
            [newItemView addSubview:removeBrandButton];
            
            
            
            
            

            
            
   //ADD DETAILS PICKERS!!         
            colorsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            colorsPicker.tag = 904;
            colorsPicker.delegate = self;
            colorsPicker.showsSelectionIndicator = YES; 
            
            CGAffineTransform t0 = CGAffineTransformMakeTranslation(colorsPicker.bounds.size.width/2, colorsPicker.bounds.size.height/2);
            CGAffineTransform s0 = CGAffineTransformMakeScale(0.35, 0.35);
            CGAffineTransform t1 = CGAffineTransformMakeTranslation(-colorsPicker.bounds.size.width/2, -colorsPicker.bounds.size.height/2);
            
            UIView *colorpickerHolder = [[UIView alloc] initWithFrame:CGRectMake(25, 160, 125, 75)];
            
            
            
            colorsPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
            
            [colorpickerHolder addSubview:colorsPicker];
            colorpickerHolder.clipsToBounds = NO;
            
            [newItemView addSubview:colorpickerHolder];
            
            occasionsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            occasionsPicker.tag = 903;
            occasionsPicker.delegate = self;
            occasionsPicker.showsSelectionIndicator = YES; 

            UIView *occasionpickerHolder = [[UIView alloc] initWithFrame:CGRectMake(185, 280, 125, 75)];
            
            occasionsPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
            
            [occasionpickerHolder addSubview:occasionsPicker];
            occasionpickerHolder.clipsToBounds = NO;
            
            [newItemView addSubview:occasionpickerHolder];
            
            
            
            brandsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            brandsPicker.tag = 905;
            brandsPicker.delegate = self;
            brandsPicker.showsSelectionIndicator = YES; 
            
            
            UIView *brandpickerHolder = [[UIView alloc] initWithFrame:CGRectMake(25, 280, 125, 75)];

            
            brandsPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
            
            [brandpickerHolder addSubview:brandsPicker];
            brandpickerHolder.clipsToBounds = NO;
            
            [newItemView addSubview:brandpickerHolder];
            
      
            UITextView *tagsfield = [[UITextView alloc] initWithFrame:CGRectMake(185, 390, 125, 50)];
            tagsfield.backgroundColor = [UIColor whiteColor];
        
            tagsfield.layer.borderColor = [[UIColor grayColor] CGColor];
            tagsfield.layer.borderWidth = 2;
            tagsfield.layer.cornerRadius = 5;
        
            tagsfield.tag = 203;
            tagsfield.text = @"";
            tagsfield.delegate = self;
            
            tagsfield.font = [UIFont fontWithName:@"Futura" size:14];
            
            [newItemView addSubview:tagsfield];
            
            
            
            
            
            
            
            
            
            
            categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            categoryPicker.tag = 901;
            categoryPicker.delegate = self;
            categoryPicker.showsSelectionIndicator = YES; 
            
            
            UIView *categorypickerHolder = [[UIView alloc] initWithFrame:CGRectMake(185, 40, 125, 75)];
            
            categoryPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
            
            [categorypickerHolder addSubview:categoryPicker];
            categorypickerHolder.clipsToBounds = NO;
            
            [newItemView addSubview:categorypickerHolder];
            
            
            
            rackPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            rackPicker.tag = 902;
            rackPicker.delegate = self;
            rackPicker.showsSelectionIndicator = YES; 
            
            
            UIView *rackpickerHolder = [[UIView alloc] initWithFrame:CGRectMake(185, 160, 125, 75)];
            
            rackPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
            
            [rackpickerHolder addSubview:rackPicker];
            rackpickerHolder.clipsToBounds = NO;
            
            [newItemView addSubview:rackpickerHolder];
            
            
            
            [newItemView addSubview:newItemPreviewImage];
            
            
            [self.view addSubview:newItemView];
            
            
            [self deactivateAllInView:self.view except:6102];
            
            int existingcolorrow;
            int existingoccasionrow;
            int existingbrandrow;
            int existingcatrow;
            int existingrackrow;
            
            if(newitem == FALSE)
            {
                
                  tagsfield.text = tempimagerecordedit.additionaltags;
             
                // FIX HERE!!
                
                tempimagerecordedit = [self retrieveRecordNum:filenumrefedit FromCat:currenteditcat RackName:currenteditrack];
                
            
                
                
                existingcolorrow = [self findRowOf:tempimagerecordedit.color inArray:myCloset.colors];
                
                
                
                existingoccasionrow = [self findRowOf:tempimagerecordedit.occasion inArray:myCloset.occasions];
                
           
               
                existingbrandrow = [self findRowOf:tempimagerecordedit.brand inArray:myCloset.brands];
                
                
                
                existingcatrow = [self findRowOf:tempimagerecordedit.catName inCatArray:myCloset.categories];
                
                
                Category *tempcat = [myCloset.categories objectAtIndex:existingcatrow];
                existingrackrow = [self findRowOf:tempimagerecordedit.rackName inRackArray:tempcat.racksarray];
                
                
                NSLog(@"existing catname rackname %@ %@", tempimagerecordedit.catName, tempimagerecordedit.rackName);
                
        
                if(existingcolorrow > [myCloset.colors count]-1)
                    currentcolornum = 0;
                else
                    currentcolornum = existingcolorrow;
                
                if(existingoccasionrow > [myCloset.occasions count]-1)
                    currentoccasionnum = 0;
                else
                    currentoccasionnum = existingoccasionrow;
                
                if(existingbrandrow > [myCloset.brands count]-1)
                    currentbrandnum = 0;
                else
                    currentbrandnum = existingbrandrow;
                
                
                currentcatnum = existingcatrow;
                
                
                currentracknum = existingrackrow;
                
                NSLog(@"current cat %i, existingrow %i, currentracknum %i, existing row %i", currentcatnum, existingcatrow, currentracknum, existingrackrow);
                
                NSLog(@"retrieved record %i cat %i rack %@", tempimagerecordedit.fileNumRef, currenteditcat, currenteditrack);
                
            }
            else
            {
                currentcolornum = 0;
                currentoccasionnum = 0;
                currentbrandnum = 0;
                currentcatnum = categoryTypeSelector;
                currentracknum = tileScroll.tag;
                
            }

            [colorsPicker selectRow:currentcolornum inComponent:0 animated:NO];
            [occasionsPicker selectRow:currentoccasionnum inComponent:0 animated:NO];
            [brandsPicker selectRow:currentbrandnum inComponent:0 animated:NO];
            
            [categoryPicker selectRow:currentcatnum inComponent:0 animated:NO];
            [rackPicker selectRow:currentracknum inComponent:0 animated:NO];
          
            
           
            
            
            
        }
    }
    else
    {
        NSLog(@"6102 exists already!");
    }

}
                 
UIButton*tempsender;
            
-(void)proceedNewItem
{
       [self confirmNewItem:tempsender];
       [self loadVerticalArchiveInViewInScroll:racksScroll];
       [myIndicator stopAnimating];
}

-(void) editItem: (int) touchedItemNum
{
    
    NSLog(@"touched item number is %i", touchedItemNum);
    
    NSNumber *touchedItemNumber = [NSNumber numberWithInt:touchedItemNum];
    
    [self performSegueWithIdentifier:@"ItemViewSegue" sender:touchedItemNumber];
}

-(void) saveItem:(ImageRecord *)newRecord withImage:(UIImage *)newImage
{
    NSLog(@"temp record is %i, %@, %@, %@, %@", newRecord.categoryType, newRecord.rackName, newRecord.brand, newRecord.color, newRecord.occasion);
    
    
    Category *tempcategory;
    tempcategory = [myCloset.categories objectAtIndex:newRecord.categoryType];
    
    
    if([tempcategory.racksarray count] == 0)
    {
        
        [self alertWithAlt:@"You must create a Type to save the item."];
        
    }
    else{
        
        
        
        UIImage * image = newImage;
        
        float bestwidth = image.size.width/5;
        float bestheight = image.size.height/5;
        
        float reducedwidth = image.size.width/8;
        float reducedheight = image.size.height/8;
        
        float thumbreducedwidth = image.size.width/30;
        float thumbreducedheight = image.size.height/30;
        
        
        CGSize bestSize = CGSizeMake(bestwidth, bestheight);
        
        CGSize reducedSize = CGSizeMake(reducedwidth, reducedheight);
        
        CGSize thumbnailSize = CGSizeMake(thumbreducedwidth, thumbreducedheight);
        
        
        
        UIImage *thumbnailImage = [self imageWithImage:image scaledToSize:thumbnailSize];
        UIImage *reducedImage = [self imageWithImage:image scaledToSize:reducedSize];
        
        
        UIImage *bestImage;
        
        //UIImage *bestImage = [self imageWithImage:image scaledToSize:bestSize];
        
        
        //SAVE IMAGES (FULL AND THUMBNAIL);
        
        if(!(lastImageNumArch = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastimagenum]))
        {
            imageFileNum = 1;
        }
        else
        {
            imageFileNum = [lastImageNumArch intValue];
            imageFileNum++;
        }
        
        
        lastImageNumArch = [NSNumber numberWithInt:imageFileNum];
        [NSKeyedArchiver archiveRootObject:lastImageNumArch toFile:pathlastimagenum];
        
        
        
        NSString *newShortImageFilePathBest = [NSString stringWithFormat:@"Documents/%db.png",imageFileNum];
        NSLog(@"Added %@", newShortImageFilePathBest);
        
        NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",imageFileNum];
        NSLog(@"Added %@", newShortImageFilePath);
        NSString *newShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dt.png",imageFileNum];
        NSLog(@"Added %@", newShortImageFilePathThumb);
        
        
        
        
        NSString  *newImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathBest];
        NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
        NSString  *newImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathThumb];
        
        [UIImagePNGRepresentation(reducedImage) writeToFile:newImageFilePath atomically:YES];
        
        [UIImagePNGRepresentation(thumbnailImage) writeToFile:newImageFilePathThumb atomically:YES];
        
        //[UIImagePNGRepresentation(bestImage) writeToFile:newImageFilePathBest atomically:YES];
        
        NSError *attributesError = nil;
        
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePath error:&attributesError];
        
        NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        
        long long fileSize = [fileSizeNumber longLongValue];
        
        if(fileSize < 125000)
        {
            NSLog(@"file is %llu, too small!", fileSize);
            
            int x = 2;
            
            int optwidth;
            int optheight;
            int optwidththumb;
            int optheightthumb;
            
            
            while (fileSize < 125000 && x < 11)
            {
                optwidth = reducedwidth * x;
                optheight = reducedheight * x;
                optwidththumb = thumbreducedwidth * x;
                optheightthumb = thumbreducedheight * x;
                
                reducedSize = CGSizeMake(optwidth, optheight);
                
                thumbnailSize = CGSizeMake(optwidththumb, optheightthumb);
                
                reducedImage = [self imageWithImage:image scaledToSize:reducedSize];
                thumbnailImage = [self imageWithImage:image scaledToSize:thumbnailSize];
                
                [UIImagePNGRepresentation(reducedImage) writeToFile:newImageFilePath atomically:YES];
                
                [UIImagePNGRepresentation(thumbnailImage) writeToFile:newImageFilePathThumb atomically:YES];
                
                fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePath error:&attributesError];
                
                fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
                
                
                fileSize = [fileSizeNumber longLongValue];
                
                NSLog(@"new %llu", fileSize);
                
                
                x++;
                NSLog(@"%i", x);
            }
            
            if(fileSize < 125000)
            {
                bestImage = reducedImage;
                NSLog(@"A");
                
            }
            
            else if(fileSize > 125000 && x < 6)
            {
                int optbestwidth = optwidth * 2;
                int optbestheight = optheight * 2;
                bestSize = CGSizeMake(optbestwidth, optbestheight);
                bestImage = [self imageWithImage:image scaledToSize:bestSize];
                NSLog(@"B");
            }
            else if(fileSize > 125000 && x < 8)
            {
                int optbestwidth = optwidth * 1.4;
                int optbestheight = optheight * 1.4;
                bestSize = CGSizeMake(optbestwidth, optbestheight);
                bestImage = [self imageWithImage:image scaledToSize:bestSize];
                NSLog(@"C");
            }
            else
            {
                bestwidth = image.size.width;
                bestheight = image.size.height;
                bestSize = CGSizeMake(bestwidth, bestheight);
                bestImage = [self imageWithImage:image scaledToSize:bestSize];
                NSLog(@"D");
            }
            
            [UIImagePNGRepresentation(bestImage) writeToFile:newImageFilePathBest atomically:YES];
            
            
        }
        else if (fileSize > 125000)
        {
            NSLog(@"NO OPTIMIZATION");
            UIImage *bestImage = [self imageWithImage:image scaledToSize:bestSize];
            [UIImagePNGRepresentation(bestImage) writeToFile:newImageFilePathBest atomically:YES];
        }
        
        newRecord.imageFilePath = [[NSString alloc] initWithString:newImageFilePath];
        newRecord.imageFilePathThumb = [[NSString alloc] initWithString:newImageFilePathThumb];
        newRecord.imageFilePathBest = [[NSString alloc] initWithString:newImageFilePathBest];
        
        NSLog(@"new record file path is %@", newRecord.imageFilePath);
        
        
        newRecord.fileNumRef = imageFileNum;
        
        
        //newRecord.additionaltags = retrieveadditional.text;
        
        
        [self addItem:newRecord toCat:newRecord.catName toRack:newRecord.rackName];
        
        
        [myCloset saveClosetArchive];
        
        
        NSLog(@"something here changed!");
        
        appDelegate.reloadarchives = YES;
        
        NSLog(@"mixer reloadarchives state is %i", mixerController.reloadarchives);
        if(currentcatnum == 0 || currentcatnum == 1) appDelegate.topChanged = YES;
        if(currentcatnum == 2) appDelegate.rightChanged = YES;
        if(currentcatnum == 3) appDelegate.lowerChanged = YES;
        if(currentcatnum == 4) appDelegate.topOverlayChanged = YES;
        if(currentcatnum == 5) appDelegate.accessoriesChanged = YES;
        
        NSLog(@"mixer topchanged state is %i", mixerController.topChanged);
        
        
        
        [self loadImagesInTileScroll];
    }
    
    if(fromCamera == TRUE)
    {
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    }
    
    
}

-(void) confirmItemDetails: (UIButton *)sender
{
    tempsender = sender;
    [self reactivateAllInView:self.view];
    [self deactivateAllInView:self.view except:38 and:555];
    
    [myIndicator startAnimating];
     
    if (newitem == TRUE)
    {
        
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(proceedNewItem) userInfo:nil repeats:NO];
          
    }
    else
    {
        [self confirmEditItem:sender];
          [self loadVerticalArchiveInViewInScroll:racksScroll];
    }
        
}
 



 -(void) confirmNewItem: (UIButton *) sender
{
    Category *tempcategory;
        tempcategory = [myCloset.categories objectAtIndex:currentcatnum];
    Rack *temprack;
        
    
    if([tempcategory.racksarray count] == 0)
    {
       
        [self alertWithAlt:@"You must create a Type to save the item."];

    }
    else{
        
                      
    
    UIImage * image = tempnewimage;
        
    float bestwidth = image.size.width/5;
    float bestheight = image.size.height/5;
    
    float reducedwidth = image.size.width/8;
    float reducedheight = image.size.height/8;
    
    float thumbreducedwidth = image.size.width/30;
    float thumbreducedheight = image.size.height/30;
    
    
    CGSize bestSize = CGSizeMake(bestwidth, bestheight);
        
    CGSize reducedSize = CGSizeMake(reducedwidth, reducedheight);
    
    CGSize thumbnailSize = CGSizeMake(thumbreducedwidth, thumbreducedheight);
        
        
    
    UIImage *thumbnailImage = [self imageWithImage:image scaledToSize:thumbnailSize];
    UIImage *reducedImage = [self imageWithImage:image scaledToSize:reducedSize];

        
        UIImage *bestImage;
        
        //UIImage *bestImage = [self imageWithImage:image scaledToSize:bestSize];
    
    
    //SAVE IMAGES (FULL AND THUMBNAIL);
        
        if(!(lastImageNumArch = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastimagenum]))
        {
            imageFileNum = 1;
        }
        else
        {
            imageFileNum = [lastImageNumArch intValue];
            imageFileNum++;
        }
        
        
        lastImageNumArch = [NSNumber numberWithInt:imageFileNum];
        [NSKeyedArchiver archiveRootObject:lastImageNumArch toFile:pathlastimagenum];
        
        
    
    NSString *newShortImageFilePathBest = [NSString stringWithFormat:@"Documents/%db.png",imageFileNum];
    NSLog(@"Added %@", newShortImageFilePathBest);
        
    NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",imageFileNum];
    NSLog(@"Added %@", newShortImageFilePath);
    NSString *newShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dt.png",imageFileNum];
    NSLog(@"Added %@", newShortImageFilePathThumb);
    
    
    
    
    NSString  *newImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathBest];
    NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
    NSString  *newImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathThumb];
    
    [UIImagePNGRepresentation(reducedImage) writeToFile:newImageFilePath atomically:YES];
    
    [UIImagePNGRepresentation(thumbnailImage) writeToFile:newImageFilePathThumb atomically:YES];
    
    //[UIImagePNGRepresentation(bestImage) writeToFile:newImageFilePathBest atomically:YES];
     
    NSError *attributesError = nil;
        
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePath error:&attributesError];
    
    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    
    long long fileSize = [fileSizeNumber longLongValue];
    
    if(fileSize < 125000)
    {
        NSLog(@"file is %llu, too small!", fileSize);
        
        int x = 2;
        
        int optwidth;
        int optheight;
        int optwidththumb;
        int optheightthumb;
        

        while (fileSize < 125000 && x < 11)
        {
            optwidth = reducedwidth * x;
            optheight = reducedheight * x;
            optwidththumb = thumbreducedwidth * x;
            optheightthumb = thumbreducedheight * x;
            
            reducedSize = CGSizeMake(optwidth, optheight);
            
            thumbnailSize = CGSizeMake(optwidththumb, optheightthumb);
            
            reducedImage = [self imageWithImage:image scaledToSize:reducedSize];
            thumbnailImage = [self imageWithImage:image scaledToSize:thumbnailSize];
           
            [UIImagePNGRepresentation(reducedImage) writeToFile:newImageFilePath atomically:YES];
            
            [UIImagePNGRepresentation(thumbnailImage) writeToFile:newImageFilePathThumb atomically:YES];

            fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePath error:&attributesError];
            
            fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
            
            
            fileSize = [fileSizeNumber longLongValue];
            
            NSLog(@"new %llu", fileSize);
            
            
            x++;
            NSLog(@"%i", x);
        }
        
        if(fileSize < 125000)
        {
            bestImage = reducedImage;
            NSLog(@"A");
               
        }
        
        else if(fileSize > 125000 && x < 6)
        {
            int optbestwidth = optwidth * 2;
            int optbestheight = optheight * 2;
            bestSize = CGSizeMake(optbestwidth, optbestheight);
            bestImage = [self imageWithImage:image scaledToSize:bestSize];
            NSLog(@"B");
        }
        else if(fileSize > 125000 && x < 8)
        {
            int optbestwidth = optwidth * 1.4;
            int optbestheight = optheight * 1.4;
            bestSize = CGSizeMake(optbestwidth, optbestheight);
            bestImage = [self imageWithImage:image scaledToSize:bestSize];
            NSLog(@"C");
        }
        else
        {
            bestwidth = image.size.width;
            bestheight = image.size.height;
            bestSize = CGSizeMake(bestwidth, bestheight);
            bestImage = [self imageWithImage:image scaledToSize:bestSize];
            NSLog(@"D");
        }
        
        [UIImagePNGRepresentation(bestImage) writeToFile:newImageFilePathBest atomically:YES];
        
        
    }
    else if (fileSize > 125000)
    {
         NSLog(@"NO OPTIMIZATION");
         UIImage *bestImage = [self imageWithImage:image scaledToSize:bestSize];
         [UIImagePNGRepresentation(bestImage) writeToFile:newImageFilePathBest atomically:YES];
    }

    
    ImageRecord *newRecord = [[ImageRecord alloc] init];
    newRecord.imageFilePath = [[NSString alloc] initWithString:newImageFilePath];
    newRecord.imageFilePathThumb = [[NSString alloc] initWithString:newImageFilePathThumb];
    newRecord.imageFilePathBest = [[NSString alloc] initWithString:newImageFilePathBest];
        
    NSLog(@"new record file path is %@", newRecord.imageFilePath);
        
       
    newRecord.fileNumRef = imageFileNum;
        
       
    
    
    //CREATE NEW RECORD
        
      /*
        fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePath error:&attributesError];
        fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        fileSize = [fileSizeNumber longLongValue];
        NSLog(@"final reduced %llu", fileSize);
        
        fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePathBest error:&attributesError];
        fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        fileSize = [fileSizeNumber longLongValue];
        NSLog(@"final best %llu", fileSize);
        
        fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:newImageFilePathThumb error:&attributesError];
        fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        fileSize = [fileSizeNumber longLongValue];
        NSLog(@"final thumb %llu", fileSize); 
        
        */
        
        
    UIView *removeview = sender.superview;
    
    
    
    UITextView *retrieveadditional = [self retrieveTextView:203 fromView:removeview]; 
    

    if([myCloset.colors count]>0)
    {
        newRecord.color = [myCloset.colors objectAtIndex:currentcolornum];
    }
    if([myCloset.occasions count]>0)
    {
        newRecord.occasion = [myCloset.occasions objectAtIndex:currentoccasionnum];
    }
    if([myCloset.brands count]>0)
    {
        newRecord.brand = [myCloset.brands objectAtIndex:currentbrandnum];
    }
    
    
    if([myCloset.categories count]>0)
    {

        
        tempcategory = [myCloset.categories objectAtIndex:currentcatnum];
        
        newRecord.catName = tempcategory.categoryname;
         newRecord.categoryType = currentcatnum;
        
        NSLog(@"new record catname is %@", newRecord.catName);
    }
    
    if([tempcategory.racksarray count]>0)
    {
        if(currentracknum == 30000)
        {
            NSLog(@"3000000");
            currentracknum = 0;
        }
        
        
        temprack = [tempcategory.racksarray objectAtIndex:currentracknum];
        
        newRecord.rackName = temprack.rackname;
        
        NSLog(@"new record rackname is %@", newRecord.rackName);
    }
    
    
    
    
    newRecord.additionaltags = retrieveadditional.text;
    
    
    [self addItem:newRecord toCat:newRecord.catName toRack:newRecord.rackName];
    
    
    [removeview removeFromSuperview];
    
    
    [self dismissAlert];
    
        
    
    [myCloset saveClosetArchive];
        
        
        
        NSLog(@"something here changed!");
        
        appDelegate.reloadarchives = YES;
        
        NSLog(@"mixer reloadarchives state is %i", mixerController.reloadarchives);
    if(currentcatnum == 0 || currentcatnum == 1) appDelegate.topChanged = YES;
    if(currentcatnum == 2) appDelegate.rightChanged = YES;
    if(currentcatnum == 3) appDelegate.lowerChanged = YES;
    if(currentcatnum == 4) appDelegate.topOverlayChanged = YES;
    if(currentcatnum == 5) appDelegate.accessoriesChanged = YES;
        
          NSLog(@"mixer topchanged state is %i", mixerController.topChanged);
    
    
    
    [self loadImagesInTileScroll];
    }
    
    if(fromCamera == TRUE)
    {
        UIImageWriteToSavedPhotosAlbum(tempnewimage, nil, nil, nil);
    }
}








-(void) addItem: (ImageRecord *) record toCat: (NSString *) catname toRack: (NSString *) rackname
{
    
    
    
    NSLog(@"outside additem forloop");
    for(int y=0; y<[myCloset.categories count]; y++)
    {
        
        NSLog(@"inside additem forloop");
        
        Category *tempcategory = [myCloset.categories objectAtIndex:y];
        
        if([catname compare:tempcategory.categoryname] == NSOrderedSame)
        {
        
            for (int x = 0; x < [tempcategory.racksarray count]; ++x)
            {
                Rack * temprack;
                temprack = [tempcategory.racksarray objectAtIndex:x];
                
               
                
                if ([rackname compare:temprack.rackname] == NSOrderedSame)
                {
                   
                    
                    if (!temprack.rackitemsarray)
                    {
                        temprack.rackitemsarray = [[NSMutableArray alloc] init];
                    }
                    
                    
                    record.catName = [NSString stringWithString:tempcategory.categoryname];
                    
                    
                    record.rackName = [NSString stringWithString:temprack.rackname];
                    
                   
                    
                    [temprack.rackitemsarray addObject:record];
                    
                    
                    NSLog(@"new record has rackname %@ and cat %@", record.rackName, record.catName);
                    NSLog(@"%i added to %@", record.fileNumRef, record.rackName);
                    
                    
                    ImageRecord *testrecord = [temprack.rackitemsarray objectAtIndex:[temprack.rackitemsarray count]-1];
                    
                    NSLog(@"new restored test record is %i in %@, image %@", testrecord.fileNumRef, testrecord.rackName, testrecord.imageFilePath);
                    
                    NSLog(@"addingitem to closet identity %@", myCloset.closetIdentity);
                    
                    break;
                }
                
                
            }
            break;
        }
        
        
    }
}
 
-(void) saveEditItem:(ImageRecord *)editedRecord
{
    NSLog(@"saving tag 2 %@", editedRecord.tagTwo);
    changedrack = FALSE;
    
    Category *existingCat = [myCloset.categories objectAtIndex:categoryTypeSelector];
    
    Rack *existingRack = [existingCat.racksarray objectAtIndex:currentracklabel.tag];
    NSLog(@"existing cat is %@, and rack is %@, edited record %@ %@", existingCat.categoryname, existingRack.rackname, editedRecord.catName, editedRecord.rackName);
    

        if( !([existingCat.categoryname compare:editedRecord.catName] == NSOrderedSame) || !([existingRack.rackname compare:editedRecord.rackName] == NSOrderedSame))
        {
            NSLog(@"****************cat has changed");
            changedrack = TRUE;
        }
    
    
    if(changedrack == TRUE)
    {
        
        
        [self addItem:editedRecord toCat:editedRecord.catName toRack:editedRecord.rackName];
        NSLog(@"added item to %@ %@", editedRecord.catName, editedRecord.rackName );
        
        
        [self deleteItemFileNum:editedRecord.fileNumRef FromCat:existingCat.categoryname Rack:existingRack.rackname];
        NSLog(@"deleted item from %i %@ %@", editedRecord.fileNumRef, existingCat.categoryname,existingRack.rackname);
        
    }
    

    [self updateItemInOutfits:editedRecord.fileNumRef newCat:editedRecord.catName newRack:editedRecord.rackName];
    
    
    [myCloset saveClosetArchive];
    
    
    if(currentcatnum == 0 || currentcatnum == 1) mixerController.topChanged = YES;
    if(currentcatnum == 2) mixerController.rightChanged = YES;
    if(currentcatnum == 3) mixerController.lowerChanged = YES;
    if(currentcatnum == 4) mixerController.topOverlayChanged = YES;
    if(currentcatnum == 5) mixerController.accessoriesChanged = YES;
    

}

/*

-(void) confirmEditItem: (UIButton *) sender
{
    


    Category *tempcategory;
    tempcategory = [myCloset.categories objectAtIndex:currentcatnum];
    
    
    
    if([tempcategory.racksarray count] == 0)
    {
        
        [self alertWithAlt:@"You must create a Type to save the item."];
        
    }
    else{
    
    
    UIView *removeview = sender.superview;
    UITextView *retrieveadditional = [self retrieveTextView:203 fromView:removeview]; 
    
   
    NSLog(@"confirm rows color:%i, occasion:%i, brand:%i, cat:%i, rack:%i", currentcolornum, currentoccasionnum, currentbrandnum, currentcatnum, currentracknum);
    
    if([myCloset.colors count]>0)
    {
        tempimagerecordedit.color = [myCloset.colors objectAtIndex:currentcolornum];
    }
    if([myCloset.occasions count]>0)
    {
          tempimagerecordedit.occasion = [myCloset.occasions objectAtIndex:currentoccasionnum];
    }
    if([myCloset.brands count]>0)
    {
        tempimagerecordedit.brand = [myCloset.brands objectAtIndex:currentbrandnum];
    }
    
    
    tempimagerecordedit.additionaltags = retrieveadditional.text;
    
    
 
    changedrack = FALSE;
    NSString *oldcat;
    NSString *oldrack;
  
    
    Category *tempnewcat = [myCloset.categories objectAtIndex:currentcatnum];
    
    if([myCloset.categories count]>0)
    {
        oldcat = tempimagerecordedit.catName;
        
        if( !([tempnewcat.categoryname compare:tempimagerecordedit.catName] == NSOrderedSame))
        {
            
            NSLog(@"****************cat has changed");
            tempimagerecordedit.catName = tempnewcat.categoryname;
            changedrack = TRUE;
            
                   }
    }

    
    if([tempnewcat.racksarray count]>0)
    {
        Rack *tempnewrack = [tempnewcat.racksarray objectAtIndex:currentracknum];
        
        oldrack = tempimagerecordedit.rackName;
        
        if( !([tempnewrack.rackname compare:tempimagerecordedit.rackName] == NSOrderedSame))
        {
            
             NSLog(@"********************rack has changed");
            tempimagerecordedit.rackName = tempnewrack.rackname;
            changedrack = TRUE;
        }
    }
    
    

    if(changedrack == TRUE)
    {
        
    
        [self addItem:tempimagerecordedit toCat:tempimagerecordedit.catName toRack:tempimagerecordedit.rackName];
        NSLog(@"added item to %@ %@", tempimagerecordedit.catName, tempimagerecordedit.rackName ); 
        
      
        [self deleteItemFileNum:tempimagerecordedit.fileNumRef FromCat:oldcat Rack:oldrack];
          NSLog(@"deleted item from %i %@ %@", tempimagerecordedit.fileNumRef, oldcat,oldrack); 
        
    }
    
    
  


    [removeview removeFromSuperview];
        
        
        currenteditcat = currentcatnum;
        currenteditrack = tempimagerecordedit.rackName;
        
        NSLog(@"new cat and rack is %i, %@", currenteditcat, currenteditrack);
        
        
        NSString *brandstring;
        NSString *occasionstring;
        
        if([tempimagerecordedit.brand compare:@"N/A"]==NSOrderedSame) brandstring = @"";
        else brandstring = [NSString stringWithFormat:@"by %@",tempimagerecordedit.brand];
        
        if([tempimagerecordedit.occasion compare:@"N/A"]==NSOrderedSame) occasionstring = @"";
        else occasionstring = [NSString stringWithFormat:@"(Occasion: %@)",tempimagerecordedit.occasion];
        
      
        
    
        [self updateItemInOutfits:tempimagerecordedit.fileNumRef newCat:tempimagerecordedit.catName newRack:tempimagerecordedit.rackName];
        
    
    NSString *newdetails = [NSString stringWithFormat:@"%@ %@ %@ \n%@", tempimagerecordedit.color, tempimagerecordedit.rackName, brandstring, occasionstring];
    passedDetailsLabel.text = newdetails;
    
    [myCloset saveClosetArchive];
            [self.view addSubview:clipview];
        
        
        
        
        
        if(currentcatnum == 0 || currentcatnum == 1) mixerController.topChanged = YES;
        if(currentcatnum == 2) mixerController.rightChanged = YES;
        if(currentcatnum == 3) mixerController.lowerChanged = YES;
        if(currentcatnum == 4) mixerController.topOverlayChanged = YES;
        if(currentcatnum == 5) mixerController.accessoriesChanged = YES;
        
        
        
        
    }
   
}
 */



 
 
 
-(void) updateItemInOutfits: (int) filenumref newCat: (NSString *) newcat newRack: (NSString *) newrack 
{
    for(int x= 0; x< [myCloset.outfitsArray count]; x++)
    {
        OutfitRecord *tempoutfit = [myCloset.outfitsArray objectAtIndex:x];
        
        if (tempoutfit.toprefnum == filenumref)
        {
            tempoutfit.topcatname = newcat;
            tempoutfit.toprackname = newrack;
            
        }
        if (tempoutfit.rightrefnum == filenumref)
        {
            tempoutfit.rightcatname = newcat;
            tempoutfit.rightrackname = newrack;
            
        }
        if (tempoutfit.lowerrefnum == filenumref)
        {
            tempoutfit.lowercatname = newcat;
            tempoutfit.lowerrackname = newrack;
        }
        if (tempoutfit.topoverlayrefnum == filenumref)
        {
            tempoutfit.topoverlaycatname = newcat;
            tempoutfit.topoverlayrackname = newrack;
        }
        
        
    }
}
 
     
           
                 
                 
                 

-(int) findRowOf: (NSString *) detail inArray: (NSMutableArray *) array
{
    int x;
    for(x=0; x<[array count]; x++)
    {
        
        if([detail compare:[array objectAtIndex:x]] == NSOrderedSame)
            {
                
                break;
            }
    }
    return x;
    
}


-(int) findRowOf: (NSString *) catname inCatArray: (NSMutableArray *) catarray
{
    int x;
    
    for(x=0; x<[catarray count]; x++)
    {
        Category *tempcat = [catarray objectAtIndex:x];
        
        if ([catname compare:tempcat.categoryname] == NSOrderedSame)
        {
          
            break;
        
        }
        

    }
    return x; 
}


-(int) findRowOf: (NSString *) rackname inRackArray: (NSMutableArray *) rackarray
{
    int x;
    
    for(x=0; x<[rackarray count]; x++)
    {
        Rack *temprack = [rackarray objectAtIndex:x];
        
        if ([rackname compare:temprack.rackname] == NSOrderedSame)
        {
            
            break;
            
        }
        
        
    }
    return x; 
}






/*
 UILabel *addrackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
 
 addrackLabel.backgroundColor = [UIColor blackColor];
 addrackLabel.numberOfLines = 0;
 
 NSString *currentcatname = [self getCurrentCategory];
 NSString *newrackstring = [NSString stringWithFormat:@"NEW TYPE", currentcatname];
 addrackLabel.text = newrackstring;
 addrackLabel.textColor = [UIColor whiteColor];
 addrackLabel.font = [UIFont fontWithName:@"Futura" size:22];
 addrackLabel.textAlignment = UITextAlignmentCenter;
 
 [enterCategoryNameView addSubview:addrackLabel];
 
 
 
 
 UITextField *newcategoryfield = [[UITextField alloc] initWithFrame:CGRectMake(25, 60, 150, 40)];
 newcategoryfield.backgroundColor = [UIColor whiteColor];
 newcategoryfield.font = [UIFont fontWithName:@"Futura" size:14];
 newcategoryfield.userInteractionEnabled = YES;
 newcategoryfield.borderStyle = UITextBorderStyleRoundedRect;
 newcategoryfield.delegate = self;
 
 
 
 
 int originX = self.view.frame.size.width/2 - 100;
 int originY = self.view.frame.size.height/2 - 125;
 
 
 
 UIView *enterCategoryNameView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 125)];
 
 */

-(void) addNewDetailCallUp: (UIButton *)sender
{
    
     shiftlocked = TRUE;
    
    if([self doesViewAlreadyExist:89] == NO)
    {
        [self deactivateAllInView:self.view except:89];
        
        
        int originX = self.view.frame.size.width/2 - 100;
        int originY = self.view.frame.size.height/2 - 125;
        
        
        
        UIView *enterNewDetailView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 125)];
        
        enterNewDetailView.backgroundColor = [UIColor whiteColor];
        
        
        enterNewDetailView.tag = 89;
        
        enterNewDetailView.layer.borderColor = [[UIColor grayColor] CGColor];
        enterNewDetailView.layer.borderWidth = 2;
        
        
        
        
        
        [self.view addSubview:enterNewDetailView];
        
        UILabel *adddetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        adddetailLabel.backgroundColor = [UIColor blackColor];
        adddetailLabel.textAlignment = UITextAlignmentCenter;
        
        NSString *fieldname;
        
        
        if (sender.tag == 2) fieldname = @"TYPE";
        if (sender.tag == 3) fieldname = @"OCCASION";
        if (sender.tag == 4) fieldname = @"COLOR";
        if (sender.tag == 5) fieldname = @"BRAND";
        
        
        
        
        NSString *detailstring= [NSString stringWithFormat:@"NEW %@", fieldname];
        
        
        
        adddetailLabel.text = detailstring;
        adddetailLabel.textColor = [UIColor whiteColor];
        adddetailLabel.font = [UIFont fontWithName:@"Futura" size:22];
        
        [enterNewDetailView addSubview:adddetailLabel];
        
        
        UITextField *newdetailfield = [[UITextField alloc] initWithFrame:CGRectMake(25, 60, 150, 40)];
        newdetailfield.backgroundColor = [UIColor whiteColor];
        newdetailfield.userInteractionEnabled = YES;
        newdetailfield.font = [UIFont fontWithName:@"Futura" size:16];
        newdetailfield.borderStyle = UITextBorderStyleRoundedRect;
        newdetailfield.delegate = self;
        newdetailfield.tag = sender.tag;
        
        [enterNewDetailView addSubview:newdetailfield];
    }
    else
    {
        NSLog(@"89 already there!");
        
    }
    
    
}




-(void) callUpNewDetailField: (UIButton *) sender
{
    
    shiftlocked = TRUE;
   
    if([organizercontroller doesViewAlreadyExist:89] == NO)
    {
        
        int originX = appDelegate.mixerController.organizerController.view.frame.size.width/2 - 100;
        int originY = appDelegate.mixerController.organizerController.view.frame.size.height/2 - 75;
        
        
        
        UIView *enterDetailView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 100)];
        
        enterDetailView.backgroundColor = [UIColor whiteColor];
        
        
        enterDetailView.tag = 89;
        
        [appDelegate.mixerController.organizerController.view addSubview:enterDetailView];
        
        
        
        UITextField *newdetailfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 100, 25)];
        
        newdetailfield.tag = sender.tag;
        newdetailfield.font = [UIFont fontWithName:@"Futura" size:18];
        newdetailfield.backgroundColor = [UIColor whiteColor];
        newdetailfield.userInteractionEnabled = YES;
        newdetailfield.borderStyle = UITextBorderStyleRoundedRect;
        newdetailfield.delegate = self;
        
        [enterDetailView addSubview:newdetailfield];
    }
    else
    {
        NSLog(@"89 already there!");
        
    }
    
    
}





-(void) cancelNewItem: (UIButton *) sender;
{
    
    UIView * cancelnewitem = sender.superview;
    [cancelnewitem removeFromSuperview];
    
    [self reactivateAllInView:self.view];
    //[self deactivateAllInView:self.view except:38 and: 555];
    [self.view addSubview:clipview];
}








-(UIView *) retrieveView: (int) findviewtag fromView: (UIView *) view;
{
    for(int x = 0; x < [view.subviews count]; ++x)
    {
        UIView *tempview = [view.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return tempview;
        }
        
    }
    return nil;
}



-(UITextField *) retrieveTextField: (int) findviewtag fromView: (UIView *) view;
{
    for(int x = 0; x < [view.subviews count]; ++x)
    {
        UITextField *textfield = [view.subviews objectAtIndex:x];
        if (textfield.tag == findviewtag)
        {
            return textfield;
        }
        
    }
    return nil;
}

-(UITextView *) retrieveTextView: (int) findviewtag fromView: (UIView *) view;
{
    for(int x = 0; x < [view.subviews count]; ++x)
    {
        UITextView *textview = [view.subviews objectAtIndex:x];
        if (textview.tag == findviewtag)
        {
            return textview;
        }
        
    }
    return nil;
}


-(void) textViewDidBeginEditing:(UITextView *)textView
{
    CGPoint positionWithKeyboard = CGPointMake(self.view.center.x, self.view.center.y-200);
    [UIView beginAnimations:@"rearranging tiles" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.view.center = positionWithKeyboard;
    
    [UIView commitAnimations];
}
-(void) textViewDidEndEditing:(UITextView *)textView
{
    CGPoint positionWithKeyboard = CGPointMake(self.view.center.x, self.view.center.y+200);
    [UIView beginAnimations:@"rearranging tiles" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.view.center = positionWithKeyboard;
    
    [UIView commitAnimations];
}




-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    
    [picker dismissModalViewControllerAnimated:YES];
}
                        //END ADD IMAGE FROM CAMERA ROLL










//USE TO SCALE IMAGES DOWN

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}                                                       //END SCALE IMAGES DOWN







-(void) removeItem: (UIButton *) sender
{
    if (sender.tag == 1)
    {
        
    }
    
    if (sender.tag == 2)
    {
        
    }
    
    if (sender.tag == 3)
    {
        if(currentoccasionnum != 0){
        
        [myCloset removeItem: currentoccasionnum fromDescriptor:myCloset.occasions];
        [occasionsPicker reloadAllComponents];
        currentoccasionnum = currentoccasionnum -1;
           
        }
        
    }
    if (sender.tag == 4)
    {
        if([myCloset.colors count] > 1)
        {
        
        [myCloset removeItem: currentcolornum fromDescriptor:myCloset.colors];
        [colorsPicker reloadAllComponents];
        
            if(currentcolornum !=0)
                currentcolornum = currentcolornum -1;
        }
        
    }
    if (sender.tag == 5)
    {
        if(currentbrandnum != 0){
        
        [myCloset removeItem: currentbrandnum fromDescriptor:myCloset.brands];
        [brandsPicker reloadAllComponents];
        
        currentbrandnum = currentbrandnum -1;
        }
        
    }
    
    [colorsPicker selectRow:currentcolornum inComponent:0 animated:NO];
    [brandsPicker selectRow:currentbrandnum inComponent:0 animated:NO];
    [occasionsPicker selectRow:currentoccasionnum inComponent:0 animated:NO];
   

    
    
  
}





- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component 
{
    if(pickerView.tag == 901)
    {
        
        currentcatnum = row;
        
        currentracknum = 0;
        
        [rackPicker reloadAllComponents];
        
        
        [rackPicker selectRow:currentracknum inComponent:0 animated:NO];
       
        
    }
    if(pickerView.tag == 902)
    {
        
        currentracknum = row;
        
        NSLog(@"currentracknum changed to %i", currentracknum);
        
    }
    if(pickerView.tag == 903)
    {
        
        currentoccasionnum = row;
        
    }
    if(pickerView.tag == 904)
    {
        
        currentcolornum = row;
        NSLog(@"%i", currentcolornum);
        
    }

    if(pickerView.tag == 905)
    {
        
        currentbrandnum = row;
        
    }

    
    
}



// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    if(pickerView.tag == 901)
    {
        NSUInteger numRows = [myCloset.categories count];
        
        return numRows;
    }
    
    if(pickerView.tag == 902)
    {
        Category *tempcat = [myCloset.categories objectAtIndex:currentcatnum];
        
        NSUInteger numRows = [tempcat.racksarray count];
        
        NSLog(@"RETURNING ROWS IN RACK IS %i, current cat is %i", numRows, currentcatnum);
        
        return numRows;
    }
    if(pickerView.tag == 903)
    {
        NSUInteger numRows = [myCloset.occasions count];
        
        return numRows;
    }
    if(pickerView.tag == 904)
    {
        NSUInteger numRows = [myCloset.colors count];
        
        return numRows;
    }

    if(pickerView.tag == 905)
    {
        NSUInteger numRows = [myCloset.brands count];
        
        return numRows;
    }
    


    
    return nil;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// tell the picker the title for a given component
/* - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
 {
 NSString *title;
 title = [@"" stringByAppendingFormat:@"%d",row];
 
 return title;
 }   */



- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view 
{
   
    UILabel *pickerLabel = (UILabel *)view;
    NSMutableArray *temparray;
    

    if (pickerView.tag == 901)
    {
        temparray = [[NSMutableArray alloc] init ];
        
        for(int x = 0; x<[myCloset.categories count]; x++)
        {
            Category *tempcat = [myCloset.categories objectAtIndex:x];
            [temparray addObject:tempcat.categoryname];
        }
    }
    
    if (pickerView.tag == 902)
    {
        temparray = [[NSMutableArray alloc] init ];
        
        Category *tempcat = [myCloset.categories objectAtIndex:currentcatnum];
        
        
        for(int x = 0; x<[tempcat.racksarray count]; x++)
        {
            Rack *temprack = [tempcat.racksarray objectAtIndex:x];
            [temparray addObject:temprack.rackname];
        }
    }
    if (pickerView.tag == 903) 
    {
        temparray = myCloset.occasions;
    }
    if (pickerView.tag == 904) 
    {
        temparray = myCloset.colors;
    }

    if (pickerView.tag == 905) 
    {
        temparray = myCloset.brands;
    }
    
    
    
    
    
    

        if (pickerLabel == nil) 
        {
            CGRect frame = CGRectMake(0.0, 0.0, 200, 40);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:UITextAlignmentLeft];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
             [pickerLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:44]];
        }
        
        
        [pickerLabel setText:[temparray objectAtIndex:row]];
        
    
    

    
    return pickerLabel;
    
    
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component 
{
    int sectionWidth = 300;
    
    return sectionWidth;
}

















-(UIView *) retrieveView: (int) findviewtag
{
    for(int x = 0; x < [self.view.subviews count]; ++x)
    {
        UIView *tempview = [self.view.subviews objectAtIndex:x];
        if (tempview.tag == findviewtag)
        {
            return tempview;
        }
        
    }
    return nil;
}



- (void)keyboardDidShow: (NSNotification *) notif
{

    if(shiftlocked  == FALSE)
    {
        CGPoint positionWithKeyboard = CGPointMake(self.view.center.x, self.view.center.y);
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        self.view.center = positionWithKeyboard;
        
        [UIView commitAnimations];
        
    }
 
}

- (void)keyboardDidHide: (NSNotification *) notif
{

    
    if(shiftlocked == FALSE)
    {
        
        NSLog(@"shifting back down!");
        
        CGPoint originalPositon = CGPointMake(self.view.center.x, self.view.center.y);
        [UIView beginAnimations:@"rearranging tiles" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        
        self.view.center = originalPositon;
        
        [UIView commitAnimations];
        
        
    }
    
    shiftlocked = FALSE;
        
}




NSString *pathfullcloset;

NSString *pathhomelitecloset;
NSString *pathbackupclosetzip;
NSString *pathhomebackupcloset;

Closet *fullCloset;

NSString *pathlitecloset;
NSString *pathhomelitecloset;
NSString *pathliteclosetzip;
Closet *liteCloset;


-(void) unzipLiteCloset
{
    
    NSFileManager *filemgr;
  
    
    filemgr =[NSFileManager defaultManager];
    
    pathhomelitecloset = [pathhome stringByAppendingPathComponent:@"Lite"];
    
    pathliteclosetzip = [pathhome stringByAppendingPathComponent:@"litecloset.zip"];
    
    
    if([filemgr fileExistsAtPath:pathliteclosetzip])
    {
        NSLog(@"lite zip exists!");
       // [SSZipArchive unzipFileAtPath:pathliteclosetzip toDestination:pathhomelitecloset];
        
        ZipArchive *unzipper = [[ZipArchive alloc] init];
        
        [unzipper UnzipOpenFile:pathliteclosetzip];
        [unzipper UnzipFileTo:pathhomelitecloset overWrite:YES];
        [unzipper UnzipCloseFile];
        
        [self loadLiteData];

    }
    else
    {
        NSLog(@"FINISHED LOAD rackscrolls subview count is %i point B", [racksScroll.subviews count]);
        NSLog(@"no lite zip exists!");
        
    }
    
    }

-(void) loadLiteData
{
    
    pathlitecloset = [pathhomelitecloset stringByAppendingPathComponent:@"closet.arch"];
    
    NSLog(@"%@ is pathlitecloset", pathlitecloset);
    
    liteCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlitecloset];
    
    if (!liteCloset)
    {
        NSLog(@"please copy lite data first");
    }
    else{
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        NSLog(@"lite closet found, adding closet!!!!");
        [self addLiteCloset];
    }

}

-(void) backupLiteCloset
{
    pathhomelitecloset = [pathhome stringByAppendingPathComponent:@"Lite"];
    
    pathliteclosetzip = [pathhome stringByAppendingPathComponent:@"litecloset.zip"];
    
    NSMutableArray *inputPaths = [[NSMutableArray alloc] init];
    
    [inputPaths addObject:mixerController.pathcloset]; //ADD closet.arch file!
    
    
    for(int y=0; y<[myCloset.categories count]; y++)
    {
        
        Category *tempcategory = [myCloset.categories objectAtIndex:y];
        
        for (int x = 0; x < [tempcategory.racksarray count]; ++x)
        {
            Rack * temprack;
            temprack = [tempcategory.racksarray objectAtIndex:x];
            
            for(int z=0; z< [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                
                //change record number
                
                [inputPaths addObject:temprecord.imageFilePath];
                [inputPaths addObject:temprecord.imageFilePathBest];
                [inputPaths addObject:temprecord.imageFilePathThumb];
                
                NSString *pathadded = [inputPaths objectAtIndex:inputPaths.count -1];
                
                NSLog(@"%@", pathadded);
            }
            
        }
        
    }
    
    
    //SSZipArchive *sszip = [[SSZipArchive alloc] init];
   // [SSZipArchive createZipFileAtPath:pathliteclosetzip withFilesAtPaths:inputPaths];

}

-(void) addLiteCloset
{
    
     NSFileManager *fm = [[NSFileManager alloc] init];

    for(int y=0; y<[liteCloset.categories count]; y++)
    {
        
        Category *tempcategory = [liteCloset.categories objectAtIndex:y];
        
        for (int x = 0; x < [tempcategory.racksarray count]; ++x)
        {
            Rack * temprack;
            temprack = [tempcategory.racksarray objectAtIndex:x];
            
            for(int z=0; z< [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                
                
                
                
                NSString *newLiteShortImageFilePathBest = [NSString stringWithFormat:@"Documents/Lite/%db.png",temprecord.fileNumRef];
                
                NSString *newLiteShortImageFilePath = [NSString stringWithFormat:@"Documents/Lite/%d.png",temprecord.fileNumRef];
                
                NSString *newLiteShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/Lite/%dt.png",temprecord.fileNumRef];
                
                
                
                
                NSString  *newLiteImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newLiteShortImageFilePathBest];
                NSString  *newLiteImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newLiteShortImageFilePath];
                NSString  *newLiteImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newLiteShortImageFilePathThumb];
                
                 //change record number
                
                
                if(!(lastImageNumArch = [NSKeyedUnarchiver unarchiveObjectWithFile:pathlastimagenum]))
                {
                    imageFileNum = 1;
                }
                else
                {
                    imageFileNum = [lastImageNumArch intValue];
                    ++imageFileNum;
                }
                
                
                lastImageNumArch = [NSNumber numberWithInt:imageFileNum];
                [NSKeyedArchiver archiveRootObject:lastImageNumArch toFile:pathlastimagenum];
                
                
                
                temprecord.fileNumRef = imageFileNum;
                
                
                
                //create new image file names
                
                
                NSString *newShortImageFilePathBest = [NSString stringWithFormat:@"Documents/%db.png",temprecord.fileNumRef];
                
                NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",temprecord.fileNumRef];
                
                NSString *newShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dt.png",temprecord.fileNumRef];
                
                
                
                
                NSString  *newImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathBest];
                NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
                NSString  *newImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathThumb];
                

                
                //copy image files from lite folder to root documents folder with new number
               
                
                [fm copyItemAtPath:newLiteImageFilePath toPath:newImageFilePath error:nil];
                
                [fm copyItemAtPath:newLiteImageFilePathBest toPath:newImageFilePathBest error:nil];
                
                [fm copyItemAtPath:newLiteImageFilePathThumb toPath:newImageFilePathThumb error:nil];
                
                [fm removeItemAtPath:newLiteImageFilePath error:nil];
                [fm removeItemAtPath:newLiteImageFilePathBest error:nil];
                [fm removeItemAtPath:newLiteImageFilePathThumb error:nil];
                
                NSLog(@"files copied to new paths with new numbers");
                
                //change record to reflect new names and path
                
                temprecord.imageFilePath = newImageFilePath;
                temprecord.imageFilePathBest = newImageFilePathBest;
                temprecord.imageFilePathThumb = newImageFilePathThumb;
                
                
                
                NSLog(@"updated path is %@", temprecord.imageFilePathBest);
                NSLog(@"updated path is  %@", temprecord.imageFilePath);
                NSLog(@"updated path is %@", temprecord.imageFilePathThumb);
                
                
                //add rack and details from record to myCloset
                
                NSLog(@"category type for this record is %i", temprecord.categoryType);
                
                [myCloset printSomething];
                
                NSLog(@"item category isssssssss!!! %@, %@", temprecord.catName, temprecord.catName);
                
                if(![myCloset doesRack:temprecord.rackName existInCategoryName:temprecord.catName])
                {
                    
                    int t;
                    
                    for (int x=0; x < [myCloset.categories count]; x++)
                    {
                        Category *tempc = [myCloset.categories objectAtIndex:x];
                        if ([tempc.categoryname compare:temprecord.catName] == NSOrderedSame)
                        {
                            NSLog(@"x is %i, names match, %@ is temp cat, %@ is temprecord", x, tempc.categoryname, temprecord.catName);
                            
                            t=x;
                            
                            break;
                        }
                    }
                    
                    NSLog(@"rack does not exist!, adding! %@", temprecord.rackName);
                    [myCloset addNewRack:temprecord.rackName toCatNum:t];
                    
                    
                }
                else {
                    NSLog(@"rack exists! no need to add it");
                }
                
                
                if(![myCloset doesDetail:temprecord.color existIn:myCloset.colors])
                {
                    [myCloset addItem:temprecord.color toDescriptionCat:@"colors"];
                }
                else { NSLog(@"color exists"); }
                
                if(![myCloset doesDetail:temprecord.brand existIn:myCloset.brands])
                {
                    [myCloset addItem:temprecord.brand toDescriptionCat:@"brands"];
                }
                else { NSLog(@"brand exists"); }
                
                if(![myCloset doesDetail:temprecord.occasion existIn:myCloset.occasions])
                {
                    [myCloset addItem:temprecord.occasion toDescriptionCat:@"occasions"];
                }
                else { NSLog(@"occasion exists"); }
                
                [self addItem:temprecord toCat:temprecord.catName toRack:temprecord.rackName];
         
            }
      
        }
        
    }
    
    
    
    
    
     [fm removeItemAtPath:pathlitecloset error:nil];
     [fm removeItemAtPath:pathliteclosetzip error:nil];
    
    mixerController.topChanged = YES;
    mixerController.rightChanged = YES;
    mixerController.lowerChanged = YES;
    mixerController.topOverlayChanged = YES;
    mixerController.accessoriesChanged = YES;
    
    
    [self loadVerticalArchiveInViewInScroll:racksScroll];
    
    [self loadImagesInTileScroll];
    
}


-(void) clearCloset
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appDelegate.mixerController;
    
    mixerController.myCloset = [[Closet alloc] initWithRacksRestore];
    
    [mixerController.myCloset saveClosetArchive];
    
    
    
    
    NSLog(@"CLOSET IDENTITY after clear %@", mixerController.myCloset.closetIdentity);
    
    
    
    NSString *extension = @"png";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    
    NSLog(@"cleared closet");
    
    
    
}

-(void) restoreFullCloset
{

    NSLog(@"organizer controller restoring full closet");
    NSFileManager *filemgr;
    
    
    filemgr =[NSFileManager defaultManager];
    
    pathhomebackupcloset = [pathhome stringByAppendingPathComponent:@"Backup"];
    
    pathbackupclosetzip = [pathhome stringByAppendingPathComponent:@"restoreMyCloset.zip"];
    
    
    if([filemgr fileExistsAtPath:pathbackupclosetzip])
    {
        
        [self clearCloset];
        NSLog(@"restoremycloset.zip exists!");
        //[SSZipArchive unzipFileAtPath:pathbackupclosetzip toDestination:pathhomebackupcloset];
        
        ZipArchive *unzipper = [[ZipArchive alloc] init];
        
        [unzipper UnzipOpenFile:pathbackupclosetzip];
        [unzipper UnzipFileTo:pathhomebackupcloset overWrite:YES];
        [unzipper UnzipCloseFile];
        
        [self loadFullData];
        
    }
    else
    {
        NSLog(@"no backup zip exists!");
    }
    
}

-(void) loadFullData
{
    
    pathfullcloset = [pathhomebackupcloset stringByAppendingPathComponent:@"closet.arch"];
    
    NSLog(@"%@ is pathhomebackupcloset", pathfullcloset);
    
    fullCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathfullcloset];
    
    if (!fullCloset)
    {
        NSLog(@"please add full closet data file first");
    }
    else{
        
        
        NSLog(@"full backup closet found, adding closet!!!!");
        [self addFullCloset];
    }
    
}


-(void) addFullCloset

{
    
    pathcloset = [pathhome stringByAppendingPathComponent:mixerController.currentUser.closetfile];
    
    int largestrecordnumber = 0;
    
    myCloset = mixerController.myCloset;
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    for(int y=0; y<[fullCloset.categories count]; y++)
    {
        
        Category *tempcategory = [fullCloset.categories objectAtIndex:y];
        
        for (int x = 0; x < [tempcategory.racksarray count]; ++x)
        {
            Rack * temprack;
            temprack = [tempcategory.racksarray objectAtIndex:x];
            
            for(int z=0; z< [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                
                if (temprecord.fileNumRef > largestrecordnumber)
                {
                    largestrecordnumber = temprecord.fileNumRef;
                }
                
                
                NSString *newBackupShortImageFilePathBest = [NSString stringWithFormat:@"Documents/Backup/%db.png",temprecord.fileNumRef];
                
                NSString *newBackupShortImageFilePath = [NSString stringWithFormat:@"Documents/Backup/%d.png",temprecord.fileNumRef];
                
                NSString *newBackupShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/Backup/%dt.png",temprecord.fileNumRef];
                
                
                
                
                NSString  *newBackupImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newBackupShortImageFilePathBest];
                NSString  *newBackupImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newBackupShortImageFilePath];
                NSString  *newBackupImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newBackupShortImageFilePathThumb];
                
                //change record number
                
            
                
                
                //create new image file names
                
                
                NSString *newShortImageFilePathBest = [NSString stringWithFormat:@"Documents/%db.png",temprecord.fileNumRef];
                
                NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",temprecord.fileNumRef];
                
                NSString *newShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dt.png",temprecord.fileNumRef];
                
                
                
                
                
                NSString  *newImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathBest];
                NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
                NSString  *newImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathThumb];
                
                
                
                //copy image files from lite folder to root documents folder with new number
                NSLog(@"before 1st copyitem");
                
                [fm copyItemAtPath:newBackupImageFilePath toPath:newImageFilePath error:nil];
                
                NSLog(@"before 2nd copyitem");
                
                [fm copyItemAtPath:newBackupImageFilePathBest toPath:newImageFilePathBest error:nil];
                NSLog(@"before 3rd copyitem");
                [fm copyItemAtPath:newBackupImageFilePathThumb toPath:newImageFilePathThumb error:nil];
                NSLog(@"before 4th copyitem");
                
                [fm copyItemAtPath:pathfullcloset toPath:pathcloset error:nil];
                
                [fm removeItemAtPath:newBackupImageFilePath error:nil];
                [fm removeItemAtPath:newBackupImageFilePathBest error:nil];
                [fm removeItemAtPath:newBackupImageFilePathThumb error:nil];
                
                NSLog(@"files copied to new paths with new numbers");
                
                //change record to reflect new names and path
                
                temprecord.imageFilePath = newImageFilePath;
                temprecord.imageFilePathBest = newImageFilePathBest;
                temprecord.imageFilePathThumb = newImageFilePathThumb;
                
                
                
                NSLog(@"updated path is %@", temprecord.imageFilePathBest);
                NSLog(@"updated path is  %@", temprecord.imageFilePath);
                NSLog(@"updated path is %@", temprecord.imageFilePathThumb);
           
            }
            
        }
        
    }
    
    
    [fm removeItemAtPath:pathfullcloset error:nil];
    [fm removeItemAtPath:pathbackupclosetzip error:nil];
    
    
    
    
    for(int y=0; y<[fullCloset.outfitsArray count]; y++)
    {
        
        
        
        for (int x = 0; x < [fullCloset.outfitsArray count]; ++x)
        {
            ImageRecord *tempoutfit = [fullCloset.outfitsArray objectAtIndex:x];
            
            if (tempoutfit.fileNumRef > largestrecordnumber)
            {
                largestrecordnumber = tempoutfit.fileNumRef;
                
            }
            
            NSString *newOutfitBackupShortImageFilePath = [NSString stringWithFormat:@"Documents/Backup/%do.png",tempoutfit.fileNumRef];
            
            NSString *newOutfitBackupShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/Backup/%dot.png",tempoutfit.fileNumRef];
            
            
            
            
            NSString  *newOutfitBackupImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newOutfitBackupShortImageFilePath];
            NSString  *newOutfitBackupImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newOutfitBackupShortImageFilePathThumb];
            
            //change record number
            
            
            
            
            
            NSString *newOutfitShortImageFilePath = [NSString stringWithFormat:@"Documents/%do.png",tempoutfit.fileNumRef];
            
            NSString *newOutfitShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dot.png",tempoutfit.fileNumRef];
            
            
            
            
            
            NSString  *newOutfitImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newOutfitShortImageFilePath];
            NSString  *newOutfitImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newOutfitShortImageFilePathThumb];
      
            
            
            [fm copyItemAtPath:newOutfitBackupImageFilePath toPath:newOutfitImageFilePath error:nil];
            
    
            
            [fm copyItemAtPath:newOutfitBackupImageFilePathThumb toPath:newOutfitImageFilePathThumb error:nil];
            
            
            
            [fm removeItemAtPath:newOutfitBackupImageFilePath error:nil];
          
            [fm removeItemAtPath:newOutfitBackupImageFilePathThumb error:nil];
            
            
            
            
            tempoutfit.imageFilePath = newOutfitImageFilePath;
            tempoutfit.imageFilePathThumb = newOutfitImageFilePathThumb;
            
            
            NSLog(@"updated path is  %@", tempoutfit.imageFilePath);
            NSLog(@"updated path is %@", tempoutfit.imageFilePathThumb);
            
            
            
        }
        
    }
    
    
    [fullCloset saveClosetArchive];
    
    
    mixerController.myCloset = [NSKeyedUnarchiver unarchiveObjectWithFile:pathcloset];
    
    myCloset = mixerController.myCloset;
    

    
    NSLog(@"largest number is %i", largestrecordnumber);
    
    lastImageNumArch = [NSNumber numberWithInt:largestrecordnumber];
    [NSKeyedArchiver archiveRootObject:lastImageNumArch toFile:pathlastimagenum];
    
    
    mixerController.topChanged = YES;
    mixerController.rightChanged = YES;
    mixerController.lowerChanged = YES;
    mixerController.topOverlayChanged = YES;
    mixerController.accessoriesChanged = YES;
    
}



int baseItemTwoMatchCount =0;

-(void) stepThroughClosetFind: (NSString *) cat
{
    BOOL foundSomething = NO;
    outfitComplete = NO;
    
    
    
    for(int y=0; y<[myCloset.categories count]; y++)
    {
        
        Category *tempcategory = [myCloset.categories objectAtIndex:y];
        
        if([tempcategory.categoryname compare:cat] == NSOrderedSame)
        {
        
            NSLog(@"%@ stepping", tempcategory.categoryname);
            
            
            
            int rackarraycount = [tempcategory.racksarray count];
            int tries = 0;
            
            NSUInteger r;
            
            while(!foundSomething && tries < 100)
            {
                tries++;
                NSLog(@"didn't find YET");
                r = arc4random_uniform(rackarraycount);
            
                NSLog(@"RANDOM rack %i", r);
            
                Rack * randomrack;
                randomrack = [tempcategory.racksarray objectAtIndex:r];
            
                if([randomrack.rackitemsarray count]> 0)
                {
                    foundSomething = YES;
                    
                    int rackitemscount = [randomrack.rackitemsarray count];
                
                    NSUInteger s = arc4random_uniform(rackitemscount);
                
                    NSLog(@"RANDOM item %i", s);
                    
                
                    tempMatch = [randomrack.rackitemsarray objectAtIndex:s];
                    
                    
                    
                    NSLog(@"%i %@ %@", tempMatch.fileNumRef, tempMatch.color, tempMatch.rackName);
                    
                    NSString *randomItem = [NSString stringWithFormat:@"%i %@ %@ ", tempMatch.fileNumRef, tempMatch.color, tempMatch.rackName];
                    
                    geniusHubLabel.text = [geniusHubLabel.text stringByAppendingString:randomItem];
                    
                    
                    UIImage *retrieveitemimage = [UIImage imageWithContentsOfFile:tempMatch.imageFilePath];
                    
                    if(!geniusItemOneFound)
                    {
                        geniusItemViewOne.image = retrieveitemimage;
                    }
                    else geniusItemViewTwo.image = retrieveitemimage;
                    
                    
                    if (!geniusItemOneFound){

                        [organizercontroller checkForMatchItemA:geniusItemBase.rackName ItemB:tempMatch.rackName ColorA:geniusItemBase.color ColorB:tempMatch.color Cat:tempMatch.catName ColorBar:100];
                    }
                    else{
                          [organizercontroller checkForMatchItemA:geniusItemOne.rackName ItemB:tempMatch.rackName ColorA:geniusItemOne.color ColorB:tempMatch.color Cat:tempMatch.catName ColorBar:100];
                    }
                   

                    
                    
                    
                }
        
            }
        }
    }

}





-(BOOL) checkForMatchItemA: (NSString *)itemA ItemB: (NSString *)itemB ColorA: (NSString *) colorA ColorB:(NSString *) colorB Cat: (NSString *) catB ColorBar: (int) x
{
    
    
    __block BOOL matchtrue;
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    //[myIndicator startAnimating];
    
    if ([catB compare:@"Bottoms"] == NSOrderedSame)
    {
        catB = @"b";
    }
    else if ([catB compare:@"Footwear"] == NSOrderedSame)
    {
        catB = @"f";
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/detcompreturn.php", mixerController.domain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    NSString *requestBodyString = [NSString stringWithFormat:@"itemA=%@&itemB=%@&colorA=%@&colorB=%@&catB=%@&colorbar=%i", itemA, itemB, colorA, colorB, catB, x];
    NSLog(@"%@", requestBodyString);
    
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"]; // added from first suggestion
    //NSURLResponse *response = NULL;
    //NSError *requestError = NULL;
    //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error){
        
        if ([data length] > 0 && error == nil)
        {
            
            //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            //[myIndicator stopAnimating];
            
            NSLog(@"something was downloaded");
            
            
            [self reactivateAllInView:self.view];
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            int z = [responseString intValue];
            
            NSLog(@"return string is %@", responseString);
            NSLog(@"return activity is %i", z);
            
            
            

            
            
            if (z==1)
            {
                matchtrue = TRUE;
                NSLog(@"found a match!");
                NSString *matchResult = [geniusHubLabel.text stringByAppendingString:@" good match\n"];
                geniusHubLabel.text = matchResult;
                
                
                if(!geniusItemOneFound)
                {
                    geniusItemOne = tempMatch;
                    NSLog(@"geniusItemOne is %@ %@", geniusItemOne.color, geniusItemOne.rackName);
                    geniusItemOneFound = YES;
                    organizercontroller.currentMatchCat = @"Footwear";
                    [self stepThroughClosetFind:@"Footwear"];
                    
                    
                }
                else if (geniusItemOneFound && !outfitComplete)
                {
                    geniusItemTwo = tempMatch;
                    NSLog(@"geniusItemTwo is %@ %@", geniusItemTwo.color, geniusItemTwo.rackName);
                    
                    if (!outfitComplete && !geniusBaseMatchingItemTwo)
                    {
                        geniusBaseMatchingItemTwo = YES;
                        [organizercontroller checkForMatchItemA:geniusItemBase.rackName ItemB:geniusItemTwo.rackName ColorA:geniusItemBase.color ColorB:geniusItemTwo.color Cat:geniusItemTwo.catName ColorBar:100];
                    }
                    else
                    {
                        NSLog(@"item two matches base, outfit complete");
                        outfitComplete = YES;
                        geniusBaseMatchingItemTwo = NO;
                        geniusItemTwoFound = NO;
                        geniusItemOneFound = NO;
                        NSLog(@"outfit complete");
                    }
                }
           
            
                
            }
            else { //if item fails
                
                if (!geniusBaseMatchingItemTwo)
                {
                    matchtrue = FALSE;
                    NSLog(@"no match");
                    NSString *matchResult = [geniusHubLabel.text stringByAppendingString:@" bad match\n"];
                    geniusHubLabel.text = matchResult;
                    NSLog(@"current match cat is %@", currentMatchCat);
                    [self stepThroughClosetFind:currentMatchCat];
                }
                else{
                    
                    NSLog(@"item 2 doesnt match base, try again");
                    outfitComplete = NO;
                    geniusBaseMatchingItemTwo = NO;
                    geniusItemTwoFound = NO;
                    geniusItemOneFound = NO;
                    
                    
                    currentMatchCat = startingMatchCat;
                    [self stepThroughClosetFind:startingMatchCat];
                   
                }
                
                
                
            }
            
            
            
            
        }
        else if ([data length] == 0 && error == nil)
        {
            
            
            
            
            
        }
        else if (error != nil)
        {
            
            
            
        }
    }];
    
    return matchtrue;
    
}




/*
-(void) addFullCloset
{
    
    myCloset = mixerController.myCloset;
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    for(int y=0; y<[fullCloset.categories count]; y++)
    {
        
        Category *tempcategory = [fullCloset.categories objectAtIndex:y];
        
        for (int x = 0; x < [tempcategory.racksarray count]; ++x)
        {
            Rack * temprack;
            temprack = [tempcategory.racksarray objectAtIndex:x];
            
            for(int z=0; z< [temprack.rackitemsarray count]; z++)
            {
                ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                
                
                
                
                NSString *newBackupShortImageFilePathBest = [NSString stringWithFormat:@"Documents/Backup/%db.png",temprecord.fileNumRef];
                
                NSString *newBackupShortImageFilePath = [NSString stringWithFormat:@"Documents/Backup/%d.png",temprecord.fileNumRef];
                
                NSString *newBackupShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/Backup/%dt.png",temprecord.fileNumRef];
                
                
                
                
                NSString  *newBackupImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newBackupShortImageFilePathBest];
                NSString  *newBackupImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newBackupShortImageFilePath];
                NSString  *newBackupImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newBackupShortImageFilePathThumb];
                
                //change record number
                
                temprecord.fileNumRef = imageFileNum;
                
                ++imageFileNum;
                
                lastImageNumArch = [NSNumber numberWithInt:imageFileNum];
                [NSKeyedArchiver archiveRootObject:lastImageNumArch toFile:pathlastimagenum];
                
                //create new image file names
                
                
                NSString *newShortImageFilePathBest = [NSString stringWithFormat:@"Documents/%db.png",temprecord.fileNumRef];
                
                NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",temprecord.fileNumRef];
                
                NSString *newShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dt.png",temprecord.fileNumRef];
                
                
                
                
                NSString  *newImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathBest];
                NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
                NSString  *newImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathThumb];
                
                
                
                //copy image files from lite folder to root documents folder with new number
                
                
                [fm copyItemAtPath:newBackupImageFilePath toPath:newImageFilePath error:nil];
                
                [fm copyItemAtPath:newBackupImageFilePathBest toPath:newImageFilePathBest error:nil];
                
                [fm copyItemAtPath:newBackupImageFilePathThumb toPath:newImageFilePathThumb error:nil];
                
                [fm removeItemAtPath:newBackupImageFilePath error:nil];
                [fm removeItemAtPath:newBackupImageFilePathBest error:nil];
                [fm removeItemAtPath:newBackupImageFilePathThumb error:nil];
                
                NSLog(@"files copied to new paths with new numbers");
                
                //change record to reflect new names and path
                
                temprecord.imageFilePath = newImageFilePath;
                temprecord.imageFilePathBest = newImageFilePathBest;
                temprecord.imageFilePathThumb = newImageFilePathThumb;
                
                
                
                NSLog(@"updated path is %@", temprecord.imageFilePathBest);
                NSLog(@"updated path is  %@", temprecord.imageFilePath);
                NSLog(@"updated path is %@", temprecord.imageFilePathThumb);
                
                
                //add rack and details from record to myCloset
                
                NSLog(@"category type for this record is %i", temprecord.categoryType);
                
                [myCloset printSomething];
                
                if(![myCloset doesRack:temprecord.rackName existInCategoryNum:temprecord.categoryType])
                {
                    NSLog(@"rack does not exist!, adding! %@", temprecord.rackName);
                    [myCloset addNewRack:temprecord.rackName toCatNum:temprecord.categoryType];
                }
                else {
                    NSLog(@"rack exists! no need to add it");
                }
                
                
                if(![myCloset doesDetail:temprecord.color existIn:myCloset.colors])
                {
                    [myCloset addItem:temprecord.color toDescriptionCat:@"colors"];
                }
                else { NSLog(@"color exists"); }
                
                if(![myCloset doesDetail:temprecord.brand existIn:myCloset.brands])
                {
                    [myCloset addItem:temprecord.brand toDescriptionCat:@"brands"];
                }
                else { NSLog(@"brand exists"); }
                
                if(![myCloset doesDetail:temprecord.occasion existIn:myCloset.occasions])
                {
                    [myCloset addItem:temprecord.occasion toDescriptionCat:@"occasions"];
                }
                else { NSLog(@"occasion exists"); }
                
                [self addItem:temprecord toCat:temprecord.catName toRack:temprecord.rackName];
                
                
                
            }
            
        }
        
    }
    [fm removeItemAtPath:pathfullcloset error:nil];
    [fm removeItemAtPath:pathbackupclosetzip error:nil];
    
    
    [myCloset saveClosetArchive];
    
    
    mixerController.topChanged = YES;
    mixerController.rightChanged = YES;
    mixerController.lowerChanged = YES;
    mixerController.topOverlayChanged = YES;
    mixerController.accessoriesChanged = YES;
    
}
*/









- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    //[self unzipLiteCloset];
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point G", [racksScroll.subviews count]);
}

-(void)viewDidAppear:(BOOL)animated
{
    if (mixerController.geniusMode == YES)
    {
        
        geniusMode = YES;
        [geniusHub setHidden:NO];
        
    }
    
     NSLog(@"FINISHED LOAD rackscrolls subview count is %i point G1", [racksScroll.subviews count]);
    if (mixerController.closetRestored == YES)
    {
        NSLog(@"FINISHED LOAD rackscrolls subview count is %i point H", [racksScroll.subviews count]);
        mixerController.closetRestored = NO;
        [self loadVerticalArchiveInViewInScroll:racksScroll];
        [self loadImagesInTileScroll];
        
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point I", [racksScroll.subviews count]);
    
    if (mixerController.topChanged == YES || mixerController.rightChanged == YES || mixerController.lowerChanged == YES || mixerController.topOverlayChanged == YES || mixerController.accessoriesChanged == YES)
    {
        mixerController.reloadarchives = YES;
        NSLog(@"something changed!");
        
         NSLog(@"start animate");
        [mixerController.myLoadIndicator startAnimating];
    }
   
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point J", [racksScroll.subviews count]);
 
    
	[super viewDidDisappear:animated];
}


- (void)viewDidUnload
{
    
    NSLog(@"FINISHED LOAD rackscrolls subview count is %i point K", [racksScroll.subviews count]);
   
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}







-(void) showImageToolBar
{
    

    
    if (!_imageToolBarOpen)
    {
        
        NSLog(@"hi, moving toolbar");
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            imageToolBar.frame = CGRectMake(imageToolBar.frame.origin.x, self.view.frame.size.height - 88, imageToolBar.frame.size.width, 44);
            
            
            
        } ];
        
        _imageToolBarOpen = YES;
        [imageToolBar setHidden:NO];
        
        racksScroll.userInteractionEnabled = NO;
        racksScroll.scrollEnabled= NO;
        rackTypeScroll.userInteractionEnabled = NO;
        tileScroll.userInteractionEnabled = NO;
    }
    
}

-(void) reactivateInterface
{

    
    racksScroll.userInteractionEnabled = YES;
    racksScroll.scrollEnabled = YES;
    rackTypeScroll.userInteractionEnabled = YES;
    tileScroll.userInteractionEnabled = YES;
}

-(IBAction) hideImageToolBar
{
    
    [self reactivateInterface];
    
    if(_imageToolBarOpen)
    {
        NSLog(@"hi, closing toolbar, reactivated everything!");
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [imageToolBar setHidden:YES];
            
            
            imageToolBar.frame = CGRectMake(imageToolBar.frame.origin.x, imageToolBar.frame.origin.y + imageToolBar.frame.size.height, imageToolBar.frame.size.width, imageToolBar.frame.size.height);
            
            
        } ];
    }
    
    _imageToolBarOpen = NO;
    [imageToolBar setHidden:YES];
    
    
}


@end
