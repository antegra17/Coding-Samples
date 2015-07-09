//
//  NewDetailController.m
//  ClosetFash
//
//  Created by Anthony Tran on 4/18/15.
//
//

#import "NewDetailController.h"

@interface NewDetailController ()

@end

@implementation NewDetailController

@synthesize detailField, tagNum, existingTag;

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
     NSLog(@"loaded new detail controller");
    
    if(tagNum == 4)
        self.title = [NSString stringWithFormat:@"New Outfit Category"];
    else if (tagNum == 0)
        self.title = [NSString stringWithFormat:@""];
    else if (tagNum == 10){
        self.title = [NSString stringWithFormat:@"Outfit Name"];
        
        detailField.placeholder = @"Outfit Name";
    }
    else
        self.title = [NSString stringWithFormat:@"Tag %i", tagNum];
    
    
    if(![existingTag isEqualToString:@""])
    {
        detailField.text = existingTag;
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
