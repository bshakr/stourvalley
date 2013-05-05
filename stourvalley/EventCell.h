//
//  EventCell.h
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EventCell : UICollectionViewCell


@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageCV;

@end
