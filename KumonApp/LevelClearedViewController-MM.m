//
//  LevelClearedViewController.m
//  KumonApp
//
//  Created by Pia Srivastava on 2/24/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "LevelClearedViewController.h"
#import "AssignmentsTableViewController.h"
// MALENA
#import "B49ViewController.h"

// MALENA
@interface LevelClearedViewController ()
- (IBAction)onAssignmentsButton:(id)sender;
- (IBAction)onNextButton:(id)sender;

@end

@implementation LevelClearedViewController

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
	NSLog(@"in LevelClearedViewController VIEWDIDLOAD- number = %d", number);
	
	/*** MALENA ****/
	
	// SET NAVIGATION BAR
	
	self.navigationController.navigationBar.hidden = NO;
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"level_cleared_header.png"] forBarMetrics:UIBarMetricsDefault];
	self.navigationItem.hidesBackButton = YES;
	
	
		
	/*** MALENA **/

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAssignmentsButton:(id)sender {
    
   // AssignmentsTableViewController *assignmentsVC = [[AssignmentsTableViewController alloc] init];
//    assignmentsVC.studentUserName = self.NameText.text;
//    assignmentsVC.studentName = objects[0][@"FirstName"];
    //[self.navigationController pushViewController:assignmentsVC animated:YES];
	
	//find the assignment that is the next one in the list sequentially that is *not* done
	
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
   // for (int i= 0 ; i < [[self.navigationController viewControllers]count] ; i++) {
	//	if ( [[[self.navigationController viewControllers] objectAtIndex:i] isKindOfClass:[FifiViewControllerClassname class]]) //{
			//[self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
		//}
	//}
	
	
	
	
}
@end
