//
//  SVMenuCell.m
//  stourvalley
//
//  Created by Bassem on 18/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMenuCell.h"

@implementation SVMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
        topLineView.backgroundColor = [UIColor colorWithRed:12/255.0 green:14/255.0 blue:17/255.0 alpha:1];
        [self.view addSubview:topLineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 1)];
        bottomLineView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
        [self.view addSubview:bottomLineView];


    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
