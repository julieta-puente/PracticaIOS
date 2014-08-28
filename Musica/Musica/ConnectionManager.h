//
//  ConnectionManager.h
//  Musica
//
//  Created by Julieta Puente on 27/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ConnectionManager;
@protocol ConnectionResponse
-(void)connectionFailedWithError:(NSError *)error forConnection:(ConnectionManager *)connection;
-(void)connectionFinishedWithData:(NSData *)data forConnection: (ConnectionManager *)connection;
@end

@interface ConnectionManager : NSObject
-(void) establishConnectionWithURL:(NSURL *) url;
@property (weak,nonatomic) id<ConnectionResponse> delegate;
@end
