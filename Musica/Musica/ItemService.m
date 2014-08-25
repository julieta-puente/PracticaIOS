//
//  ItemService.m
//  Musica
//
//  Created by Julieta Puente on 22/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ItemService.h"

@interface ItemService()
@property (copy, nonatomic) NSString * itemId;
@end
@implementation ItemService

-(id) initWithItemId: (NSString *) itemId{
    if([super init]){
        self.itemId = itemId;
    }
    return self;
}

-(void) fetchItem{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.mercadolibre.com/items/%@",self.itemId]];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate fetchFailed:error];
            });
        } else {
            [self receivedJSON:data];
        }
    }];
}

-(void) receivedJSON: (NSData *) data{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", localError);
        return;
    }
    
    SearchedObject * obj = [[SearchedObject alloc] init];
    
    for (NSString *key in parsedObject) {
        if ([obj respondsToSelector:NSSelectorFromString(key)]) {
            [obj setValue:[parsedObject valueForKey:key] forKey:key];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate resultsReceived:obj];
    });
}
@end
