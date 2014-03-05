//
//  LevelClearedViewController.h
//  KumonApp
//
//  Created by Pia Srivastava on 2/24/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LevelClearedViewController : UIViewController
@property (strong) AVAudioPlayer * myPlayer;

@property  (nonatomic, strong) NSString *assignment;

@end
