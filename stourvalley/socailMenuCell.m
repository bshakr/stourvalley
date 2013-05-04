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
        
        //self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        self.layer.shadowOffset = CGSizeMake(0.5f, 0.6f);
        self.layer.shadowOpacity = 0.2f;
       // self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23.0f, 2.0f, 57.0f, 57.0f)];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54.0f, 54.0f)];
        self.imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.imageView.layer.cornerRadius = 54.0f/2.0f ;
        self.imageView.layer.borderWidth = 3.0f;
        self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.imageView.layer.shouldRasterize = YES;
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
