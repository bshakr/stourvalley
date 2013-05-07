//
//  UIColor+RGB.m
//  stourvalley
//
//  Created by Bassem on 07/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)
+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];

}

@end
