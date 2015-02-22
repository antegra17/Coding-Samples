//
//  Chart.m
//  PeePaws
//
//  Created by Anthony Tran on 10/13/14.
//  Copyright (c) 2014 Anthony Tran. All rights reserved.
//

#import "Chart.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "GrowthDataPoint.h"
#import "PuppyData.h"
#import "PuppyProfile.h"



@implementation Chart

@synthesize mode, totalTimeFrameWeeks;



HomeViewController *homeViewController;
UINavigationController *homeNavigationController;
AppDelegate *appDelegate;

NSArray *equationCompOne;
NSArray *equationCompTwo;
NSArray *equationCompThree;

int growthCurveOne;
int growthCurveTwo;


-(id)initWithFrame:(CGRect)frame
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (self = [super initWithFrame:frame])
    {
        
        UITabBarController *tabController = (UITabBarController *) appDelegate.window.rootViewController;
        homeNavigationController = [tabController.viewControllers objectAtIndex:0];
        //mainViewController = [homeNavigationController.viewControllers objectAtIndex:0];
        homeViewController = [homeNavigationController.viewControllers objectAtIndex:0];
        
     NSLog(@"growth data # %ld", (long)[homeViewController.puppyData.growthdata count]);
    

    }
    
    self.mode = 0;
    //mode 0 = all time
    //mode 1 = last 52 weeks
    //mode 2 = last 12 weeks
    
    
    
    equationCompOne = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:-0.0202],
                       [NSNumber numberWithFloat:-0.0184],
                       [NSNumber numberWithFloat:-0.0163],
                       [NSNumber numberWithFloat:-0.0143],
                       [NSNumber numberWithFloat:-0.0118],
                       [NSNumber numberWithFloat:-0.0157],
                       [NSNumber numberWithFloat:-0.0134],
                       [NSNumber numberWithFloat:-0.0111],
                       [NSNumber numberWithFloat:-0.0088],
                       [NSNumber numberWithFloat:-0.0071],
                       [NSNumber numberWithFloat:-0.0051],
                       [NSNumber numberWithFloat:-0.003],
                       [NSNumber numberWithFloat:-0.001],nil];
    
    equationCompTwo = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:3.1949],
                       [NSNumber numberWithFloat:2.8998],
                       [NSNumber numberWithFloat:2.556],
                       [NSNumber numberWithFloat:2.2122],
                       [NSNumber numberWithFloat:1.8058],
                       [NSNumber numberWithFloat:1.8558],
                       [NSNumber numberWithFloat:1.5229],
                       [NSNumber numberWithFloat:1.19],
                       [NSNumber numberWithFloat:0.8571],
                       [NSNumber numberWithFloat:0.6728],
                       [NSNumber numberWithFloat:0.4787],
                       [NSNumber numberWithFloat:0.2847],
                       [NSNumber numberWithFloat:0.0907],nil];
    
    equationCompThree = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:3.2469],
                       [NSNumber numberWithFloat:2.5099],
                       [NSNumber numberWithFloat:2.427],
                       [NSNumber numberWithFloat:2.3442],
                       [NSNumber numberWithFloat:3.0593],
                       [NSNumber numberWithFloat:-0.338],
                       [NSNumber numberWithFloat:-0.2529],
                       [NSNumber numberWithFloat:-0.1677],
                       [NSNumber numberWithFloat:-0.0826],
                       [NSNumber numberWithFloat:-0.0895],
                       [NSNumber numberWithFloat:-0.0499],
                       [NSNumber numberWithFloat:-0.0109],
                       [NSNumber numberWithFloat:-0.0282],nil];
    
    
    growthCurveOne = 20;
    growthCurveTwo = 20;
    
    self.project = TRUE;
    return self;
}



-(NSArray *)sortedDataPoints {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    
    return [(NSSet*)homeViewController.puppyData.growthdata sortedArrayUsingDescriptors:sortDescriptors];
    
}



-(int) returnTimeFrame
{
   
    int timeFrame = 0;

     NSDate *dateB = [NSDate date];
     NSDate *dateA = homeViewController.puppyData.profile.dob;

        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                   fromDate:dateA
                                                     toDate:dateB
                                                    options:0];
    
        timeFrame = (int) components.day;
    
    totalTimeFrameWeeks = ceilf(timeFrame/7)+1;
    
    if (mode == 1 && timeFrame > 365)
        timeFrame = 365;
    if (mode == 2 && timeFrame > 84)
        timeFrame = 84;
    
    
    NSLog(@"longest timeframe is %i", timeFrame);
    return timeFrame;
}


-(NSInteger) returnLargestWeight
{
    NSNumber *largestWeight;
    
    largestWeight = [NSNumber numberWithInteger:0];
    
    NSArray *sortedDataPoints = [self sortedDataPoints];
    
    
    for (GrowthDataPoint *datapoint in sortedDataPoints)
    {
        NSNumber *tempWeight = datapoint.weight;
        
        if([tempWeight integerValue] > [largestWeight integerValue])
        {
            largestWeight = tempWeight;
            
        }
        
        
    }
    
    NSLog(@"largest weight is %ld", [largestWeight integerValue]);
    return [largestWeight integerValue];
}

-(NSInteger) returnLowestWeightWithinTimeFrame
{
    NSNumber *lowestWeight;
    
    lowestWeight = [NSNumber numberWithInteger:500];
    
    NSArray *sortedDataPoints = [self sortedDataPoints];
    
    
    int timeFrame = 0;
    
    NSDate *dateB = [NSDate date];
   
    int testTime = 10000;
    
    if (mode == 1)
        testTime = 365;
    if (mode ==2)
        testTime = 84;
    
    for (GrowthDataPoint *datapoint in sortedDataPoints)
    {
        
        NSDate *dateA = datapoint.date;
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                   fromDate:dateA
                                                     toDate:dateB
                                                    options:0];
        
        timeFrame = (int) components.day;
        
       
        
        
        
        NSNumber *tempWeight = datapoint.weight;
        
        if([tempWeight integerValue]  < [lowestWeight integerValue])
        {
            if (timeFrame < testTime)
            {
                lowestWeight = tempWeight;
            }
            
        }
        
        
    }
    
    NSLog(@"lowest weight is %ld in %i days", [lowestWeight integerValue], timeFrame);
    return [lowestWeight integerValue];
}



-(void) toggleProject
{
    if (self.project == TRUE)
    {
        NSLog(@"toggle project off");
        self.project = FALSE;
    }else {
        NSLog(@"toggle project on");
        self.project = TRUE;
    }
}

- (void)drawRect:(CGRect)rect
{


    for (UILabel *removeLabel in self.subviews)
    {
        if([removeLabel isKindOfClass:[UILabel class]])
        {
            [removeLabel removeFromSuperview];
        }        
    }
    
    CGRect newSize = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    
    self.frame = newSize;
    
    float timeFrameDays = (float) [self returnTimeFrame];
    float largestWeightPounds = (float) [self returnLargestWeight];
    float floatLowestWeightPounds;
    int lowestWeightPounds = 0;
    
    
    
     [self determineGrowthCurves];
    
    if(self.project && mode == 0)
    {
        if(growthCurveOne >=0 && growthCurveOne <= 4){
            timeFrameDays = 70 *7;
        }
        if(growthCurveOne >=5 && growthCurveOne <= 8){
            timeFrameDays = 48 *7;
        }
        if(growthCurveOne >=9 && growthCurveOne <= 12){
            timeFrameDays = 36 *7;
        }
        
        totalTimeFrameWeeks = timeFrameDays/7;
        
        
        if(growthCurveOne == 0) largestWeightPounds = 130;
        if(growthCurveOne == 1) largestWeightPounds = 115;
        if(growthCurveOne == 2) largestWeightPounds = 105;
        if(growthCurveOne == 3) largestWeightPounds = 90;
        if(growthCurveOne == 4) largestWeightPounds = 75;
        if(growthCurveOne == 5) largestWeightPounds = 55;
        if(growthCurveOne == 6) largestWeightPounds = 45;
        if(growthCurveOne == 7) largestWeightPounds = 35;
        if(growthCurveOne == 8) largestWeightPounds = 25;
        if(growthCurveOne == 9) largestWeightPounds = 20;
        if(growthCurveOne == 10) largestWeightPounds = 15;
        if(growthCurveOne == 11) largestWeightPounds = 10;
        if(growthCurveOne == 12) largestWeightPounds = 5;
        
    }
    
    NSLog(@"largest is %f, lowest is %i", largestWeightPounds, lowestWeightPounds);

    
    int yScaleMultiple = 2;
    int remainderCheckYScaleLabel = 2;
    
    
    
    if(largestWeightPounds - lowestWeightPounds > 20){
        remainderCheckYScaleLabel = 5;
        yScaleMultiple = 5;
    }
    
    
    if(largestWeightPounds - lowestWeightPounds > 60){
        remainderCheckYScaleLabel = 10;
        yScaleMultiple = 10;
        
    }
    
    

    NSLog(@"multiple is %i", yScaleMultiple);
    
    if(mode ==0)
        lowestWeightPounds = 0;
    else{
        floatLowestWeightPounds = (float) [self returnLowestWeightWithinTimeFrame];
        
        if (floatLowestWeightPounds <= 6)
        {
            lowestWeightPounds = 0;
        }
        else{
            
            lowestWeightPounds = (int) ceilf(floatLowestWeightPounds);
            
            int weightOffset = lowestWeightPounds%yScaleMultiple;
            
            lowestWeightPounds = lowestWeightPounds-weightOffset;
            
            NSLog(@"lowest weight pounds is %f, %i", floatLowestWeightPounds, lowestWeightPounds);
        }
    }
    

    
    
    int timeFrameWeeks = ceilf(timeFrameDays/7)+1;
    int weightIntervals = ceilf(largestWeightPounds)+yScaleMultiple;
    
    weightIntervals = (weightIntervals+yScaleMultiple)/yScaleMultiple;
    
    NSLog(@"weight intervals before doubling %i", weightIntervals);
    
    weightIntervals = weightIntervals*2; //so each 'whole' interval has a line midline
    
    
    
    NSLog(@"largest weight pounds is %f, weight intervals %i", largestWeightPounds, weightIntervals);
    
    

    
    if([[self sortedDataPoints] count] ==0)
    {
        weightIntervals = 10;
        lowestWeightPounds = 0;
        timeFrameWeeks = 13;
        totalTimeFrameWeeks = 12;
    }
    
    NSLog(@"unrounded: %f, timeframe weeks is %i", timeFrameDays/7, timeFrameWeeks);
    
    NSLog(@"days: %f days, largest weight: %f", timeFrameDays, largestWeightPounds);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    float gridFromX;
    float gridFromY;
    float gridToX;
    float gridToY;
    float growthViewContentSize = 0;
    
    float spacing = (self.frame.size.width-15)/timeFrameWeeks;
    
    int correctedIntervals = (weightIntervals - (lowestWeightPounds/yScaleMultiple));
    
    float weightSpacing = (self.frame.size.height-15)/correctedIntervals;
    
    
    NSLog(@"%f spacing, frame width %f", spacing, self.frame.size.width);
    
    
    int startingWeek = 1;
    
    if(mode == 1 && totalTimeFrameWeeks > 52)
        startingWeek = totalTimeFrameWeeks - 51;
    if(mode == 2 && totalTimeFrameWeeks > 12)
        startingWeek = totalTimeFrameWeeks - 11;
    
    NSLog(@"starting week is %i, total %i", startingWeek, totalTimeFrameWeeks);
    
    
    
   

    for (int x = 1; x <= timeFrameWeeks; x++)
    {
        
        UILabel *xScaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+(x*spacing), self.frame.size.height - 10, 20,10)];
        xScaleLabel.font = [UIFont fontWithName:@"Chalkduster" size:7];
        xScaleLabel.textColor = [UIColor whiteColor];
        xScaleLabel.textAlignment = NSTextAlignmentCenter;
        xScaleLabel.text = [NSString stringWithFormat:@"%i", startingWeek];
        
        NSLog(@"week %i of %i", x, timeFrameWeeks);
        
      
        int weekDivisor =1;
        
        if (totalTimeFrameWeeks > 16)
        {
            if (mode ==0 || mode ==1)
                weekDivisor = 2;
            else weekDivisor =1;
        }
        
        if (totalTimeFrameWeeks > 28)
        {
            if (mode ==0 || mode ==1)
                weekDivisor = 5;
            else weekDivisor =2;
        }
        
        
        if (totalTimeFrameWeeks > 78)
        {
            if (mode ==0)
                weekDivisor = 10;
            else if (mode ==1)
                weekDivisor = 5;
            else weekDivisor =2;
        }
        
        
        
        
        gridFromX = 15+(x*spacing);
        gridFromY = self.frame.size.height-15;
        gridToX = 15+(x*spacing);
        gridToY = 0;
        
        if(startingWeek%weekDivisor == 0 && gridFromX < self.superview.frame.size.width - 5){
        
            [self addSubview:xScaleLabel];

            
            CGContextSetLineWidth(ctx, 0.2);
            CGContextSetStrokeColorWithColor(ctx,
                                         [UIColor whiteColor].CGColor);
        
        
            CGContextMoveToPoint(ctx, gridFromX, gridFromY);
            CGContextAddLineToPoint(ctx, gridToX, gridToY);
            CGContextStrokePath(ctx);
        }
        
        growthViewContentSize = 15+(x*spacing);
        
        self.frame = CGRectMake(0, 0, growthViewContentSize, self.frame.size.height);
        startingWeek++;

    }

    
    NSLog(@"remainder check %i", remainderCheckYScaleLabel);
    
   
    int lowestWeightPoundsIncreasing = lowestWeightPounds;
    
    
    
    NSLog(@"weight intervals %i, lowest %i", weightIntervals, lowestWeightPounds);
    
    
    int yCount = 1;
    
   
    
    for (int y = yCount; yCount <= correctedIntervals;yCount++)
    {
    
        
        UILabel *yScaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-3, self.frame.size.height -20 - (weightSpacing *(yCount-1)), 18,10)];
        yScaleLabel.font = [UIFont fontWithName:@"Chalkduster" size:7];
        yScaleLabel.textColor = [UIColor whiteColor];
        yScaleLabel.textAlignment = NSTextAlignmentCenter;
        yScaleLabel.text = [NSString stringWithFormat:@"%i", lowestWeightPoundsIncreasing];
    
        NSLog(@"loest weight pounds increasing %i", lowestWeightPoundsIncreasing);
        NSLog(@"%i weight intervals, %i y multiple", weightIntervals, yScaleMultiple);
        
        
        float correctedMultiple = (float) yScaleMultiple/2;
        NSLog(@"compare to %f", weightIntervals*correctedMultiple);
        NSLog(@"%i corrected weight intervals", correctedIntervals);
        NSLog(@"%i loop intervals", yCount);
        NSLog(@"%i remaindercheck", remainderCheckYScaleLabel);
        
     
        if(yCount %2 !=0 && (lowestWeightPoundsIncreasing <= weightIntervals*correctedIntervals))
        {
            NSLog(@"adding Y label");
            
            [self addSubview:yScaleLabel];
            
            lowestWeightPoundsIncreasing = lowestWeightPoundsIncreasing + yScaleMultiple;
        }
       
        gridFromX = 15;
        gridFromY = yCount*weightSpacing;
        gridToX = growthViewContentSize;
        gridToY = yCount*weightSpacing;
        
        
        NSLog(@"y line position %f, %i is count, %f is weight spacing", gridFromY,y,weightSpacing);
        
        
        CGContextSetLineWidth(ctx, 0.2);
        CGContextSetStrokeColorWithColor(ctx,
                                         [UIColor whiteColor].CGColor);
        
        CGContextMoveToPoint(ctx, gridFromX, gridFromY);
        CGContextAddLineToPoint(ctx, gridToX, gridToY);
        CGContextStrokePath(ctx);
        
        
    
        
    }
    
    
    
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    [f setMaximumFractionDigits:2];
    
    float xCoord;
    float fromX =0;
    float fromY =0;
    float toX;
    float toY;
    
    //begin draw puppy growth data

    for (GrowthDataPoint *datapoint in [self sortedDataPoints])
    {
      
      
        
        // Determine age in days
        
        NSDate *dateA;
    
        dateA = homeViewController.puppyData.profile.dob;
    

        NSDate *dateB = datapoint.date;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                   fromDate:dateA
                                                     toDate:dateB
                                                    options:0];
        
        xCoord = (int) components.day;
        float weeks = xCoord/7;
        
        if (mode == 1  && totalTimeFrameWeeks > 52)
            weeks = weeks - (totalTimeFrameWeeks - 52);
        if (mode == 2 && totalTimeFrameWeeks > 12)
            weeks = weeks - (totalTimeFrameWeeks - 12);
        
        xCoord = 15+(weeks)*spacing;
        
        
        //*determine age in days
        
        
        
        NSString *temp = [f stringFromNumber:datapoint.weight];
        
        double weight = [datapoint.weight doubleValue];
        NSLog(@"chart data is age %f weeks, weight %@", weeks, temp);
        
        toX = xCoord;
        
        toY = self.frame.size.height - 15 -(((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
       

        
        NSLog(@"point weight is %f, lowest weight pounds %i", weight, lowestWeightPounds);
        
        
        
        if (fromX && fromY && (int)fromY != 0)
        {
            
            NSLog(@"FROMX %f, toX %f, fromY %f, toY %f", fromX, toX, fromY, toY);
            
            if(fromX < 15 && toX >=15)
            {
                NSLog(@"crossing Y axis!!");
                
                float slope = (toX-fromX)/(toY-fromY);
                
                float changeXtoYAxis = (-1*fromX)+15;
                float changeY = changeXtoYAxis/slope;
                
                fromX = 15;
                fromY = fromY+changeY;
                
                NSLog(@"NEW FROMX %f, new FROMY %f", fromX, fromY);
                CGContextMoveToPoint(ctx, fromX, fromY);
            }
            
            
            float xAxisYCoord = correctedIntervals * weightSpacing;
            
            if(fromY > xAxisYCoord && toY < xAxisYCoord)
            {
                NSLog(@"crossing X axis!!");
                
                float slope = (toX-fromX)/(fromY - toY);
                
                
                
                float changeYtoXAxis = fromY - xAxisYCoord;
                float changeX = slope*changeYtoXAxis;
                
                NSLog(@"change Y is %f, change X is %f, slope is %f", changeYtoXAxis, changeX, slope);
                
                fromX = fromX+changeX;
                fromY = xAxisYCoord;
                
                NSLog(@"NEW FROMX %f, new FROMY %f", fromX, fromY);
                CGContextMoveToPoint(ctx, fromX, fromY);
            }
            
            if(toX >=15){
                            CGContextAddLineToPoint(ctx, toX, toY);
                            CGContextStrokePath(ctx);
            }
            
            
            
        }
        
        
        fromX = xCoord;
        fromY = self.frame.size.height - 15 - (((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
        
        
        
        CGContextSetLineWidth(ctx, 2.0);
        CGContextSetStrokeColorWithColor(ctx,
                                         [UIColor whiteColor].CGColor);
        
        if(toX >=15){
        
            CGRect rectangle = CGRectMake(fromX-3,fromY-3,6,6);
            CGContextAddEllipseInRect(ctx, rectangle);
        
        
            CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
        }
        
        CGContextSetAlpha(ctx,1);
        CGContextFillPath(ctx);
        
        CGContextMoveToPoint(ctx, fromX, fromY);
        
        
    }  //end draw puppy growth points

    
   
    int maxMaturityOne = 0;
    int maxMaturityTwo = 0;
    
    double weightAtMaturityOne =0;
    double weightAtMaturityTwo =0;
    
    fromX=0;
    fromY=0;
    
    
   if(mode == 0 && growthCurveOne < 20 && growthCurveTwo < 20 && self.project && [[self sortedDataPoints] count] > 0){
       
       
       
       NSMutableArray *startFillCoordX = [[NSMutableArray alloc] init];
       NSMutableArray *startFillCoordY = [[NSMutableArray alloc] init];
       NSMutableArray *endFillCoordX = [[NSMutableArray alloc] init];
       NSMutableArray *endFillCoordY = [[NSMutableArray alloc] init];
       
    
    
    //begin draw reference curve ONE
    
    
    if(growthCurveOne >=0 && growthCurveOne <= 4)
        maxMaturityOne = 70;
    if(growthCurveOne >=5 && growthCurveOne <= 8)
        maxMaturityOne = 48;
    if(growthCurveOne >=9 && growthCurveOne <= 12)
        maxMaturityOne = 36;
    
    
    float compOne;
    float compTwo;
    float compThree;
    
    NSNumber *tempNSNumberOne = [equationCompOne objectAtIndex:growthCurveOne];
    NSNumber *tempNSNumberTwo = [equationCompTwo objectAtIndex:growthCurveOne];
    NSNumber *tempNSNumberThree = [equationCompThree objectAtIndex:growthCurveOne];
    
    
    compOne = [tempNSNumberOne floatValue];
    compTwo = [tempNSNumberTwo floatValue];
    compThree = [tempNSNumberThree floatValue];
    
    NSLog(@"comp values %f, %f, %f", compOne,compTwo, compThree);
    
    

    
    for (int x = 0; x < maxMaturityOne+2; x=x+2)
    {
        
        
        float weeks = (float) x;
        
        if (mode == 1  && totalTimeFrameWeeks > 52)
            weeks = weeks - (totalTimeFrameWeeks - 52);
        if (mode == 2 && totalTimeFrameWeeks > 12)
            weeks = weeks - (totalTimeFrameWeeks - 12);
        
        xCoord = 15+(weeks)*spacing;
        
    
        float weight = compOne*pow(x, 2) + compTwo*x + compThree;
        
        
        weightAtMaturityOne = (double) (compOne*pow(maxMaturityOne, 2) + compTwo*maxMaturityOne + compThree);
        
        NSLog(@"chart data is age %f weeks, weight %f", weeks, weight);
        
        toX = xCoord;
        toY = self.frame.size.height - 15 -(((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
        
        
        NSLog(@"point weight is %f, lowest weight pounds %i", weight, lowestWeightPounds);
        
        
        
        if (fromX && fromY && (int)fromY != 0)
        {
            
            NSLog(@"FROMX %f, toX %f, fromY %f, toY %f", fromX, toX, fromY, toY);
            
            if(fromX < 15 && toX >=15)
            {
                NSLog(@"crossing Y axis!!");
                
                float slope = (toX-fromX)/(toY-fromY);
                
                float changeXtoYAxis = (-1*fromX)+15;
                float changeY = changeXtoYAxis/slope;
                
                fromX = 15;
                fromY = fromY+changeY;
                
                NSLog(@"NEW FROMX %f, new FROMY %f", fromX, fromY);
                CGContextMoveToPoint(ctx, fromX, fromY);
            }
            
            
            float xAxisYCoord = correctedIntervals * weightSpacing;
            
            if(fromY > xAxisYCoord && toY < xAxisYCoord)
            {
                NSLog(@"crossing X axis!!");
                
                float slope = (toX-fromX)/(fromY - toY);
                
                
                
                float changeYtoXAxis = fromY - xAxisYCoord;
                float changeX = slope*changeYtoXAxis;
                
                NSLog(@"change Y is %f, change X is %f, slope is %f", changeYtoXAxis, changeX, slope);
                
                fromX = fromX+changeX;
                fromY = xAxisYCoord;
                
                NSLog(@"NEW FROMX %f, new FROMY %f", fromX, fromY);
                CGContextMoveToPoint(ctx, fromX, fromY);
            }
            
            if(toX >=15){
                CGContextAddLineToPoint(ctx, toX, toY);
                CGContextStrokePath(ctx);
            }
            
            
            
        }
        
        
        fromX = xCoord;
        fromY = self.frame.size.height - 15 - (((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
        
        
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx,
                                         [UIColor yellowColor].CGColor);
        
     
        
        CGContextSetAlpha(ctx,0.75);
        CGContextFillPath(ctx);
        
        CGContextMoveToPoint(ctx, fromX, fromY);
        
        
    }
    //end draw ref growth curve ONE
       
       
       // create coordinates for fill-in from curve one
       
       for (float x = 0; x < maxMaturityOne; x=x+0.5)
       {
           
           
           float weeks = (float) x;
           
           if (mode == 1  && totalTimeFrameWeeks > 52)
               weeks = weeks - (totalTimeFrameWeeks - 52);
           if (mode == 2 && totalTimeFrameWeeks > 12)
               weeks = weeks - (totalTimeFrameWeeks - 12);
           
           xCoord = 15+(weeks)*spacing;
           
           
           float weight = compOne*pow(x, 2) + compTwo*x + compThree;
           
           NSLog(@"chart data is age %f weeks, weight %f", weeks, weight);
           
           toX = xCoord;
           toY = self.frame.size.height - 15 -(((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
           
           [startFillCoordX addObject:[NSNumber numberWithFloat:toX]];
           [startFillCoordY addObject:[NSNumber numberWithFloat:toY]];
       } //end fill-in coordinates from curve one
    
    //begin draw reference curve TWO
    
    fromX = 0;
    fromY = 0;
    
  
    
  

    tempNSNumberOne = [equationCompOne objectAtIndex:growthCurveTwo];
    tempNSNumberTwo = [equationCompTwo objectAtIndex:growthCurveTwo];
    tempNSNumberThree = [equationCompThree objectAtIndex:growthCurveTwo];
    
    
    compOne = [tempNSNumberOne floatValue];
    compTwo = [tempNSNumberTwo floatValue];
    compThree = [tempNSNumberThree floatValue];
    
    NSLog(@"comp values %f, %f, %f", compOne,compTwo, compThree);
    
        if(growthCurveTwo >=0 && growthCurveTwo <= 4)
            maxMaturityTwo = 70;
        if(growthCurveTwo >=5 && growthCurveTwo <= 8)
            maxMaturityTwo = 48;
        if(growthCurveTwo >=9 && growthCurveTwo <= 12)
            maxMaturityTwo = 36;
    
    
    for (int x = 0; x < maxMaturityOne+2; x=x+2)
    {
        
        
        float weeks = (float) x;
        
        if (mode == 1  && totalTimeFrameWeeks > 52)
            weeks = weeks - (totalTimeFrameWeeks - 52);
        if (mode == 2 && totalTimeFrameWeeks > 12)
            weeks = weeks - (totalTimeFrameWeeks - 12);
        
        xCoord = 15+(weeks)*spacing;
        
        
        float weight = compOne*pow(x, 2) + compTwo*x + compThree;
    
         weightAtMaturityTwo = (double) (compOne*pow(maxMaturityTwo, 2) + compTwo*maxMaturityTwo + compThree);
        
        NSLog(@"chart data is age %f weeks, weight %f", weeks, weight);
        
        toX = xCoord;
        if(maxMaturityTwo < maxMaturityOne && x > maxMaturityTwo)
        {
            toY = toY;
        }
        else  toY = self.frame.size.height - 15 -(((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
        
    
        
        
        
        NSLog(@"point weight is %f, lowest weight pounds %i", weight, lowestWeightPounds);
        
        
        
        if (fromX && fromY && (int)fromY != 0)
        {
            
            NSLog(@"FROMX %f, toX %f, fromY %f, toY %f", fromX, toX, fromY, toY);
            
            if(fromX < 15 && toX >=15)
            {
                NSLog(@"crossing Y axis!!");
                
                float slope = (toX-fromX)/(toY-fromY);
                
                float changeXtoYAxis = (-1*fromX)+15;
                float changeY = changeXtoYAxis/slope;
                
                fromX = 15;
                fromY = fromY+changeY;
                
                NSLog(@"NEW FROMX %f, new FROMY %f", fromX, fromY);
                CGContextMoveToPoint(ctx, fromX, fromY);
            }
            
            
            float xAxisYCoord = correctedIntervals * weightSpacing;
            
            if(fromY > xAxisYCoord && toY < xAxisYCoord)
            {
                NSLog(@"crossing X axis!!");
                
                float slope = (toX-fromX)/(fromY - toY);
                
                
                
                float changeYtoXAxis = fromY - xAxisYCoord;
                float changeX = slope*changeYtoXAxis;
                
                NSLog(@"change Y is %f, change X is %f, slope is %f", changeYtoXAxis, changeX, slope);
                
                fromX = fromX+changeX;
                fromY = xAxisYCoord;
                
                NSLog(@"NEW FROMX %f, new FROMY %f", fromX, fromY);
                CGContextMoveToPoint(ctx, fromX, fromY);
            }
            
            if(toX >=15){
                
                CGContextAddLineToPoint(ctx, toX, toY);
                CGContextStrokePath(ctx);
            }
            
            
            
        }
        
        
        fromX = xCoord;
        
        if(maxMaturityTwo < maxMaturityOne && x > maxMaturityTwo)
        {
            fromY = fromY;
        }
        else fromY = self.frame.size.height - 15 - (((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
        
        
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx,
                                         [UIColor yellowColor].CGColor);
        
        
        
        CGContextSetAlpha(ctx,0.75);
        CGContextFillPath(ctx);
        
        CGContextMoveToPoint(ctx, fromX, fromY);
        
        
    }
    //end draw ref growth curve TWO
       
       
       // create coordinates for fill-in from curve two
       
       for (float x = 0; x < maxMaturityOne; x=x+0.5)
       {
           
           
           float weeks = (float) x;
           
           if (mode == 1  && totalTimeFrameWeeks > 52)
               weeks = weeks - (totalTimeFrameWeeks - 52);
           if (mode == 2 && totalTimeFrameWeeks > 12)
               weeks = weeks - (totalTimeFrameWeeks - 12);
           
           xCoord = 15+(weeks)*spacing;
           
           
           float weight = compOne*pow(x, 2) + compTwo*x + compThree;
           
           NSLog(@"chart data is age %f weeks, weight %f", weeks, weight);
           
           toX = xCoord;
           if(maxMaturityTwo < maxMaturityOne && x > maxMaturityTwo)
           {
               toY = toY;
           }
           else toY = self.frame.size.height - 15 -(((weight-lowestWeightPounds)/yScaleMultiple)*(weightSpacing*2));
           
           [endFillCoordX addObject:[NSNumber numberWithFloat:toX]];
           [endFillCoordY addObject:[NSNumber numberWithFloat:toY]];
       } //end fill-in coordinates from curve two
       
       
       //begin FILL-IN
       
    
       

  
       NSNumber *startFillXNSNumber;
       NSNumber *startFillYNSNumber;
       NSNumber *endFillXNSNumber;
       NSNumber *endFillYNSNumber;
       
       
       for (int x =0; x < [endFillCoordX count]; x++)
       {
           startFillXNSNumber = [startFillCoordX objectAtIndex:x];
           startFillYNSNumber = [startFillCoordY objectAtIndex:x];
           endFillXNSNumber = [endFillCoordX objectAtIndex:x];
           endFillYNSNumber = [endFillCoordY objectAtIndex:x];
           
           CGContextSetLineWidth(ctx, 2.5);
           CGContextSetStrokeColorWithColor(ctx,
                                            [UIColor yellowColor].CGColor);
           
           
           
           CGContextSetAlpha(ctx,0.25);
           
           CGContextMoveToPoint(ctx, [startFillXNSNumber floatValue], [startFillYNSNumber floatValue]);
           CGContextAddLineToPoint(ctx, [endFillXNSNumber floatValue], [endFillYNSNumber floatValue]);
           CGContextStrokePath(ctx);
       }
       
       
       NSString *projectLabelTemp;
       
       if(weightAtMaturityOne == weightAtMaturityTwo && growthCurveOne ==0)
           projectLabelTemp = [NSString stringWithFormat:@"%@'s projected adult weight range is above %.2f pounds.", homeViewController.puppyData.profile.name, weightAtMaturityTwo];
       else if(weightAtMaturityOne == weightAtMaturityTwo && growthCurveOne == 12)
           projectLabelTemp = [NSString stringWithFormat:@"%@'s projected adult weight range is below %.2f pounds.", homeViewController.puppyData.profile.name, weightAtMaturityTwo];
       else
           projectLabelTemp = [NSString stringWithFormat:@"%@'s projected adult weight range is %.2f to %.2f pounds.", homeViewController.puppyData.profile.name, weightAtMaturityTwo, weightAtMaturityOne];
       
       
       homeViewController.projectLabel.text = projectLabelTemp;
       
       
  }//end if growthcurveone and growthcurvetwo exist
    
    
    
    
    
}

-(void) determineGrowthCurves
{
    growthCurveOne = 20;
    growthCurveTwo = 20;
    
    float weeksReference = 0;
    float weightReference = 0;
    
    for (GrowthDataPoint *datapoint in [self sortedDataPoints])
    {
        // Determine age in weeks
        
        NSDate *dateA;
        
        dateA = homeViewController.puppyData.profile.dob;
        
        
        NSDate *dateB = datapoint.date;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                   fromDate:dateA
                                                     toDate:dateB
                                                    options:0];
        
        int xCoord = (int) components.day;
        float weeks = (float) xCoord/7;
        
        
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        [f setMaximumFractionDigits:2];
        NSString *temp = [f stringFromNumber:datapoint.weight];
        
        double weight = [datapoint.weight doubleValue];
    
        if (weeks <= 36)
        {
            weeksReference = weeks;
            weightReference = (float) weight;
            
            NSLog(@"weeks ref = %f, weight ref = %f", weeksReference, weightReference);
            
        }
    
    }
    
    
    if (weightReference >0)
    {
    
    
    float compOne;
    float compTwo;
    float compThree;
    float weightCalculated;
    
    
    NSNumber *tempNSNumberOne;
    NSNumber *tempNSNumberTwo;
    NSNumber *tempNSNumberThree;
    
    for (int x = 0; x <= 12; x++)
    {
        tempNSNumberOne = [equationCompOne objectAtIndex:x];
        tempNSNumberTwo = [equationCompTwo objectAtIndex:x];
        tempNSNumberThree = [equationCompThree objectAtIndex:x];
        
        compOne = [tempNSNumberOne floatValue];
        compTwo = [tempNSNumberTwo floatValue];
        compThree = [tempNSNumberThree floatValue];
        
        weightCalculated = compOne*pow(weeksReference, 2) + compTwo*weeksReference + compThree;
        
        NSLog(@"weight ref is %f, week ref is %f, weight calculated is %f", weightReference, weeksReference, weightCalculated);
        
        if (weightCalculated > weightReference)
            growthCurveOne = x;
        
        if(weightCalculated < weightReference){
            growthCurveTwo = x;
            break;
        }
    }
        
        
    if (growthCurveOne == 20 && growthCurveTwo == 0)
    {
        growthCurveOne = 0;
        growthCurveTwo = 0;
    }
    if(growthCurveOne == 12 && growthCurveTwo ==20)
    {
        growthCurveOne = 12;
        growthCurveTwo = 12;
    }
        
    NSLog(@"growth curve one is %i, two is %i",  growthCurveOne, growthCurveTwo);
    
    }
    
}

@end
