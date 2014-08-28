//
//  ItemService.h
//  Musica
//
//  Created by Julieta Puente on 22/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
@class ItemService;

@protocol ItemResponse
-(void) serviceFailedWithError:(NSError *) error forService:(ItemService *) service;
-(void) serviceFinishedWithData:(Item *) data forService: (ItemService *) service;
@end

@interface ItemService : NSObject

-(id) initWithItemId: (NSString *) itemId;
-(void) fetchItem;

@property (weak,nonatomic) id<ItemResponse> delegate;
@end
