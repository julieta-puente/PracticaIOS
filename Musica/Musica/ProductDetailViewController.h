//
//  ProductDetailViewController.h
//  Musica
//
//  Created by Julieta Puente on 20/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductImageGallery.h"

@interface ProductDetailViewController : UIViewController


@property (strong, nonatomic) IBOutlet ProductImageGallery *collectionViewDetail;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UIButton *buttonBuy;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withId:(NSString *) itemId;
@end
