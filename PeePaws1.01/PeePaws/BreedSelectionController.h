//
//  BreedSelectionController.h
//  PeePaws
//
//  Created by Anthony Tran on 11/19/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreedSelectionController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>



@property (nonatomic, strong) IBOutlet UITableView *breedTableView;
@property (nonatomic, strong) NSString *selectedBreed;

@property (nonatomic, strong) NSMutableArray * breeds;
@property (nonatomic, strong) NSMutableArray * searchResults;





@end
