//
//  MainViewController.h
//  ClosetFash
//
//  Created by Anthony Tran on 4/26/15.
//
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *mainContainer;
@property (strong, nonatomic) IBOutlet UIView *filterContainer;
@property (strong, nonatomic) IBOutlet UIView *menuContainer;

-(void) toggleFilterMenu;
-(void) toggleMenu;


@end
