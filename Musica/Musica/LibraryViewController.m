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

@interface LibraryViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView * _tableViewLibrary;
    MusicLibrary * _music;
}
@property (retain, nonatomic) IBOutlet UITableView *tableViewLibrary;
@property (retain, nonatomic) NSArray * tableData;
@property (retain,nonatomic) MusicLibrary * music;

@end

@implementation LibraryViewController

@synthesize tableViewLibrary=_tableViewLibrary;
@synthesize tableData=_tableData;
@synthesize music=_music;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withMusic: (MusicLibrary *) music
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.music=music;
    }
    return self;
}

- (void)viewDidLoad
{
    self.tableViewLibrary.delegate = self;
    self.tableViewLibrary.dataSource = self;
    [super viewDidLoad];
// Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated{
    [self.tableViewLibrary reloadData];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.music getAlbums]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"CellIdentifier";
    
    AlbumTableViewCell * cell = (AlbumTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AlbumTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
   }
    cell.labelName.text= [self.music getAlbums][indexPath.row];
    cell.labelYear.text= [self.music yearForAlbum:cell.labelName.text];
    cell.labelGroup.text=[self.music groupForAlbum:cell.labelName.text];
    cell.imageViewAlbum.image = [self.music imageForAlbum:cell.labelName.text];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Albumes";
}

- (void)dealloc {
    [_tableViewLibrary release];
    [_tableData release];
    [super dealloc];
}
@end
