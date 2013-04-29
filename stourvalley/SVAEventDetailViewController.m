//
//  SVAEventDetailViewController.m
//  stourvalley
//
//  Created by Treechot Shompoonut on 28/04/2013.
//  Copyright (c) 2013 Bassem Shaker. All rights reserved.
//

#import "SVAEventDetailViewController.h"
#import "NVSlideMenuController.h"
#import "tableCell.h"
#import "EventMenuCell.h"
#import "cellectionCell.h"
#import "imageTableCell.h"
#import "imageCollectionView.h"




@interface SVAEventDetailViewController ()
{
   
}
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;

@end

@implementation SVAEventDetailViewController

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
            [cell.tbImageView setImage:[UIImage imageNamed:@"svaavatar.png"]];
            
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
        cell.mcellName.text = [NSString stringWithFormat:@"Booking"];
        [cell.mcellImage setImage:[UIImage imageNamed:@"bookingIcon"]];
        
    }if (indexPath.section ==2 && indexPath.row == 1) {
        cell.mcellName.text = [NSString stringWithFormat:@"Get direction"];
        [cell.mcellImage setImage:[UIImage imageNamed:@"directionIcon"]];
    }
    
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
   
    return  self.cellCount;
}

-(UICollectionViewCell *)collectionView:(imageCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 180, 120)];
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
