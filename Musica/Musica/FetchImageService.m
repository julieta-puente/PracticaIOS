//
//  FetchImageService.m
//  Musica
//
//  Created by Julieta Puente on 13/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "FetchImageService.h"
@interface FetchImageService ()

@end
@implementation FetchImageService

-(id) init{
    if ([super init]){
        
    }
    return self;
}

-(void) fetchImageWithURL: (NSURL *) url{
    
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    [[delegateFreeSession dataTaskWithURL: url
                        completionHandler:^(NSData *data, NSURLResponse *response,
                                            NSError *error) {
                            if(error!=nil){
                                [self.delegate noImageFound];
                            }else{
                                [self.delegate loadImage:data];
                            }
                            
                        }] resume];
}
@end
