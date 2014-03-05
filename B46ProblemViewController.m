//
//  B46ProblemViewController.m
//  KumonApp
//
//  Created by malena mesarina on 3/2/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "B46ProblemViewController.h"
#import "B46PageViewController.h"
#import "LevelClearedViewController.h"
#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>

const NSUInteger _OP_WIDTH = 202;
const NSUInteger _OP_HEIGHT = 220;
const NSUInteger CALCBUTTON_WIDTH = 52;
const NSUInteger CALCBUTTON_HEIGHT = 46;
const NSUInteger MYDEBUG = 1;

const NSUInteger FONTSIZE = 48;

@interface B46ProblemViewController ()

@property (nonatomic, strong) NSMutableArray *calcButtonCoordinates;
@property (nonatomic, strong) NSMutableArray *operationsMapToNavbarBackgroundImage;
@property (nonatomic, strong) NSMutableArray *calcButtonsMapToImageArray;
@property (nonatomic, strong) UITextView *resultTextView;

@property (nonatomic, strong) NSMutableString *result;

@property (nonatomic, strong) AVAudioPlayer *soundPlayer;

@property (nonatomic, strong) NSMutableArray *goodSounds;
@property (nonatomic, strong) NSMutableArray *badSounds;



- (void) placeCalculatorButtons;

- (void)back_button: (UIButton*) sender;

- (void)on_calcButton_action: (UIButton*) sender;


@end

@implementation B46ProblemViewController

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
	
	// INITIALIZE SOUNDS
	
	self.goodSounds = [[NSMutableArray alloc] init];
	self.goodSounds = (NSMutableArray*) @[@"Amazing_Anya", @"Awesome_Avik", @"Brilliant Keya", @"GoodJob_Anya", @"GoodJob_Avik", @"Great_Avik", @"Superb_Avik", @"Terrific_Anya", @"Wonderful_Anya", @"Yay!"];
	
	self.badSounds = [[NSMutableArray alloc] init];
	self.badSounds = (NSMutableArray*) @[@"AlmostRight_Anya", @"Are You Sure Keya", @"DontGiveUp_Avik", @"Incorrect_Anya", @"NotQuite_Anya", @"Try Again Keya", @"Uh Oh Keya", @"UhOh_Anya", @"UhOh_Avik"];
	
	
	NSUInteger number = [self.navigationController.viewControllers count];
	NSLog(@"in B46ProblemViewController VIEWDIDLOAD- number = %d", number);
	// CREATE THE SINGLETON TO HOLD CHECKMARKS
	
	self.singleObj = [CheckMarksSingleton singleObj];
	
	
	
	// SET NAVIGATION BAR
	
	self.navigationController.navigationBar.hidden = NO;
	
	NSString *navBarImageName = self.operationsMapToNavbarBackgroundImage[self.opIndex];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: navBarImageName] forBarMetrics:UIBarMetricsDefault];
	
	// Set LEFT BACK BUTTON
	
	UIImage *back_butt_image = [UIImage imageNamed:@"b46_problem_back_button.png"];
	CGRect frameimg = CGRectMake(0, 0, back_butt_image.size.width, back_butt_image.size.height);
	UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
	[backButton setBackgroundImage:back_butt_image forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(back_button:)
		 forControlEvents:UIControlEventTouchUpInside];
	[backButton setShowsTouchWhenHighlighted:YES];
	
	UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
	self.navigationItem.leftBarButtonItem=backButtonItem;
	

	
	// SET BACKGROUND IMAGE
	UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"problem_background"]];
	[self.view addSubview:boxBackView];
	self.view.backgroundColor = [UIColor clearColor];

	
	
		
	// PLACE THE OPERATION
	
	NSInteger x = 59;
	NSInteger y = 96;
	
	UIImageView *opView = [[UIImageView alloc] init];
	
	[opView setFrame:CGRectMake(x,y,_OP_WIDTH,_OP_HEIGHT)];
	//NSLog(@"i + offset = %d", i + offset);
	NSString *imageName = self.opImageName;
	opView.image = [UIImage imageNamed:imageName];
	[self.view addSubview:opView];
	
	// PLACE tHE RESULT UITEXTVIEW
	
	x = 82;
	y = 215;
	
	self.resultTextView = [[UITextView alloc] init];
	[self.resultTextView setFrame:CGRectMake(x,y,157,74)];
	self.resultTextView.textAlignment = NSTextAlignmentRight;	self.resultTextView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.resultTextView];

	
	// PLACE THE CALCULATOR BUTTONS
	[self placeCalculatorButtons];
	
	
}

- (void) loadView {
	
	[super loadView];
	
	
	
	// MAP THE OPERATIONS TO THEIR RESPECTIVE NAVIGATION HEADER
	self.operationsMapToNavbarBackgroundImage = [[NSMutableArray alloc] init];
	self.operationsMapToNavbarBackgroundImage= (NSMutableArray*) @[@"problem_header_01.png", @"problem_header_02.png", @"problem_header_03.png", @"problem_header_04.png", @"problem_header_05.png", @"problem_header_06.png", @"problem_header_07.png", @"problem_header_08.png", @"problem_header_09.png", @"problem_header_10.png", @"problem_header_11.png", @"problem_header_10.png", @"problem_header_13.png", @"problem_header_14.png", @"problem_header_15.png", @"problem_header_16.png", @"problem_header_17.png", @"problem_header_18.png"];
	
	
	// MAP THE CALCULATOR BUTTONS TO THEIR RESPECTIVE IMAGE
	self.calcButtonsMapToImageArray = [[NSMutableArray alloc] init];
	self.calcButtonsMapToImageArray = (NSMutableArray*) @[@"problem_button_1.png", @"problem_button_2.png", @"problem_button_3.png", @"problem_button_4.png", @"problem_button_5.png", @"problem_button_6.png", @"problem_button_7.png", @"problem_button_8.png", @"problem_button_9.png", @"problem_button_clear.png", @"problem_button_0.png", @"problem_button_enter.png"];
	
	
	
	// INITIALIZE THE COORDINATES OF THE CALCULATOR BUTTONS
	self.calcButtonCoordinates = [[NSMutableArray alloc] init];
	[self calculatorButtonsCoordinates];

	// INITIALIZE result string
	self.result = [[NSMutableString alloc] initWithString:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - private methods
- (void)calculatorButtonsCoordinates {
	
	// BUTTON 1
	NSNumber *x = [NSNumber numberWithInt:82];
	NSNumber *y = [NSNumber numberWithInt:357];
	
	NSArray *myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	
	
	[self.calcButtonCoordinates insertObject:myArray atIndex:0];
	
	// BUTTON 2
	x = [NSNumber numberWithInt:135];
	y = [NSNumber numberWithInt:357];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:1];
	
	// BUTTON 3
	x = [NSNumber numberWithInt:188];
	y = [NSNumber numberWithInt:357];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:2];
	
	// BUTTON 4
	x = [NSNumber numberWithInt:82];
	y = [NSNumber numberWithInt:402];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:3];
	
	// BUTTON 5
	
	x = [NSNumber numberWithInt:135];
	y = [NSNumber numberWithInt:402];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:4];
	
	// BUTTON 6
	x = [NSNumber numberWithInt:187];
	y = [NSNumber numberWithInt:402];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:5];
	
	// BUTTON 7
	
	x = [NSNumber numberWithInt:82];
	y = [NSNumber numberWithInt:447];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:6];
	
	// BUTTON 8
	
	x = [NSNumber numberWithInt:135];
	y = [NSNumber numberWithInt:447];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:7];
	
	// BUTTON 9
	x = [NSNumber numberWithInt:187];
	y = [NSNumber numberWithInt:447];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:8];
	
	// BUTTON C
	x = [NSNumber numberWithInt:82];
	y = [NSNumber numberWithInt:492];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:9];
	
	// BUTTON 0
	x = [NSNumber numberWithInt:135];
	y = [NSNumber numberWithInt:492];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:10];
	
	// BUTTON E
	x = [NSNumber numberWithInt:187];
	y = [NSNumber numberWithInt:492];
	myArray = [[NSArray alloc] initWithObjects:x,y, nil];
	[self.calcButtonCoordinates insertObject:myArray atIndex:11];

}

- (void) placeCalculatorButtons {
	
	NSInteger i;
	for ( i = 0; i < 12; i++) {
		NSNumber *x = self.calcButtonCoordinates[i][0];
		NSNumber  *y = self.calcButtonCoordinates[i][1];
		
		CGRect frameimg = CGRectMake( [x integerValue], [y integerValue], CALCBUTTON_WIDTH, CALCBUTTON_HEIGHT);
		UIButton *opButton = [[UIButton alloc] initWithFrame:frameimg];
		
		NSString *imageName = self.calcButtonsMapToImageArray[i ];
		UIImage *opImage  = [UIImage imageNamed:imageName];
		
		[opButton setBackgroundImage:opImage forState:UIControlStateNormal];
		[opButton addTarget:self action:@selector(on_calcButton_action:) forControlEvents:UIControlEventTouchUpInside];
		[opButton setShowsTouchWhenHighlighted:YES];
		opButton.tag = i;  //Remember the calculator button index
		[self.view addSubview:opButton];

	}
	 
	
	/*
	NSArray *cArray = self.calcButtonCoordinates
	NSInteger x = 59;
	NSInteger y = 96;
	
	UIImageView *opView = [[UIImageView alloc] init];
	
	[opView setFrame:CGRectMake(x,y,_OP_WIDTH,_OP_HEIGHT)];
	//NSLog(@"i + offset = %d", i + offset);
	NSString *imageName = self.opImageName;
	opView.image = [UIImage imageNamed:imageName];
	[self.view addSubview:opView];
	 */
	
	
}

- (void)back_button: (UIButton*) sender {
	[self.navigationController popViewControllerAnimated:YES];
	
}


- (void)on_calcButton_action: (UIButton*) sender {
	
	NSInteger index = (NSInteger)sender.tag;
	NSLog(@"Pressed button %d", index);
	
	NSNumber *Kerning = @16;
	
	if (self.result.length >= 3) {
		// Assume first three are the desired result and disable more entries
		self.resultTextView.editable = NO;
	} else {
		self.resultTextView.editable = YES;
	}
	
	if (index == 0) {
		
		[self.result appendString:@"1"];
		NSLog(@"result = %@", self.result);
		
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
		NSLog(@"NSTextAlignmentRight = %d", NSTextAlignmentRight);
		NSLog(@"result alignment %d", self.resultTextView.textAlignment);
		
	}
	
	if (index == 1 ) {
		[self.result appendString:@"2"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	if (index == 2) {
		[self.result appendString:@"3"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	if (index == 3) {
		[self.result appendString:@"4"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	

	
	if (index == 4) {
		[self.result appendString:@"5"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	if (index == 5) {
		[self.result appendString:@"6"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	if (index == 6) {
		[self.result appendString:@"7"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	if (index == 7) {
		[self.result appendString:@"8"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	if (index == 8) {
		[self.result appendString:@"9"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	// Clear button was pressed, so reset string
	
	if (index == 9) {
		self.result = [NSMutableString stringWithFormat:@""];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	// Zero button was pressed
	if (index == 10) {
		[self.result appendString:@"0"];
		[self.resultTextView setAttributedText:[[NSAttributedString alloc] initWithString:self.result attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:FONTSIZE], NSForegroundColorAttributeName:[UIColor blackColor], NSKernAttributeName:Kerning}]];
		self.resultTextView.textAlignment = NSTextAlignmentRight;
	}
	
	// Enter button was pressed
	
	if (index == 11) {
		
		NSLog(@"Pressed ENTER");
		// Compare entry with valid total
		NSUInteger actual_total = self.firstNum + self.secondNum;
		
		if ([self.result intValue] == actual_total) {
			// Correct answer, place a checkmark
			
			NSInteger x = 216;
			NSInteger y = 215;
			
			UIImageView *checkMarkView = [[UIImageView alloc] init];
			
			[checkMarkView setFrame:CGRectMake(x,y,75,75)];
			
			NSString *imageName = @"problem_correct.png";
			checkMarkView.image = [UIImage imageNamed:imageName];
			[self.view addSubview:checkMarkView];
			
						
			//STORE CHECKMARK STATUS IN SINGLETON
			//[singleObj.correctCheckmarksDic setObject:yesOrNo forKey:[NSString stringWithFormat:@"%d", opIndex]];
			[self.singleObj.correctCheckmarksDic setObject:@"YES" forKey:[NSString stringWithFormat:@"%d", self.opIndex]];
			
			//MAKE A GOOD SOUND
			// Choose sound randomly
			int soundsCount = [self.goodSounds count];
			int r = rand() % soundsCount;
			NSString *soundFileName = self.goodSounds[r];
			
			NSString *path = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"m4a"];
			NSURL *urlFile = [NSURL fileURLWithPath:path];
			NSError *error;
			self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlFile error:&error];
			if (error)
			{
				NSLog(@"Error in audioPlayer: %@",[error localizedDescription]);
			} else {
				self.soundPlayer.delegate = self;
				[self.soundPlayer prepareToPlay];
				[self.soundPlayer play];
			}

			
			
			//END SOUND
			
			
			if ((MYDEBUG == 1)) {
				
				if ([self.singleObj.correctCheckmarksDic count] == 3) {
					// SET THE DONE FIELD IN STUDENT"S ASSIGNMENT INFO IN PARSE
					PFQuery *query = [PFQuery queryWithClassName:@"AssignmentsToUsers"];
					[query whereKey:@"UserName" equalTo:self.studentUserName];
					[query whereKey:@"Assignment" equalTo:self.assignment];
				
					[query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
						if (!error) {
							// Found UserStats
							[userStats setObject:@"YES" forKey:@"Done"];
						
							// Save
							[userStats saveInBackground];
						} else {
							// Did not find any UserStats for the current user
							NSLog(@"Error: %@", error);
						}
					}];
				
				
				
				LevelClearedViewController *levelClearedViewController = [[LevelClearedViewController alloc] init];
				
				levelClearedViewController.assignment = @"B46";
				[self.navigationController pushViewController:levelClearedViewController animated:YES];
					
				}
			} else {
				
				
				
				if ([self.singleObj.correctCheckmarksDic count] == 18) {
					
					// SET THE DONE FIELD IN STUDENT"S ASSIGNMENT INFO IN PARSE
					PFQuery *query = [PFQuery queryWithClassName:@"AssignmentsToUsers"];
					[query whereKey:@"UserName" equalTo:self.studentUserName];
					[query whereKey:@"Assignment" equalTo:self.assignment];
					
					[query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
						if (!error) {
							// Found UserStats
							[userStats setObject:@"YES" forKey:@"Done"];
							
							// Save
							[userStats saveInBackground];
						} else {
							// Did not find any UserStats for the current user
							NSLog(@"Error: %@", error);
						}
					}];
					LevelClearedViewController *levelClearedViewController = [[LevelClearedViewController alloc] init];
				
					[self.navigationController pushViewController:levelClearedViewController animated:YES];
				}
				
				
			}
			
			 
			
			/*****/
			
		} else {
			// Incorrect value place a cross mark
			NSInteger x = 216;
			NSInteger y = 215;
			
			UIImageView *checkMarkView = [[UIImageView alloc] init];
			
			[checkMarkView setFrame:CGRectMake(x,y,75,75)];
			
			NSString *imageName = @"problem_wrong.png";
			checkMarkView.image = [UIImage imageNamed:imageName];
			[self.view addSubview:checkMarkView];
			
			
			//Clear result and Play sound to let them try again
			self.result = [[NSMutableString alloc]initWithString:@""];
			self.resultTextView.text = @"";
			
			//MAKE A GOOD SOUND
			// Choose sound randomly
			int soundsCount = [self.badSounds count];
			int r = rand() % soundsCount;
			NSString *soundFileName = self.badSounds[r];
			
			NSString *path = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"m4a"];
			NSURL *urlFile = [NSURL fileURLWithPath:path];
			NSError *error;
			self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlFile error:&error];
			if (error)
			{
				NSLog(@"Error in audioPlayer: %@",[error localizedDescription]);
			} else {
				self.soundPlayer.delegate = self;
				[self.soundPlayer prepareToPlay];
				[self.soundPlayer play];
			}
			

			

			
		}
	}
	
	
	
}
@end
