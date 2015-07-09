//
//  DetailSelectController.m
//  ClosetFash
//
//  Created by Anthony Tran on 4/13/15.
//
//

#import "DetailSelectController.h"
#import "AppDelegate.h"
#import "Closet.h"
#import "NewDetailController.h"

@interface DetailSelectController ()

@end

@implementation DetailSelectController

@synthesize detailTableView, selectedDetailCat, selectedDetailCatName, selectedDetailName, selectedDetailCatTableRowNum, selectedDetailNum, selectedCatNum, addDetailButton, organizerController, outfitRecord, mixerController;

Closet *myCloset;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    myCloset = appDelegate.myCloset;
    
    
    if([selectedDetailCatName isEqualToString:@"Category"])
    {
        NSMutableArray *temparray = [[NSMutableArray alloc] init ];
        
        for(int x = 0; x<[myCloset.categories count]; x++)
        {
            Category *tempcat = [myCloset.categories objectAtIndex:x];
            [temparray addObject:tempcat.categoryname];
        }
        
        selectedDetailCat = temparray;
        selectedDetailCatTableRowNum = 0;
        [addDetailButton setEnabled:NO];
        [addDetailButton setTitle:@""];
    }
    else if([selectedDetailCatName isEqualToString:@"Brand"])
    {
        selectedDetailCat = myCloset.brands;
        selectedDetailCatTableRowNum = 2;
    }
    else if ([selectedDetailCatName isEqualToString:@"Color"])
    {
        selectedDetailCat = myCloset.colors;
        selectedDetailCatTableRowNum = 3;
    }
    else if ([selectedDetailCatName isEqualToString:@"Occasion"])
    {
        selectedDetailCat = myCloset.occasions;
        selectedDetailCatTableRowNum = 4;
    }
    else if ([selectedDetailCatName isEqualToString:@"Type"])
    {
        selectedDetailCatTableRowNum = 1;
        [self updateTypes];
    }
    else if ([selectedDetailCatName isEqualToString:@"Categories"])
    {
        selectedDetailCat = myCloset.outfitCategories;
        selectedDetailCatTableRowNum = 100;
        
    }


    
    self.title = selectedDetailCatName;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) updateTypes
{
    NSMutableArray* temparray = [[NSMutableArray alloc] init];
    
 
    Category *tempcat = [myCloset.categories objectAtIndex:selectedCatNum];
    for(int x = 0; x<[tempcat.racksarray count]; x++)
    {
        Rack *temprack = [tempcat.racksarray objectAtIndex:x];
        [temparray addObject:temprack.rackname];
    }
    selectedDetailCat = temparray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [selectedDetailCat count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"DetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
    
    cell.textLabel.text = [selectedDetailCat objectAtIndex:indexPath.row];
    
    
    [cell.textLabel setHidden:NO];
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:15.0];
    cell.textLabel.textColor =  [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    
    NSLog(@"returning new data cells %@", cell.textLabel.text);
    return cell;
}

- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSLog(@"selected row");
    
    selectedDetailNum = (int) indexPath.row;
    

        selectedDetailName = [NSString stringWithString:[selectedDetailCat objectAtIndex:indexPath.row]];
        NSLog(@"did selected row: selected detail cat is %@ and detail num %i", selectedDetailCatName, selectedDetailNum);
        
        [self performSegueWithIdentifier:@"DetailSelectedSegue" sender:self];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if(![selectedDetailCatName isEqualToString:@"Type"])
        {
            
            [myCloset removeItem:  (int)indexPath.row fromDescriptor:selectedDetailCat];
            NSLog(@"deleted from-non-type");
            
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Delete Type" message:@"Deleting this type will also remove all of your items of this type.  Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
            
            alert.tag = indexPath.row;
            
            [alert show];
        
        }
        

        // Delete the row from the data source
       
        
    } /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   */
}

//delegate method for deletion of rack-type

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1)
    {
        
        NSLog(@"deleting row %i",(int) alertView.tag);
         NSIndexPath *deleteRowPath = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
        
        UITableViewCell *deleteCell = [detailTableView cellForRowAtIndexPath:deleteRowPath];
        
        NSLog(@"deleting rack named %@", deleteCell.textLabel.text);
        
        [organizerController deleteRack:deleteCell.textLabel.text fromCategory:[myCloset.categories objectAtIndex:selectedCatNum]];
        
        [self updateTypes];
        [self.detailTableView reloadData];
        [organizerController loadVerticalArchiveInViewInScroll:organizerController.racksScroll];
    }
    else if (buttonIndex == 0)
    {
        [self.detailTableView setEditing:NO animated:YES];
    }
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwinded to detail select controller");
    
    
    NewDetailController *detailController = [segue sourceViewController];
    
    NSString *newDetail = detailController.detailField.text;
    
    
    if ([selectedDetailCatName isEqualToString:@"Type"])
    {
        NSLog(@"add rack");
        
        [myCloset addNewRack:newDetail toCatNum:selectedCatNum];
        
        NSMutableArray* temparray = [[NSMutableArray alloc] init];
        Category *tempcat = [myCloset.categories objectAtIndex:selectedCatNum];
        for(int x = 0; x<[tempcat.racksarray count]; x++)
        {
            Rack *temprack = [tempcat.racksarray objectAtIndex:x];
            [temparray addObject:temprack.rackname];
        }
        selectedDetailCat = temparray;
        
    }
    else if([selectedDetailCatName isEqualToString:@"Categories"])
    {
        NSLog(@"adding new outfit category");
        [mixerController addNewOutfitCategory:newDetail];
    }
    else{
        [myCloset addItem:newDetail toDescriptionCat:selectedDetailCatName];
    }
    
    
    
    
    
    
    [self.detailTableView reloadData];
    
    [organizerController loadVerticalArchiveInViewInScroll:organizerController.racksScroll];

    
}

@end
