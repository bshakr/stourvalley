//
//  SVEventsViewController.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 22/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVEventsViewController.h"
#import "NVSlideMenuController.h"
#import "EventDataModel.h"
#import "Event.h"
#import "SVAEventDetailViewController.h"
#import "EventCell.h"


@interface SVEventsViewController ()
{
    NSManagedObjectContext *context;
    NSArray *allEvents;
    NSDateFormatter *df ;
}

@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@end


@implementation SVEventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"SVA Event", @"SVA Event");
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
    

    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
	// Do any additional setup after loading the view.
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd, yyyy"];

    [self loadData];
       
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"EventCell" bundle:nil] forCellWithReuseIdentifier:@"EventCell"];
    [self.collectionView setDelegate:self];
    
    [self.collectionView reloadData];
    [self.collectionView layoutSubviews];
    
}

- (EventDataModel *) shareEvent
{
    return [EventDataModel sharedDataModel];
}

- (void) loadData
{
    //Share DataModel
    context = [[EventDataModel sharedDataModel] mainContext];
    if(context){
        NSLog(@"Context is ready to use");
        
        allEvents = [[self shareEvent] getAllEvents];
        if (allEvents.count != 0) {
        }else{
            [[EventDataModel sharedDataModel] creatEvents];
            allEvents = [[self shareEvent] getAllEvents];
            
        }
        _nameArray = [allEvents valueForKey:@"eventName"];
        _detailArray = [allEvents valueForKey:@"detail"];
        _stDateArray = [allEvents valueForKey:@"startDate"];
        _edDateArray = [allEvents valueForKey:@"endDate"];
        _imgNameArray = [allEvents valueForKey:@"imageTag"];
        _inumArray = [allEvents valueForKey:@"imageCount"];
        
        
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
    NSLog(@"All Event count = %d", allEvents.count);
    return allEvents.count;
    
}




- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    //[cell setNeedsDisplay];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.masksToBounds = NO;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 3.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.3f;
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.shouldRasterize = YES;
    
    cell.titleLabel.text = [self.nameArray objectAtIndex:indexPath.item];
    
   
    NSString *start = [df stringFromDate:[_stDateArray objectAtIndex:indexPath.item]];
    NSString *end = [df stringFromDate:[_edDateArray objectAtIndex:indexPath.item]];
   
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", start, end];
    
    NSString *iname = [NSString stringWithFormat:@"%@-0.jpg",[self.imgNameArray objectAtIndex:indexPath.item]];
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
    if (!self.eventDetailView) {
        self.eventDetailView = [[SVAEventDetailViewController alloc] initWithNibName:@"SVAEventDetailViewController" bundle:nil];
        
    }
    
    NSString *start = [df stringFromDate:[_stDateArray objectAtIndex:indexPath.item]];
    NSString *end = [df stringFromDate:[_edDateArray objectAtIndex:indexPath.item]];

    self.eventDetailView.titleLabel = [self.nameArray objectAtIndex:indexPath.item];
    self.eventDetailView.descLabel = [self.detailArray objectAtIndex:indexPath.item];
    self.eventDetailView.dateLabel =  [NSString stringWithFormat:@"%@ - %@", start, end];
    self.eventDetailView.cellCount = [[self.inumArray objectAtIndex:indexPath.item] integerValue];
    self.eventDetailView.imageTag = [self.imgNameArray objectAtIndex:indexPath.item];
    
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:self.eventDetailView animated:NO];
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[imageCollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    imageCollectionView *collectionView = (imageCollectionView *)scrollView;
    NSInteger index = collectionView.index;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}



@end
