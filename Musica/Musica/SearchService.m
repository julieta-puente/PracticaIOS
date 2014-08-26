//
//  SearchService.m
//  Musica
//
//  Created by Julieta Puente on 12/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "SearchService.h"
#import "Item.h"

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
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate fetchFailed:error];
            });
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
    
    NSMutableArray * itemArray = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    NSDictionary * paging= [parsedObject valueForKey:@"paging"];
    NSNumber * total= [paging objectForKey:@"total"];
    if(total.intValue >off){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate allResultsLoaded];
        });
    }
    if( [results count] == 0){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate noResultsFound];
        });
    }else{
        
        for (NSDictionary * objDic in results) {
            Item * item = [[Item alloc] init];
            item.title = [objDic valueForKey:@"title"];
            item.price = [objDic valueForKey:@"price"];
            item.itemId= [objDic valueForKey:@"id"];
            item.thumbnail = [objDic valueForKey:@"thumbnail"];
            [itemArray addObject:item];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate resultsReceived:itemArray];
        });
    }
    
    
}
@end