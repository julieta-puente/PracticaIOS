//
//  SearchService.m
//  Musica
//
//  Created by Julieta Puente on 12/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchService.h"

@interface SearchService()
@property (copy,nonatomic) NSString * searchString;
@end

@implementation SearchService
-(void) searchApiWithString: (NSString *) search{
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLA/search?q=%@",search ]];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self.delegate fetchFailed:error];
        } else {
            [self.delegate receivedJSON:data];
        }
    }];

}

@end