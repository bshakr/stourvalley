//
//  EventLayout.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "EventLayout.h"

static NSString * const AboutCellKind = @"EventCell";

@interface EventLayout()

@property (nonatomic, strong) NSDictionary *layoutInfo;
@property (nonatomic) CGSize itemSize;

@end

@implementation EventLayout

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    self.numberOfColumns = 1;
    self.spacingY = 20.0f;
    self.interItemSpacingY = 20.0f;
    
    
}


- (void)prepareLayout
{
    
    self.itemSize = CGSizeMake((self.collectionView.bounds.size.width - self.itemInsets.left - self.itemInsets.right), 234.0f);
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger item = 0; item < itemCount; item++) { //iterate item(s) in section
        indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        
        UICollectionViewLayoutAttributes *itemAttributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        itemAttributes.frame = [self frameForItemAtIndexPath:indexPath];  //FrameSet for item /insection at indexPath
        
       // NSLog(@"View wide : %f", self.collectionView.bounds.size.width);
       // NSLog(@"View wide : %f", self.collectionView.bounds.size.height);
        cellLayoutInfo[indexPath] = itemAttributes;
        
    }
    
    
    newLayoutInfo[AboutCellKind] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - Private

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.numberOfColumns = 1;
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger item = indexPath.item;
    //NSLog(@"Specing Y : %f", self.spacingY);
    
    
    CGFloat originX ;
    originX = floorf(self.itemInsets.left);
    
    CGFloat originY;
    originY = floorf((self.itemSize.height * item )+ self.interItemSpacingY + (self.spacingY * item));
    
    //NSLog(@"item %d,X %f,Y %f,W %f,H %f", item,originX, originY, self.itemSize.width, self.itemSize.height );
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[AboutCellKind][indexPath];
}


- (CGSize)collectionViewContentSize
{
   // NSLog(@"%f, %f, %f", self.itemInsets.top, self.itemInsets.bottom, (self.itemSize.height * self.cellCount));
    CGFloat height = self.itemInsets.top + self.itemInsets.bottom + (self.itemSize.height * self.cellCount) + (self.spacingY * self.cellCount);
    
    //NSLog(@"Content size: %f, %f", self.collectionView.bounds.size.width, height);
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}






@end
