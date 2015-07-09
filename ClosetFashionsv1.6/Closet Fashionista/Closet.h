//
//  Closet.h
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutfitRecord.h"

@interface Closet : NSObject <NSCoding, UITextFieldDelegate>
{
    NSMutableArray *categories;
    NSMutableArray *colors;
    NSMutableArray *occasions;
    NSMutableArray *brands;
    
    
    NSMutableArray *outfitsArray;
    NSMutableArray *outfitCategories;
    
    NSMutableArray *dateRecords;
    NSMutableArray *undeletable;
    
    BOOL didRectify;
    NSString *currentBackDrop;
    
    NSString *closetIdentity;
}
@property (nonatomic) BOOL didRectify;
@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *colors;
@property (nonatomic, retain) NSMutableArray *occasions;
@property (nonatomic, retain) NSMutableArray *brands;
@property (nonatomic, retain) NSMutableArray *undeletable;


@property (nonatomic, retain) NSMutableArray *outfitsArray;
@property (nonatomic, retain) NSMutableArray *outfitCategories;

@property (nonatomic, retain) NSMutableArray *dateRecords;

@property (nonatomic, retain) NSString *currentBackDrop;
@property (nonatomic, retain) NSString *closetIdentity;

-(BOOL) isItFixed: (NSString *) item;
-(void) sortRackArray: (NSMutableArray *) unsortedarray;
-(void) addItem: (NSString *) detail toDescriptionCat: (NSString *) descat;


-(void) removeItem: (int)removerownum fromDescriptor: (NSMutableArray *) array;

-(void) sortDateRecords;
-(void) sortStringArray: (NSMutableArray *) unsortedarray;
-(void) addDates: (NSMutableArray *) dates;
-(void) addDate:(NSDate *) d toOutfitNum: (int) outfitnum;
-(void) insertOutfitNum: (int) outfitnum toDates: (NSMutableArray *) dates;
-(void) removeOutfitNum: (int) outfitnum fromDates: (NSMutableArray *) dates;

-(void) textFieldShouldReturn:(UITextField *)textField;

-(Closet *) initWithRacks;
-(Closet *) initWithRacksRestore;
-(void) saveClosetArchive;
-(void) addNewRack: (NSString *) rackname toCatNum: (int) catnum;
-(void) addNewCategoryCallUp;
-(void) addNewCategory: (NSString *) name;
-(void) deleteCategory: (int) categorynumber;
-(void) listCategories;
-(void) rectifyImagePaths;
-(BOOL) needToRectify;
-(OutfitRecord *) retrieveOutfitNum: (int) x;
-(NSDate *) findLastWorn: (int) itemnum;
-(NSDate *) findNextWorn: (int) itemnum;
-(BOOL) isWornToday: (int) itemnum;


-(BOOL) doesDetail: (NSString *) itemdetail existIn: (NSMutableArray *) thisarray;
-(BOOL) doesRack: (NSString *) rackname existInCategoryNum: (int) x;
-(BOOL) doesRack: (NSString *) rackname existInCategoryName: (NSString *) cname;

-(void) printSomething;
@end
