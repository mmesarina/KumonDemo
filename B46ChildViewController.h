//
//  B46ChildViewController.h
//  KumonApp
//
//  Created by malena mesarina on 3/2/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "B46ProblemViewController.h"

// Create Delegate protocol to call Page Controller to change right button imate
@protocol scoreHeadDelegate <NSObject>

-(void)changeScoreHead:(NSInteger) score;

@end

@interface B46ChildViewController : UIViewController 
@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSArray *operationsArray; // This is set by B46PageViewController

@property (nonatomic, strong) CheckMarksSingleton *anotherSingleObj;

@property (nonatomic, strong) NSString *studentUserName;

@property (nonatomic, strong) NSString *assignment;

@property (nonatomic, strong) id delegate;


@end
