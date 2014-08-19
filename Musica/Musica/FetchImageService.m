//
//  FetchImageService.m
//  Musica
//
//  Created by Julieta Puente on 13/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "FetchImageService.h"
@interface FetchImageService ()

@property (strong, nonatomic) NSURLSession *delegateFreeSession;
@property (strong, nonatomic) NSURLSessionTask * task;
@end
@implementation FetchImageService

-(id) init{
    if ([super init]){
         self.delegateFreeSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    }
    return self;
}

-(void) fetchImageWithURL: (NSURL *) url{
    
   
    self.task=[self.delegateFreeSession dataTaskWithURL: url
                        completionHandler:^(NSData *data, NSURLResponse *response,
                                            NSError *error) {
                            if(error!=nil){
                                [self.delegate noImageFound];
                            }else{
                                [self.delegate loadImage:data];
                            }
                            
                        }];
    [self.task resume];
}

-(void) cancel{
    [self.task cancel];
}
@end
