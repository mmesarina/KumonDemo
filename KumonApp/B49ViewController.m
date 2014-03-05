//
//  B49ViewController.m
//  KumonApp
//
//  Created by Pia Srivastava on 2/24/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "B49ViewController.h"
#import "AssignmentsTableViewController.h"
#import "LevelClearedViewController.h"
#import <Parse/Parse.h>

@interface B49ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIImageView *rightOrWrongImage1;
@property (weak, nonatomic) IBOutlet UIImageView *rightOrWrongImage2;
@property (weak, nonatomic) IBOutlet UIImageView *rightOrWrongImage3;
@property (weak, nonatomic) IBOutlet UIImageView *rightOrWrongImage4;

@property int numberOfCorrectAnswers;
@property int numberOfProblems;

- (IBAction)onTap30:(UITapGestureRecognizer *)sender;
- (IBAction)onTap40:(UITapGestureRecognizer *)sender;
- (IBAction)onTap82:(UITapGestureRecognizer *)sender;
- (IBAction)onTap28:(UITapGestureRecognizer *)sender;
- (IBAction)onTap90:(UITapGestureRecognizer *)sender;
- (IBAction)onTap53:(UITapGestureRecognizer *)sender;
- (IBAction)onTap24:(UITapGestureRecognizer *)sender;
- (IBAction)onTap19:(UITapGestureRecognizer *)sender;

-(void)showHearRightWrong:(UIImageView *)rightOrWrongImage soundFile:(NSString *)nameOfSoundFile rightOrWrong:(NSString *)rightOrWrong;
-(void)updateAssignmentsStatusToDone;

@end

@implementation B49ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (AVAudioPlayer *)loadWav:(NSString *)filename {
    NSURL * url = [[NSBundle mainBundle] URLForResource:filename withExtension:@"m4a"];
    NSError * error;
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!player) {
        NSLog(@"Error loading %@: %@", url, error.localizedDescription);
    } else {
        [player prepareToPlay];
    }
    return player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rightOrWrongImage1.alpha = 0;
    self.rightOrWrongImage2.alpha = 0;
    self.rightOrWrongImage3.alpha = 0;
    self.rightOrWrongImage4.alpha = 0;
    
    self.numberOfCorrectAnswers =  0;
    self.numberOfProblems =4;
    
    // SET NAVIGATION BAR
	self.navigationController.navigationBar.hidden = NO;
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"b49_header.png"] forBarMetrics:UIBarMetricsDefault];
    
	
	// Set LEFT BACK BUTTON
	UIImage *back_butt_image = [UIImage imageNamed:@"b49_back_button.png"];
	CGRect frameimg = CGRectMake(0, 0, back_butt_image.size.width, back_butt_image.size.height);
	UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
	[backButton setBackgroundImage:back_butt_image forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(back_button:)
		 forControlEvents:UIControlEventTouchUpInside];
	[backButton setShowsTouchWhenHighlighted:YES];
	
	UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
	self.navigationItem.leftBarButtonItem=backButtonItem;
	
	
	//Set RIGHT KUMON SCORE HEAD BUTTON
	UIImage *kumonScore_butt_image = [UIImage imageNamed:@"b49_score_head.png"];
	frameimg = CGRectMake(0, 0, kumonScore_butt_image.size.width, kumonScore_butt_image.size.height);
	UIButton *kumonScoreButton = [[UIButton alloc] initWithFrame:frameimg];
	[kumonScoreButton setBackgroundImage:kumonScore_butt_image forState:UIControlStateNormal];
	kumonScoreButton.showsTouchWhenHighlighted = NO; // Don't allow it to glow when selected
	kumonScoreButton.enabled = NO;
	/*
     [kumonScoreButton addTarget:self action:@selector(kumon_score_button:)
     forControlEvents:UIControlEventTouchUpInside];
     [kumonScoreButton setShowsTouchWhenHighlighted:YES];
	 */
	
	UIBarButtonItem *kumonScoreButtonItem =[[UIBarButtonItem alloc] initWithCustomView:kumonScoreButton];
	self.navigationItem.rightBarButtonItem =kumonScoreButtonItem;
	
}

- (void)back_button: (UIButton*) sender {
	[self.navigationController popViewControllerAnimated:YES];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onTap30:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage1 soundFile:@"UhOh_Anya" rightOrWrong:@"wrong"];
}

- (IBAction)onTap40:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage1 soundFile:@"Great_Avik" rightOrWrong:@"right"];
}

- (IBAction)onTap82:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage2 soundFile:@"GoodJob_Avik" rightOrWrong:@"right"];
}

- (IBAction)onTap90:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage3 soundFile:@"Superb_Avik" rightOrWrong:@"right"];
}

- (IBAction)onTap53:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage3 soundFile:@"DontGiveUp_Avik" rightOrWrong:@"wrong"];
}

- (IBAction)onTap19:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage4 soundFile:@"NiceTry_Avik" rightOrWrong:@"wrong"];
}

- (IBAction)onTap24:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage4 soundFile:@"Terrific_Anya" rightOrWrong:@"right"];
}

- (IBAction)onTap28:(UITapGestureRecognizer *)sender {
    [self showHearRightWrong:self.rightOrWrongImage2 soundFile:@"NotQuite_Anya" rightOrWrong:@"wrong"];
}


-(void)showHearRightWrong:(UIImageView *)rightOrWrongImage soundFile:(NSString *)nameOfSoundFile rightOrWrong:(NSString *)rightOrWrong{
    rightOrWrongImage.alpha = 1;
    NSString *imageToShow;
    
    if([rightOrWrong isEqualToString:@"wrong"]){
        imageToShow = @"b49_wrong_mark";
        if(self.numberOfCorrectAnswers > 0){
            self.numberOfCorrectAnswers--;
        }
    }
    else{
        imageToShow = @"b49_correct_mark";
        self.numberOfCorrectAnswers++;
    }
    
    rightOrWrongImage.image = [UIImage imageNamed:imageToShow];
    
    //First check if they even want to hear sound!
    NSString *sound = [[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];
    NSLog(@"sound coming in is [%@]", sound);
    if([sound isEqualToString:@"on"]){
        self.myPlayer = [self loadWav:nameOfSoundFile];
        [self.myPlayer play];
    }
    
    //Check if all is done and we should show the LevelCleared screen and update the done status
    if(self.numberOfCorrectAnswers == self.numberOfProblems){
        
        //Update Done status
        [self updateAssignmentsStatusToDone];
        
        LevelClearedViewController *levelclearedVC = [[LevelClearedViewController alloc] init];
		
		/** MALENA ADDITION TO PASS ASSIGNMENT NAME TO POP THE NAV STACK TO ASSIGNMENTS VC */
		levelclearedVC.assignment = self.assignment;
		/** END **/
        [self.navigationController pushViewController:levelclearedVC animated:YES];
    }
    
}

-(void)updateAssignmentsStatusToDone{
    
    
    AssignmentsTableViewController *assignmentsVC = (AssignmentsTableViewController *)[self presentingViewController];
    NSString *studentUsername = assignmentsVC.studentUserName;
    NSString *studentName = assignmentsVC.studentName;
    NSLog(@"student username is [%@]", studentUsername);
    NSLog(@"student name is [%@]", studentName);

    PFQuery *query = [PFQuery queryWithClassName:@"AssignmentsToUsers"];
    [query whereKey:@"UserName" equalTo:@"avik"];
    [query whereKey:@"Assignment" equalTo:@"B49"];
    
	
	/* PIAS CODE THAT HOLDS THE MAIN THREAD */
	/* Warning: A long-running Parse operation is being executed on the main thread.
	 Break on warnParseOperationOnMainThread() to debug */
	
	/*
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
	
		if (!error) {
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            for (PFObject *object in objects) {
                NSLog(@"We have the objectId [%@] and are about to set Done=true", object.objectId);
                [object setObject:@"YES" forKey:@"Done"];
                [object save];

            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
	 
	 */
	
	// NEW CODE FROM MALENA
	
	
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
	
	// END NEW CODE FROM MALENA
	
    
//    PFObject *saveObject = [PFObject objectWithClassName:@"AssignmentsToUsers"];
//    [saveObject whereKey:@"UserName" equalTo:studentUsername];
//    [saveObject setObject:[NSNumber numberWithBool:YES] forKey:@"Done"];
//    
//    [saveObject save];
    
    
}

@end
