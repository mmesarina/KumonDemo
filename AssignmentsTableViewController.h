//
//  AssignmentsTableViewController.h
//  KumonApp
//
//  Created by malena mesarina on 2/21/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *studentUserName;
@property (nonatomic, strong) NSString *studentName;




@end
