//
//  SVAboutViewController.m
//  stourvalley
//
//  Created by Bassem on 12/03/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVAboutViewController.h"
#import "NVSlideMenuController.h"

#import "AboutCollectionCell.h"
#import "AboutLayout.h"
#import "socailMenuCell.h"
#import "DetailCell.h"
#import "AboutMenuCell.h"

static NSString * const AboutCellIdentifier = @"AboutCell";
static NSString * const AboutCellIdentifier2 = @"DetailCell";
static NSString * const AboutCellIdentifier3 = @"AboutMenuCell";
static NSString * const AboutCellIdentifier4 = @"socailMenuCell";


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
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[AboutCollectionCell class] forCellWithReuseIdentifier:AboutCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellWithReuseIdentifier:AboutCellIdentifier2];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AboutMenuCell" bundle:nil] forCellWithReuseIdentifier:AboutCellIdentifier3];
    [self.collectionView registerClass:[socailMenuCell class] forCellWithReuseIdentifier:AboutCellIdentifier4];
    
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 3:
            return 3;
            break;
        default:
            return 1;
            break;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    switch (indexPath.section) {
        case 0:
        {
            AboutCollectionCell *aboutCell =
            [collectionView dequeueReusableCellWithReuseIdentifier:AboutCellIdentifier
                                                      forIndexPath:indexPath];
            aboutCell.imageView.image = [UIImage imageNamed:@"about_view"];
            return aboutCell;
            break;
            
        }
        case 1:
        {
            DetailCell *detailCell =
            [collectionView dequeueReusableCellWithReuseIdentifier:AboutCellIdentifier2
                                                      forIndexPath:indexPath];
            detailCell.infoTextLabel.text = [NSString stringWithFormat:@"..a unique project which aims to increase public awareness of contemporary art while encouraging greater interest in the environment."];
            detailCell.addressTextLabel.text = [NSString stringWithFormat:@"Stour Valley Arts Limited is a registered charity in England,  office: King's Wood Forest Office, Buck Street, Challock, Kent TN25 4AR."];
            [detailCell.timeTextLabel1 setText:@"Open hours during exhibitions"];
            [detailCell.timeTextLabel2 setText:@"11am-4pm, Wednesday-Saturday"];
            detailCell.userInteractionEnabled = NO;
            return detailCell;
            break;
        }
        case 2:
        {
            AboutMenuCell *cell =
            [collectionView dequeueReusableCellWithReuseIdentifier:AboutCellIdentifier3
                                                      forIndexPath:indexPath];
            [cell.menuIconImage setImage:[UIImage imageNamed:@"phoneIcon"]];
            [cell.menuLabel setText:@"Call for appointment"];
            
            return cell;
            break;
        }
        case 3:
        {
            socailMenuCell *aboutCell =
            [collectionView dequeueReusableCellWithReuseIdentifier:AboutCellIdentifier4
                                                      forIndexPath:indexPath];
            
            
            switch (indexPath.item) {
                case 0:
                    [aboutCell.imageView setImage:[UIImage imageNamed:@"facebookIcon"]];
                    break;
                case 1:
                    [aboutCell.imageView setImage:[UIImage imageNamed:@"vimeoIcon"]];
                    
                    break;
                case 2:
                    [aboutCell.imageView setImage:[UIImage imageNamed:@"soundIcon"]];
                    
                    break;
            }
            
            
            return aboutCell;
            break;
        }
    }
    
    return nil;

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    switch (indexPath.section) {
        case 2:
            NSLog(@"Click to phone");
            break;
        case 3:
            switch (indexPath.item) {
                case 0:
                    NSLog(@"Click to facebook");
                    break;
                case 1:
                    NSLog(@"Click to vemio");
                    break;
                case 2:
                    NSLog(@"Click to soundclound");
                    break;
            }
            break;
    }
    
}



#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}


@end
