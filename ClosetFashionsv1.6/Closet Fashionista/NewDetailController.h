//
//  NewDetailController.h
//  ClosetFash
//
//  Created by Anthony Tran on 4/18/15.
//
//

#import <UIKit/UIKit.h>

@interface NewDetailController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *detailField;
@property (nonatomic, strong) NSString *existingTag;
@property (nonatomic, assign) int tagNum;

@end
