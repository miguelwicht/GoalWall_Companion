//
//  UpdatePlayerNameView.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "UpdatePlayerNameView.h"
#import "UIView+MDWViewHelper.h"

@implementation UpdatePlayerNameView

- (void)initViews
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //self.backgroundColor = [UIColor blueColor];
    
    self.eventTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 10)];
    [self.eventTitleLabel setFont:[UIFont fontWithName:self.eventTitleLabel.font.fontName size:24]];
    [self.eventTitleLabel setText:@"Event title"];
    [self addSubview:self.eventTitleLabel];
    
    
    self.modeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.eventTitleLabel.frame.origin.y + self.eventTitleLabel.frame.size.height + 15, 100, 10)];
    [self.modeTitleLabel setFont:[UIFont fontWithName:self.modeTitleLabel.font.fontName size:24]];
    [self.modeTitleLabel setText:@"Mode title"];
    [self addSubview:self.modeTitleLabel];
    [self.modeTitleLabel sizeToFit];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 300, 400, 30)];
    [self.nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.nameTextField setPlaceholder:@"Enter your name"];
    [self addSubview:self.nameTextField];
    
    self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.userImageView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.userImageView];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.submitButton setFrame:CGRectMake(0, 0, 100, 20)];
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self addSubview:self.submitButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.eventTitleLabel setOriginX:20];
    [self.eventTitleLabel setOriginY:100];
    [self.eventTitleLabel sizeToFit];
    
    
    [self.modeTitleLabel setOriginX:20];
    [self.modeTitleLabel setOriginY:self.eventTitleLabel.originBottom + 10];
    [self.modeTitleLabel sizeToFit];
    
    [self.userImageView setOriginX:20];
    [self.userImageView setOriginY:self.modeTitleLabel.originBottom + 10];
    
    [self.nameTextField setOriginX:20];
    [self.nameTextField setOriginY:self.userImageView.originBottom + 10];
    
    [self.submitButton setOriginX:self.nameTextField.originRight + 10];
    [self.submitButton setOriginY:self.nameTextField.originY];
    [self.submitButton sizeToFit];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
