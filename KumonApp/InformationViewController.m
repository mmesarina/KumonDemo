//
//  InformationViewController.m
//  KumonApp
//
//  Created by Pia Srivastava on 3/4/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *backgroundImageUIView;

@end

@implementation InformationViewController

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
    // SET NAVIGATION BAR
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"information.png"] forBarMetrics:UIBarMetricsDefault];
    
    // Set LEFT BACK BUTTON
    UIImage *back_butt_image = [UIImage imageNamed:@"settings_back_button.png"];
    CGRect frameimg = CGRectMake(0, 0, back_butt_image.size.width, back_butt_image.size.height);
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
    [backButton setBackgroundImage:back_butt_image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back_button:)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backButtonItem;
    
//    self.backgroundImageUIView
}

- (void)back_button: (UIButton*) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
