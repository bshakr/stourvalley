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
#import "tableCell.h"
#import "EventMenuCell.h"
#import "cellectionCell.h"
#import "imageTableCell.h"
#import "imageCollectionView.h"



@interface SVEventsViewController ()
{
    NSManagedObjectContext *context;
    NSArray *allEvents;
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
    return [[UIBarButtonItem alloc] initWithImage:[self listImage]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(slideOut:)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self slideOutBarButton];
	// Do any additional setup after loading the view.
   
    //Share DataModel
    context = [[EventDataModel sharedDataModel] mainContext];
    if(context){
        NSLog(@"Context is ready to use");
        // allEvents = [[EventDataModel sharedDataModel] getAllEvents];
        allEvents = [[self shareEvent] getAllEvents];
        if (allEvents.count != 0) {
          //  NSLog(@"allEvent %d", allEvents.count);
            
        }else{
            NSLog(@"allEvent is nil");
            [[EventDataModel sharedDataModel] creatEvents];
            NSLog(@"Inserted events");
            allEvents = [[self shareEvent] getAllEvents];
            NSLog(@"allEvent %d", allEvents.count);
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
    
    [self.eventTableView registerNib:[self tableCellNib] forCellReuseIdentifier:@"TBCELL"];
    [self.eventTableView registerNib:[self menuCellNib] forCellReuseIdentifier:@"MenuCell"];
    //  [self.eventTableView registerClass:[imageTableCell class] forCellReuseIdentifier:CollectionViewCellIdentifier];
    [self.collectionView registerNib:[self imageCollectionCellNib] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
    
    self.eventTableView.delegate = self;
    [self.eventTableView reloadData];
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

-(EventDataModel *) shareEvent
{
    return [EventDataModel sharedDataModel];
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
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
    }
    return 2;
    
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
            // cell.tbImageView.layer.cornerRadius = 37.5;
            // cell.tbImageView.layer.masksToBounds =  YES;
            //cell.tbImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            // cell.tbImageView.layer.borderWidth = 1.0;
            [cell.tbImageView setImage:[UIImage imageNamed:@"svaavatar.png"]];
            cell.tbNameField.text = [_nameArray objectAtIndex:indexPath.row];
            cell.tbDescField.text =  [_detailArray objectAtIndex:indexPath.row];
            
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd"];
            NSString *start = [df stringFromDate:[_stDateArray objectAtIndex:indexPath.row]];
            NSString *end = [df stringFromDate:[_edDateArray objectAtIndex:indexPath.row]];
            cell.tbDateField.text = [NSString stringWithFormat:@"%@ - %@", start, end];
            
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
        cell.mcellName.text = [NSString stringWithFormat:@"Booking"];
        [cell.mcellImage setImage:[UIImage imageNamed:@"bookingIcon"]];
        
    }if (indexPath.section ==2 && indexPath.row == 1) {
        cell.mcellName.text = [NSString stringWithFormat:@"Get direction"];
        [cell.mcellImage setImage:[UIImage imageNamed:@"directionIcon"]];
    }
    //cell.mcellName.text = [NSString stringWithFormat:@"sva menu %d, %d", indexPath.section, indexPath.row];
    return cell;
    
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
            return 200;
            break;
    }
    return 66;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(imageCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_inumArray objectAtIndex:self.index] integerValue];
}

-(UICollectionViewCell *)collectionView:(imageCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
  
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 180, 120)];
    imv.backgroundColor = [UIColor clearColor];
    imv.opaque = NO;
    
    
    NSString *iname = [NSString stringWithFormat:@"event%i-%i.jpg",_index,indexPath.row];
    if ([UIImage imageNamed:iname]) {
        imv.image = [UIImage imageNamed:iname];
    }else{
        //event-default
        imv.image = [UIImage imageNamed:@"event-default.jpg"];
    }
    cell.backgroundView = imv;
    
    //cell.backgroundColor = [UIColor grayColor];
    return cell;
}

/*#pragma mark - UICollectionViewDelegate
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
 {
 return YES;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
 // TODO: Select Item
 self.index = indexPath.row;
 //NSLog(@"Selecting index = %d", _index);
 
 }*/

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
