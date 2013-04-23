//
//  SVAboutViewController.m
//  stourvalley
//
//  Created by Bassem on 12/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVAboutViewController.h"
#import "NVSlideMenuController.h"
#import "socialCell.h"
#import "EventMenuCell.h"
#import "aboutCell.h"
@interface SVAboutViewController ()


@end

@implementation SVAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIImage *)listImage {
    return [UIImage imageNamed:@"list.png"];
}

- (UIBarButtonItem *)slideOutBarButton {
    return [[UIBarButtonItem alloc] initWithImage:[self listImage]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(slideOut:)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
    
    [self.aboutTableView registerNib:[self aboutCellNib] forCellReuseIdentifier:@"AboutCELL"];
    [self.aboutTableView registerNib:[self eventMenuCellNib] forCellReuseIdentifier:@"MenuCell"];
    [self.aboutTableView registerNib:[self socialCellNib] forCellReuseIdentifier:@"SCCELL"];
    
    self.aboutTableView.delegate = self;
    [self.aboutTableView reloadData];
}

- (UINib *)socialCellNib {
    return [UINib nibWithNibName:@"socialCell" bundle:nil];
}
- (UINib *)eventMenuCellNib {
    return [UINib nibWithNibName:@"EventMenuCell" bundle:nil];
}
- (UINib *)aboutCellNib {
    return [UINib nibWithNibName:@"aboutCell" bundle:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *CellIdentifier1 = @"AboutCELL";
    static NSString *CellIdentifier2 = @"MenuCell";
    static NSString *CellIdentifier3 = @"SCCELL";
    
    
    //NSLog(@"Event name : %@, at index %d,%d", [nameArray objectAtIndex:indexPath.section], indexPath.section, indexPath.row);
    
    switch (indexPath.section)
    {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
            }
            UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 180, 120)];
            imv.backgroundColor = [UIColor clearColor];
            imv.opaque = NO;
            imv.image = [UIImage imageNamed:@"about_view"];
            cell.backgroundView = imv;
            cell.userInteractionEnabled = NO;
            
            return cell;
            
        }
        case 1:
        {
            aboutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[aboutCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier1];
            }
            cell.infoTextLabel.text = [NSString stringWithFormat:@"..a unique project which aims to increase public awareness of contemporary art while encouraging greater interest in the environment."];
            cell.addressTextLabel.text = [NSString stringWithFormat:@"Stour Valley Arts Limited is a registered charity in England,  office: King's Wood Forest Office, Buck Street, Challock, Kent TN25 4AR."];
            [cell.timeTextLabel1 setText:@"Open hours during exhibitions"];
            [cell.timeTextLabel2 setText:@"11am-4pm, Wednesday-Saturday"];
            cell.userInteractionEnabled = NO;
            return cell;
            break;
        }
        case 2:
        {
            EventMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[EventMenuCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier2];
            }
            [cell.mcellImage setImage:[UIImage imageNamed:@"phoneIcon"]];
            cell.mcellName.text = [NSString stringWithFormat:@"Call for appointment"];
            return cell;
            break;
        }
        case 3:
        {
            socialCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3 forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[socialCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier3];
            }
            [cell.scImageView1 setImage:[UIImage imageNamed:@"facebookIcon"]];
            [cell.scImageView2 setImage:[UIImage imageNamed:@"vimeoIcon"]];
            [cell.scImageView3 setImage:[UIImage imageNamed:@"soundIcon"]];
            return cell;
            break;
        }
            
    }
    
    //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // if (cell == nil) {
    //   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // }
    
    return nil;
    
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 180;
            break;
        case 1:
            return 180;
            break;
    }
    return 66;
}

#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}

@end
