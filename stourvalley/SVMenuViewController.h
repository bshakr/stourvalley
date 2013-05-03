//
//  SVMenuViewController.h
//  stourvalley
//
//  Created by Bassem on 18/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVMenuCell.h"
@interface SVMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet SVMenuCell *menuCell;

@end
