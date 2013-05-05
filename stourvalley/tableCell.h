//
//  tableCell.h
//  CustomTableView
//
//  Created by Treechot Shompoonut on 19/04/2013.
//  Copyright (c) 2013 Treechot Shompoonut. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface tableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *tbImageView;
@property (strong, nonatomic) IBOutlet UILabel *tbNameField;
@property (strong, nonatomic) IBOutlet UILabel *tbDescField;
@property (strong, nonatomic) IBOutlet UILabel *tbDateField;

@end
