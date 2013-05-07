//
//  UIImage+Shadow.m
//  stourvalley
//
//  Created by Bassem on 07/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "UIImage+Shadow.h"

@implementation UIImage (Shadow)
- (UIImage *)imageWithShadow {
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, self.size.width + 4, self.size.height + 4, CGImageGetBitsPerComponent(self.CGImage), 0,
                                                       colourSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, CGSizeMake(0, 0), 4, [UIColor blackColor].CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(0, 4, self.size.width, self.size.height), self.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}


@end
