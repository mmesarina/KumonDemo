//
//  B49ViewController.h
//  KumonApp
//
//  Created by Pia Srivastava on 2/24/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface B49ViewController : UIViewController
@property (strong) AVAudioPlayer * myPlayer;
//MALENA ADDITION
@property (nonatomic, strong) NSString *assignment;
@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *studentUserName;
//END MALENA ADDITION

@end
