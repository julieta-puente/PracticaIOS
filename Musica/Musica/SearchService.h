//
//  SearchService.h
//  Musica
//
//  Created by Julieta Puente on 12/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchResponse
-(void) fetchFailed:(NSError *) error;
-(void) noResultsFound;
-(void) resultsReceived:(NSArray *) results;
-(void) allResultsLoaded;
@end

@interface SearchService : NSObject
-(void) searchApiWithString: (NSString *) search;
-(void) fetchNextPage;
@property (weak, nonatomic) id<SearchResponse> delegate;
@end