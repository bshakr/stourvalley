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
#import "SVAWebView.h"

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
         self.title = NSLocalizedString(@"About SVA", @"About SVA");

    }
    return self;
}
- (UIImage *)listImage {
    return [UIImage imageNamed:@"list.png"];
}

- (UIBarButtonItem *)slideOutBarButton {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[self listImage]
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(slideOut:)];
    [button setTintColor:[UIColor colorWithRed:187/255.0 green:83/255.0 blue:88/255.0 alpha:0.5]];
    return button;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *navBG = [UIImage imageNamed:@"navbar.jpg"];
    [self.navigationController.navigationBar setBackgroundImage:navBG forBarMetrics:UIBarMetricsDefault];
    

    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[AboutCollectionCell class] forCellWithReuseIdentifier:AboutCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellWithReuseIdentifier:AboutCellIdentifier2];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AboutMenuCell" bundle:nil] forCellWithReuseIdentifier:AboutCellIdentifier3];
    [self.collectionView registerClass:[socailMenuCell class] forCellWithReuseIdentifier:AboutCellIdentifier4];
    [self.collectionView reloadData];
    
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
            //aboutCell.imageView.image = [UIImage imageNamed:@"about_view"];
            UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 191.0f)];
            imv.backgroundColor = [UIColor clearColor];
            imv.opaque = NO;
            imv.contentMode = UIViewContentModeScaleToFill;
            imv.image = [UIImage imageNamed:@"about_view"];
            aboutCell.backgroundView = imv;
            return aboutCell;
            break;
    
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
                {    aboutCell.imageView.center = aboutCell.contentView.center;
                    [aboutCell.imageView setImage:[UIImage imageNamed:@"facebookIcon"]];
                }
                    break;
                case 1:
                {    aboutCell.imageView.center = aboutCell.contentView.center;
                    [aboutCell.imageView setImage:[UIImage imageNamed:@"vimeoIcon"]];
                }
                    break;
                case 2:
                {   aboutCell.imageView.center = aboutCell.contentView.center;
                    [aboutCell.imageView setImage:[UIImage imageNamed:@"soundIcon"]];
                }
                    break;
            }
            
            
            return aboutCell;
            break;
        }
    }
    
    return nil;

    
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    
    switch (indexPath.section) {
        case 2:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://01233664987 "]];
            break;
        }
        case 3:
            switch (indexPath.item) {
                case 0:
                {
                    NSLog(@"Click to facebook");
                    
                    NSURL *urlApp = [NSURL URLWithString: [NSString stringWithFormat:@"%@", @"fb://profile/100000745144271"]];
                    if ([[UIApplication sharedApplication] canOpenURL:urlApp]){
                        [[UIApplication sharedApplication] openURL:urlApp];
                    }else{
                        UIAlertView *noappAlert = [[UIAlertView alloc] initWithTitle:@"Facebook App Not Installed!" message:@"Please install the App on your iPhone." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                        [noappAlert show];
                        
                        if (!self.webView) {
                            self.webView = [[SVAWebView alloc] initWithNibName:@"SVAWebView" bundle:nil];
                            
                        }
                        
                        self.webView.address = @"https://www.facebook.com/stour.arts";
                        self.webView.pagetitle = @"SVA Facebook";
                        [self.navigationController pushViewController:self.webView animated:YES];
                    }
                    break;
                }
                    
                case 1:
                    {   
                        if (!self.webView) {
                            self.webView = [[SVAWebView alloc] initWithNibName:@"SVAWebView" bundle:nil];
                            
                        }
                        
                        self.webView.address =  @"http://vimeo.com/user3494787";
                        self.webView.pagetitle = @"SVA Vimeo";
                        [self.navigationController pushViewController:self.webView animated:YES];
                        
                        
                        break;
                        
                    }
                case 2:
                    {
                       
                        
                        if (!self.webView) {
                            self.webView = [[SVAWebView alloc] initWithNibName:@"SVAWebView" bundle:nil];
                            
                        }
                        
                        self.webView.address =  @"https://soundcloud.com/sva";
                        self.webView.pagetitle = @"SVA SoundCloud";
                        [self.navigationController pushViewController:self.webView animated:YES];
                        
                        break;
                    }
            }
            break;
    }
    
    
    
}

#pragma mark - View Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        
    }
    [self.collectionView reloadData];
}

#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}


@end
