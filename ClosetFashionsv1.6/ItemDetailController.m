//
//  ItemDetailController.m
//  ClosetFash
//
//  Created by Anthony Tran on 4/12/15.
//
//

#import "ItemDetailController.h"
#import "DetailSelectController.h"
#import "Category.h"
#import "AppDelegate.h"
#import "Closet.h"
#import "ImageRecord.h"
#import "ItemViewController.h"
#import "NewDetailController.h"

@interface ItemDetailController ()

@end



@implementation ItemDetailController

@synthesize itemImage, detailsTable, itemImageView, detailCategories, currentracknum, currentcatnum, isEditingItem, existingRecord, organizerController;

Closet *myCloset;
ImageRecord *record;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    myCloset = appDelegate.myCloset;
    
    detailsTable.delegate = self;
    detailsTable.dataSource = self;
    
    itemImageView.image = self.itemImage;
    itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    detailCategories = @[@"Category", @"Type", @"Brand", @"Color", @"Occasion", @"Tag 1",@"Tag 2",@"Tag 3"];
    
    NSLog(@"details categories count %lu", [detailCategories count]);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"current rack num is %i", self.currentracknum);
    
    
    
    //self.navigationController.navigationBar.titl
    
    //UIImage *addimage = [UIImage imageNamed:@"AddPaw"];
    CGRect frameAdd = CGRectMake(0, 0, 50, 30);
    //init a normal UIButton using that image
    UIButton* addbutton = [[UIButton alloc] initWithFrame:frameAdd];
    //[addbutton setBackgroundImage:addimage forState:UIControlStateNormal];
    [addbutton setTitle:@"Save" forState:UIControlStateNormal];
    [addbutton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    if(isEditingItem){
        self.title = @"Edit Item";
        record = existingRecord;
    }
    else{
         self.title = @"New item";
         record = [[ImageRecord alloc] init];
    }
   
    
    [addbutton setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [addbutton addTarget:self action:@selector(saveItem) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* addDataButton = [[UIBarButtonItem alloc] initWithCustomView:addbutton];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,addDataButton,nil];

   
}


-(void) saveItem
{
    NSLog(@"saving here");
    if(isEditingItem)
    {
         [self performSegueWithIdentifier:@"SaveEditItemSegue" sender:nil];
    }
    else
    [self performSegueWithIdentifier:@"SaveItemSegue" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    int numRowsInSection =0;
    
    if (section == 0)
        numRowsInSection = 5;
    else if (section == 1)
        numRowsInSection = 3;
    else if (section == 2)
        numRowsInSection = 1;
    
    return numRowsInSection;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier;
    if (indexPath.section == 0){
        CellIdentifier = @"DetailCategoryCell";
    }
    else if (indexPath.section ==1){
        CellIdentifier = @"TagsCell";
    }
    else if (indexPath.section == 2){
        CellIdentifier = @"DeleteCell";
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    

    // Configure the cell...
    
    
    if (indexPath.section ==0)
        cell.textLabel.text = [detailCategories objectAtIndex:indexPath.row];
    else if (indexPath.section ==1){
        cell.textLabel.text = [detailCategories objectAtIndex:indexPath.row+5];
        
        NSLog(@"indexpath is section %i, row %i", (int)indexPath.section,(int)indexPath.row);
        NSLog(@"detail category is %@", cell.textLabel.text);
    }
    else if (indexPath.section ==2)
        cell.textLabel.text = @"Delete Item";
    

    
    UILabel *label;
    
    label = (UILabel*)[cell viewWithTag:4];
    
    //label.text = [detailCategories objectAtIndex:indexPath.row];
    
    if ([cell.textLabel.text isEqualToString:@"Category"])
    {
        if(isEditingItem)
            label.text = existingRecord.catName;
        else{
            Category *tempcat = [myCloset.categories objectAtIndex:self.currentcatnum];
            label.text = tempcat.categoryname;
            record.catName = tempcat.categoryname;
            record.categoryType = self.currentcatnum;
        }
    }
    else if ([cell.textLabel.text isEqualToString:@"Type"])
    {
        if(isEditingItem)
            label.text = existingRecord.rackName;
        else {
            Category *tempcat = [myCloset.categories objectAtIndex:self.currentcatnum];
            Rack *temprack = [tempcat.racksarray objectAtIndex:self.currentracknum];
        
            label.text = temprack.rackname;
            record.rackName = temprack.rackname;
        }
    }
    else if ([cell.textLabel.text isEqualToString:@"Brand"])
    {
        if(!isEditingItem)
        {
            label.text = @">";
            label.textAlignment = NSTextAlignmentRight;
        }
        else
            label.text = existingRecord.brand;
        
    }
    else if ([cell.textLabel.text isEqualToString:@"Color"])
    {
        if(!isEditingItem){
            label.text = @">";
            label.textAlignment = NSTextAlignmentRight;
        }
        else
            label.text = existingRecord.color;
    }
    else if ([cell.textLabel.text isEqualToString:@"Occasion"])
    {
        if(!isEditingItem){
            label.text = @">";
            label.textAlignment = NSTextAlignmentRight;
        }
        else
            label.text = existingRecord.occasion;
    }
    else if ([cell.textLabel.text isEqualToString:@"Tag 1"])
    {
        
        cell.tag = 1;
        if(!isEditingItem){
            label.text = @">";
            label.textAlignment = NSTextAlignmentRight;
        }
        else
            label.text = existingRecord.additionaltags;
    }
    else if ([cell.textLabel.text isEqualToString:@"Tag 2"])
    {
        
        cell.tag = 2;
        if(!isEditingItem){
            label.text = @">";
            label.textAlignment = NSTextAlignmentRight;
        }
        else
            label.text = existingRecord.tagTwo;
        
        NSLog(@"existing tag 2 is %@", existingRecord.tagTwo);
    }

    else if ([cell.textLabel.text isEqualToString:@"Tag 3"])
    {
       
        cell.tag = 3;
        if(!isEditingItem){
            label.text = @">";
            label.textAlignment = NSTextAlignmentRight;
        }
        else
            label.text = existingRecord.tagThree;
    }


    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:12.0];
    cell.textLabel.textColor =  [UIColor grayColor];
    cell.backgroundColor = [UIColor clearColor];
    NSLog(@"returning cell %@", cell.textLabel.text);
       return cell;
}

- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Delete Item" message:@"Are you sure you want to delete this item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        
        alert.delegate = self;
        
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex ==1)
    {
        NSLog(@"button %lu clicked, delete item", buttonIndex);

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
    // Return NO if you do n
 
 ot want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    
    if([segue.identifier isEqualToString:@"EditTagSegue"])
    {
        UITableViewCell *selectedCell = sender;
        NewDetailController *destController = [segue destinationViewController];
        
        destController.tagNum = (int)selectedCell.tag;
        
        if (destController.tagNum == 1)
            destController.existingTag = existingRecord.additionaltags;
        if (destController.tagNum == 2)
            destController.existingTag = existingRecord.tagTwo;
        if (destController.tagNum == 3)
            destController.existingTag = existingRecord.tagThree;
        
    }
    if ([segue.identifier isEqualToString:@"EditDetailSegue"])
    {
    
        UITableViewCell *selectedCell = sender;
        DetailSelectController *destController = [segue destinationViewController];
    
        destController.selectedDetailCatName = selectedCell.textLabel.text;
        destController.selectedCatNum = currentcatnum;
        destController.organizerController = self.organizerController;
        
        
        if ([destController.selectedDetailCatName isEqualToString:@"Category"])
        {
            NSLog(@"true");
        }
    
        NSLog(@"selected cell %@", destController.selectedDetailCatName);
    
    
        NSLog(@"opening detailselectcontroller");
    }
    if ([segue.identifier isEqualToString:@"SaveItemSegue"])
    {
        OrganizerController *destController = [segue destinationViewController];
        
        NSLog(@"current cat is %i, rack is %i", currentcatnum, currentracknum);
        
        [destController saveItem:record withImage:itemImage];
    }
    if ([segue.identifier isEqualToString:@"SaveEditItemSegue"])
    {
        ItemViewController *itemViewController = [segue destinationViewController];
        
        //update item label in itemview controllers
        
        NSString *brandstring;
        NSString *occasionstring;
        
        if([record.brand compare:@"N/A"]==NSOrderedSame) brandstring = @"";
        else brandstring = [NSString stringWithFormat:@"by %@",record.brand];
        
        if([record.occasion compare:@"N/A"]==NSOrderedSame) occasionstring = @"";
        else occasionstring = [NSString stringWithFormat:@"(Occasion: %@)",record.occasion];
        
        
        
        NSString *newdetails = [NSString stringWithFormat:@"%@ %@ %@ \n%@", record.color, record.rackName, brandstring, occasionstring];
        
        itemViewController.itemLabel.text = newdetails;
        
        [organizerController saveEditItem:record];
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    if([segue.sourceViewController isKindOfClass:[NewDetailController class]])
    {
        NewDetailController *tagEditController = segue.sourceViewController;
        
        
        NSString *newTag = tagEditController.detailField.text;
        
        NSLog(@"new detail is %@", newTag);
        
        
        if(tagEditController.tagNum == 1)
            record.additionaltags = newTag;
        else if (tagEditController.tagNum == 2)
            record.tagTwo = newTag;
        else if (tagEditController.tagNum == 3)
            record.tagThree = newTag;
        
        
        NSIndexPath *myIP = [NSIndexPath indexPathForRow:tagEditController.tagNum-1 inSection:1];
        
        UITableViewCell *cell = [self.detailsTable cellForRowAtIndexPath:myIP];
        
        UILabel *label;
        
        label = (UILabel*)[cell viewWithTag:4];
        
        label.text = [NSString stringWithString:newTag];

        

    }
    
    
    if ([segue.sourceViewController isKindOfClass:[DetailSelectController class]]) {
        DetailSelectController *detailSelectController = segue.sourceViewController;
        // if the user clicked Cancel, we don't want to change the color
        
        NSLog(@"selected detail WAS %@", detailSelectController.selectedDetailName);
        NSLog(@"selected detail cat row WAS %i", detailSelectController.selectedDetailCatTableRowNum);
        
        if(detailSelectController.selectedDetailCatTableRowNum == 0)
        {
            currentcatnum = detailSelectController.selectedDetailNum;
            
            NSIndexPath *rackIP = [NSIndexPath indexPathForRow:1 inSection:0];
            
            UITableViewCell *cell = [self.detailsTable cellForRowAtIndexPath:rackIP];
            
            UILabel *label;
            
            label = (UILabel*)[cell viewWithTag:4];
            
            Category *tempcat = [myCloset.categories objectAtIndex:self.currentcatnum];
            Rack *temprack = [tempcat.racksarray objectAtIndex:0];
            
            
            label.text = temprack.rackname;
            
            record.rackName = temprack.rackname;
            record.categoryType = currentcatnum;
            record.catName = detailSelectController.selectedDetailName;
           
        }
        
        if(detailSelectController.selectedDetailCatTableRowNum == 1)
        {
            currentracknum = detailSelectController.selectedDetailNum;
            record.rackName = detailSelectController.selectedDetailName;
        }
        
        if(detailSelectController.selectedDetailCatTableRowNum == 2)
        {
           
            record.brand = detailSelectController.selectedDetailName;
        }
        
        if(detailSelectController.selectedDetailCatTableRowNum == 3)
        {
          
            record.color = detailSelectController.selectedDetailName;
        }
        if(detailSelectController.selectedDetailCatTableRowNum == 4)
        {
            
            record.occasion = detailSelectController.selectedDetailName;
        }
    
        
    
        NSIndexPath *myIP = [NSIndexPath indexPathForRow:detailSelectController.selectedDetailCatTableRowNum inSection:0];
        
        UITableViewCell *cell = [self.detailsTable cellForRowAtIndexPath:myIP];
        
        UILabel *label;
        
        label = (UILabel*)[cell viewWithTag:4];
        
        label.text = [NSString stringWithString:detailSelectController.selectedDetailName];
        
        
        
        
    }
    
    
    
}


@end
