//
//  ProductImageGallery.h
//  Musica
//
//  Created by Julieta Puente on 26/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductImageGallery : UICollectionView

-(void)setupCollectionViewWithImages: (NSArray *) images;
-(CGSize)sizeForItem;
-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(void) reloadDataWithImages:(NSArray *) images;
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end
