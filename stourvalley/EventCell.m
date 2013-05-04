//
//  EventCell.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setNeedsDisplay{
    [self setNeedsDisplayInRect:self.frame];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageCV.image = nil;
    self.titleLabel.text = nil;
    self.dateLabel.text = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
