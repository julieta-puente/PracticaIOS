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
@property (strong,nonatomic) SearchedObject * response;
@property (strong,nonatomic) MBProgressHUD * HUD;
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
//    self.collectionViewDetail.backgroundColor = [UIColor whiteColor];
    self.collectionViewDetail.delegate=self;
    self.collectionViewDetail.dataSource=self;
    [self setupCollectionView];
    self.itemService = [[ItemService alloc]initWithItemId:self.itemId];
    self.itemService.delegate=self;
    [self.itemService fetchItem];
    self.imageService= [[FetchImageService alloc]init];
    self.imageService.delegate=self;
    if(self.HUD == nil){
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    self.HUD.labelText = @"Buscando";
    self.HUD.detailsLabelText = @"Por favor espere";
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    [self.HUD show:YES];
    [self.view addSubview:self.HUD];
}

-(void)setupCollectionView {
    [self.collectionViewDetail registerNib:[UINib nibWithNibName:@"ProductDetailCell" bundle:nil] forCellWithReuseIdentifier:@"CellIdentifier"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionViewDetail setPagingEnabled:YES];
    [self.collectionViewDetail setCollectionViewLayout:flowLayout];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionViewDetail.frame.size;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arrayImage count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"CellIdentifier";
    
    ProductDetailCell * cell=(ProductDetailCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageViewProduct.image= self.arrayImage[indexPath.row];
    return cell;
}


-(void) fetchFailed:(NSError *)error{
    
}

-(void) resultsReceived:(SearchedObject *)data{
    self.labelTitle. text = data.title;
    self.labelPrice.text = [NSString stringWithFormat:@"$ %@", data.price ];
    [self fetchImages:data];
    [self.HUD hide:YES];
    self.buttonBuy.hidden = NO;
    self.labelPrice.hidden = NO;
    self.labelTitle.hidden = NO;
}

-(void) fetchImages:(SearchedObject *)data{
    NSArray * images = data.pictures;
    for (NSDictionary * imgDic in images) {
        NSURL * url = [NSURL URLWithString:[imgDic objectForKey:@"url"]];
        NSString * imageId = [imgDic objectForKey:@"id"];
        [self.imageService fetchImageWithURL:url forItem:imageId];        
    }
}

-(void) loadImage:(NSData *) data{
    SpinnerImageView * imageView = [[SpinnerImageView alloc]init];
    [imageView loadSpinner];
    [imageView loadImage:data];
    [self.arrayImage addObject:[imageView getImage]];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [self.arrayImage count];
//    [self.collectionViewDetail reloadData];
}
-(void) noImageFound{
    SpinnerImageView * imageView = [[SpinnerImageView alloc]init];
    [imageView loadSpinner];
    [imageView noImageFound];
    [self.arrayImage addObject:[imageView getImage]];
    [self.collectionViewDetail reloadData];
}

@end
