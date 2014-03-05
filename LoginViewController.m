//
//  LoginViewController.m
//
//
//  Created by Pia Srivastava on 2/16/14.
//
//

#import "LoginViewController.h"
#import "AssignmentsTableViewController.h"
#import "B49ViewController.h"
#import <Parse/Parse.h>
#import "LevelClearedViewController.h"
#import "SettingsViewController.h"
#import "B47ViewController.h"

@interface LoginViewController ()
//@property (nonatomic, strong) UITextField *NameText;
//@property (nonatomic, strong) UITextField *PasswordText;
@property (weak, nonatomic) IBOutlet UIImageView *nameArea;
@property (weak, nonatomic) IBOutlet UIImageView *passwordArea;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *invalidLogin;
@property (weak, nonatomic) IBOutlet UIButton *loginArea;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

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
	
	self.navigationController.navigationBar.hidden = YES;
    self.invalidLogin.alpha = 0;
	
	[self.nameTextField setBackgroundColor:[UIColor clearColor]];
	self.nameTextField.borderStyle = UITextBorderStyleNone;
	self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.nameTextField.clearsOnBeginEditing = YES;
	self.nameTextField.tag = 1;
	self.nameTextField.delegate = self;
	
	[self.passwordTextField setBackgroundColor:[UIColor clearColor]];
	self.passwordTextField.borderStyle = UITextBorderStyleNone;
	self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.passwordTextField.clearsOnBeginEditing = YES;
	self.passwordTextField.tag = 2;
	self.passwordTextField.delegate = self;
	
    
	/*[self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];*/
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - TextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	return;
}


// Method is called when Textfield has been asked to reisgn first responder status.
// This happens when user changes editing focus to another control.
// You can use this method to prompt user that text entered was invalid via an overlay view
// and ask to correct text
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
	if (textField.tag == 1) {
//		self.NameText = (UITextField*)[self.view viewWithTag:1];
        self.nameTextField = (UITextField*)[self.view viewWithTag:1];
		
	}
    if (textField.tag == 2) {
//        self.PasswordText = (UITextField*) [self.view viewWithTag:2];
        self.passwordTextField = (UITextField*) [self.view viewWithTag:2];
    }
    
	return YES;
}




// Method is called when Textfield has resigned first responder status.
// You would use this methods if you need your delegate to hide overaly views
// that should only appeared while editing text.
- (void)textFieldDidEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];
	return;
}

// Method is called when the the built-in clear button is pressed inside TextField
// This button is enabled via property "clearButtonMode"
// This method is also called when editing begins and the clearsOnBeginEditing property of the text field is set to YES.
- (BOOL)textFieldShouldClear:(UITextField *)textField {
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


#pragma - Button function

- (IBAction)onLoginButton:(id)sender {
    
    
//    NSString *nameEntered = self.NameText.text;
//    NSString *passwordEntered = self.PasswordText.text;

    NSString *nameEntered = self.nameTextField.text;
    NSString *passwordEntered = self.passwordTextField.text;

    NSLog(@"self.NameText.text is %@", nameEntered);
   	NSLog(@"self.PasswordText.text is %@", passwordEntered);
    
	// Check if userName and password is in the Parser DB
    if(nameEntered !=nil && passwordEntered !=nil){
        PFQuery *query = [PFQuery queryWithClassName:@"Student"];
        [query whereKey:@"UserName" equalTo:nameEntered];
        [query whereKey:@"Password" equalTo:passwordEntered];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error && objects && objects.count == 1) {
                //Success in finding user
                NSLog(@"ObjectsAgain: [%@]", objects);
                NSLog(@"User was found. OBject count = %d", objects.count);
                
                AssignmentsTableViewController *assignmentsVC = [[AssignmentsTableViewController alloc] init];
                assignmentsVC.studentUserName = nameEntered;
                assignmentsVC.studentName = objects[0][@"FirstName"];
                self.invalidLogin.alpha = 0;
                [self.navigationController pushViewController:assignmentsVC animated:YES];
            } else {
                NSLog(@"Username is not in DB");
                self.invalidLogin.alpha = 1;
            }
        }];
        
    }
    else{
        NSLog(@"Invalid name/password!");
    }
	
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"viewWillDisappear");
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGPoint buttonOrigin = self.loginArea.frame.origin ;
    CGFloat buttonHeight = self.loginArea.frame.size.height;
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        NSLog(@"We are covering the keyboard! Holy moly!");

        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    NSLog(@"keyboardWillBeHidden");
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}


@end
