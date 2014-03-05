//
//  B46PageViewController.h
//  KumonApp
//
//  Created by malena mesarina on 3/2/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "B46ChildViewController.h"

@interface B46PageViewController : UIViewController <UIPageViewControllerDataSource, scoreHeadDelegate>
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSString *assignment;
@property (strong, nonatomic) NSString *studentUserName;




@end
