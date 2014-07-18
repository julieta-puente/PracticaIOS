//
//  Song.m
//  Musica
//
//  Created by Julieta Puente on 15/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Song.h"

@implementation Song

-(id) initWithDur:(NSString *) dur withAlbum: (NSString*) album{
    if([super init]){
        self.duration = [dur copy];
        self.album=[album copy];
    }
    return self;
}

-(void) dealloc{
    [super dealloc];
}
@end
