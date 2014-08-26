//
//  ProductDetailViewController.m
//  Musica
//
//  Created by Julieta Puente on 20/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailCell.h"
#import "ItemService.h"
#import "FetchImageService.h"
#import "SpinnerImageView.h"
#import "MBProgressHUD.h"

@interface ProductDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, ItemResponse,FetchImageResponse>
@property (strong, nonatomic) NSMutableArray * arrayImage;
@property (strong,nonatomic) NSString * itemId;
@property (strong,nonatomic) ItemService * itemService;
@property (strong,nonatomic) FetchImageService * imageService;
@property (strong,nonatomic) Item * response;
@property (strong,nonatomic) MBProgressHUD * HUD;
@property (strong,nonatomic)UIActivityIndicatorView * spinner;
@end

@implementation ProductDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withId:(NSString *) itemId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.itemId=itemId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayImage = [NSMutableArray array];
    self.collectionViewDetail.delegate=self;
    self.collectionViewDetail.dataSource=self;
    [self.collectionViewDetail setupCollectionViewWithImages:self.arrayImage];
    self.itemService = [[ItemService alloc]initWithItemId:self.itemId];
    self.itemService.delegate=self;
    [self.itemService fetchItem];
    self.imageService= [[FetchImageService alloc]init];
    self.imageService.delegate=self;
     self.pageControl.hidden = YES;
    if(self.HUD == nil){
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    self.HUD.labelText = @"Buscando";
    self.HUD.detailsLabelText = @"Por favor espere";
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    [self.HUD show:YES];
    [self.view addSubview:self.HUD];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.collectionViewDetail sizeForItem];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.collectionViewDetail numberOfSections];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionViewDetail numberOfItemsInSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.pageControl.currentPage = indexPath.row;
    self.pageControl.hidden = NO;
    return [self.collectionViewDetail collectionView:collectionView cellForItemAtIndexPath:indexPath];
}


-(void) fetchFailed:(NSError *)error{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Se produjo un error en la conexión" message:@"Por favor inténtelo nuevamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.HUD hide:YES];
}

-(void) resultsReceived:(Item *)data{
    self.labelTitle. text = data.title;
    self.labelPrice.text = [NSString stringWithFormat:@"$ %@", data.price ];
    [self fetchImages:data];
    [self.HUD hide:YES];
    self.buttonBuy.hidden = NO;
    self.labelPrice.hidden = NO;
    self.labelTitle.hidden = NO;
    
}

-(void) fetchImages:(Item *)data{
    self.spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2);
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    NSArray * images = data.pictures;
    self.pageControl.numberOfPages = [images count];
    for (NSDictionary * imgDic in images) {
        NSURL * url = [NSURL URLWithString:[imgDic objectForKey:@"url"]];
        NSString * imageId = [imgDic objectForKey:@"id"];
        [self.imageService fetchImageWithURL:url forItem:imageId];        
    }
}

-(void) loadImage:(NSData *) data{
    SpinnerImageView * imageView = [[SpinnerImageView alloc]init];
    [imageView loadImage:data];
    [self.arrayImage addObject:[imageView getImage]];
    self.pageControl.currentPage = 0;
    [self.collectionViewDetail reloadDataWithImages:self.arrayImage];
    [self.spinner stopAnimating];
    
}
-(void) noImageFound{
    SpinnerImageView * imageView = [[SpinnerImageView alloc]init];
    [imageView noImageFound];
    [self.arrayImage addObject:[imageView getImage]];
    [self.collectionViewDetail reloadDataWithImages:self.arrayImage];
    [self.spinner stopAnimating];
}

@end
