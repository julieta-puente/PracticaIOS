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

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray * objects;
@property (strong, nonatomic) SearchTableViewCell * cellPrototype;
@end
@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withData:(NSArray *) data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.objects=data;
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
   
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"CellIdentifier";
    
    SearchTableViewCell * cell=(SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self completeCellContent:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

-(void) completeCellContent: (SearchTableViewCell *) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchedObject * obj = self.objects[indexPath.row];
    [cell.labelTitle setText:obj.title];
    [cell.labelPrice setText:[NSString stringWithFormat:@"$ %@", obj.price ]];
    NSURL *url = [NSURL URLWithString:obj.thumbnail];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.imageViewSearch.image= [UIImage imageWithData:data];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self completeCellContent:self.cellPrototype cellForRowAtIndexPath:indexPath];
    return [self.cellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
}


-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.objects count];
}

@end
