//
//  SearchService.m
//  Musica
//
//  Created by Julieta Puente on 12/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchService.h"
#import "SearchedObject.h"

@interface SearchService(){
    NSInteger off;
}
@property (copy,nonatomic) NSString * searchString;

@end

@implementation SearchService
-(void) searchApiWithString: (NSString *) search{
    self.searchString=search;
    [self fetchDataWithString:search withOffset:0];
}

-(void) fetchNextPage{
    off+=15;
    [self fetchDataWithString:self.searchString withOffset:(off)];
    
}
-(void) fetchDataWithString: (NSString *) search withOffset: (NSInteger) offset{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLA/search?q=%@&limit=15&offset=%d",search,offset ]];
    NSLog(@"%@",url);
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self.delegate fetchFailed:error];
        } else {
            [self receivedJSON:data];
        }
    }];
    
}

-(void) receivedJSON:(NSData *) data{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", localError);
        return;
    }
    
    NSMutableArray * objects = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    NSDictionary * paging= [parsedObject valueForKey:@"paging"];
    NSNumber * total= [paging objectForKey:@"total"];
    if(total.intValue >off){
        [self.delegate allResultsLoaded];
    }
    if( [results count] == 0){
        [self.delegate noResultsFound];
    }else{
        
        for (NSDictionary * objDic in results) {
            SearchedObject * obj = [[SearchedObject alloc] init];
            
            for (NSString *key in objDic) {
                if ([obj respondsToSelector:NSSelectorFromString(key)]) {
                    [obj setValue:[objDic valueForKey:key] forKey:key];
                }
            }
            
            [objects addObject:obj];
        }
        [self.delegate resultsReceived:objects];
    }
    
    
}
@end