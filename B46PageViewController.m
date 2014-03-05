//
//  B46PageViewController.m
//  KumonApp
//
//  Created by malena mesarina on 3/2/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "B46PageViewController.h"
#import "B46ChildViewController.h"
#import <Parse/Parse.h>


@interface B46PageViewController ()

@property (nonatomic, strong) NSMutableArray *operationsArray;

- (void)back_button: (UIButton*) sender;

- (void)loadOperationsFromParse:(NSString*) assignment;




@end

@implementation B46PageViewController

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
	// Do any additional setup after loading the view.
	
	NSUInteger number = [self.navigationController.viewControllers count];
	NSLog(@"in B46PageViewController VIEWDIDLOAD- number = %d", number);
	
	
	
	
	
	// SET NAVIGATION BAR
	
	self.navigationController.navigationBar.hidden = NO;
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"b46_slider_header.png"] forBarMetrics:UIBarMetricsDefault];
    

	
	// Set LEFT BACK BUTTON
	
	UIImage *back_butt_image = [UIImage imageNamed:@"b46_slider_back_button.png"];
	CGRect frameimg = CGRectMake(0, 0, back_butt_image.size.width, back_butt_image.size.height);
	UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
	[backButton setBackgroundImage:back_butt_image forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(back_button:)
		 forControlEvents:UIControlEventTouchUpInside];
	[backButton setShowsTouchWhenHighlighted:YES];
	
	UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
	self.navigationItem.leftBarButtonItem=backButtonItem;
	
	
	//Set RIGHT KUMON SCORE HEAD BUTTON
	
	UIImage *kumonScore_butt_image = [UIImage imageNamed:@"b46_slider_score_head.png"];
	
	
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
	

	
	
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
	
    
    self.pageController.dataSource = self;
	
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    B46ChildViewController *initialViewController = [self viewControllerAtIndex:0];
	
	// Set itself to delegate of child to change score heades in nav bar
	//initialViewController.delegate = self;
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
	
	// Replace the current controller by our new page controller,
    [self addChildViewController:self.pageController];
	
	// Add the page controller view to the current view.
    [[self view] addSubview:[self.pageController view]];
	
    [self.pageController didMoveToParentViewController:self];
}


- (void) loadView {
	
	[super loadView];
	
	self.operationsArray = [[NSMutableArray alloc] init];
	
	[self loadOperationsFromParse:self.assignment];
	
		
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(B46ChildViewController *)viewController index];
	NSUInteger currentIndex = index;
    
    if (index == 0) {
        return nil;
    }
    
    index--;
	NSUInteger nextIndex = index ;
    NSLog(@"In viewControllerBefore index = %d and going to index = %d", currentIndex, nextIndex);
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(B46ChildViewController *)viewController index];
	NSUInteger currentIndex = index;
    
	
    index++;
	
    if (index == 3) {
        return nil;
    }
    
	NSUInteger nextIndex = index ;
    NSLog(@"In viewControllerBefore index = %d and going to index = %d", currentIndex, nextIndex);
	
	
    return [self viewControllerAtIndex:index];
    
}

#pragma -private methods
- (B46ChildViewController *)viewControllerAtIndex:(NSUInteger)index {
	
    B46ChildViewController *childViewController = [[B46ChildViewController alloc] initWithNibName:@"B46ChildViewController" bundle:nil];
	
	// Setting the index property of the Child Controller
	childViewController.index = index;
	
	// Set the assignment Name passed from AssignmentTableViewController
	childViewController.assignment = self.assignment;
	
	// Pass the operations
	childViewController.operationsArray = self.operationsArray;
	
	// Pass the studentUserName
	childViewController.studentUserName = self.studentUserName;
	
	//childViewController.delegate = self;
	
	
    
    return childViewController;
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
	
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}


- (void)back_button: (UIButton*) sender {
	[self.navigationController popViewControllerAnimated:YES];
	
}


- (void)loadOperationsFromParse:(NSString*) assignment {
	
	NSLog(@"In loadOperationsFromParse Assignment = %@", assignment);
	
	
	PFQuery *query = [PFQuery queryWithClassName:@"Assignment"];
	[query whereKey:@"Assignment" equalTo:self.assignment];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			// The find succeeded.
			NSLog(@"Successfully retrieved %d objects.", objects.count);
			
			NSDictionary *asgmntDic = objects[0];
			NSArray *opArray = [[NSArray alloc] init];
			
			// GET OP1
			opArray = asgmntDic[@"op1"];
			NSLog(@"opArray = %@", opArray);
			NSLog(@"op1 (1) = %@", opArray[0]);
			[self.operationsArray addObject:opArray];
			
			// GET OP2
			opArray = asgmntDic[@"op2"];
			[self.operationsArray addObject:opArray];
			
			// GET OP3
			opArray = asgmntDic[@"op3"];
			[self.operationsArray addObject:opArray];
			
			// GET OP4
			opArray = asgmntDic[@"op4"];
			[self.operationsArray addObject:opArray];
			
			// GET OP5
			opArray = asgmntDic[@"op5"];
			[self.operationsArray addObject:opArray];
			
			// GET OP6
			opArray = asgmntDic[@"op6"];
			[self.operationsArray addObject:opArray];
			
			// GET OP7
			opArray = asgmntDic[@"op7"];
			[self.operationsArray addObject:opArray];
			
			// GET OP8
			opArray = asgmntDic[@"op8"];
			[self.operationsArray addObject:opArray];
			
			// GET OP9
			opArray = asgmntDic[@"op9"];
			[self.operationsArray addObject:opArray];
			
			// GET OP10
			opArray = asgmntDic[@"op10"];
			[self.operationsArray addObject:opArray];
			
			// GET OP11
			opArray = asgmntDic[@"op11"];
			[self.operationsArray addObject:opArray];
			
			// GET OP12
			opArray = asgmntDic[@"op12"];
			[self.operationsArray addObject:opArray];
			
			// GET OP13
			opArray = asgmntDic[@"op13"];
			[self.operationsArray addObject:opArray];
			
			// GET OP14
			opArray = asgmntDic[@"op14"];
			[self.operationsArray addObject:opArray];
			
			// GET OP15
			opArray = asgmntDic[@"op15"];
			[self.operationsArray addObject:opArray];
			
			// GET OP16
			opArray = asgmntDic[@"op16"];
			[self.operationsArray addObject:opArray];
			
			// GET OP17
			opArray = asgmntDic[@"op17"];
			[self.operationsArray addObject:opArray];
			
			// GET OP18
			
			opArray = asgmntDic[@"op18"];
			[self.operationsArray addObject:opArray];

		
		} else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}
	}];
	
	
	

	
}

- (void)changeScoreHead {
	
	NSLog(@"In CHANGE SCORE HEAD DELEGATE");
	
}

@end
