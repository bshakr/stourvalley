//
//  SVMenuViewController.m
//  stourvalley
//
//  Created by Bassem on 18/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMenuViewController.h"
#import "SVMenuCell.h"
#import "NVSlideMenuController.h"
#import "SVAboutViewController.h"
#import "SVMapViewController.h"

enum {
    MenuMapRow = 0,
    MenuAboutRow,
    MenuRowCount
};

@interface SVMenuViewController ()

@end

@implementation SVMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.173 alpha:1.000];
    self.tableView.separatorColor = [UIColor blackColor];
    
    [self.tableView registerNib:[self menuCellNib] forCellReuseIdentifier:@"SVMenuCell"];
}
- (UINib *)menuCellNib {
    return [UINib nibWithNibName:@"MenuCell" bundle:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Menu";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MenuRowCount;
}

- (void)configureCell:(SVMenuCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case MenuMapRow:
            cell.label.text = @"Map";
            break;
            
        case MenuAboutRow:
            cell.label.text = @"About";
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SVMenuCell";
    SVMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - table view delegate

- (BOOL)isShowingClass:(Class)class {
    UIViewController *controller = self.slideMenuController.contentViewController;
    if ([controller isKindOfClass:class]) {
        return YES;
    }
    
    if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)controller;
        if ([navController.visibleViewController isKindOfClass:class]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)showControllerClass:(Class)class {
    if ([self isShowingClass:class]) {
        [self.slideMenuController toggleMenuAnimated:self];
    } else {
        id mainVC = [[class alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
        [self.slideMenuController setContentViewController:nav
                                                  animated:YES
                                                completion:nil];
    }
}

- (void)showMapController {
    [self showControllerClass:[SVMapViewController class]];
}

- (void)showAboutController {
    [self showControllerClass:[SVAboutViewController class]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case MenuMapRow:
            [self showMapController];
            break;
            
        case MenuAboutRow:
            [self showAboutController];
            break;
    }
}


@end
