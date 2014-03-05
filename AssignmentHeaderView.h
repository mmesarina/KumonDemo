//
//  AssignmentHeaderView.h
//  KumonApp
//
//  Created by malena mesarina on 2/27/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentHeaderView : UITableViewHeaderFooterView
@property (strong, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *score1ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *score2ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *score3ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *score4ImageView;

@end
