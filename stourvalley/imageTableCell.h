//
//  imageTableCell.h
//  CustomTableView
//
//  Created by Treechot Shompoonut on 19/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageCollectionView.h"


static NSString *CollectionViewCellIdentifier = @"CellIdentifier";

@interface imageTableCell : UITableViewCell 

@property (nonatomic, strong) imageCollectionView *collectionView;

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;
@end


