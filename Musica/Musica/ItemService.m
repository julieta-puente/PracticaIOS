//
//  ItemService.m
//  Musica
//
//  Created by Julieta Puente on 22/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "ItemService.h"
#import "ConnectionManager.h"

@interface ItemService() <ConnectionResponse>
@property (copy, nonatomic) NSString * itemId;
@property (strong,nonatomic) ConnectionManager * connection;
@end
@implementation ItemService

-(id) initWithItemId: (NSString *) itemId{
    if([super init]){
        self.itemId = itemId;
        self.connection = [[ConnectionManager alloc]init];
        self.connection.delegate= self;
    }
    return self;
}

-(void) fetchItem{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.mercadolibre.com/items/%@",self.itemId]];
//    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        if (error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.delegate fetchFailed:error];
//            });
//        } else {
//            [self receivedJSON:data];
//        }
//    }];
    [self.connection establishConnectionWithURL:url];
}

-(void)connectionFailedWithError:(NSError *)error forConnection:(ConnectionManager *)connection{
    [self.delegate serviceFailedWithError:error forService:self];
}

-(void)connectionFinishedWithData:(NSData *)data forConnection: (ConnectionManager *)connection{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", localError);
        return;
    }
    
    Item * item = [[Item alloc] init];
    item.title=[parsedObject valueForKey:@"title"];
    item.price=[parsedObject valueForKey:@"price"];
    item.pictures=[parsedObject valueForKey:@"pictures"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate serviceFinishedWithData:item forService:self];
    });
}


@end
