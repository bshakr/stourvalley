//
//  imageTableCell.m
//  CustomTableView
//
//  Created by Treechot Shompoonut on 19/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import "imageTableCell.h"
#import "imageCollectionView.h"
#import "imagesLayout.h"


@implementation imageTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    imagesLayout *customLayout = [[imagesLayout alloc] init];
   
    self.collectionView = [[imageCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:customLayout];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:247/255.0 green:242/255.0 blue:236/255.0 alpha:1.0]];
    
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"collectionCell" bundle:nil] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
    return self;}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
}

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.index = index;
    
    
    [self.collectionView reloadData];
}





@end


