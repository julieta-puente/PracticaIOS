//
//  FetchImageService.h
//  Musica
//
//  Created by Julieta Puente on 13/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchImageResponse <NSObject>

-(void) loadImage:(NSData *) data;
-(void) noImageFound;
@end
@interface FetchImageService : NSObject

-(void) fetchImageWithURL: (NSURL *) url;
@property (weak, nonatomic) id<FetchImageResponse> delegate;
@end
