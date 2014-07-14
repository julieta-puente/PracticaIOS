//
//  Album.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Album.h"

@implementation Album

-(id) initWithYear:(NSString *) year withGroup: (NSString*) group{
    if([super init]){
        self.year = [year copy];
        self.group=[group copy];
    }
    return self;
}
@end
