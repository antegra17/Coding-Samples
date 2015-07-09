//
//  Closet.m
//  Closet Fashionista
//
//  Created by Anthony Tran on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Closet.h"
#import "Category.h"
#import "AppDelegate.h"
#import "OrganizerController.h"
#import "MixerController.h"

#import "DateRecord.h"


@implementation Closet


@synthesize categories, outfitsArray, outfitCategories, dateRecords, colors, occasions, brands, undeletable, didRectify, currentBackDrop, closetIdentity;


-(Closet *) initWithRacks
{
    didRectify = NO;
    
    closetIdentity = @"Original";
    
    categories = [[NSMutableArray alloc] init];
    outfitCategories = [[NSMutableArray alloc] init];
    colors = [[NSMutableArray alloc] init];
    occasions = [[NSMutableArray alloc] init];
    brands = [[NSMutableArray alloc] init];
    undeletable = [[NSMutableArray alloc] init];
    
    
    [undeletable addObject:@"N/A"];


    
    
    NSLog(@"running initwithracks closet!");
    [self addNewCategory:@"Tops"];
    [self addNewCategory:@"Dresses"];
    [self addNewCategory:@"Bottoms"];
    [self addNewCategory:@"Footwear"];
    [self addNewCategory:@"Outerwear"];
    [self addNewCategory:@"Accessories"];
    [self addNewCategory:@"Backdrops"];
    
    
    
     [self addNewRack:@"Professional" toCatNum: 6];
     [self addNewRack:@"Simple" toCatNum: 6];
     [self addNewRack:@"Playful" toCatNum: 6];
    
    
     [self addNewRack:@"Necklace" toCatNum: 5];
     [self addNewRack:@"Bracelet" toCatNum: 5];
     [self addNewRack:@"Earrings" toCatNum: 5];
     [self addNewRack:@"Scarf" toCatNum: 5];
    [self addNewRack:@"Handbag" toCatNum: 5];
    

    
    [self addNewRack:@"Jacket" toCatNum: 4];
    [self addNewRack:@"Coat" toCatNum: 4];
    [self addNewRack:@"Cardigan" toCatNum: 4];
    [self addNewRack:@"Sweater" toCatNum: 4];
    
    
    
    
    [self addNewRack:@"Blouse" toCatNum: 0];
    [self addNewRack:@"Jacket" toCatNum: 0];
    [self addNewRack:@"Dress shirt" toCatNum: 0];
    [self addNewRack:@"Short-sleeve" toCatNum: 0];
    [self addNewRack:@"T-shirt" toCatNum: 0];
    [self addNewRack:@"Halter-top" toCatNum: 0];
    [self addNewRack:@"Tank-top" toCatNum: 0];
    [self addNewRack:@"Polo" toCatNum: 0];
    [self addNewRack:@"Off-shoulder" toCatNum: 0];
 
    
    
    
    
    [self addNewRack:@"Cocktail dress" toCatNum: 1];
    [self addNewRack:@"Work dress" toCatNum: 1];
    [self addNewRack:@"Evening dress" toCatNum: 1];
    [self addNewRack:@"Maxi dress" toCatNum: 1];
    [self addNewRack:@"Casual dress" toCatNum: 1];
    
    
    [self addNewRack:@"Shorts" toCatNum: 2];
    [self addNewRack:@"Bermudas" toCatNum: 2];
    [self addNewRack:@"Capris" toCatNum: 2];
    [self addNewRack:@"Trousers" toCatNum: 2];
    [self addNewRack:@"Jeans" toCatNum: 2];
    [self addNewRack:@"Skirt" toCatNum: 2];
    [self addNewRack:@"Cargo-pants" toCatNum: 2];
    [self addNewRack:@"Leggings" toCatNum: 2];
    
    
    [self addNewRack:@"Running shoes" toCatNum: 3];
    [self addNewRack:@"Heels" toCatNum: 3];
    [self addNewRack:@"Flats" toCatNum: 3];
    [self addNewRack:@"Flip-flops" toCatNum: 3];
    [self addNewRack:@"Sandals" toCatNum: 3];
     [self addNewRack:@"Wedge shoes" toCatNum: 3];
     [self addNewRack:@"Boots" toCatNum: 3];
     [self addNewRack:@"Mules" toCatNum: 3];
     [self addNewRack:@"Pumps" toCatNum: 3];


    
    [colors addObject:@"Black"];
    [colors addObject:@"Blue"];
    [colors addObject:@"Red"];
    [colors addObject:@"Gray"];
    [colors addObject:@"Green"];
    [colors addObject:@"Pink"];
    [colors addObject:@"Yellow"];
    [colors addObject:@"Orange"];
    [colors addObject:@"Purple"];
    [colors addObject:@"Brown"];
    [colors addObject:@"White"];
   
    
   
    [brands addObject:@"Gap"];
    [brands addObject:@"M)phosis"];
    [brands addObject:@"Warehouse"];
    [brands addObject:@"Calvin Klein"];
    [brands addObject:@"DKNY"];
    [brands addObject:@"Ann Taylor"];
    [brands addObject:@"Tommy Hilfiger"];
    [brands addObject:@"Mango"];
    [brands addObject:@"Zara"];
    [brands addObject:@"Miss Sixty"];
    [brands addObject:@"Uniqlo"];
    [brands addObject:@"Old Navy"];
    [brands addObject:@"A&F"];
    [brands addObject:@"Gucci"];
    [brands addObject:@"Prada"];
    [brands addObject:@"Levi's"];
    [brands addObject:@"Quiksilver"];
    [brands addObject:@"Billabong"];
    [brands addObject:@"Forever 21"];
    [brands addObject:@"Raoul"];
    [brands addObject:@"Nike"];
    [brands addObject:@"Pazzion"];
    [brands addObject:@"Charles & Keith"];

    [occasions addObject:@"Work"];
    [occasions addObject:@"Gym"];
    [occasions addObject:@"Beach"];
    [occasions addObject:@"Casual"];
    [occasions addObject:@"Clubbing"];
    
    [outfitCategories addObject:@"Business"];
    [outfitCategories addObject:@"Casual"];
    [outfitCategories addObject:@"Night-life"];
   
    
    
     
    
    [self sortStringArray:colors];
    [self sortStringArray:brands];
    [self sortStringArray:occasions];
    [brands insertObject:@"N/A" atIndex:0];
    [occasions insertObject:@"N/A" atIndex:0];

    
    
    /*
    
    NSString *teststring;
    
    teststring = [undeletable objectAtIndex:1];
    
    NSLog(@"%@", teststring);
    
    teststring = @"changed";
    
    NSString *teststring2;
    
    teststring2 = [undeletable objectAtIndex:1];
    NSLog(@"teststring 1 is %@", teststring);
    NSLog(@"%@ after change", teststring2);
    
    Rack *testrack = [[Rack alloc] initRack];
    
    testrack.rackname = @"rack1";
    
    [undeletable addObject:testrack];
    
    Rack *testrack2 = [[Rack alloc] initRack];
    testrack2 = [undeletable objectAtIndex:7];
    
    NSLog(@"testrack2 name is %@", testrack2.rackname);
    
    testrack2.rackname = @"changed";
    
        NSLog(@"testrack2 name is %@", testrack2.rackname);
    
    Rack *testrack3 = [undeletable objectAtIndex:7];
        
        NSLog(@"testrack2 name is %@", testrack2.rackname);
        NSLog(@"testrack3 name is %@", testrack3.rackname);
     */
    
    return self;
}


-(Closet *) initWithRacksRestore
{
    didRectify = NO;
    
    closetIdentity = @"Restore";
    
    categories = [[NSMutableArray alloc] init];
    outfitCategories = [[NSMutableArray alloc] init];
    colors = [[NSMutableArray alloc] init];
    occasions = [[NSMutableArray alloc] init];
    brands = [[NSMutableArray alloc] init];
    undeletable = [[NSMutableArray alloc] init];
    
    
    [undeletable addObject:@"N/A"];
    
    
    
    
    NSLog(@"running initwithracks closet!");
    [self addNewCategory:@"Tops"];
    [self addNewCategory:@"Dresses"];
    [self addNewCategory:@"Bottoms"];
    [self addNewCategory:@"Footwear"];
    [self addNewCategory:@"Outerwear"];
    [self addNewCategory:@"Accessories"];
    [self addNewCategory:@"Backdrops"];
    
    
    
    [self addNewRack:@"Professional" toCatNum: 6];
    [self addNewRack:@"Simple" toCatNum: 6];
    [self addNewRack:@"Playful" toCatNum: 6];
    
    
    [self addNewRack:@"Necklace" toCatNum: 5];
    [self addNewRack:@"Bracelet" toCatNum: 5];
    [self addNewRack:@"Earrings" toCatNum: 5];
    [self addNewRack:@"Scarf" toCatNum: 5];
    [self addNewRack:@"Handbag" toCatNum: 5];
    
    
    
    [self addNewRack:@"Jacket" toCatNum: 4];
    [self addNewRack:@"Coat" toCatNum: 4];
    [self addNewRack:@"Cardigan" toCatNum: 4];
    [self addNewRack:@"Sweater" toCatNum: 4];
    
    
    
    
    [self addNewRack:@"Blouse" toCatNum: 0];
    [self addNewRack:@"Jacket" toCatNum: 0];
    [self addNewRack:@"Dress shirt" toCatNum: 0];
    [self addNewRack:@"Short-sleeve" toCatNum: 0];
    [self addNewRack:@"T-shirt" toCatNum: 0];
    [self addNewRack:@"Halter-top" toCatNum: 0];
    [self addNewRack:@"Tank-top" toCatNum: 0];
    [self addNewRack:@"Polo" toCatNum: 0];
    [self addNewRack:@"Off-shoulder" toCatNum: 0];
    
    
    
    
    
    [self addNewRack:@"Cocktail dress" toCatNum: 1];
    [self addNewRack:@"Work dress" toCatNum: 1];
    [self addNewRack:@"Evening dress" toCatNum: 1];
    [self addNewRack:@"Maxi dress" toCatNum: 1];
    [self addNewRack:@"Casual dress" toCatNum: 1];
    
    
    [self addNewRack:@"Shorts" toCatNum: 2];
    [self addNewRack:@"Bermudas" toCatNum: 2];
    [self addNewRack:@"Capris" toCatNum: 2];
    [self addNewRack:@"Trousers" toCatNum: 2];
    [self addNewRack:@"Jeans" toCatNum: 2];
    [self addNewRack:@"Skirt" toCatNum: 2];
    [self addNewRack:@"Cargo-pants" toCatNum: 2];
    [self addNewRack:@"Leggings" toCatNum: 2];
    
    
    [self addNewRack:@"Running shoes" toCatNum: 3];
    [self addNewRack:@"Heels" toCatNum: 3];
    [self addNewRack:@"Flats" toCatNum: 3];
    [self addNewRack:@"Flip-flops" toCatNum: 3];
    [self addNewRack:@"Sandals" toCatNum: 3];
    [self addNewRack:@"Wedge shoes" toCatNum: 3];
    [self addNewRack:@"Boots" toCatNum: 3];
    [self addNewRack:@"Mules" toCatNum: 3];
    [self addNewRack:@"Pumps" toCatNum: 3];
    
    
    
    [colors addObject:@"Black"];
    [colors addObject:@"Blue"];
    [colors addObject:@"Red"];
    [colors addObject:@"Gray"];
    [colors addObject:@"Green"];
    [colors addObject:@"Pink"];
    [colors addObject:@"Yellow"];
    [colors addObject:@"Orange"];
    [colors addObject:@"Purple"];
    [colors addObject:@"Brown"];
    [colors addObject:@"White"];
    
    
    
    [brands addObject:@"Gap"];
    [brands addObject:@"M)phosis"];
    [brands addObject:@"Warehouse"];
    [brands addObject:@"Calvin Klein"];
    [brands addObject:@"DKNY"];
    [brands addObject:@"Ann Taylor"];
    [brands addObject:@"Tommy Hilfiger"];
    [brands addObject:@"Mango"];
    [brands addObject:@"Zara"];
    [brands addObject:@"Miss Sixty"];
    [brands addObject:@"Uniqlo"];
    [brands addObject:@"Old Navy"];
    [brands addObject:@"A&F"];
    [brands addObject:@"Gucci"];
    [brands addObject:@"Prada"];
    [brands addObject:@"Levi's"];
    [brands addObject:@"Quiksilver"];
    [brands addObject:@"Billabong"];
    [brands addObject:@"Forever 21"];
    [brands addObject:@"Raoul"];
    [brands addObject:@"Nike"];
    [brands addObject:@"Pazzion"];
    [brands addObject:@"Charles & Keith"];
    
    [occasions addObject:@"Work"];
    [occasions addObject:@"Gym"];
    [occasions addObject:@"Beach"];
    [occasions addObject:@"Casual"];
    [occasions addObject:@"Clubbing"];
    
    [outfitCategories addObject:@"Business"];
    [outfitCategories addObject:@"Casual"];
    [outfitCategories addObject:@"Night-life"];
    
    
    
    
    
    [self sortStringArray:colors];
    [self sortStringArray:brands];
    [self sortStringArray:occasions];
    [brands insertObject:@"N/A" atIndex:0];
    [occasions insertObject:@"N/A" atIndex:0];
    
    
    
    /*
     
     NSString *teststring;
     
     teststring = [undeletable objectAtIndex:1];
     
     NSLog(@"%@", teststring);
     
     teststring = @"changed";
     
     NSString *teststring2;
     
     teststring2 = [undeletable objectAtIndex:1];
     NSLog(@"teststring 1 is %@", teststring);
     NSLog(@"%@ after change", teststring2);
     
     Rack *testrack = [[Rack alloc] initRack];
     
     testrack.rackname = @"rack1";
     
     [undeletable addObject:testrack];
     
     Rack *testrack2 = [[Rack alloc] initRack];
     testrack2 = [undeletable objectAtIndex:7];
     
     NSLog(@"testrack2 name is %@", testrack2.rackname);
     
     testrack2.rackname = @"changed";
     
     NSLog(@"testrack2 name is %@", testrack2.rackname);
     
     Rack *testrack3 = [undeletable objectAtIndex:7];
     
     NSLog(@"testrack2 name is %@", testrack2.rackname);
     NSLog(@"testrack3 name is %@", testrack3.rackname);
     */
    
    return self;
}


-(BOOL) isItFixed: (NSString *) item
{
    for (int x = 0; x< [undeletable count]; x++)
    {
        NSString *fixeditem = [undeletable objectAtIndex:x];
        
        NSLog(@"fixed: %@", fixeditem);
        if([item compare:fixeditem] == NSOrderedSame)
        {
            
            return true;
        }
    }
    return false;
}



-(BOOL) needToRectify
{
    
    BOOL itemExists;
    itemExists = NO;
    
    int existAtX;
    int existAtY;
    
    Rack * temprack;
    Category *tempcategory;
    
    for(int x=0; x < [self.categories count]; x++)
    {
        if (itemExists == YES) break;
        
        tempcategory = [self.categories objectAtIndex:x];
        
        for(int y=0; y < [tempcategory.racksarray count]; y++)
        {
            if (itemExists == YES) break;
            
            temprack = [tempcategory.racksarray objectAtIndex:y];
            
            if([temprack.rackitemsarray count] > 0)
            {
                existAtX = x;
                existAtY = y;
                itemExists = YES;
                NSLog(@"item exists at %i, %i", existAtX, existAtY);
            }
        }
    }
    
    
    if (itemExists == YES)
    {
        tempcategory = [self.categories objectAtIndex:existAtX];
        temprack = [tempcategory.racksarray objectAtIndex:existAtY];
        
        
        ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:0];
        
        
        
        NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",temprecord.fileNumRef];
        
        
        NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
        
        
        NSLog(@"old path %@", temprecord.imageFilePath);
        
        NSLog(@"new path %@", newImageFilePath);
        
        
        if([temprecord.imageFilePath compare:newImageFilePath] == NSOrderedSame)
            return NO;
        else return YES;
    }
    else
    {
        NSLog(@"no item exists");
        return NO;
    }
}


-(void) rectifyImagePaths
{
    for(int y=0; y<[self.categories count]; y++)
    {
        
        Category *tempcategory = [self.categories objectAtIndex:y];
        
            for (int x = 0; x < [tempcategory.racksarray count]; ++x)
            {
                Rack * temprack;
                temprack = [tempcategory.racksarray objectAtIndex:x];
                
                
                
                for(int z=0; z< [temprack.rackitemsarray count]; z++)
                {
                    ImageRecord *temprecord = [temprack.rackitemsarray objectAtIndex:z];
                    
                    NSString *newShortImageFilePathBest = [NSString stringWithFormat:@"Documents/%db.png",temprecord.fileNumRef];
                   
                    
                    NSString *newShortImageFilePath = [NSString stringWithFormat:@"Documents/%d.png",temprecord.fileNumRef];
                    
                    NSString *newShortImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dt.png",temprecord.fileNumRef];
                   
                    
                    
                    
                    
                    NSString  *newImageFilePathBest = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathBest];
                    NSString  *newImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePath];
                    NSString  *newImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortImageFilePathThumb];
                    
                   
                    
                    temprecord.imageFilePath = newImageFilePath;
                    temprecord.imageFilePathBest = newImageFilePathBest;
                    temprecord.imageFilePathThumb = newImageFilePathThumb;
                    
                    NSLog(@"update path %@", temprecord.imageFilePathBest);
                    NSLog(@"update path %@", temprecord.imageFilePath);
                    NSLog(@"update path %@", temprecord.imageFilePathThumb);
                    
                    
                }
                
                   
                    
            }
            
    }
    
    
    
    
    
     for(int y=0; y<[self.outfitsArray count]; y++)
     {
         OutfitRecord *temprecord = [self.outfitsArray objectAtIndex:y];
         
         NSString *newShortOutfitImageFilePath = [NSString stringWithFormat:@"Documents/%do.png",temprecord.fileNumRef];
         
         NSString *newShortOutfitImageFilePathThumb = [NSString stringWithFormat:@"Documents/%dot.png",temprecord.fileNumRef];
         
         NSString *newOutfitImageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:newShortOutfitImageFilePath];
         
         NSString *newOutfitImageFilePathThumb = [NSHomeDirectory() stringByAppendingPathComponent:newShortOutfitImageFilePathThumb];
         
         
         temprecord.imageFilePath = newOutfitImageFilePath;
         
         temprecord.imageFilePathThumb = newOutfitImageFilePathThumb;
         
         NSLog(@"new outfit path %@", temprecord.imageFilePath);
         NSLog(@"new outfit path thumb %@", temprecord.imageFilePathThumb);
         
     }

    [self saveClosetArchive];
}
        
    



-(void) addItem: (NSString *) detail toDescriptionCat: (NSString *) descat
{
    if(!colors)
    {
        colors = [[NSMutableArray alloc] init];
    }
    if(!occasions)
    {
        occasions = [[NSMutableArray alloc] init];
    }
    if(!brands)
    {
        brands = [[NSMutableArray alloc] init];
    }
    
    
    
    NSLog(@"final descat is %@", descat);
    
    if([descat compare:@"Color"] == NSOrderedSame)
    {
        [colors addObject:detail];
        [self sortStringArray:colors];
        
        NSLog(@"added %@ to %@", detail, descat);
        
    }
    if([descat compare:@"Occasion"] == NSOrderedSame)
    {
        [occasions addObject:detail];
        [self sortStringArray:occasions];
        NSLog(@"added %@ to %@", detail, descat);
        
    }
    if([descat compare:@"Brand"] == NSOrderedSame)
    {
        [brands addObject:detail];
        [self sortStringArray:brands];
        NSLog(@"added %@ to %@", detail, descat);
    }
    
   [self saveClosetArchive];
    
}

-(void) sortStringArray: (NSMutableArray *) unsortedarray
{
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    
    BOOL hasNA;
    hasNA = FALSE;
    
    
    for(int x=0; x<[unsortedarray count]; x++)
    {
        NSString *itemtosort =  [unsortedarray objectAtIndex:x];
        
        NSLog(@"sorting %@", itemtosort);
        
        if(x == 0)
        {
            [sortedArray addObject:itemtosort];
            continue; //skip rest, next loop iteration starts
        }
        
        int h;
        if(hasNA== TRUE) h=1; else h=0;
        
        for(int y = h; y<[sortedArray count]; y++)
        {
            
            NSString *itemtocompare;
            NSString *itemtocomparenext;
            
            itemtocompare = [sortedArray objectAtIndex:y];
            if([itemtocompare compare:@"N/A"] == NSOrderedSame)
            {
                [sortedArray addObject:itemtosort];
                hasNA= TRUE;
                break;
            }
            else if([itemtosort compare:itemtocompare] == NSOrderedAscending)   //e.g. itemtosort is a, itemtocompare b
            {
                [sortedArray insertObject:itemtosort atIndex:y];
                break;
                
            }
            else if(y == [sortedArray count] - 1)
            {
                if ([itemtosort compare:itemtocompare] == NSOrderedAscending)
                {
                    [sortedArray insertObject:itemtosort atIndex:y];
                    
                }
                
                if ([itemtosort compare:itemtocompare] == NSOrderedDescending)
                {
                    [sortedArray addObject:itemtosort];
                    
                }
                
                break;
            }
            else
            {
                
                itemtocomparenext = [sortedArray objectAtIndex:y+1];
                
                if([itemtosort compare:itemtocompare] == NSOrderedAscending &&
                   [itemtosort compare:itemtocomparenext] == NSOrderedDescending)
                    
                {
                    [sortedArray insertObject:itemtosort atIndex:y+1];
                    break;
                }
                
                if([itemtosort compare:itemtocompare] == NSOrderedSame)
                {
                    break;
                }
            }
            
            
        }
        
        
    }
    
    [unsortedarray removeAllObjects];
    [unsortedarray addObjectsFromArray:sortedArray];
    [sortedArray removeAllObjects];

    
    [self saveClosetArchive];
    

    
}

-(void) sortRackArray: (NSMutableArray *) unsortedarray
{
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    
    
    for(int x=0; x<[unsortedarray count]; x++)
    {
        Rack *racktosort  = [unsortedarray objectAtIndex:x];
        
        
        NSString *itemtosort =  racktosort.rackname;
        
        NSLog(@"sorting %@", itemtosort);
        
        if(x == 0)
        {
            [sortedArray addObject:racktosort];
            continue; //skip rest, next loop iteration starts
        }
        
        for(int y=0; y<[sortedArray count]; y++)
        {
              Rack *racktocompare  = [sortedArray objectAtIndex:y];
              
            NSString *itemtocompare;
            NSString *itemtocomparenext;
            
            itemtocompare = racktocompare.rackname;
            
            if([itemtosort compare:itemtocompare] == NSOrderedAscending)
            {
                [sortedArray insertObject:racktosort atIndex:y];
                break;
                
            }
            else if(y == [sortedArray count] - 1)
            {
                if ([itemtosort compare:itemtocompare] == NSOrderedAscending)
                {
                    [sortedArray insertObject:racktosort atIndex:y];
                    
                }
                
                if ([itemtosort compare:itemtocompare] == NSOrderedDescending)
                {
                    [sortedArray addObject:racktosort];
                    
                }
                
                break;
            }
            else
            {
                Rack *racktocomparenext  = [sortedArray objectAtIndex:y+1];
                itemtocomparenext = racktocomparenext.rackname;
                
                if([itemtosort compare:itemtocompare] == NSOrderedAscending &&
                   [itemtosort compare:itemtocomparenext] == NSOrderedDescending)
                    
                {
                    [sortedArray insertObject:racktosort atIndex:y+1];
                    break;
                }
                
                if([itemtosort compare:itemtocompare] == NSOrderedSame)
                {
                    break;
                }
            }
            
            
        }
        
        
    }
    
    [unsortedarray removeAllObjects];
    [unsortedarray addObjectsFromArray:sortedArray];
    [sortedArray removeAllObjects];
    
    
    [self saveClosetArchive];
    
    
    
}




-(void) removeItem: (int) removerownum fromDescriptor: (NSMutableArray *) array
{
    if([array count] > 0)
    {
        [array removeObjectAtIndex:removerownum];
    }
    
    [self saveClosetArchive];
}



-(void) addDates: (NSMutableArray *) dates
{
    
    if(!dateRecords)
    {
      dateRecords = [[NSMutableArray alloc] init];
    }
    
    
    NSLog(@"dates count is    %i", [dates count]);
    
    for(int x=0; x<[dates count]; x++)
    {
        DateRecord *daterecord = [[DateRecord alloc] init];
        
        daterecord.date = [dates objectAtIndex:x];
        
        [dateRecords addObject:daterecord];
        
        
        NSLog(@"NEWLY ADDED TO DATE RECORDS %@",daterecord.date);
    }
    
    
    NSLog(@"all daterecords with just added dates:");
    
    for(int x=0; x<[dateRecords count]; x++)
    {
        DateRecord *daterecordverify = [[DateRecord alloc] init];
        
        daterecordverify = [dateRecords objectAtIndex:x];
        
        NSLog(@"%@", daterecordverify.date);
        
    }
    
    [self sortDateRecords];
    [self saveClosetArchive];
}




-(void) addDate:(NSDate *) d toOutfitNum: (int) outfitnum
{
    for (int x=0; x<[outfitsArray count]; x++)
    {
        OutfitRecord *outfitRetrieve = [outfitsArray objectAtIndex:x];
        if (outfitRetrieve.fileNumRef == outfitnum)
        {
            [outfitRetrieve.dates addObject:d];
        }
    }
    
    
     [self saveClosetArchive];
   
}



-(NSDate *) findLastWorn: (int) itemnum
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    [comp setHour:8];
    NSDate *today = [gregorian dateFromComponents:comp];
    
    DateRecord *tempdaterecord = [[DateRecord alloc] init];
    NSDate *lastworn;
    BOOL found;
    
    found = NO;
    
    for(int x= [dateRecords count] - 1; x >= 0; x--)
    {
    
        
        tempdaterecord = [dateRecords objectAtIndex:x];
        
        int tempoutfitnum;
        NSNumber *tempoutfitNSnum;
        
        for (int x=0; x < [tempdaterecord.outfitRefNumsArray count]; x++)
        {
            tempoutfitNSnum = [tempdaterecord.outfitRefNumsArray objectAtIndex:x];
            tempoutfitnum = [tempoutfitNSnum intValue];
            
            OutfitRecord *tempoutfitrecord = [self retrieveOutfitNum:tempoutfitnum];
            
            if(tempoutfitrecord.fileNumRef == itemnum)
            {
                if([tempdaterecord.date compare:today] == NSOrderedAscending)
                {
                
                    lastworn = tempdaterecord.date;
                    found = YES;
                    break;
                    
                }
                
            }
            
            if (tempoutfitrecord.toprefnum == itemnum ||
                tempoutfitrecord.rightrefnum == itemnum ||
                tempoutfitrecord.lowerrefnum == itemnum ||
                tempoutfitrecord.topoverlayrefnum == itemnum)
            {
                if([tempdaterecord.date compare:today] == NSOrderedAscending)
                {
                    lastworn = tempdaterecord.date;
                    found = YES;
                    break;
                }
            }

        }
    
        if(found) break;

    }
    
    return lastworn;
    
    
}


-(NSDate *) findNextWorn: (int) itemnum
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    [comp setHour:8];
    NSDate *today = [gregorian dateFromComponents:comp];
    
    DateRecord *tempdaterecord = [[DateRecord alloc] init];
    NSDate *nextworn;
    BOOL found;
    
    found = NO;
    
    for(int x = 0; x < [dateRecords count]; x++)
    {
        
        
        tempdaterecord = [dateRecords objectAtIndex:x];
        
        int tempoutfitnum;
        NSNumber *tempoutfitNSnum;
        
        for (int x=0; x < [tempdaterecord.outfitRefNumsArray count]; x++)
        {
            tempoutfitNSnum = [tempdaterecord.outfitRefNumsArray objectAtIndex:x];
            tempoutfitnum = [tempoutfitNSnum intValue];
            
            OutfitRecord *tempoutfitrecord = [self retrieveOutfitNum:tempoutfitnum];
            
            if(tempoutfitrecord.fileNumRef == itemnum)
            {
                if([tempdaterecord.date compare:today] == NSOrderedDescending)
                {
                    
                    nextworn = tempdaterecord.date;
                    found = YES;
                    break;
                    
                }
                
            }
            
            if (tempoutfitrecord.toprefnum == itemnum ||
                tempoutfitrecord.rightrefnum == itemnum ||
                tempoutfitrecord.lowerrefnum == itemnum ||
                tempoutfitrecord.topoverlayrefnum == itemnum)
            {
                if([tempdaterecord.date compare:today] == NSOrderedDescending)
                {
                    nextworn = tempdaterecord.date;
                    found = YES;
                    break;
                }
            }
            
        }
        
        if(found) break;
        
    }
    
    return nextworn;
    
    
}


-(BOOL) isWornToday: (int) itemnum
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    [comp setHour:8];
    NSDate *today = [gregorian dateFromComponents:comp];
    
    DateRecord *tempdaterecord = [[DateRecord alloc] init];
    BOOL found;
    
    found = NO;
    
    for(int x = 0; x < [dateRecords count]; x++)
    {
        
        
        tempdaterecord = [dateRecords objectAtIndex:x];
        
        int tempoutfitnum;
        NSNumber *tempoutfitNSnum;
        
        for (int x=0; x < [tempdaterecord.outfitRefNumsArray count]; x++)
        {
            tempoutfitNSnum = [tempdaterecord.outfitRefNumsArray objectAtIndex:x];
            tempoutfitnum = [tempoutfitNSnum intValue];
            
            OutfitRecord *tempoutfitrecord = [self retrieveOutfitNum:tempoutfitnum];
            
            if(tempoutfitrecord.fileNumRef == itemnum)
            {
                if([tempdaterecord.date compare:today] == NSOrderedSame)
                {
                    
                    found = YES;
                    return YES;
                    
                }
                
            }
            
            if (tempoutfitrecord.toprefnum == itemnum ||
                tempoutfitrecord.rightrefnum == itemnum ||
                tempoutfitrecord.lowerrefnum == itemnum ||
                tempoutfitrecord.topoverlayrefnum == itemnum)
            {
                if([tempdaterecord.date compare:today] == NSOrderedSame)
                {
                    found = YES;
                    return YES;
                }
            }
            
        }
        
        if(found) break;
        
    }
    
    return NO;
    
    
}



-(OutfitRecord *) retrieveOutfitNum: (int) outfitnum
{
    OutfitRecord *tempoutfitrecord;
    
    
    for(int x=0; x<[outfitsArray count];x++)
    {
        
        tempoutfitrecord = [outfitsArray objectAtIndex:x];
        
        if(tempoutfitrecord.fileNumRef == outfitnum)
        {
            break;
        }
    }
    
    return tempoutfitrecord;
}



-(void) sortDateRecords
{
    NSMutableArray *sortedDateRecords = [[NSMutableArray alloc] init];
    
    
    for(int x=0; x<[dateRecords count]; x++)
    {
        DateRecord *daterecordtosort = [[DateRecord alloc] init];
        
        daterecordtosort = [dateRecords objectAtIndex:x];
        
        NSLog(@"sorting %@", daterecordtosort.date);
        
        if(x == 0)
        {
            [sortedDateRecords addObject:daterecordtosort];
            continue; //skip rest, next loop iteration starts
        }
        
        for(int y=0; y<[sortedDateRecords count]; y++)
        {
            DateRecord *daterecordtocompare = [[DateRecord alloc] init];
            DateRecord *daterecordtocomparenext = [[DateRecord alloc] init];
            
            daterecordtocompare = [sortedDateRecords objectAtIndex:y];
            
            if([daterecordtosort.date compare:daterecordtocompare.date] == NSOrderedAscending)
            {
                [sortedDateRecords insertObject:daterecordtosort atIndex:y];
                break;
                
            }
            else if(y == [sortedDateRecords count] - 1)
            {
                if ([daterecordtosort.date compare:daterecordtocompare.date] == NSOrderedAscending)
                {
                    [sortedDateRecords insertObject:daterecordtosort atIndex:y];
                    
                }
                
                if ([daterecordtosort.date compare:daterecordtocompare.date] == NSOrderedDescending)
                {
                    [sortedDateRecords addObject:daterecordtosort];
                    
                }
                
                break;
            }
            else
            {
            
                daterecordtocomparenext = [sortedDateRecords objectAtIndex:y+1];
            
                if([daterecordtosort.date compare:daterecordtocompare.date] == NSOrderedAscending &&
                   [daterecordtosort.date compare:daterecordtocomparenext.date] == NSOrderedDescending)
                    
                {
                    [sortedDateRecords insertObject:daterecordtosort atIndex:y+1];
                    break;
                }
   
                if([daterecordtosort.date compare:daterecordtocompare.date] == NSOrderedSame)
                {
                    break;
                }
            }
            
            
        }
            

    }
    
    [dateRecords removeAllObjects];
    [dateRecords addObjectsFromArray:sortedDateRecords];
    [sortedDateRecords removeAllObjects];

    
    
    NSLog(@"sorted date records:");
    
    for(int x=0; x<[dateRecords count]; x++)
    {
        DateRecord *daterecordverify = [[DateRecord alloc] init];
        
        daterecordverify = [dateRecords objectAtIndex:x];
        
        NSLog(@"%@", daterecordverify.date);
    }
    
    
    [self saveClosetArchive];

    
}



-(void) insertOutfitNum: (int) outfitnum toDates: (NSMutableArray *) dates
{
    NSNumber *outfitNSNum = [NSNumber numberWithInt:outfitnum];
    
    for(int x = 0; x<[dates count]; x++)
    {
        
        NSDate *addtodate = [dates objectAtIndex:x];
    
        for (int y = 0; y<[dateRecords count]; y++)
        {
            DateRecord *daterecordtomodify = [[DateRecord alloc] init];
            
            daterecordtomodify = [dateRecords objectAtIndex:y];
        
            NSLog(@"found %@", daterecordtomodify.date);
            
            if([addtodate compare:daterecordtomodify.date] == NSOrderedSame)
            {
                int outfitnumexists = 0;
                
                for(int a = 0; a<[daterecordtomodify.outfitRefNumsArray count]; a++)
                {
                    NSNumber *existingOutfitNum = [daterecordtomodify.outfitRefNumsArray objectAtIndex:a];
                    
                    if ([outfitNSNum intValue] == [existingOutfitNum intValue])
                    {
                        NSLog(@"outfit already exists on %@", daterecordtomodify.date);
                        ++outfitnumexists;
                    }
                }
                    
                
                if(outfitnumexists == 0)
                {
                    NSLog(@"matching date!, adding outfit");
                    
                    if(!daterecordtomodify.outfitRefNumsArray)
                    {
                        daterecordtomodify.outfitRefNumsArray = [[NSMutableArray alloc] init];
                    }
                
                    
                    [daterecordtomodify.outfitRefNumsArray addObject:outfitNSNum];
                }
                
                
                
                for(int z = 0; z<[daterecordtomodify.outfitRefNumsArray count]; z++)
                {
                    
                    
                    NSNumber *tempnum = [daterecordtomodify.outfitRefNumsArray objectAtIndex:z];
                    
                    int outfitIntNum = [tempnum intValue];
                    NSLog(@"in date %@ is the following: ", daterecordtomodify.date);
                    NSLog(@"%i", outfitIntNum);
                }
            }

        }
    }
    
     [self saveClosetArchive];
}



-(void) removeOutfitNum: (int) outfitnum fromDates: (NSMutableArray *) dates
{
    NSNumber *outfitnumtoremove = [NSNumber numberWithInt:outfitnum];
    
    for (int x = 0; x<[dateRecords count]; x++)
    {
        
        int datesmatched;
        
        DateRecord *daterecordtomodify = [[DateRecord alloc] init];
            
        daterecordtomodify = [dateRecords objectAtIndex:x];
        
        NSLog(@"looking at date %@", daterecordtomodify.date);
        
        for (int y=0; y<[dates count]; y++)
        {
            NSDate *removefromdate = [dates objectAtIndex:y];

            if([removefromdate compare:daterecordtomodify.date] == NSOrderedSame)
            {
                datesmatched++;
                
                for(int z=0; z<[daterecordtomodify.outfitRefNumsArray count]; z++)
                {
                    NSNumber *tempoutfitnum = [daterecordtomodify.outfitRefNumsArray objectAtIndex:z];
                    
                    if([tempoutfitnum compare:outfitnumtoremove] == NSOrderedSame)
                    {
                        NSLog(@"found and deleting outfit %i from date %@", [tempoutfitnum intValue], daterecordtomodify.date);
                      
                        [daterecordtomodify.outfitRefNumsArray removeObjectAtIndex:z];
                        
                        
                        if([daterecordtomodify.outfitRefNumsArray count] == 0)
                        {
                          [dateRecords removeObjectAtIndex:x];
                            x--;
                        }
                        
                        
                    }
            
                }
                [self saveClosetArchive];
                break;
                
            }
        }
        if(datesmatched == [dates count]) 
        {
            NSLog(@"all dates found and deleted, breaking out");
            break;
        }
    }

     [self saveClosetArchive];
}





-(void) deleteCategory: (int) categorynumber
{
    if([categories count] > 0)
    {
        [categories removeObjectAtIndex:categorynumber];
    }
}


-(void) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [textField.superview removeFromSuperview];
    
    NSLog(@"%@", textField.text);
    
    
    if ([textField.text compare:@""] == NSOrderedSame) //need to change to any number of blanks
    {
        
    }
    else [self addNewCategory:textField.text];
}


-(void) addNewCategoryCallUp
{
    
    AppDelegate *appdelegate;
    OrganizerController *organizercontroller;

    
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    organizercontroller = appdelegate.mixerController.organizerController;
    
    
    if([organizercontroller doesViewAlreadyExist:69] == NO)
    {
    
        int originX = appdelegate.mixerController.organizerController.view.frame.size.width/2 - 100;
        int originY = appdelegate.mixerController.organizerController.view.frame.size.height/2 - 75;
    
    
    
        UIView *enterCategoryNameView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 200, 100)];
        
        enterCategoryNameView.backgroundColor = [UIColor whiteColor];
        
        
        enterCategoryNameView.tag = 69;
    
        [appdelegate.mixerController.organizerController.view addSubview:enterCategoryNameView];
    
    
        UITextField *newcategoryfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 100, 25)];
        newcategoryfield.backgroundColor = [UIColor whiteColor];
        newcategoryfield.userInteractionEnabled = YES;
        newcategoryfield.borderStyle = UITextBorderStyleRoundedRect;
        newcategoryfield.delegate = self;
    
        [enterCategoryNameView addSubview:newcategoryfield];
    }
    else
    {
        NSLog(@"69 already there!");

    }
    

}


-(void) addNewCategory: (NSString *)name
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    OrganizerController *organizercontroller = appDelegate.mixerController.organizerController;
    
    
    Category *newcategory = [[Category alloc] init];
    newcategory.categoryname = name;
    newcategory.shouldLoad = YES;
    
    if(!categories)
    {
        categories = [[NSMutableArray alloc] init];
    }
    
    [categories addObject:newcategory];
    
    
    
    NSLog(@"added to category");
    [self listCategories];
    
    
    
    [self saveClosetArchive];
   
    [organizercontroller clearScroll:organizercontroller.rackTypeScroll];
    
    [organizercontroller loadCategoryArchive];

}

-(void) addNewRack: (NSString *) rackname toCatNum: (int) catnum
{
    if([categories count] > 0)
    {
        
        Rack * newrack = [[Rack alloc] init];
        
        
        
        newrack.rackname = rackname;  //need to allocate memory? noo...
        newrack.racktype = catnum;
        newrack.shouldLoad = YES;
        
        
        Category *tempcategory = [categories objectAtIndex:catnum];
        
        NSLog(@"adding new rack called %@ to %@, racktype is %i", rackname, tempcategory.categoryname, newrack.racktype);
        
        
        
        if(!tempcategory.racksarray)
        {
            tempcategory.racksarray = [[NSMutableArray alloc] init];
        }
        
        [tempcategory.racksarray addObject:newrack];
        
        NSLog(@"category %@ new rack count is %i", tempcategory.categoryname, [tempcategory.racksarray count]);
        
        
        [self sortRackArray:tempcategory.racksarray];
        
        [self saveClosetArchive];
    }
    
}


-(void) saveClosetArchive
{
    
    AppDelegate *appdelegate;
    MixerController *mixerController;
    
    
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mixerController = appdelegate.mixerController;
    
    
    NSString *pathhome = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *pathcloset = [pathhome stringByAppendingPathComponent:@"closet.arch"];
    
    NSLog(@"attempt to save closet to %@", pathcloset);
    
    if([NSKeyedArchiver archiveRootObject:self toFile:pathcloset])
    {
        NSLog(@"path closet archived to is %@", pathcloset);
        NSLog(@"closet archive good");
    }
}




-(void) listCategories;
{
    NSLog(@"cat count %i", [categories count]);
    for(int x = 0; x < [categories count]; x++)
    {
        Category *tempcategory = [categories objectAtIndex:x];
        NSLog(@"category %@", tempcategory.categoryname);
        
    }
}




-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:categories forKey:@"Closetcategories"];

    
     [aCoder encodeObject:outfitsArray forKey:@"Closetoutfitsarray"];
     [aCoder encodeObject:outfitCategories forKey:@"Closetoutfitcategories"];
    
     [aCoder encodeObject:dateRecords forKey:@"Closetdaterecords"];
    
    [aCoder encodeObject:colors forKey:@"Closetcolors"];
    [aCoder encodeObject:occasions forKey:@"Closetoccasions"];
    [aCoder encodeObject:brands forKey:@"Closetbrands"];
    [aCoder encodeBool:didRectify forKey:@"Closetdidrectify"];
    
    [aCoder encodeObject:currentBackDrop forKey:@"Closetbackdrop"];
    [aCoder encodeObject:closetIdentity forKey:@"Closetidentity"];
    
    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    
    categories = [aDecoder decodeObjectForKey:@"Closetcategories"];

    outfitsArray = [aDecoder decodeObjectForKey:@"Closetoutfitsarray"];
    outfitCategories = [aDecoder decodeObjectForKey:@"Closetoutfitcategories"];
    
    dateRecords = [aDecoder decodeObjectForKey:@"Closetdaterecords"];
    
    colors = [aDecoder decodeObjectForKey:@"Closetcolors"];
    occasions = [aDecoder decodeObjectForKey:@"Closetoccasions"];
    brands = [aDecoder decodeObjectForKey:@"Closetbrands"];
    didRectify = [aDecoder decodeBoolForKey:@"Closetdidrectify"];
    currentBackDrop = [aDecoder decodeObjectForKey:@"Closetbackdrop"];
     closetIdentity = [aDecoder decodeObjectForKey:@"Closetidentity"];
    
    return self;
}

-(BOOL) doesDetail: (NSString *) itemdetail existIn: (NSMutableArray *) thisarray
{
    NSString *tempDetail;
    
    for (int i = 0; i <[thisarray count]; i++)
    {
        tempDetail = [thisarray objectAtIndex:i];
        
        if ([itemdetail compare:tempDetail] == NSOrderedSame)
        {
            NSLog(@"%@ exists already", itemdetail);
            return YES;
        }
    }
    return NO;
}

-(BOOL) doesRack: (NSString *) rackname existInCategoryNum: (int) x
{
    Category *tempCategory;
    Rack *tempRack;
    
    tempCategory = [categories objectAtIndex:x];
    
    NSLog(@"going into for loop");
    
    for (int i = 0; i <[tempCategory.racksarray count]; i++)
    {
        tempRack = [tempCategory.racksarray objectAtIndex:i];
        
        NSLog(@"comparing existing rack %@ to new rack %@", tempRack.rackname, rackname);
        
        if ([rackname compare:tempRack.rackname] == NSOrderedSame)
        {
            NSLog(@"%@ exists already", rackname);
            return YES;
        }
    }
    return NO;
}


-(BOOL) doesRack: (NSString *) rackname existInCategoryName: (NSString *) cname
{
    Category *tempCategory;
    Rack *tempRack;
    
    for (int x=0; x < [categories count]; x++)
    {
        tempCategory = [categories objectAtIndex:x];
        
        if ([tempCategory.categoryname compare:cname] == NSOrderedSame)
        {
            break;
        }
    }
    
    
    NSLog(@"going into for loop");
    
    for (int i = 0; i <[tempCategory.racksarray count]; i++)
    {
        tempRack = [tempCategory.racksarray objectAtIndex:i];
        
        NSLog(@"comparing existing rack %@ to new rack %@", tempRack.rackname, rackname);
        
        if ([rackname compare:tempRack.rackname] == NSOrderedSame)
        {
            NSLog(@"%@ exists already", rackname);
            return YES;
        }
    }
    return NO;
}

-(void) printSomething
{
    NSLog(@"printing something");
}


@end
