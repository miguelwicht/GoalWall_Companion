//
//  RankingTableViewCell.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 24/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "RankingTableViewCell.h"

@implementation RankingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.isEven = 0;
    [self.profileImageView setFrame:CGRectMake(74, 17, 100, 100)];
//    [self.profileImageView setBackgroundColor:[UIColor purpleColor]];
//    [self.profileImageView setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellStyle
{
    UIColor *backgroundColor = [UIColor colorWithRed:(188.0 / 255.0) green:(6.0 / 255.0) blue:(6.0 / 255.0) alpha:1.0];
    UIColor *textColor = [UIColor whiteColor];
    
    if (self.isEven)
    {
        backgroundColor = [UIColor whiteColor];
        textColor = [UIColor colorWithRed:(76.0 / 255.0) green:(76.0 / 255.0) blue:(76.0 / 255.0) alpha:1.0];
    }
    else
    {
        backgroundColor = [UIColor colorWithRed:(188.0 / 255.0) green:(6.0 / 255.0) blue:(6.0 / 255.0) alpha:1.0];
        textColor = [UIColor whiteColor];
        
    }
    
    [self.contentView setBackgroundColor:backgroundColor];
    
    self.rankLabel.textColor = textColor;
    self.nameLabel.textColor = textColor;
    
    self.valueLabel01.textColor = textColor;
    self.valueDescriptionLabel01.textColor = textColor;
    self.valueLabel02.textColor = textColor;
    self.valueDescriptionLabel02.textColor = textColor;
    self.valueLabel03.textColor = textColor;
    self.valueDescriptionLabel03.textColor = textColor;
    self.valueLabel04.textColor = textColor;
    self.valueDescriptionLabel04.textColor = textColor;
}

@end
