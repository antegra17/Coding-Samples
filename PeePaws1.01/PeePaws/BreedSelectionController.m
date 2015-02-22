//
//  BreedSelectionController.m
//  PeePaws
//
//  Created by Anthony Tran on 11/19/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "BreedSelectionController.h"
#import "NewPuppyViewController.h"
#import "SearchResultsTableViewController.h"

#import "AppDelegate.h"
#import "HomeViewController.h"


@interface BreedSelectionController ()

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultsTableViewController *resultsTableViewController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end


@implementation BreedSelectionController

@synthesize breedTableView, selectedBreed, breeds, searchController, searchResults, resultsTableViewController;

AppDelegate *appDelegate;
UINavigationController *homeNavigationController;
HomeViewController *homeViewController;
HeaderControlView *headerControlView;
BreedSelectionController *breedSelectionController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
    homeNavigationController = [tabController.viewControllers objectAtIndex:0];

    selectedBreed = @"hello";
    
    // Do any additional setup after loading the view.
    
    self.title = @"Select Breed";
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Chalkduster" size:15],
      NSFontAttributeName, nil]];
    
    breedTableView.delegate = self;
    breedTableView.dataSource = self;
    
    
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"breedslist" ofType:@"plist"];
    NSDictionary *breedsDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistCatPath];
    
    NSArray * breedNameDictionary = breedsDictionary[@"DogBreeds"];
    
    NSLog(@"breedNamesDictionary count %ld, breedsDictionary count %ld", [breeds count], [breedsDictionary count]);
    
    breeds = [[NSMutableArray alloc] init];
    
    for (NSDictionary *breedDictObject in breedNameDictionary)
    {
        NSString *breedName = breedDictObject[@"Name"];
    
        [breeds addObject:breedName];
    }
    
    NSLog(@"breeds count is %ld", [breeds count]);
  
    
    breedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    //resultsTableViewController = [[SearchResultsTableViewController alloc] init];
    
    resultsTableViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchResultsTableViewController"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableViewController];
    
    self.searchController.searchResultsUpdater = self;
    
  
    CGRect frameX = CGRectMake(15,0,self.view.frame.size.width-30,44);
    CGRect frameY = CGRectMake(0,0,self.view.frame.size.width-30,44);
    UIView * titleView = [[UIView alloc] initWithFrame:frameX];
    
    titleView.clipsToBounds = YES;
    titleView.backgroundColor = [UIColor clearColor];
   
    
    [titleView addSubview:searchController.searchBar];
    
    [self.breedTableView addSubview:titleView];

    self.searchController.searchBar.frame = frameY;
 
    //self.searchController.searchBar.barTintColor = [UIColor clearColor];
    self.searchController.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchController.searchBar.backgroundColor = [UIColor clearColor];
    
    
  
    //self.searchController.searchBar.translucent = YES;
    
    
    
    //self.navigationItem.titleView = titleView;
    
    
    
    //self.breedTableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = FALSE;
    
    self.definesPresentationContext = YES;
  
    
    
    
    
    
    
    
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
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    /*
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    self.tabBarController.tabBar.shadowImage = [UIImage new];
    self.tabBarController.tabBar.translucent = YES;*/
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"begin editing");
    
    if([UIScreen mainScreen].bounds.size.height == 480)
    {
    
        homeViewController.headerCover.backgroundColor = [UIColor blackColor];
        homeViewController.headerCover.image = [UIImage imageNamed:@"Background4S"];
    }
    
    [homeViewController.navigationController.view addSubview:homeViewController.headerCoverView];
    
    
  
}
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"end editing");
    
    [homeViewController.headerCoverView removeFromSuperview];
    
   
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}


-(void)home:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    
    
    
    return [breeds count]+1;
}

- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSLog(@"selected row");
    
    if(indexPath.row != 0)
    {
        selectedBreed = [NSString stringWithString:[breeds objectAtIndex:indexPath.row-1]];
    NSLog(@"did selected row: selected breed is %@", selectedBreed);
    
    [self performSegueWithIdentifier:@"BreedSelected" sender:self];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    
    NSLog(@"selected is %@, %lu", indexPath, lastIndex);
    
    
    static NSString *CellIdentifier = @"BreedCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"";
    }else
    {
        //NSString *breed = [breeds objectAtIndex:indexPath.row-1];
        
        NSString *breed = [breeds objectAtIndex:indexPath.row-1];
        cell.textLabel.text = breed;
        
        NSLog(@"%@ breed name", breed);
    }
    
    
    
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:15.0];
    cell.textLabel.textColor =  [UIColor whiteColor];
    cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
    
    
}



-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = [self.searchController.searchBar text];
   
    searchResults = [breeds mutableCopy];
    
    [searchResults removeAllObjects]; // First clear the filtered array.
    
     
     for (NSString *breed in breeds) {
     
     NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
     NSRange breedRange = NSMakeRange(0, breed.length);
     NSRange foundRange = [breed rangeOfString:searchText options:searchOptions range:breedRange];
     if (foundRange.length > 0) {
     [self.searchResults addObject:breed];
     }
     }
    
    
    
    SearchResultsTableViewController *resultsTableController = (SearchResultsTableViewController *)self.searchController.searchResultsController;
    
    resultsTableController.searchResults = searchResults;
    [resultsTableController.tableView reloadData];
    


    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"%@ prepare for segue", selectedBreed);
    
    NSLog(@"preparing for segue back to newpuppycontroller!");
    
    if ([segue.destinationViewController isKindOfClass:[NewPuppyViewController class]]) {
        
        
        
    }
}


#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"cancel clicked");
    [homeViewController.headerCoverView removeFromSuperview];
    
}

@end
