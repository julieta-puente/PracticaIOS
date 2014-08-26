//
//  ProductImageGallery.m
//  Musica
//
//  Created by Julieta Puente on 26/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ProductImageGallery.h"
#import "ProductDetailCell.h"
@interface ProductImageGallery ()
@property (strong,nonatomic) NSMutableArray * images;
@end
@implementation ProductImageGallery

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setupCollectionViewWithImages: (NSArray *) images {
    self.backgroundColor = [UIColor whiteColor];
    [self registerNib:[UINib nibWithNibName:@"ProductDetailCell" bundle:nil] forCellWithReuseIdentifier:@"CellIdentifier"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self setPagingEnabled:YES];
    [self setCollectionViewLayout:flowLayout];
    self.images=[NSMutableArray arrayWithArray:images];
}

-(CGSize)sizeForItem{
    return self.frame.size;
}

-(NSInteger)numberOfSections{
    return 1;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"CellIdentifier";
    ProductDetailCell * cell=(ProductDetailCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageViewProduct.image= self.images[indexPath.row];
    return cell;
}

-(void) reloadDataWithImages:(NSArray *) images{
    [super reloadData];
    self.images= [NSMutableArray arrayWithArray:images];
}

@end
