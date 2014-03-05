//
//  SettingsViewController.m
//
//
//  Created by Pia Srivastava on 2/27/14.
//
//

#import "SettingsViewController.h"
#import "AssignmentsTableViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *soundOnButton;
@property (weak, nonatomic) IBOutlet UIButton *soundOffButton;
- (IBAction)onSoundOnButton:(id)sender;
- (IBAction)onSoundsOffButton:(id)sender;

@end

@implementation SettingsViewController

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
    
    //Set inital settings accordingly
    NSString *sound = [[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];
    NSLog(@"sound coming in is [%@]", sound);
    if([sound isEqualToString:@"on"]){
        [self.soundOnButton setImage:[UIImage imageNamed:@"settings_sound_on.png"] forState:UIControlStateNormal];
        [self.soundOffButton setImage:[UIImage imageNamed:@"settings_sound_off_dim.png"] forState:UIControlStateNormal];
    }
    else{
        [self.soundOffButton setImage:[UIImage imageNamed:@"settings_sound_off.png"] forState:UIControlStateNormal];
        [self.soundOnButton setImage:[UIImage imageNamed:@"settings_sound_on_dim.png"] forState:UIControlStateNormal];
    }
    
    // SET NAVIGATION BAR
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"settings_header.png"] forBarMetrics:UIBarMetricsDefault];
    
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
}

- (void)back_button: (UIButton*) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSoundOnButton:(id)sender {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"on" forKey:@"sound"];
    [standardUserDefaults synchronize];
    
    [self.soundOnButton setImage:[UIImage imageNamed:@"settings_sound_on.png"] forState:UIControlStateNormal];
    [self.soundOffButton setImage:[UIImage imageNamed:@"settings_sound_off_dim.png"] forState:UIControlStateNormal];
}

- (IBAction)onSoundsOffButton:(id)sender {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"off" forKey:@"sound"];
    [standardUserDefaults synchronize];
    
    [self.soundOffButton setImage:[UIImage imageNamed:@"settings_sound_off.png"] forState:UIControlStateNormal];
    [self.soundOnButton setImage:[UIImage imageNamed:@"settings_sound_on_dim.png"] forState:UIControlStateNormal];
}
@end
