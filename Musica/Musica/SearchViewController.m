//
//  SearchViewController.m
//  Musica
//
//  Created by Julieta Puente on 08/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "SearchedObject.h"
#import "SearchService.h"
#import "MBProgressHUD.h"
#import "NoResultViewController.h"
#import "ProductDetailViewController.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate,SearchResponse>

@property (strong, nonatomic) NSMutableArray * objects;
@property (strong, nonatomic) SearchTableViewCell * cellPrototype;
@property (strong,nonatomic) SearchService * searchService;
@property (copy, nonatomic) NSString * searchString;
@property (strong, nonatomic) MBProgressHUD * HUD;
@property (strong,nonatomic) SearchTableViewCell *lastVisibleCell;
@end
@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSearchString:(NSString *)search
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchService = [[SearchService alloc]init];
        self.searchString=search;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableViewSearch.delegate = self;
    self.tableViewSearch.dataSource = self;
    [self.tableViewSearch registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellIdentifier"];
     self.cellPrototype = [self.tableViewSearch dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    self.searchService.delegate=self;
    //ASADO: horripilante, algo mejor??
    self.tableViewSearch.tableFooterView = [[UIView alloc] init] ;
    [self.searchService searchApiWithString:self.searchString];
    if(self.HUD == nil){
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    self.HUD.labelText = @"Buscando";
    self.HUD.detailsLabelText = @"Por favor espere";
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.yOffset = -30.0;
    [self.HUD show:YES];
    [self.view addSubview:self.HUD];
   
}

#pragma mark - table view

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"CellIdentifier";
    
    SearchTableViewCell * cell=(SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    SearchedObject * content = self.objects[indexPath.row];
    [cell completeCellWithContent:content];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchedObject * content = self.objects[indexPath.row];
    [self.cellPrototype  completeCellWithContent:content];
    return [self.cellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
}


-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.objects count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *visibleRows = [self.tableViewSearch visibleCells];
    SearchTableViewCell *lastCell = [visibleRows lastObject];
    NSIndexPath *path = [self.tableViewSearch indexPathForCell:lastCell];
    if(path.row == [self.objects count]-1)
    {
        if(lastCell!= self.lastVisibleCell){
            self.lastVisibleCell=lastCell;
            UIActivityIndicatorView * spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [spinner startAnimating];
            spinner.frame = CGRectMake(0, 0, 320, 44);
            self.tableViewSearch.tableFooterView =spinner;
            [self.searchService fetchNextPage];
        }
    }
}
-(void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [(SearchTableViewCell *)cell cancelService];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell * cell = (SearchTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    ProductDetailViewController * productView = [[ProductDetailViewController alloc]initWithNibName:nil bundle:nil withURL:cell.permalink];
    [self.navigationController pushViewController:productView animated:YES];
    [self.tableViewSearch deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - search service response
-(void) fetchFailed:(NSError *) error{
    dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Se produjo un error en la conexión" message:@"Por favor inténtelo nuevamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.HUD hide:YES];
    self.tableViewSearch.tableFooterView =nil;
         });

}

-(void) noResultsFound{
    dispatch_async(dispatch_get_main_queue(), ^{
        NoResultViewController * noResultView = [[NoResultViewController alloc]initWithNibName:nil bundle:nil];
        [self.view addSubview:noResultView.view];
        [self.HUD hide:YES];
        self.tableViewSearch.tableFooterView =nil;
    });

}

-(void) resultsReceived:(NSArray *)results{
    if (self.objects == nil){
        self.objects= [NSMutableArray arrayWithArray:results] ;
    }else{
        [self.objects addObjectsFromArray:results];
    }
    NSLog(@"%d", [self.objects count]);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD hide:YES];
        [self.tableViewSearch reloadData];
        self.tableViewSearch.tableFooterView =nil;
    });
}

-(void) allResultsLoaded{
    self.tableViewSearch.tableFooterView =nil;
}

@end
