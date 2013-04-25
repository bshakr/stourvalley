//
//  socailMenuCell.m
//  SVAAboutPage
//
//  Created by Treechot Shompoonut on 24/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "socailMenuCell.h"

@interface socailMenuCell()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@end

@implementation socailMenuCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOffset = CGSizeMake(0.5f, 0.6f);
        self.layer.shadowOpacity = 0.2f;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23.0f, 2.0f, 59.0f, 59.0f)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = nil;
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
