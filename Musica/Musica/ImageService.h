//
//  FetchImageService.h
//  Musica
//
//  Created by Julieta Puente on 13/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageService;
@protocol ImageResponse <NSObject>
-(void) serviceFinishedWithImageData:(NSData *) data forService:(ImageService *)service;
-(void) serviceFinishedWithNoImageData: (ImageService *) service;
@optional
-(void) sacameLaFoto;
@end
@interface ImageService : NSObject

-(void) fetchImageWithURL: (NSURL *) url forItem:(NSString *) item;
-(void) cancel;
@property (weak, nonatomic) id<ImageResponse> delegate;
@end
