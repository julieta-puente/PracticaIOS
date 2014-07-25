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


@interface LibraryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableViewLibrary;
@property (retain, nonatomic) NSArray * tableData;
@property (retain,nonatomic) MusicLibrary * music;
@property (retain, nonatomic) AlbumTableViewCell * cellPrototype;
@property (retain, nonatomic) NSMutableDictionary * groupSection;

@end

@implementation LibraryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withMusic: (MusicLibrary *) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music=music;
        self.groupSection = [NSMutableDictionary dictionary];
    
    }
    return self;
}

- (void)viewDidLoad
{
    self.tableViewLibrary.delegate = self;
    self.tableViewLibrary.dataSource = self;
    
    NSString * cellIdentifier =@"CellIdentifier";
    [self.tableViewLibrary registerNib:[UINib nibWithNibName:@"AlbumTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.cellPrototype = [self.tableViewLibrary dequeueReusableCellWithIdentifier:cellIdentifier];
    [super viewDidLoad];
// Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated{
    for (NSString *  group in [self.music getGroups]) {
        [self.groupSection setObject: [NSMutableArray array] forKey: group];
    }
    for (NSString * album in [self.music getAlbums]) {
        NSString * group= [self.music groupForAlbum:album];
        NSMutableArray * albumArray= [self.groupSection objectForKey:group];
        [albumArray addObject:album];
        [self.groupSection setObject:albumArray forKey:group];
    }
    [self.tableViewLibrary reloadData];
    [super viewDidAppear:animated];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [[self.music getAlbums]count];
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
    cell.labelName.text= [self.groupSection objectForKey:name][indexPath.row];
    cell.labelYear.text= [self.music yearForAlbum:cell.labelName.text];
    cell.labelGroup.text=[self.music groupForAlbum:cell.labelName.text];
    cell.imageViewAlbum.image = [UIImage imageNamed:[self.music imageForAlbum:cell.labelName.text]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Albumes";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)]autorelease];
    view.backgroundColor = [UIColor lightGrayColor];
    UILabel * labelName= [[[UILabel alloc]initWithFrame:CGRectMake(10, 3, 100, 20)]autorelease];
    labelName.numberOfLines=0;
    [labelName setText: [self.groupSection allKeys][section]];
    [view addSubview:labelName];
    UILabel * labelStyle= [[[UILabel alloc]initWithFrame:CGRectMake(160, 3, 100, 20)]autorelease];
    labelStyle.numberOfLines=0;
    [labelStyle setText: [self.music styleForGroup: labelName.text] ];
    [view addSubview:labelStyle];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
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
}
- (void)dealloc {
    [_tableViewLibrary release];
    [_tableData release];
    [_music release];
    [super dealloc];
}
@end
