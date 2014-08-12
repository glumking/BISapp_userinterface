//
//  HomeworkTableViewCell.m
//  BIS app
//
//  Created by phillips on 8/8/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "HomeworkTableViewCell.h"

@implementation HomeworkTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
