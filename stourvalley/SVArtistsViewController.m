//
//  SVArtistsViewController.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 04/05/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVArtistsViewController.h"
#import "NVSlideMenuController.h"
#import "ArtistDataModel.h"
#import "Artist.h"
#import "SVArtistsDetailViewController.h"
#import "EventCell.h"



@interface SVArtistsViewController ()
{
    NSManagedObjectContext *context;
    NSArray *allArtists;
}
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@end

@implementation SVArtistsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = NSLocalizedString(@"Artist Commissions", @"Artist Commissions");
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
    // Do any additional setup after loading the view from its nib.
    UIImage *navBG = [UIImage imageNamed:@"navbar.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBG forBarMetrics:UIBarMetricsDefault];

    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
	// Do any additional setup after loading the view.
    
    [self loadData];
    
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:247/255.0 green:242/255.0 blue:236/255.0 alpha:1.0]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"EventCell" bundle:nil] forCellWithReuseIdentifier:@"EventCell"];
    [self.collectionView setDelegate:self];
    
    [self.collectionView reloadData];
    [self.collectionView layoutSubviews];
}


- (ArtistDataModel *) shareArtist
{
    return [ArtistDataModel sharedDataModel];
}

- (void) loadData
{
    //Share DataModel
    context = [[ArtistDataModel sharedDataModel] mainContext];
    allArtists = nil;
    if(context){
        NSLog(@"Context is ready to use");
        allArtists = [[self shareArtist] loadAllArtists];
        if (allArtists.count == 0) {
            [[ArtistDataModel sharedDataModel] creatArtists];
            allArtists = [[self shareArtist] loadAllArtists];
            
        }        
        _nameArray = [allArtists valueForKey:@"name"];
        _detailArray = [allArtists valueForKey:@"info"];
        _stDateArray = [allArtists valueForKey:@"commissionDate"];
        _inumArray = [allArtists valueForKey:@"imageCount"];
        
        
    }else{
        NSLog(@"Context == nil");
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"All Event count = %d", allArtists.count);
    return allArtists.count;
    
}




- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    //[cell setNeedsDisplay];
    cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    cell.layer.masksToBounds = NO;
    //cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0].CGColor;
    cell.layer.borderWidth = 3.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.3f;
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.shouldRasterize = YES;
    
    cell.titleLabel.text = [self.nameArray objectAtIndex:indexPath.item];
    
    
    
    NSString *commissionDate = [_stDateArray objectAtIndex:indexPath.item];
    //NSString *end = [_edDateArray objectAtIndex:indexPath.item];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", commissionDate];
    
    NSString *iname = [NSString stringWithFormat:@"%@-0.jpg",[self.nameArray objectAtIndex:indexPath.item]];
    //NSString *iname = @"event-default.jpg";
    cell.imageCV.image = nil;
    
    if ([UIImage imageNamed:iname]) {
        cell.imageCV.image = [UIImage imageNamed:iname];
    }else{
        //event-default
        cell.imageCV.image = [UIImage imageNamed:@"event-default.jpg"];
    }
    //cell.imageCV.image = [UIImage imageNamed:@"event.jpg"];
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.artistsDetailView) {
        self.artistsDetailView = [[SVArtistsDetailViewController alloc] initWithNibName:@"SVArtistsDetailViewController" bundle:nil];
        
    }
    
    
    NSString *commisDate = [_stDateArray objectAtIndex:indexPath.item];
    //NSString *end = [_edDateArray objectAtIndex:indexPath.item];
    
    self.artistsDetailView.titleLabel = [self.nameArray objectAtIndex:indexPath.item];
    self.artistsDetailView.descLabel = [self.detailArray objectAtIndex:indexPath.item];
    self.artistsDetailView.dateLabel =  [NSString stringWithFormat:@"%@", commisDate];
    self.artistsDetailView.cellCount = [[self.inumArray objectAtIndex:indexPath.item] integerValue];
    
    NSString *imageTage = [self.nameArray objectAtIndex:indexPath.item];
    self.artistsDetailView.imageTag = imageTage;
    //self.artistsDetailView.bookingLink = [self.linkArray objectAtIndex:indexPath.item];
   // self.artistsDetailView.bookingLink = @"";
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:self.artistsDetailView animated:NO];
    
}






#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    
}


#pragma mark - Event handlers

- (void)slideOut:(id)sender {
    [self.slideMenuController toggleMenuAnimated:self];
}


#pragma mark - UIScrollViewDelegate Methods

/*-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[imageCollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    imageCollectionView *collectionView = (imageCollectionView *)scrollView;
    NSInteger index = collectionView.index;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}
*/


@end
