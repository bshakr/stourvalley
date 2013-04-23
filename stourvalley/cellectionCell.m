//
//  cellectionCell.m
//  CustomTableView
//
//  Created by Treechot Shompoonut on 20/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "cellectionCell.h"
//#import "imagesAttrbutes.h"
#import <QuartzCore/QuartzCore.h>

@implementation cellectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         [self setClearsContextBeforeDrawing:YES];
      
    }
    return self;
}

- (void)setNeedsDisplay{
    [self setNeedsDisplayInRect:self.frame];
}


/*- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview)
    {
        self.cellimageView.layer.shadowOpacity = 0.5;
        self.cellimageView.layer.shadowOffset = CGSizeMake(0, 3);
        self.cellimageView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectInset(self.cellimageView.bounds,1,1)] CGPath];
    }
}*/

/*- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    if ([layoutAttributes isKindOfClass:[imagesAttrbutes class]])
    {
        imagesAttrbutes *imgAtr = (imagesAttrbutes *)layoutAttributes;
        self.cellimageView.layer.shadowOpacity = imgAtr.shadowOpacity;
    }
}*/

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

