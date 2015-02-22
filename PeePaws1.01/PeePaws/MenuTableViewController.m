//
//  MenuTableViewController.m
//  PeePaws
//
//  Created by Anthony Tran on 12/13/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "MenuTableViewController.h"
#import "NewPuppyViewController.h"

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HeaderControlView.h"
#import "UIPaddedTableViewCell.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

AppDelegate *appDelegate;

UINavigationController *homeNavigationController;
HomeViewController *homeViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];
    homeViewController = [homeNavigationController.viewControllers objectAtIndex:0];
    
    [homeViewController.headerControlView setUserInteractionEnabled:NO];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    //[self.tableView setBackgroundView:imageView];
    
    imageView.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:imageView];
    
    [self.view sendSubviewToBack:[self.view.subviews objectAtIndex:[self.view.subviews count]-1]];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    self.tabBarController.tabBar.shadowImage = [UIImage new];
    self.tabBarController.tabBar.translucent = YES;
    
    
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
    
}

-(void)home:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0,0,self.tableView.frame.size.width, self.tableView.frame.size.height);
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
    return 3;
}


- (UIPaddedTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"MenuCell";
    
    UIPaddedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UIPaddedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 1)
    {
        cell.textLabel.text = @"Edit Growth Data";
        
    }
    if (indexPath.row == 2)
    {
        cell.textLabel.text = @"Edit Profile";
    }
    // Configure the cell...
    
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:17.0];
    cell.textLabel.textColor =  [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
}


- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row == 0)
    {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    if ([cell.textLabel.text isEqualToString:@"Edit Growth Data"])
    {
         [self performSegueWithIdentifier:@"EditGrowthSegue" sender:cell];
        
    }
    if ([cell.textLabel.text isEqualToString:@"Edit Profile"])
    {
        [self performSegueWithIdentifier:@"EditProfileSegue" sender:cell];
        
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
    if ([segue.destinationViewController isKindOfClass:[NewPuppyViewController class]]) {
 
    NSLog(@"going to edit profile controller!!!");
        NewPuppyViewController *editProfileController = segue.destinationViewController;
        
        editProfileController.editProfileActive  = YES;
        [homeViewController.headerControlView setHidden:YES];
        
 
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [homeViewController.headerControlView setHidden:NO];
}


@end
