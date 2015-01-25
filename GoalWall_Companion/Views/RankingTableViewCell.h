//
//  RankingTableViewCell.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 24/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingTableViewCell : UITableViewCell

@property BOOL isEven;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel01;
@property (weak, nonatomic) IBOutlet UILabel *valueDescriptionLabel01;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel02;
@property (weak, nonatomic) IBOutlet UILabel *valueDescriptionLabel02;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel03;
@property (weak, nonatomic) IBOutlet UILabel *valueDescriptionLabel03;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel04;
@property (weak, nonatomic) IBOutlet UILabel *valueDescriptionLabel04;

- (void)updateCellStyle;
@end
