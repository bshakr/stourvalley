//
//  SVArtistsDetailViewController.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 04/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVArtistsDetailViewController.h"
#import "NVSlideMenuController.h"
#import "tableCell.h"
#import "EventMenuCell.h"
#import "cellectionCell.h"
#import "imageTableCell.h"
#import "imageCollectionView.h"
#import "SVAWebView.h"
#import "UIViewController+MJPopupViewController.h"
#import "PopupViewController.h"
#import "ArtInstallationDataModel.h"
#import "SVMapboxViewController.h"


@interface SVArtistsDetailViewController ()
{
    NSManagedObjectContext *context;
    NSArray *installationArray;
    float la, lo;
    NSString *installationName;
    NSMutableArray *arrayforLat;
    NSMutableArray *arrayforLon;
    
}
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@end

@implementation SVArtistsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*- (UIImage *)listImage {
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
 */


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.artistTableView deselectRowAtIndexPath:[self.artistTableView indexPathForSelectedRow] animated:YES];
    self.title = NSLocalizedString(self.titleLabel, @"SVA");
    [self.artistTableView reloadData];
    [self.collectionView reloadData];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *navBG = [UIImage imageNamed:@"navbar.jpg"];
    [self.navigationController.navigationBar setBackgroundImage:navBG forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:187/255.0 green:83/255.0 blue:88/255.0 alpha:0.5]];
    
    //self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
    
    [self.artistTableView registerNib:[self tableCellNib] forCellReuseIdentifier:@"TBCELL"];
    [self.artistTableView registerNib:[self menuCellNib] forCellReuseIdentifier:@"MenuCell"];
    //  [self.eventTableView registerClass:[imageTableCell class] forCellReuseIdentifier:CollectionViewCellIdentifier];
    [self.collectionView registerNib:[self imageCollectionCellNib] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
    [self.artistTableView setBackgroundColor:[UIColor colorWithRed:250/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]];
    
    self.artistTableView.delegate = self;
    [self.artistTableView reloadData];
    [self.collectionView reloadData];
    
}

- (UINib *)tableCellNib {
    return [UINib nibWithNibName:@"tablecell" bundle:nil];
}


- (UINib *)menuCellNib {
    return [UINib nibWithNibName:@"EventMenuCell" bundle:nil];
}


- (UINib *)imageCollectionCellNib {
    return [UINib nibWithNibName:@"collectionCell" bundle:nil];
}

- (ArtInstallationDataModel *) shareInstallation
{
    return [ArtInstallationDataModel sharedDataModel];
}

- (void) getInstallationforArtist
{
    //Share DataModel
    context = [self.shareInstallation mainContext];
    installationArray = nil;
    NSString *thisArtist =  self.titleLabel ;
    NSLog(@"This Artist is %@", thisArtist);
    if(context){
        NSLog(@"Context is ready to use");
        installationArray = [[self shareInstallation] getLocationByName:thisArtist];
        if (installationArray.count == 0) {
            // [[ArtistDataModel sharedDataModel] creatArtists];
            // allArtists = [[self shareArtist] loadAllArtists];
            NSLog(@"Not found installation for %@", thisArtist);
            
        }else{
            
            NSLog(@"Found %d installation in db -> %@", installationArray.count, [[installationArray objectAtIndex:0] description]);
            arrayforLat = [installationArray valueForKey:@"latitude"];
            arrayforLon = [installationArray valueForKey:@"longitude"];
            
            
            
        }
        // _nameArray = [allArtists valueForKey:@"name"];
        // _detailArray = [allArtists valueForKey:@"info"];
        // _stDateArray = [allArtists valueForKey:@"commissionDate"];
        // _inumArray = [allArtists valueForKey:@"imageCount"];
        
        
    }else{
        NSLog(@"Context == nil");
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /* switch (section)
     {
     case 0:
     return 1;
     break;
     case 1:
     return 1;
     break;
     }
     return 2;
     */
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TBCELL";
    static NSString *CellIdentifier2 = @"MenuCell";
    static NSString *ImageCellIdent = @"CellIdentifier";
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            imageTableCell *cell = (imageTableCell *)[tableView dequeueReusableCellWithIdentifier:ImageCellIdent];
            
            cell = [[imageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageCellIdent];
            
            [cell setCollectionViewDataSourceDelegate:self index:indexPath.row];
            NSInteger index = cell.collectionView.index;
            
            CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
            [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
            
            return cell;
            break;
            
        }
        case 1:
        {
            tableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[tableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
            }
            //[cell.tbImageView setImage:[UIImage imageNamed:@"svaavatar.png"]];
            cell.tbImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            
            cell.tbImageView.layer.cornerRadius = 75.0f/2.0f ;
            cell.tbImageView.layer.borderWidth = 4.0f;
            cell.tbImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.tbImageView.layer.shouldRasterize = YES;
            //self.imageView.contentMode = UIViewContentModeScaleToFill;
            cell.tbImageView.clipsToBounds = YES;
            
            
            NSString *avatar = [NSString stringWithFormat:@"%@-avt.jpg", self.imageTag];
            [cell.tbImageView setImage:[UIImage imageNamed:avatar]];
            cell.tbNameField.text = self.titleLabel;
            cell.tbDescField.text = self.descLabel;
            cell.tbDateField.text = self.dateLabel;
            _index = indexPath.row;
            cell.userInteractionEnabled = NO;
            
            
            return cell;
            break;
        }
            
    }
    
    EventMenuCell *cell = [tableView
                           dequeueReusableCellWithIdentifier:CellIdentifier2
                           forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[EventMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
    }
    if (indexPath.section ==2 && indexPath.row == 0) {
        cell.mcellName.text = [NSString stringWithFormat:@"Get direction"];
        [cell.mcellImage setImage:[UIImage imageNamed:@"directionIcon"]];
        //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    /*
     if (indexPath.section ==2 && indexPath.row == 1) {
     cell.mcellName.text = [NSString stringWithFormat:@"Get direction"];
     [cell.mcellImage setImage:[UIImage imageNamed:@"directionIcon"]];
     //cell.selectionStyle = UITableViewCellSelectionStyleGray;
     }*/
    
    return cell;
    
}


#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 200;
            break;
        case 1:
            return 229;
            break;
    }
    return 77;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self getInstallationforArtist];
        
        if (installationArray.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Destination not found"
                                                            message:@"The art commission has been claimed by the forest"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self.artistTableView deselectRowAtIndexPath:[self.artistTableView indexPathForSelectedRow] animated:YES];
        }else{
            
            la = [[arrayforLat objectAtIndex:0] floatValue];
            lo = [[arrayforLon objectAtIndex:0] floatValue];
            NSLog(@"lat/lon %f/%f", la,lo);
            
            if (!self.mapView) {
                //initial lat/lon around carpark 51.2133, 0.8963
                self.mapView = [[SVMapboxViewController alloc] initWithLatitude:[NSNumber numberWithFloat:la] andLongitude:[NSNumber numberWithFloat:lo]];
                
            }
            
            //self.webView.address =  self.bookingLink;
            //self.webView.pagetitle = @"SVA Events";
            [self.navigationController pushViewController:self.mapView animated:YES];
            
        }
        
    }
    
}


#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(imageCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  self.cellCount;
}

-(UICollectionViewCell *)collectionView:(imageCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 200, 125)];
    imv.backgroundColor = [UIColor clearColor];
    imv.opaque = NO;
    
    NSString *iname = [NSString stringWithFormat:@"%@-%i.jpg",self.imageTag,indexPath.row];
    
    if ([UIImage imageNamed:iname]) {
        imv.image = [UIImage imageNamed:iname];
    }else{
        //event-default
        imv.image = [UIImage imageNamed:@"event-default.jpg"];
    }
    cell.backgroundView = imv;
    
    cell.layer.masksToBounds = NO;
    //cell.layer.borderColor = [UIColor whiteColor].CGColor;
    //cell.layer.borderWidth = 3.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.3f;
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOffset = CGSizeMake(1.0f, 2.0f);
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.shouldRasterize = YES;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    
    PopupViewController *popUpView = [[PopupViewController alloc] initWithNibName:@"PopupViewController" bundle:nil];
    
    NSString *iname = [NSString stringWithFormat:@"%@-%i.jpg",self.imageTag,indexPath.item];
    popUpView.view.backgroundColor = [UIColor blackColor];
    //popUpView.fullImageView.backgroundColor = [UIColor clearColor];
    
    
    if ([UIImage imageNamed:iname]) {
        
        [popUpView.fullImageView setImage:[UIImage imageNamed:iname]];
        NSLog(@"click at image : %@", iname);
        
    }else{
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        
    }
    
    
    [self presentPopupViewController:popUpView animationType:MJPopupViewAnimationFade];
    
    
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[imageCollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    imageCollectionView *collectionView = (imageCollectionView *)scrollView;
    NSInteger index = collectionView.index;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

@end
