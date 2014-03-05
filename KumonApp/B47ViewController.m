//
//  B47ViewController.m
//  KumonApp
//
//  Created by Pia Srivastava on 2/28/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "B47ViewController.h"


@interface B47ViewController()

- (IBAction)onBackButton:(id)sender;
- (IBAction)onTabProblem1:(UITextField *)sender;

@property (weak, nonatomic) IBOutlet UITextField *problem1;
@property (weak, nonatomic) IBOutlet UITextField *problem2;

@end

@implementation B47ViewController

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
    self.problem1.delegate = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",textField.text);
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onBackButton:(id)sender {
}
- (IBAction)onTabProblem1:(UITextField *)sender {
    NSLog(@"onTabProblem1");

    [sender resignFirstResponder];
    NSString *numberEntered = sender.text;
    NSLog(@"You entered %@",numberEntered);
    if([numberEntered isEqualToString:@"91"]){
        [sender setRightViewMode:UITextFieldViewModeAlways];
        sender.rightView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b47_correct_mark.png"]];
    }
    else{
        [sender setRightViewMode:UITextFieldViewModeAlways];
        sender.rightView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b49_wrong_mark.png"]];
    }
       
       
}
@end
