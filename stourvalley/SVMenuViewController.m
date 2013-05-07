//
//  SVMenuViewController.m
//  stourvalley
//
//  Created by Bassem on 18/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVMenuViewController.h"
#import "NVSlideMenuController.h"
#import "SVAboutViewController.h"
#import "SVMapboxViewController.h"
#import "SVEventsViewController.h"
#import "SVArtistsViewController.h"
#import "UIColor+RGB.h"

enum {
    MenuMapRow = 0,
    MenuEventRow,
    MenuArtistRow,
    MenuAboutRow,
    MenuRowCount
};

@interface SVMenuViewController ()

@end

@implementation SVMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *menuBG = [UIImage imageNamed:@"menu-bg.png"];
    UIColor *backgroundTile = [UIColor colorWithPatternImage:menuBG];
    self.tableView.backgroundColor = backgroundTile;
    self.tableView.separatorColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Menu";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70,10,300,24)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithR:187 g:83 b:88 a:1.0];
    label.text = @"Stour Valley Arts";
    [headerView addSubview:label];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)configureCell:(SVMenuCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case MenuMapRow:
            cell.icon.image = [UIImage  imageNamed:@"map-icon.png"];
            cell.label.text = @"Map";
            break;

        case MenuEventRow:
            cell.icon.image = [UIImage  imageNamed:@"calendar-icon.png"];
            cell.label.text = @"Events";
            break;
    
        case MenuArtistRow:
            cell.icon.image = [UIImage  imageNamed:@"exhibition-icon.png"];
            cell.label.text = @"Artist Commissions";
            break;
            
        case MenuAboutRow:
            cell.icon.image = [UIImage  imageNamed:@"about-icon.png"];
            cell.label.text = @"About SVA";
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SVMenuCell";
    SVMenuCell *menuCell =(SVMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(menuCell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SVMenuCell" owner:self options:nil];
        menuCell = _menuCell;
        _menuCell = nil;

    }
    [self configureCell:menuCell forIndexPath:indexPath];
    
    return menuCell;
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
    }
    else {
        id mainVC = [[class alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
        [self.slideMenuController setContentViewController:nav animated:YES completion:nil];
    }
}

- (void)showMapController {
    [self showControllerClass:[SVMapboxViewController class]];
}

- (void)showEventController {
    [self showControllerClass:[SVEventsViewController class]];
}

-  (void)showArtistController{
    [self showControllerClass:[SVArtistsViewController class]];
}

- (void)showAboutController {
    [self showControllerClass:[SVAboutViewController class]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case MenuMapRow:
            [self showMapController];
            break;
            
        case MenuEventRow:
            [self showEventController];
            break;
            
        case MenuArtistRow:
            [self showArtistController];
            break;
            
        case MenuAboutRow:
            [self showAboutController];
            break;
    }
}


@end
