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
@property (nonatomic, copy) NSString * name;

@end

@implementation Song

-(id) initWithName: (NSString *) name withDuration:(NSString *) dur{
    if([super init]){
        self.duration = dur;
        self.name= name;
    }
    return self;
}

-(void) dealloc{
    [_duration release];
    [_name release];
    [super dealloc];
}
@end
