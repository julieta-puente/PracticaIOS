//
//  Song.m
//  Musica
//
//  Created by Julieta Puente on 15/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Song.h"
@interface Song(){
    NSString * _duration;
    NSString * _album;
}

@property (nonatomic,copy) NSString * duration;
@property (nonatomic,copy) NSString * album;

@end

@implementation Song

@synthesize duration=_duration;
@synthesize album=_album;

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
