//
//  AboutLayout.m
//  AboutView
//
//  Created by Treechot Shompoonut on 24/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "AboutLayout.h"
#import "AboutCollectionCell.h"

static NSString * const AboutCellKind = @"AboutCell";
/*static NSUInteger const RotationCount = 32;
static NSUInteger const RotationStride = 3;
static NSUInteger const PhotoCellBaseZIndex = 100;*/

@interface AboutLayout()

@property (nonatomic, strong) NSDictionary *layoutInfo;
//@property (nonatomic, strong) NSArray *rotations;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGSize block0;
@property (nonatomic) CGSize block1;
@property (nonatomic) CGSize block2;
@property (nonatomic) CGSize block3;




@end

@implementation AboutLayout


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
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    
    self.block0 = CGSizeMake(320.0f, 191.0f);
    self.block1 = CGSizeMake(320.0f, 180.0f);
    self.block2 = CGSizeMake(320.0f, 66.0f);
    self.block3 = CGSizeMake(106.6f, 66.0f);
    self.interItemSpacingY = 0.5f;
    
    self.numberOfColumns = 1;
    
}

#pragma mark - Layout

- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) { //iterate sectionCount
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) { //iterate item(s) in section
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
              
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];  //FrameSet for item /insection at indexPath
            
            cellLayoutInfo[indexPath] = itemAttributes;
           
        }
    }
    
    newLayoutInfo[AboutCellKind] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
    
}


#pragma mark - Private

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath
{  
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    NSInteger item = indexPath.item;
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) {spacingX = spacingX / (self.numberOfColumns - 1);}
    
    CGFloat originX ;
    switch (item) {
        case 0:{
            originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
            break;
        }
        case 1:
        {
            //int x = (self.collectionView.bounds.size.width - ((self.itemSize.width *2) + self.itemInsets.left + self.itemInsets.right));
            originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column) + (self.itemSize.width + 0.5f);
            break;
        }
        case 2:
        {
            originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column) + ((self.itemSize.width *2) + 1.0f);
            break;
        }
        default:
        {
            originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
            break;
        }
    }
   
    CGFloat originY;
    
    switch (indexPath.section) {
        case 0:
        {
            self.itemSize = self.block0;
            originY = floor(self.itemInsets.top +
                                    (self.itemSize.height + self.interItemSpacingY) * row);
            break;
        }
        case 1:
        {
            self.itemSize = self.block1;
            originY = floor(self.itemInsets.top + (self.block0.height + self.interItemSpacingY) * row) ;
            break;
        }
        case 2:
        {
            self.itemSize = self.block2;
            originY = (self.itemInsets.top + self.block0.height + self.block1.height + (self.interItemSpacingY));
            break;
        }
        case 3:
        {
            self.itemSize = self.block3;
            originY = (self.itemInsets.top + self.block0.height + self.block1.height + self.block2.height + (self.interItemSpacingY*3));
            break;
        }
        
    }
    
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
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
   // CGFloat height = self.itemInsets.top + rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    CGFloat height = self.itemInsets.top + self.block0.height + self.block1.height + self.block2.height + self.block3.height
    + (self.interItemSpacingY *3)+ self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}


#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize
{
    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
    
}


/*- (CATransform3D)transformForAlbumPhotoAtIndex:(NSIndexPath *)indexPath
{
    
    NSInteger offset = (indexPath.section * RotationStride + indexPath.item);
    return [self.rotations[offset % RotationCount] CATransform3DValue];
}*/

@end
