//
//  MyCell.h
//  KumonApp
//
//  Created by malena mesarina on 2/22/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *MyLabel;
@property (strong, nonatomic) IBOutlet UILabel *AnotherLabel;

@property (strong, nonatomic) IBOutlet UIImageView *AssignmentImageView;
@property (strong, nonatomic) IBOutlet UIImageView *CheckMarkImageView;

@end
