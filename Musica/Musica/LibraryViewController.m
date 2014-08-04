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
@property (strong, nonatomic) HeaderView * headerPrototype;

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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    self.headerPrototype = [nib objectAtIndex:0];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]
                                             initWithTitle:@"Exportar" style: UIBarButtonItemStyleDone target:self action:@selector(export:)] ;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableViewLibrary reloadData];
}
#pragma mark - File System

-(void) export: (id) sender{
    NSFileManager * filemg;
    filemg = [NSFileManager defaultManager];
    NSMutableData * data=[[NSMutableData alloc] init];
    NSKeyedArchiver* archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    for (NSString * key in [self.groupSection allKeys]) {
        NSData * albumArray = [self.groupSection objectForKey:key];
        [archiver encodeObject:key forKey:[NSString stringWithFormat:@"Group:%@",key ]];
        [archiver encodeObject:albumArray forKey:[NSString stringWithFormat:@"AlbumFor:%@",key ]];
    }
    [archiver finishEncoding];
    [filemg createFileAtPath: @"/Users/jpuente/Documents/newfile.txt" contents: data attributes: nil];

}
//-(void) load{
//    NSDictionary * ret;
//    NSData* data=[NSData dataWithContentsOfFile:@"/Users/jpuente/Documents/newfile.txt"];
//    if (data)
//    {
//        NSKeyedUnarchiver* unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        if (unarchiver)
//        {
//                ret=(NSDictionary*)[unarchiver decodeObjectForKey:@"AlbumArray"];
//            [unarchiver finishDecoding];
//        }
//    }
//    NSLog(@"%@", [[ret objectForKey:@"The Beatles" ] objectAtIndex:0]);
//}

#pragma mark - table

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
    HeaderView * headerView;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    headerView = [nib objectAtIndex:0];
    [self initHeader:headerView inSection:section];
    return headerView;
}

-(void)initHeader:(HeaderView *) headerView inSection: (NSInteger)section{
    [headerView.labelGroup setText:[self.groupSection allKeys][section]];
    [headerView.labelStyle setText:[self.music styleForGroup: headerView.labelGroup.text]];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    [self initHeader:self.headerPrototype inSection:section];
    return [self.headerPrototype systemLayoutSizeFittingSize:UILayoutFittingExpandedSize ].height+1;
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 40.f;
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
    NSString * group = [self.groupSection allKeys][indexPath.section];
    Album * album = [self.groupSection objectForKey:group][indexPath.row];
    AlbumDetailViewController * albumDetail= [[AlbumDetailViewController alloc] initWithNibName:nil bundle:nil withAlbum:album withGroup: group];
    [self.navigationController pushViewController:albumDetail animated:YES];
    [self.tableViewLibrary deselectRowAtIndexPath:indexPath animated:YES];
}

@end
