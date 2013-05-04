//
//  EventLayout.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EventLayout : UICollectionViewFlowLayout


@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) CGFloat spacingY;


@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) NSInteger cellCount;

@end
