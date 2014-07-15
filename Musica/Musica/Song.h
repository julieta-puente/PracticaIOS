//
//  Song.h
//  Musica
//
//  Created by Julieta Puente on 15/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic,copy) NSString * duration;
@property (nonatomic,copy) NSString * album;

-(id) initWithDur:(NSString *) dur withAlbum: (NSString*) album;
@end
