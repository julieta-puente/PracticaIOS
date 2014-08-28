//
//  FetchImageService.m
//  Musica
//
//  Created by Julieta Puente on 13/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ImageService.h"
#import "StorageManager.h"
@interface ImageService ()

@property (strong, nonatomic) NSURLSession *delegateFreeSession;
@property (strong, nonatomic) NSURLSessionTask * task;
@property (strong,nonatomic)  StorageManager * sManager;
@end
@implementation ImageService

-(id) init{
    if ([super init]){
         self.delegateFreeSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        self.sManager = [[StorageManager alloc]init];
    }
    return self;
}

-(void) fetchImageWithURL: (NSURL *) url forItem:(NSString *)item{
    dispatch_queue_t my_queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(my_queue,^{
       NSData * imgData = [self.sManager getData:item];
    if(imgData!=nil){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate serviceFinishedWithImageData:imgData forService:self];
        });
    } else{
        self.task=[self.delegateFreeSession dataTaskWithURL: url
                                          completionHandler:^(NSData *data, NSURLResponse *response,
                                                              NSError *error) {
                                              if(error!=nil){
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.delegate serviceFinishedWithNoImageData:self];
                                                  });
                                              }else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.delegate serviceFinishedWithImageData:data forService:self];
                                                      [self.sManager saveData:data forItem:item];
                                                  });
                                              }
                   
                                          }];
        [self.task resume];
    }
    });
   
}

-(void) cancel{
    [self.task cancel];
}
@end
