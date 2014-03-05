//
//  B46ChildViewController.m
//  PageApp
//
//  Created by malena mesarina on 3/1/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "B46ChildViewController.h"
#import "B46ProblemViewController.h"
#import "B46PageViewController.h"
#import "CheckMarksSingleton.h"

#import <SystemConfiguration/SystemConfiguration.h>

const NSUInteger OP_WIDTH = 122;
const NSUInteger OP_HEIGHT = 133;

@interface B46ChildViewController ()

@property (nonatomic, strong) NSMutableArray *opCoordinates;
@property (nonatomic, strong) NSMutableArray *checkmarksCoordinates;
@property (nonatomic, strong) NSMutableArray *operationsMapToImagesArray;
@property (nonatomic, assign) NSInteger correctAnswers;

@property (nonatomic, strong) NSMutableArray *heads;

//@property (nonatomic, strong) NSMutableDictionary *correctCheckmarksDic;


- (void)loadPage:(NSInteger) pageIndex;

- (void)op_button_action: (UIButton*) sender;

- (void)initializeOpCoordinates;

- (void)initializeCheckmarksCoordinates;





@end

@implementation B46ChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	NSUInteger number = [self.navigationController.viewControllers count];
	NSLog(@"in B46ChildViewController VIEWDIDLOAD- number = %d", number);
	
	// CREATE THE SINGLETON TO HOLD CHECKMARKS
	
	self.anotherSingleObj = [CheckMarksSingleton singleObj];
	
	
	// SET NAVIGATION BAR
	
	self.navigationController.navigationBar.hidden = NO;
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"b46_slider_header.png"] forBarMetrics:UIBarMetricsDefault];
	
	
		

	
	
		
	// SET BACKGROUND IMAGE
	UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b46_slider_background.png"]];
	[self.view addSubview:boxBackView];
	self.view.backgroundColor = [UIColor clearColor];
	
	// INITIALIZE COORDINATES of operations
	[self initializeOpCoordinates];
	
	
	// INITIALIZE CHECKMARKS COORDINATES
	[self initializeCheckmarksCoordinates];
	
	// Place Operations Views at Coordinates
	
	[self loadPage:self.index];
	
	
	
	

	
	
}

- (void) loadView {
	
	[super loadView];
	
	NSLog(@"In loadView");
	
	
	self.operationsMapToImagesArray = [[NSMutableArray alloc] init];
	self.operationsMapToImagesArray = (NSMutableArray*) @[@"b46_slider_p01.png", @"b46_slider_p02.png", @"b46_slider_p03.png", @"b46_slider_p04.png", @"b46_slider_p05.png", @"b46_slider_p06.png", @"b46_slider_p07.png", @"b46_slider_p08.png", @"b46_slider_p09. png", @"b46_slider_p10.png", @"b46_slider_p11.png", @"b46_slider_p12.png", @"b46_slider_p13.png", @"b46_slider_p14.png", @"b46_slider_p15.png", @"b46_slider_p16.png", @"b46_slider_p17.png", @"b46_slider_p18.png"];;
	
	// INITIALIZE SCORE HEADS ARRAY
	self.heads = [[NSMutableArray alloc] init];
	self.heads = (NSMutableArray*) @[@"score_head_0", @"score_head_1.png", @"score_head_2.png", @"score_head_3.png", @"score_head_4.png", @"score_head_5.png", @"score_head_6.png", @"score_head_7.png", @"score_head_8.png", @"score_head_9. png", @"score_head_10.png", @"score_head_11.png", @"score_head_12.png", @"score_head_13.png", @"score_head_14.png", @"score_head_15.png", @"score_head_16.png", @"score_head_17.png", @"score_heade_18.png"];
	
	
	
}

- (void) viewWillAppear:(BOOL)animated {
	
	
	// SET NAVIGATION BAR
	
	self.navigationController.navigationBar.hidden = NO;
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"b46_slider_header.png"] forBarMetrics:UIBarMetricsDefault];
		// Check how many check marks there are
	
	NSLog(@"In viewWillAppear of B46ChildViewController");
	
	for(NSString *key in [self.anotherSingleObj.correctCheckmarksDic allKeys]) {
		NSLog(@"key = %d checkmark = %@", [key integerValue], [self.anotherSingleObj.correctCheckmarksDic objectForKey:key]);
	}
	
	

	
	if ([self.anotherSingleObj.correctCheckmarksDic count] > 0) {
		
		// REPLACE THE SCORE HEAD WITH AS MANY HAIRS AS WITH CORRECT CHECKMARKS
		//Is anyone listening
		if([self.delegate respondsToSelector:@selector(changeScoreHead:)])
		{
			//send the delegate function with the amount entered by the user
			[self.delegate changeScoreHead:[self.anotherSingleObj.correctCheckmarksDic count]];
		}

		
		
		
		
		NSUInteger pageIndex = self.index;
		int offset = pageIndex * 6;
		NSLog(@"page index = %d  offset = %d checkmarks count = %d", pageIndex, offset,[self.anotherSingleObj.correctCheckmarksDic count] );
	
		
	
		for (int i = 0; i < 6; i++) {
		
		    // PLACE THE CHECKMARKS ON THE PAGE
			
			NSUInteger checkmarkIndex = offset + i;
			// Get the dictionary entry
			NSString *keyString = [NSString stringWithFormat:@"%d", checkmarkIndex];
			if ([self.anotherSingleObj.correctCheckmarksDic objectForKey: keyString] != nil) {
			
				NSString *correctString = [self.anotherSingleObj.correctCheckmarksDic objectForKey:keyString];
				if ([correctString isEqualToString:@"YES"]){
					NSNumber *x = self.checkmarksCoordinates[i][0];
					NSNumber  *y = self.checkmarksCoordinates[i][1];
		
					CGRect frameimg = CGRectMake( [x integerValue], [y integerValue], 42, 32);
					UIImageView *checkMarkView = [[UIImageView alloc] initWithFrame:frameimg];
		
					NSString *imageName = @"b46_slider_correct_mark.png";
					UIImage *image = [UIImage imageNamed:imageName];
					checkMarkView.image = image;
		
		
					[self.view addSubview:checkMarkView];
				}
		
			}
		}
		
				
	}// end of checking chekmarks

	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
	
	//self.screenNumber.text = [NSString stringWithFormat:@"Screen #%d", self.index];
}


#pragma - private methods
- (void)loadPage: (NSInteger) pageIndex {
	
	
	int offset = pageIndex * 6;
	NSLog(@"page index = %d  offset = %d", pageIndex, offset);
	for (int i = 0; i < 6; i++) {
		// Get coordinates of operation
		//NSArray *coord = self.operationsArray[offset + i];
		//NSLog(@"opCoordinates %@", self.opCoordinates);
		//NSLog(@"opCoordinates [%d][0] = %@", i, self.opCoordinates[i][0]);
		
		
		// PLACE THE OPERATIONA ON THE PAGE
		NSNumber *x = self.opCoordinates[i][0];
		NSNumber  *y = self.opCoordinates[i][1];
		 
		CGRect frameimg = CGRectMake( [x integerValue], [y integerValue], OP_WIDTH, OP_HEIGHT);
		UIButton *opButton = [[UIButton alloc] initWithFrame:frameimg];
		 
		NSString *imageName = self.operationsMapToImagesArray[i + offset];
		UIImage *opImage  = [UIImage imageNamed:imageName];
		
		[opButton setBackgroundImage:opImage forState:UIControlStateNormal];
		[opButton addTarget:self action:@selector(op_button_action:) forControlEvents:UIControlEventTouchUpInside];
		[opButton setShowsTouchWhenHighlighted:YES];
		opButton.tag = i+offset;  //Remember the operation index in operationsArray to use in handler
		[self.view addSubview:opButton];

		/* OLD CODE
		
		UIImageView *opView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,122, 133)];
		
		[opView setFrame:CGRectMake([x integerValue],[y integerValue],OP_WIDTH,OP_HEIGHT)];
		
		
		
		//NSLog(@"i + offset = %d", i + offset);
		NSString *imageName = self.operationsMapToImagesArray[i + offset];
		opView.image = [UIImage imageNamed:imageName];
		
		 
		
		*/
	}
	
}


- (void)op_button_action: (UIButton*) sender {
	
	NSLog(@"Inside the op_button_action");
	B46ProblemViewController *b46ProblemViewController = [[B46ProblemViewController alloc] init];
	
	
	
	NSInteger opIndex = sender.tag;
	
	NSArray *opArray = self.operationsArray[opIndex];
	NSLog(@"opIndex = %d", opIndex);
	NSLog(@" operationsArray[opIndex] = %@ ", opArray);
	
	NSNumber *first = [[NSNumber alloc] init];
	NSNumber *second = [[NSNumber alloc] init];
	first = opArray[0];
	second = opArray[1];
	b46ProblemViewController.firstNum = [first integerValue];
	b46ProblemViewController.secondNum = [second integerValue];
	b46ProblemViewController.opImageName = self.operationsMapToImagesArray[opIndex];
	b46ProblemViewController.opIndex = opIndex;
	b46ProblemViewController.studentUserName = self.studentUserName;
	b46ProblemViewController.assignment = self.assignment;
	
	[self.navigationController pushViewController:b46ProblemViewController animated:YES];
	
}




- (void)initializeOpCoordinates {
	self.opCoordinates = [[NSMutableArray alloc] initWithCapacity:6];
	
	
	NSNumber *x = [NSNumber numberWithInt:23];
	NSNumber *y = [NSNumber numberWithInt:78];
	
	NSArray *myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	
	
	[self.opCoordinates insertObject:myArray atIndex:0];
	
	x = [NSNumber numberWithInt:23];
	y = [NSNumber numberWithInt:235];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.opCoordinates insertObject:myArray atIndex:1];
	
	x = [NSNumber numberWithInt:23];
	y = [NSNumber numberWithInt:393];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.opCoordinates insertObject:myArray atIndex:2];
	
	x = [NSNumber numberWithInt:175];
	y = [NSNumber numberWithInt:78];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.opCoordinates insertObject:myArray atIndex:3];
	
	x = [NSNumber numberWithInt:175];
	y = [NSNumber numberWithInt:235];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.opCoordinates insertObject:myArray atIndex:4];
	
	
	x = [NSNumber numberWithInt:175];
	y = [NSNumber numberWithInt:393];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.opCoordinates insertObject:myArray atIndex:5];
	
	long i ;
	for ( i= 0; i < 6 ; i++ ) {
		//NSLog(@"opCoordinates[%d][0]= %@  opCoordinates[%d][1] = %@", (int) i, self.opCoordinates[i][0], (int) i, self.opCoordinates[i][1]);
	
	}
}


- (void) initializeCheckmarksCoordinates {
	self.checkmarksCoordinates = [[NSMutableArray alloc] initWithCapacity:6];
	
	
	NSNumber *x = [NSNumber numberWithInt:63];
	NSNumber *y = [NSNumber numberWithInt:155];
	
	NSArray *myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	
	
	[self.checkmarksCoordinates insertObject:myArray atIndex:0];
	
	x = [NSNumber numberWithInt:63];
	y = [NSNumber numberWithInt:311];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.checkmarksCoordinates insertObject:myArray atIndex:1];
	
	x = [NSNumber numberWithInt:63];
	y = [NSNumber numberWithInt:469];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.checkmarksCoordinates insertObject:myArray atIndex:2];
	
	x = [NSNumber numberWithInt:215];
	y = [NSNumber numberWithInt:155];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.checkmarksCoordinates insertObject:myArray atIndex:3];
	
	x = [NSNumber numberWithInt:215];
	y = [NSNumber numberWithInt:311];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.checkmarksCoordinates insertObject:myArray atIndex:4];
	
	
	x = [NSNumber numberWithInt:215];
	y = [NSNumber numberWithInt:469];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.checkmarksCoordinates insertObject:myArray atIndex:5];
	

	
	
}



@end
