//
//  SearchBarViewController.m
//  Musica
//
//  Created by Julieta Puente on 11/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchBarViewController.h"
#import "SearchViewController.h"
#import "KeyboardToolbar.h"
#import "RecentSearchTableViewCell.h"

@interface SearchBarViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray * recentSearch;
@property (strong, nonatomic) NSMutableArray * filteredArray;
@property (strong,nonatomic) RecentSearchTableViewCell * cellPrototype;
@end

@implementation SearchBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.recentSearch = [NSMutableArray array];
//        self.filteredArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.text = nil;
    self.searchBar.barTintColor = [UIColor yellowColor];
    [self.searchBar setPlaceholder:@"Buscar"];
    self.searchBar.delegate= self;
    self.searchBar.showsCancelButton = YES;

    KeyboardToolbar *toolBar = [[KeyboardToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                     0.0f,
                                                                     self.view.window.frame.size.width,
                                                                     35.0f)];
    toolBar.okButton.action=@selector(doneEditing);
    self.searchBar.inputAccessoryView = toolBar;
    self.tableViewRecents.delegate=self;
    self.tableViewRecents.dataSource=self;
    [self.tableViewRecents registerNib:[UINib nibWithNibName:@"RecentSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellIdentifier"];
    self.cellPrototype = [self.tableViewRecents dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    //ASADO: horripilante, algo mejor??
    self.tableViewRecents.tableFooterView = [[UIView alloc] init] ;
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.searchBar.text = nil;
    [self.tableViewRecents reloadData];
}


#pragma mark- Search bar
-(void) doneEditing{
    [self.searchBar resignFirstResponder];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    [self filterContentForSearchText: searchBar.text];
    if(![self.recentSearch containsObject:searchBar.text]){
        
        [self.recentSearch addObject:searchBar.text];
    }
    [self loadSearchWithString: searchBar.text];
}

-(void) loadSearchWithString: (NSString *) search{
    SearchViewController * searchView = [[SearchViewController alloc]initWithNibName:nil bundle:nil withSearchString:search];
    [self.navigationController pushViewController:searchView animated:YES];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
}


#pragma mark - Table view

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.recentSearch count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"CellIdentifier";
    RecentSearchTableViewCell * cell=(RecentSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self completeCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

-(void) completeCell:(RecentSearchTableViewCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.labelRecent.text =self.recentSearch[indexPath.row];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self loadSearchWithString:self.recentSearch [indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self completeCell:self.cellPrototype cellForRowAtIndexPath:indexPath];
    return [self.cellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
}


-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

#pragma mark Content Filtering
//-(void)filterContentForSearchText:(NSString*)searchText {
//    [self.filteredArray removeAllObjects];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
//    self.filteredArray = [NSMutableArray arrayWithArray:[self.recentSearch filteredArrayUsingPredicate:predicate]];
//    NSLog(@"filteredArray count %d", [self.filteredArray count]);
//}

@end
