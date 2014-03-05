//
//  LevelClearedViewController.m
//  KumonApp
//
//  Created by Pia Srivastava on 2/24/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "LevelClearedViewController.h"
#import "AssignmentsTableViewController.h"

@interface LevelClearedViewController ()
- (IBAction)onAssignmentsButton:(id)sender;
- (IBAction)onNextButton:(id)sender;

@end

@implementation LevelClearedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // SET NAVIGATION BAR
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"level_cleared_header.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.hidesBackButton = YES;
  
    self.myPlayer = [self loadWav:@"Yay!"];
    [self.myPlayer play];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)onAssignmentsButton:(id)sender {
    
  //  AssignmentsTableViewController *assignmentsVC = [[AssignmentsTableViewController alloc] init];
//    assignmentsVC.studentUserName = self.NameText.text;
//    assignmentsVC.studentName = objects[0][@"FirstName"];
    
    //[self.navigationController pushViewController:assignmentsVC animated:YES];
	
	
	/*** MALENA **/
	
	if ([self.assignment isEqualToString:@"B46"]) {
		int count = [self.navigationController.viewControllers count];
		
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-4] animated:NO];
	} else if ([self.assignment isEqualToString:@"B49"]) {
		int count = [self.navigationController.viewControllers count];
		
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-3] animated:NO];
	}
	
	/** MALENA **/
}

- (IBAction)onNextButton:(id)sender {
    
    //find the assignment that is the next one in the list sequentially that is *not* done
    
}
@end
