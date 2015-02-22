//
//  SearchResultsTableViewController.m
//  PeePaws
//
//  Created by Anthony Tran on 1/11/15.
//  Copyright (c) 2015 Anthony Tran. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "BreedSelectionController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"



@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

@synthesize searchResults, selectedBreedFiltered;

AppDelegate *appDelegate;
UINavigationController *homeNavigationController;
HomeViewController *homeViewController;
HeaderControlView *headerControlView;
BreedSelectionController *breedSelectionController;

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];
    breedSelectionController = [homeNavigationController.viewControllers objectAtIndex:[homeNavigationController.viewControllers count]-1];

    NSLog(@"breedselected in breedcontroller is %@", breedSelectionController.selectedBreed);
    
    
    [homeViewController.navigationController.view addSubview:homeViewController.headerCoverView];
    
    
   
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    
    [self.tableView setBackgroundView:imageView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.navigationController.navigationBar.translucent = NO;
    
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    self.tabBarController.tabBar.shadowImage = [UIImage new];
    self.tabBarController.tabBar.translucent = YES;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    NSString *breed = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = breed;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
    return cell;
    
}
- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSLog(@"selected row");
    
    selectedBreedFiltered = [NSString stringWithString:[self.searchResults objectAtIndex:indexPath.row]];
    
    breedSelectionController.selectedBreed = selectedBreedFiltered;
    
    [breedSelectionController performSegueWithIdentifier:@"BreedSelected" sender:self];
    
    [homeViewController.headerCoverView removeFromSuperview];
    
    
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
