//
//  OutfitDetailController.m
//  ClosetFash
//
//  Created by Anthony Tran on 5/6/15.
//
//

#import "OutfitDetailController.h"
#import "DetailSelectController.h"
#import "Category.h"
#import "AppDelegate.h"
#import "Closet.h"
#import "OutfitRecord.h"
#import "ItemViewController.h"
#import "NewDetailController.h"
#import "DateSelectionController.h"
#import "DateRecord.h"

@interface OutfitDetailController ()

@end



@implementation OutfitDetailController

@synthesize outfitImage, detailsTable, outfitImageView, detailCategories, isEditingOutfit,record, organizerController, mixerController;

Closet *myCloset;
OutfitRecord *record;
NSMutableArray *selectedDatesArray;
NSDate *selectedDate;
NSDate *currentSelectedDate;


BOOL calremove;

static int calendarShadowOffset = (int)-20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    myCloset = appDelegate.myCloset;
    
    selectedDatesArray = [[NSMutableArray alloc] init];
    
    detailsTable.delegate = self;
    detailsTable.dataSource = self;
    
    outfitImageView.image = self.outfitImage;
    outfitImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    detailCategories = @[@"Category", @"Dates"];
    
    NSLog(@"details categories count %lu", [detailCategories count]);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //self.navigationController.navigationBar.titl
    
    //UIImage *addimage = [UIImage imageNamed:@"AddPaw"];
    CGRect frameAdd = CGRectMake(0, 0, 50, 30);
    //init a normal UIButton using that image
    UIButton* addbutton = [[UIButton alloc] initWithFrame:frameAdd];
    //[addbutton setBackgroundImage:addimage forState:UIControlStateNormal];
    [addbutton setTitle:@"Save" forState:UIControlStateNormal];
    [addbutton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];

    [addbutton setShowsTouchWhenHighlighted:YES];
    
    //set the button to handle clicks - this one calls a method called 'downloadClicked'
    [addbutton addTarget:self action:@selector(saveOutfit) forControlEvents:UIControlEventTouchDown];
    
    //finally, create your UIBarButtonItem using that button
    UIBarButtonItem* addDataButton = [[UIBarButtonItem alloc] initWithCustomView:addbutton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,addDataButton,nil];
    
    
    
    if(isEditingOutfit){
        self.title = @"Edit Outfit";
        
        
    }
    else{
        self.title = @"New Outfit";
        record = [[OutfitRecord alloc] init];
    }
    
    calremove = FALSE;
    
}


-(void) saveOutfit
{
    if ([record.categories count] == 0)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Select Category" message:@"Please select a category for this outfit." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
        
        [alert show];
        
    }
    else{
    
        NSLog(@"saving here");
        if(isEditingOutfit)
        {
            [self performSegueWithIdentifier:@"ConfirmEditSegue" sender:nil];
        }
        else
            [self performSegueWithIdentifier:@"SaveOufitSegue" sender:nil];
    }
    
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
    if(section ==0)
        return 1;
    else if(section ==1)
        return [record.categories count]+1;
    else if (section ==2)
        return [record.dates count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier;
    if (indexPath.row == 0 && indexPath.section ==0)
        CellIdentifier = @"OutfitNameCell";
    else if (indexPath.row == 0 && indexPath.section ==1)
        CellIdentifier = @"OutfitActiveDetailCell";
    else if (indexPath.row == 0 && indexPath.section ==2)
        CellIdentifier = @"OutfitActiveDateCell";
    else
        CellIdentifier = @"OutfitDetailCell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
  
    UILabel *label;
    
    label = (UILabel*)[cell viewWithTag:4];
    
    if (indexPath.section == 0){
        
            cell.textLabel.text = @"Outfit Name";
        
            if(![record.outfitName isEqualToString:@""])
                label.text = record.outfitName;
            else
                label.text = @">";
        
            label.textAlignment = NSTextAlignmentRight;
    
    }
    
    if (indexPath.section == 1){
     
        if(indexPath.row == 0){
            cell.textLabel.text = @"Categories";
            label.text = @"Categories";
        }
        else
            label.text = [record.categories objectAtIndex:indexPath.row -1];
    }
    
    
    if (indexPath.section == 2){
        
        if(indexPath.row == 0){
            cell.textLabel.text = @"Dates";
            label.text = @"Dates";
        }
        else{
            
            NSDate *date = [record.dates objectAtIndex:indexPath.row -1];
            
            int daysToAdd = 1;
            NSDate *newDate1 = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            
            NSDateComponents *componentsA = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:newDate1];
            
           
            
            NSInteger yearA = [componentsA year];
            NSInteger monthA = [componentsA month];
            NSInteger dayA = [componentsA day];
            
            NSString *dateLabel = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)monthA, (long)dayA, (long)yearA];
            
            NSLog(@"display date %@", date);
            
            label.text = dateLabel;
            
        }
    }
    
    if(indexPath.section != 0)
    [cell.textLabel setHidden:YES];
    
        
    
    if ([cell.textLabel.text isEqualToString:@"Categories"])
    {
        if(isEditingOutfit)
            //label.text = existingRecord.catName;
        /*else{
            
            //Category *tempcat = [myCloset.categories objectAtIndex:self.currentcatnum];
            //label.text = tempcat.categoryname;
            //record.catName = tempcat.categoryname;
            //record.categoryType = self.currentcatnum;
        }*/
            NSLog(@"asdf");
    }
    else if ([cell.textLabel.text isEqualToString:@"Dates"])
    {
        if(isEditingOutfit)
            //label.text = existingRecord.rackName;
        /*else {
       
            
         
        }*/
            
            NSLog(@"asdf");
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
 
    UITableViewCell *senderCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row ==0 && indexPath.section ==0)
        [self performSegueWithIdentifier:@"EditOutfitNameSegue" sender:senderCell];
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
 // Delete the row from the data source
     
     if (indexPath.section == 1)
        [record.categories removeObjectAtIndex:indexPath.row -1];
     else if (indexPath.section == 2)
         [record.dates removeObjectAtIndex:indexPath.row - 1];
     
     NSLog(@"deleting");
     
     
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
 // Return NO if you do n
 
 ot want the item to be re-orderable.
 return YES;
 }
 */


//CALENDAR METHODS

TKCalendarMonthView *calendar;


// Show/Hide the calendar by sliding it down/up from the top of the device.
- (IBAction)toggleCalendar {
    // If calendar is off the screen, show it, else hide it (both with animations)
    
 

    
    if(calremove == FALSE)
    {
        
        self.navigationController.navigationBar.userInteractionEnabled = NO;
        calendar = 	[[TKCalendarMonthView alloc] init];
        calendar.delegate = self;
        calendar.dataSource = self;
        // Add Calendar to just off the top of the screen so it can later slide down
        calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset+800, calendar.frame.size.width, calendar.frame.size.height);
        // Ensure this is the last "addSubview" because the calendar must be the top most view layer
        [self.view addSubview:calendar];
        [calendar reload];
        

        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.75];
        calendar.frame = CGRectMake(0, 215, calendar.frame.size.width, calendar.frame.size.height);
        
        
        
        

        
        [UIView commitAnimations];
        
        
    
        
        
        //set user interaction off!!!!!!!!!!!!!!!!!!!!!!!!!!!! ???
        
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        
        NSDateComponents *componentsA = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        
        //NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        //NSDateComponents *comp = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
        
        [componentsA setHour:8];
        NSDate *newtoday = [calendar dateFromComponents:componentsA];
        
        currentSelectedDate = newtoday;
        
        NSLog(@"toggle calendar %@", newtoday);
        
        
        calremove = TRUE;
        
        
    }
    
    
    else if(calremove == TRUE)
    {
        
        
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        NSLog(@"hide calendar");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.75];
        calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);
  
        
        [UIView commitAnimations];
    
        
        calremove = FALSE;
        
        
        
        [calendar removeFromSuperview];
        
        
    }
    
    
    
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods




- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
    NSLog(@"calendarMonthView didSelectDate");
    
    NSLog(@"did select date: %@", d);
    
    currentSelectedDate = d;
    
    BOOL duplicatedate = FALSE;
    
    

    for(int x = 0; x<[record.dates count]; x++)
    {
        NSDate *tempdate = [record.dates objectAtIndex:x];
        if([tempdate compare:d] == NSOrderedSame)
        {
            duplicatedate = TRUE;
            NSLog(@"duplicate");
            break;
        }
        
    }
    
    
    if(duplicatedate == FALSE)
    {
        if(!record.dates)
            record.dates = [[NSMutableArray alloc] init];
        
        [record.dates addObject:d];
        
        [record.dates sortUsingSelector:@selector(compare:)];
        
        [self.detailsTable reloadData];
    
        
    }

      [self toggleCalendar];
    
    
    /*
    
    if(viewInScrollOutfits.addselectionmode == TRUE)
    {
        viewInScrollOutfits.addselectionmode = FALSE;
        
        [outfitCategoryLabel setHidden:TRUE];
        [scrollcontain setHidden:TRUE];
        [clipview setHidden:TRUE];
        
        
        [self clearViewInScroll:viewInScrollOutfits];
        
        
    }
    
    
    [addOutfitButton setHidden:FALSE];
    
    //add add item button
    
    
    
    
    [self loadOutfitsFromDate:d];
     */
    
}


- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
    NSLog(@"calendarMonthView monthDidChange");
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
    NSLog(@"calendarMonthView marksFromDate toDate");
    NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
    // When testing initially you will have to update the dates in this array so they are visible at the
    // time frame you are testing the code.
    
   	NSMutableArray *data = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < [myCloset.dateRecords count]; x++)
    {
        DateRecord *temprecord = [myCloset.dateRecords objectAtIndex:x];
        NSDate *tempdate = temprecord.date;
        
        
        int daysToAdd = 1;
        NSDate *newDate1 = [tempdate dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd 00:00:00 +0000"];
    
        NSString *stringFromDate = [formatter stringFromDate:newDate1];
        
        
        NSLog(@"date from DATE RECORDS from daterecordclass is %@", tempdate);
        NSLog(@"date from DATE RECORDS is %@", stringFromDate);
        
        [data addObject:stringFromDate]; //instead of adding stringfromdate
    }
    
    
    // Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
    NSMutableArray *marks = [NSMutableArray array];
    
    // Initialise calendar to current type and set the timezone to never have daylight saving
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Construct DateComponents based on startDate so the iterating date can be created.
    // Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed
    // with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first
    // iterating date then times would go up and down based on daylight savings.
    

    
    
    NSDateComponents *componentsA = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
    //NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
    //                                          NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
    //                                fromDate:startDate];
    
    NSDate *d = [calendar dateFromComponents:componentsA];
    
    // Init offset components to increment days in the loop by one each time
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    
    
    // for each date between start date and end date check if they exist in the data array
    while (YES) {
        // Is the date beyond the last date? If so, exit the loop.
        // NSOrderedDescending = the left value is greater than the right
        if ([d compare:lastDate] == NSOrderedDescending) {
            break;
        }
        
        // If the date is in the data array, add it to the marks array, else don't
        if ([data containsObject:[d description]]) {
            [marks addObject:[NSNumber numberWithBool:YES]];
        } else {
            [marks addObject:[NSNumber numberWithBool:NO]];
        }
        
        // Increment day using offset components (ie, 1 day in this instance)
        d = [calendar dateByAddingComponents:offsetComponents toDate:d options:0];
    }
    
    
    return [NSArray arrayWithArray:marks];
}








#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"performing a segue");
    if([segue.identifier isEqualToString:@"EditOutfitNameSegue"])
    {
      
            UITableViewCell *selectedCell = (UITableViewCell *) sender;
        
            UILabel *label;
        
            label = (UILabel*)[selectedCell viewWithTag:4];
        
            NewDetailController *destController = [segue destinationViewController];
        
            destController.tagNum = 10;
        
            if (![label.text isEqualToString:@">"])
                destController.existingTag = label.text;
    }
    
    if ([segue.identifier isEqualToString:@"EditDetailSegue"])
    {
        
        UIButton *senderButton = (UIButton *) sender;
        
        UITableViewCell *selectedCell = (UITableViewCell *) senderButton.superview.superview;
        
        DetailSelectController *destController = [segue destinationViewController];
        
        destController.selectedDetailCatName = selectedCell.textLabel.text;
        //destController.selectedCatNum = currentcatnum;
        destController.organizerController = self.organizerController;
        destController.mixerController = self.mixerController;
        
        if ([destController.selectedDetailCatName isEqualToString:@"Category"])
        {
            NSLog(@"true");
        }
        
        NSLog(@"selected cell %@", destController.selectedDetailCatName);
        
        
        NSLog(@"opening detailselectcontroller");
    }
    if ([segue.identifier isEqualToString:@"SaveOutfitSegue"])
    {
        NSLog(@"perfmring save outfit segue");
  
    }
    if ([segue.identifier isEqualToString:@"ConfirmEditSegue"])
    {

            ItemViewController *itemViewController = [segue destinationViewController];
            itemViewController.itemLabel.text = record.outfitName;
            itemViewController.editMade = YES;
            [myCloset saveClosetArchive];
            NSLog(@"saving edit outfit");
        
    }
   
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{

    
    if([segue.sourceViewController isKindOfClass:[NewDetailController class]])
    {
        NewDetailController *outfitNameEditController = segue.sourceViewController;
        
        
        NSString *outfitName = outfitNameEditController.detailField.text;
        
        NSLog(@"new name is %@", outfitName);
        
        NSIndexPath *myIP = [NSIndexPath indexPathForRow:0 inSection:0];
        
        UITableViewCell *cell = [self.detailsTable cellForRowAtIndexPath:myIP];
        
        UILabel *label;
        
        label = (UILabel*)[cell viewWithTag:4];
        
        label.text = [NSString stringWithString:outfitName];
        
        record.outfitName = outfitName;
        
        
    }
    
    
    if ([segue.sourceViewController isKindOfClass:[DetailSelectController class]]) {
        DetailSelectController *detailSelectController = segue.sourceViewController;
        // if the user clicked Cancel, we don't want to change the color
        
        NSLog(@"selected detail WAS %@", detailSelectController.selectedDetailName);
        NSLog(@"selected detail cat row WAS %i", detailSelectController.selectedDetailCatTableRowNum);
        
        if(detailSelectController.selectedDetailCatTableRowNum == 100)
        {
            if (!record.categories)
                record.categories = [[NSMutableArray alloc] init];
            
            BOOL exists = FALSE;
            
            for (NSString* string in record.categories)
            {
                if ([string isEqualToString:detailSelectController.selectedDetailName])
                {
                    exists = TRUE;
                }
            }
            
            if (!exists){
                
                [record.categories addObject:detailSelectController.selectedDetailName];
                [record.categories sortUsingSelector:@selector(compare:)];
            }
            
            [self.detailsTable reloadData];
            
        }
        
        NSIndexPath *myIP = [NSIndexPath indexPathForRow:detailSelectController.selectedDetailCatTableRowNum inSection:0];
        
        UITableViewCell *cell = [self.detailsTable cellForRowAtIndexPath:myIP];
        
        UILabel *label;
        
        label = (UILabel*)[cell viewWithTag:4];
        
        label.text = [NSString stringWithString:detailSelectController.selectedDetailName];
        
    }
    
    
    if ([segue.sourceViewController isKindOfClass:[DateSelectionController class]]) {
        DateSelectionController *dateSelectionController = segue.sourceViewController;
        
    
        if (!record.dates)
            record.dates = [[NSMutableArray alloc] init];
        
        selectedDate = dateSelectionController.selectedDate;
        
        NSLog(@"selected date is %@", selectedDate);
        
        [record.dates addObject:selectedDate];
        
        [self.detailsTable reloadData];
    
        
    }
    
    
    
}


@end
