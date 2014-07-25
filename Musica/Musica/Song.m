//
//  Song.m
//  Musica
//
//  Created by Julieta Puente on 15/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Song.h"
@interface Song()
@property (nonatomic,copy) NSString * duration;
@property (nonatomic,copy) NSString * album;

@end

@implementation Song

-(id) initWithDur:(NSString *) dur withAlbum: (NSString*) album{
    if([super init]){
        self.duration = dur;
        self.album=album;
    }
    return self;
}

-(void) dealloc{
    [_album release];
    [_duration release];
    [super dealloc];
}
@end
