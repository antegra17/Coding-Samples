//
//  FilterSelectController.m
//  ClosetFash
//
//  Created by Anthony Tran on 4/26/15.
//
//

#import "FilterSelectController.h"
#import "Category.h"
#import "Rack.h"
#import "AppDelegate.h"

@interface FilterSelectController ()

@end

@implementation FilterSelectController

@synthesize categoryNumber;


Category *tempcategory;
AppDelegate *appDelegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tempcategory = [appDelegate.myCloset.categories objectAtIndex:categoryNumber];
    
    self.title = tempcategory.categoryname;

  
    
    NSLog(@"selected category is %i", categoryNumber);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [tempcategory.racksarray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TypeFilterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    
    
    NSLog(@"%i racksarray count", (int)[tempcategory.racksarray count]);
    
        Rack *temprack = [tempcategory.racksarray objectAtIndex:indexPath.row];
        NSString *rackname = temprack.rackname;
    
    cell.tag = indexPath.row;
    cell.textLabel.text = rackname;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.textColor =  [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    
    UIImageView *checkView = [cell viewWithTag:10];
    
     NSLog(@"should load is %i", (int)temprack.shouldLoad);
    if(temprack.shouldLoad == YES)
    {
        NSLog(@"changing color");
        checkView.backgroundColor = [UIColor blueColor];
    }
    else
        checkView.backgroundColor = [UIColor grayColor];

    
    
    
    return cell;
}

UITableViewCell *selectedCell;
Rack *temprack;
UIImageView *checkView;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    temprack = [tempcategory.racksarray objectAtIndex:indexPath.row];
    checkView = [selectedCell viewWithTag:10];
    
    if (temprack.shouldLoad == 1)
    {
        checkView.backgroundColor = [UIColor grayColor];
        temprack.shouldLoad = 0;
    }
    else{
        checkView.backgroundColor = [UIColor blueColor];
        temprack.shouldLoad = 1;
    }
    
    [appDelegate.myCloset saveClosetArchive];

    
    appDelegate.reloadarchives = YES;
    
    NSLog(@"category filter is %i", categoryNumber);
    
    if(categoryNumber == 0)
        appDelegate.topChanged = YES;
    if(categoryNumber == 1)
        appDelegate.topChanged = YES;
    if(categoryNumber == 2)
        appDelegate.rightChanged = YES;
    if(categoryNumber == 3)
        appDelegate.lowerChanged = YES;
    if(categoryNumber == 4)
        appDelegate.topOverlayChanged = YES;
    if(categoryNumber == 5)
        appDelegate.accessoriesChanged = YES;

    if(appDelegate.rightChanged == YES)
    {
        NSLog(@"right has changed");
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
