//
//  LibraryViewController.m
//  Musica
//
//  Created by Julieta Puente on 21/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "LibraryViewController.h"
#import "AlbumTableViewCell.h"
#import "MusicLibrary.h"
#import "AlbumDetailViewController.h"
#import "Album.h"
#import "HeaderView.h"


@interface LibraryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViewLibrary;
@property (strong, nonatomic) NSArray * tableData;
@property (strong,nonatomic) MusicLibrary * music;
@property (strong, nonatomic) AlbumTableViewCell * cellPrototype;
@property (strong, nonatomic) NSDictionary * groupSection;
@property (strong, nonatomic) HeaderView * headerView;

@end

@implementation LibraryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withMusic: (MusicLibrary *) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music=music;
        self.groupSection = [self.music getAlbums];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableViewLibrary.delegate = self;
    self.tableViewLibrary.dataSource = self;
    NSString * cellIdentifier =@"CellIdentifier";
    [self.tableViewLibrary registerNib:[UINib nibWithNibName:@"AlbumTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.cellPrototype = [self.tableViewLibrary dequeueReusableCellWithIdentifier:cellIdentifier];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableViewLibrary reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString * name = [self.groupSection allKeys][section];
    return [[self.groupSection objectForKey:name] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.groupSection allKeys]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"CellIdentifier";
    
    AlbumTableViewCell * cell = (AlbumTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AlbumTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
   }
  
    [self initCellContent:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

-(void) initCellContent: (AlbumTableViewCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * name = [self.groupSection allKeys][indexPath.section];
    Album * album= [self.groupSection objectForKey:name][indexPath.row];
    cell.labelName.text= [album getName];
    cell.labelYear.text= [album getYear];
    cell.labelGroup.text=name;
    cell.imageViewAlbum.image = [UIImage imageNamed:[album getImageName]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headerView = [[HeaderView alloc]init];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    self.headerView = [nib objectAtIndex:0];
    [self initHeader:self.headerView inSection:section];
    return self.headerView;
}

-(void)initHeader:(HeaderView *) headerView inSection: (NSInteger)section{
    [headerView.labelGroup setText:[self.groupSection allKeys][section]];
    [headerView.labelStyle setText:[self.music styleForGroup: headerView.labelGroup.text]];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    [self initHeader:self.headerView inSection:section];
    return [self.headerView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize ].height+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self initCellContent:self.cellPrototype cellForRowAtIndexPath:indexPath];
    return [self.cellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height+1;
    
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumTableViewCell * cell = (AlbumTableViewCell *)[self tableView:self.tableViewLibrary cellForRowAtIndexPath:indexPath];
    AlbumDetailViewController * albumDetail= [[AlbumDetailViewController alloc] initWithNibName:nil bundle:nil withImage:cell.imageViewAlbum.image withName:cell.labelName.text withGroup:cell.labelGroup.text withYear:cell.labelYear.text];
    [self.navigationController pushViewController:albumDetail animated:YES];
    [self.tableViewLibrary deselectRowAtIndexPath:indexPath animated:YES];
}

@end
