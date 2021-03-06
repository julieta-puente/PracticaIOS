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
#import "ImageService.h"
#import "SpinnerImageView.h"
#import "MBProgressHUD.h"

@interface ProductDetailViewController ()<ItemResponse,ImageResponse,UIScrollViewDelegate>
@property (strong, nonatomic) NSMutableArray * arrayImage;
@property (strong,nonatomic) NSString * itemId;
@property (strong,nonatomic) ItemService * itemService;
@property (strong,nonatomic) ImageService * imageService;
@property (strong,nonatomic) Item * response;
@property (strong,nonatomic) MBProgressHUD * HUD;
@property (strong,nonatomic) NSMutableArray * imageViewArray;
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
    self.imageViewArray = [NSMutableArray array];
    self.scrollViewImages.delegate= self;
    self.itemService = [[ItemService alloc]initWithItemId:self.itemId];
    self.itemService.delegate=self;
    [self.itemService fetchItem];
    self.imageService= [[ImageService alloc]init];
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


-(void) serviceFailedWithError:(NSError *) error forService:(ItemService *) service{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Se produjo un error en la conexión" message:@"Por favor inténtelo nuevamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.HUD hide:YES];
}

-(void) serviceFinishedWithData:(Item *) data forService: (ItemService *) service{
    self.labelTitle. text = data.title;
    self.labelPrice.text = [NSString stringWithFormat:@"$ %@", data.price ];
    [self fetchImages:data];
    [self.HUD hide:YES];
    self.buttonBuy.hidden = NO;
    self.labelPrice.hidden = NO;
    self.labelTitle.hidden = NO;
    
}

-(void) fetchImages:(Item *)data{
    NSArray * images = data.pictures;
    CGSize pagesScrollViewSize = self.scrollViewImages.frame.size;
    self.scrollViewImages.contentSize = CGSizeMake(pagesScrollViewSize.width * [images count], pagesScrollViewSize.height);
    if ([data.pictures count]==0){
        [self serviceFinishedWithNoImageData:self.imageService];
    }
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [images count];
    int page=0;
    for (NSDictionary * imgDic in images) {
        [self loadImageToScrollViewForPage:page];
        page++;
        NSURL * url = [NSURL URLWithString:[imgDic objectForKey:@"url"]];
        NSString * imageId = [imgDic objectForKey:@"id"];
        [self.imageService fetchImageWithURL:url forItem:imageId];
    }
}

-(void) loadImageToScrollViewForPage:(NSInteger)page{
    CGRect frame = self.scrollViewImages.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    SpinnerImageView * imageView = [[SpinnerImageView alloc]initWithFrame:frame];
    [imageView loadSpinner];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollViewImages addSubview:imageView];
    [self.imageViewArray addObject:imageView];
}
-(void) serviceFinishedWithImageData:(NSData *)data forService:(ImageService *)service{
    SpinnerImageView * imageView = self.imageViewArray[[self.arrayImage count]];
    [imageView serviceFinishedWithImageData:data forService:service];
    [self.arrayImage addObject:[imageView getImage]];
    
}
-(void) serviceFinishedWithNoImageData: (ImageService *) service{
    [self loadImageToScrollViewForPage:0];
    SpinnerImageView * imageView = self.imageViewArray[[self.arrayImage count]];
    [imageView serviceFinishedWithNoImageData:service];
    [self.arrayImage addObject:[imageView getImage]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollViewImages.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewImages.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    self.pageControl.currentPage=page;
}

@end
