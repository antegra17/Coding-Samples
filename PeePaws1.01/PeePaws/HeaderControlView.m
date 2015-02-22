//
//  HeaderControlView.m
//  PeePaws
//
//  Created by Anthony Tran on 10/30/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "HeaderControlView.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "PuppyData.h"
#import "PuppyProfile.h"
#import "SelectionTableView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HeaderControlView
@synthesize puppySelectionTableView, puppies;


AppDelegate *appDelegate;
HomeViewController *homeViewController;
UINavigationController *homeNavigationController;

int tablePositionY;
int headerSizeY;

- (void)setData {
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];
    homeViewController = [homeNavigationController.viewControllers objectAtIndex:0];
    
    puppySelectionTableView = [[SelectionTableView alloc] init];
    
    headerSizeY = 105;
    tablePositionY = 30;
    
    if([UIScreen mainScreen].bounds.size.height == 480)
    {
        headerSizeY = 95;
        tablePositionY = 20;
        
    }
       
    
    puppySelectionTableView.frame = CGRectMake(-15,tablePositionY, homeViewController.headerWidth,[homeViewController.puppies count] *75);
    
    
    puppySelectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [puppySelectionTableView setDelegate:self];
    [puppySelectionTableView setDataSource:self];
    
    [self addSubview:puppySelectionTableView];
    
    self.backgroundColor = [UIColor clearColor];
    puppySelectionTableView.backgroundColor = [UIColor clearColor];
    self.puppySelectionTableView.scrollEnabled = NO;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    NSLog(@"ran numberofsections 1");
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"ran number of rows %lu", [homeViewController.puppies count]);
    
    puppySelectionTableView.frame = CGRectMake(-15,tablePositionY, homeViewController.headerWidth,[homeViewController.puppies count] *75);
    
    NSLog(@"animating");
    
    [UIView animateWithDuration:0.25 animations:^{
        puppySelectionTableView.backgroundColor = [UIColor clearColor];
        puppySelectionTableView.alpha = 1;
       
    } completion:
     
     ^(BOOL finished) {
         
     }
     
     ];

    return [homeViewController.puppies count];
    
}



- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
  
    if ([homeNavigationController.viewControllers count] == 2)
    {
        NSLog(@"correction load");
        [puppySelectionTableView reloadData];
        
    }
    
    
    
    NSLog(@"DID SELECT: number of home nav views %ld", [homeNavigationController.viewControllers count]);
    
    NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"puppy count %lu", (long)[homeViewController.puppies count]);
    NSLog(@"selected is %@, %lu", indexPath, lastIndex);
    NSLog(@"selected dog is %@", cell.textLabel.text);
    
    [homeViewController selectPuppy:cell.textLabel.text];
    
   
    
    if ([cell.textLabel.text isEqualToString:@"Add Puppy"]){
        
        
        [UIView animateWithDuration:0.5 animations:^{
            cell.frame = CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height);
            self.frame = CGRectMake(homeViewController.headerStartX,0,self.frame.size.width,headerSizeY);
        } ];
        
        [homeNavigationController.navigationBar setUserInteractionEnabled:YES];
        for (int row = 0; row < [homeViewController.puppies count]; row++) {
            
            if (row != lastIndex && row < lastIndex) {
                
                NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:0];
                UITableViewCell* cell = [tableView cellForRowAtIndexPath:cellPath];
                //do stuff with 'cell'
                NSLog(@"doing stuf with cell row %i", row);
                NSLog(@"%@", cellPath);
                
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    cell.frame = CGRectMake(cell.frame.origin.x,cell.frame.origin.y + 75, cell.frame.size.width, cell.frame.size.height);
                } completion:
                 
                 ^(BOOL finished) {
                     //[puppySelectionTableView reloadData];
                     puppySelectionTableView.backgroundColor = [UIColor clearColor];
                     puppySelectionTableView.alpha = 1;
                 }
                 
                 ];
            }
        }
        
    }
    
    else if(lastIndex == 0)
    {
        NSLog(@" height is %lu", (long)self.frame.size.height);
        
        if(self.frame.size.height > headerSizeY)
        {
            NSLog(@"already open");
            self.frame = CGRectMake(homeViewController.headerStartX,0,self.frame.size.width,headerSizeY);
            [homeNavigationController.navigationBar setUserInteractionEnabled:YES];
            puppySelectionTableView.backgroundColor = [UIColor clearColor];
            puppySelectionTableView.alpha = 1;
        }
        else if ([homeNavigationController.viewControllers count] < 2){
            
            NSLog(@"number of homenav views %ld", [homeNavigationController.viewControllers count]);
            
            [puppySelectionTableView reloadData];
            
        [UIView animateWithDuration:0.1 animations:^{
            self.frame = CGRectMake(homeViewController.headerStartX,0,self.frame.size.width,tablePositionY+[homeViewController.puppies count] *75);
        } ];
            
             puppySelectionTableView.backgroundColor = [UIColor blackColor];
             puppySelectionTableView.alpha = 0.8;
            
             NSLog(@" height is %lu", (long)self.frame.size.height);
            
            [homeNavigationController.navigationBar setUserInteractionEnabled:NO];
            
        }
        
    }
    else
    {

        [UIView animateWithDuration:0.5 animations:^{
            cell.frame = CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height);
            self.frame = CGRectMake(homeViewController.headerStartX,0,self.frame.size.width,headerSizeY);
        } ];
        
        
        [homeNavigationController.navigationBar setUserInteractionEnabled:YES];
    
        for (int row = 0; row < [homeViewController.puppies count]; row++) {
            
            if (row != lastIndex && row < lastIndex) {
            
                NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:0];
                UITableViewCell* cell = [tableView cellForRowAtIndexPath:cellPath];
                //do stuff with 'cell'
                NSLog(@"doing stuf with cell row %i", row);
                NSLog(@"%@", cellPath);
                
            
                
                [UIView animateWithDuration:0.5 animations:^{
                    cell.frame = CGRectMake(cell.frame.origin.x,cell.frame.origin.y + 75, cell.frame.size.width, cell.frame.size.height);
                } completion:
                 
                 ^(BOOL finished) {
                     [puppySelectionTableView reloadData];
                 }
                 
                 ];
                
                
          
                
                NSLog(@"%lu, %@ down", (long) cell.frame.size.height, cell.textLabel.text);
                
            }
            
            
        }
        
   
    
    
    PuppyData *puppyDataToMove = [homeViewController.puppies objectAtIndex:lastIndex];
    
    [homeViewController.puppies removeObjectAtIndex:lastIndex];
    
    
    [homeViewController.puppies insertObject:puppyDataToMove atIndex:0];
        

    PuppyData *movedPuppyData = [homeViewController.puppies objectAtIndex:0];
    PuppyProfile *movedProfile = movedPuppyData.profile;
    NSLog(@"%@ moved to 0!", movedProfile.name);
    
   
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    
    
    NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    
    NSLog(@"selected is %@, %lu", indexPath, lastIndex);
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
    if ([homeNavigationController.viewControllers count] == 2)
    {
        NSLog(@"correction load");
        
        
        cell.textLabel.text = @"Add Puppy";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:15.0];
        cell.textLabel.textColor =  [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.imageView.image = [UIImage new];
        [cell.imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.imageView.layer setBorderWidth:3.0];
        
        cell.imageView.image = [UIImage imageNamed:@"addpuppy.png"];
        
    }
    else{
    
    
    PuppyData *puppydata = [homeViewController.puppies objectAtIndex:indexPath.row];
    PuppyProfile *profile = puppydata.profile;
    cell.textLabel.text = profile.name;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
                                 profile.breedOne, profile.dob];
    
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:15.0];
    cell.textLabel.textColor =  [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.imageView.image = [UIImage new];
    [cell.imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.imageView.layer setBorderWidth:3.0];

    
    
    
    if(profile.imagePath)
    {
    
     NSString *shortImageFilePath = [NSString stringWithString:profile.imagePath];
    
    
     NSString  *imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:shortImageFilePath];
    
    
     UIImage *cellImage = [[UIImage alloc] initWithContentsOfFile:imageFilePath];
    
      NSLog(@"CELL IMAGE from %@", profile.imagePath);
    
        cell.imageView.image = cellImage;
    }
    if([profile.name isEqualToString:@"Add Puppy"])
    {
        
        //UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background5.png"]];
        
      
        
        
        cell.imageView.image = [UIImage imageNamed:@"addpuppy.png"];

        
    }
    
    CGSize itemSize = CGSizeMake(75, 75);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSLog(@"adding %@ to view at index %lu", profile.name, indexPath.row);
        
    }
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
        
    
    
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        
        
        PuppyData *object = [homeViewController.puppies objectAtIndex:indexPath.row];
        
        [homeViewController.puppies removeObjectAtIndex:indexPath.row];
        
        // You might want to delete the object from your Data Store if you’re using CoreData
        
        [context deleteObject:object];
        
        NSError *error;
        
        [context save:&error];
        
        // Animate the deletion
        
         self.frame = CGRectMake(homeViewController.headerStartX,0,self.frame.size.width,tablePositionY+75);
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
        
        if ([homeViewController.puppies count] == 1)
        {
            homeViewController.navigationItem.rightBarButtonItems = nil;
            
            homeViewController.breedLabel.text = @"";
            homeViewController.breedLabelTwo.text = @"";
            homeViewController.ageLabel.text = @"";
            homeViewController.sexLabel.text = @"";
            
        }
        
        
    }
    
    /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
     
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     
     YourObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Header" inManagedObjectContext:context];
     
     newObject.value = @”value”;
     
     [context save:&error];
     
     [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
     
     if (self.dataSourceArray.count > 0) {
     
     self.editButton.enabled = YES;
     
     }*/
    
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    NSLog(@"CAN EDIT: number of home nav views %ld", [homeNavigationController.viewControllers count]);
    
    if ([homeNavigationController.viewControllers count] >1)
    {
        
        return NO;
    }
    else if (self.frame.size.height > 105 && ![cell.textLabel.text isEqualToString:@"Add Puppy"])
    {
        return YES;
    }
   
    
    return NO;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
