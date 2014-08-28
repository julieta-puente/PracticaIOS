//
//  ConnectionManager.m
//  Musica
//
//  Created by Julieta Puente on 27/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager

-(void) establishConnectionWithURL:(NSURL *) url{
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate connectionFailedWithError:error forConnection:self];
            });
        } else {
            [self.delegate connectionFinishedWithData:data forConnection: self];
        }
    }];
}
@end
