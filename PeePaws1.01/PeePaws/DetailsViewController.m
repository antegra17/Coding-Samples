//
//  DetailsViewController.m
//  PeePaws
//
//  Created by Anthony Tran on 10/19/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "DetailsViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "PuppyData.h"
#import "GrowthDataPoint.h"
#import "UIPaddedTableViewCell.h"


@interface DetailsViewController ()

@end



@implementation DetailsViewController

@synthesize growthPoints;

UINavigationController *homeNavigationController;
AppDelegate *appDelegate;
HomeViewController *homeViewController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];

    homeViewController = [homeNavigationController.viewControllers objectAtIndex:0];
    
    NSLog(@"growth data # %ld", (long)[homeViewController.puppyData.growthdata count]);
    
    growthPoints = [[self sortedDataPoints] mutableCopy];
    
    self.navigationItem.rightBarButtonItem = _addDetailButton;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    [self.tableView setBackgroundView:imageView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:5];
    
    
    UIImage *image = [UIImage imageNamed:@"BackArrow"];
    CGRect frame = CGRectMake(0, 0, 22, 22);
    
    //init a normal UIButton using that image
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [button addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* newBackButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,newBackButton,nil];
    
    UIImage *addimage = [UIImage imageNamed:@"AddPaw"];
    CGRect frameAdd = CGRectMake(0, 0, 30, 30);
    //init a normal UIButton using that image
    UIButton* addbutton = [[UIButton alloc] initWithFrame:frameAdd];
    [addbutton setBackgroundImage:addimage forState:UIControlStateNormal];
    [addbutton setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [addbutton addTarget:self action:@selector(gotoAddData:) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* addDataButton = [[UIBarButtonItem alloc] initWithCustomView:addbutton];
    
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,addDataButton,nil];
    
    
    

   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)home:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoAddData:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"AddDataSegue" sender:sender];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (section == 0)
        return 1;
    else
        return [growthPoints count];
    
    
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
 
    
    static NSString *CellIdentifier = @"DetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    NSLog(@"section is %ld", indexPath.section);
    
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    if(indexPath.section == 1)
    {
    
    GrowthDataPoint *datapoint = [growthPoints objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"  MM-dd-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:datapoint.date];

    NSLog(@"data point date is %@", datapoint.date);
    
    cell.textLabel.text = dateString;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"                          %@ pounds",
                                 datapoint.weight];
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    
    return cell;
}


- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{


}

-(NSArray *)sortedDataPoints {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    
    return [(NSSet*)homeViewController.puppyData.growthdata sortedArrayUsingDescriptors:sortDescriptors];
    
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
}*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        
        
        GrowthDataPoint *object = [self.growthPoints objectAtIndex:indexPath.row];
        
        [self.growthPoints removeObjectAtIndex:indexPath.row];
        
        // You might want to delete the object from your Data Store if you’re using CoreData
        
        [context deleteObject:object];
        
        NSError *error;
        
        [context save:&error];
        
        // Animate the deletion
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
        
        
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

-(void) viewDidAppear:(BOOL)animated
{
    growthPoints = [[self sortedDataPoints] mutableCopy];

    [self.tableView reloadData];
 
    
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwinding to details view controller");
  
    
    
}
@end
