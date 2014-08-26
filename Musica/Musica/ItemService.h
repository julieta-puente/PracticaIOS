//
//  ItemService.h
//  Musica
//
//  Created by Julieta Puente on 22/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
@protocol ItemResponse
-(void) fetchFailed:(NSError *) error;
-(void) resultsReceived: (Item *) data;
@end

@interface ItemService : NSObject

-(id) initWithItemId: (NSString *) itemId;
-(void) fetchItem;

@property (weak,nonatomic) id<ItemResponse> delegate;
@end
