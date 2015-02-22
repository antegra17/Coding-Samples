//
//  SearchResultsTableViewController.h
//  PeePaws
//
//  Created by Anthony Tran on 1/11/15.
//  Copyright (c) 2015 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results
@property (nonatomic, strong) NSString *selectedBreedFiltered;



@end
