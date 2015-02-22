//
//  HeaderControlView.h
//  PeePaws
//
//  Created by Anthony Tran on 10/30/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionTableView.h"

@interface HeaderControlView : UIView <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) SelectionTableView *puppySelectionTableView;
@property (nonatomic, strong) NSMutableArray *puppies;
-(void) setData;
-(void) refreshTable;

@end
