//
//  SearchService.h
//  Musica
//
//  Created by Julieta Puente on 12/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchService;

@protocol SearchResponse
-(void) serviceFailedWithError:(NSError *) error forService:(SearchService *) service;
-(void) serviceFinishedWithNoData: (SearchService *) service;
-(void) serviceFinishedWithData:(NSArray *) results forService: (SearchService *) service;
-(void) serviceFinishedFetchingData: (SearchService *) service;
@end

@interface SearchService : NSObject
-(void) searchApiWithString: (NSString *) search;
-(void) fetchNextPage;
@property (weak, nonatomic) id<SearchResponse> delegate;
@end