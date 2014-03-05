//
//  B46ProblemViewController.h
//  KumonApp
//
//  Created by malena mesarina on 3/2/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CheckMarksSingleton.h"



@interface B46ProblemViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, assign) NSInteger opIndex;
@property (nonatomic, assign) NSInteger firstNum;
@property (nonatomic, assign) NSInteger secondNum;
@property (nonatomic, strong) NSString *opImageName;

@property (nonatomic, strong) CheckMarksSingleton *singleObj;

@property (nonatomic, strong) NSString *studentUserName;

@property (nonatomic, strong) NSString *assignment;









@end
