//
//  SearchService.h
//  Musica
//
//  Created by Julieta Puente on 12/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComunicatorResponse
-(void) fetchFailed:(NSError *) error;
-(void) receivedJSON:(NSData *) data;
@end

@interface SearchService : NSObject
-(void) searchApiWithString: (NSString *) search;
@property (weak, nonatomic) id<ComunicatorResponse> delegate;
@end