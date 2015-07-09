//
//  MainViewController.m
//  ClosetFash
//
//  Created by Anthony Tran on 4/26/15.
//
//

#import "MainViewController.h"
#import "MixerController.h"
#import "AppDelegate.h"

@interface MainViewController ()


@end

@implementation MainViewController



@synthesize mainContainer, filterContainer, menuContainer;

UINavigationController *navController;
MixerController *mixerController;
AppDelegate *appDelegate;


BOOL filterOpen;
BOOL menuOpen;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    filterOpen = NO;
    menuOpen = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) toggleFilterMenu{

    NSLog(@"toggling menu");
   

    if(!filterOpen)
    {
        NSLog(@"opening");
       
        filterOpen = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            mainContainer.frame = CGRectMake(-200, 0, mainContainer.frame.size.width, mainContainer.frame.size.height);
            filterContainer.frame = CGRectMake(self.view.frame.size.width-200,0, filterContainer.frame.size.width, filterContainer.frame.size.height);
          } ];
    }
    
    else if(filterOpen)
    {
        NSLog(@"closing");
        filterOpen = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            mainContainer.frame = CGRectMake(0, 0, mainContainer.frame.size.width, mainContainer.frame.size.height);
            filterContainer.frame = CGRectMake(320,0, filterContainer.frame.size.width, filterContainer.frame.size.height);
        } ];

        
        if(appDelegate.reloadarchives == YES)
        {
            
            // Do any additional setup after loading the view.
            
            navController = [self.childViewControllers objectAtIndex:2];
            
            mixerController = [navController.viewControllers objectAtIndex:0];
            
            [mixerController loadAllChangedArchives];
        }
        
        
    }
    

}

-(void) toggleMenu{
    
    NSLog(@"toggling menu");
    
    
    if(!menuOpen)
    {
        NSLog(@"opening menu");
        
        menuOpen = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            mainContainer.frame = CGRectMake(200, 0, mainContainer.frame.size.width, mainContainer.frame.size.height);
            menuContainer.frame = CGRectMake(0,0, filterContainer.frame.size.width, filterContainer.frame.size.height);
        } ];
    }
    
    else if(menuOpen)
    {
        NSLog(@"closing menu");
        menuOpen = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            mainContainer.frame = CGRectMake(0, 0, mainContainer.frame.size.width, mainContainer.frame.size.height);
            menuContainer.frame = CGRectMake(-200,0, filterContainer.frame.size.width, filterContainer.frame.size.height);
        } ];
        
        
        if(appDelegate.reloadarchives == YES)
        {
            
            // Do any additional setup after loading the view.
            
            navController = [self.childViewControllers objectAtIndex:2];
            
            mixerController = [navController.viewControllers objectAtIndex:0];
            
            [mixerController loadAllChangedArchives];
        }
        
        
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
