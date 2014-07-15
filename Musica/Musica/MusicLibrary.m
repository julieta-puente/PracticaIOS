//
//  MusicLibrary.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "MusicLibrary.h"
#import "Group.h"
#import "Album.h"
#import "Song.h"

@implementation MusicLibrary


-(id)init{
    if([super init]){
        self.groups = [NSMutableDictionary dictionary];
        self.songs = [NSMutableDictionary dictionary];
        self.albums = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void) addGroup:(NSString *)group withStyle:(NSString *)style withDesc:(NSString *)desc{
    Group * g = [[Group alloc]initWithStyle:style withDesc:desc];
    [self.groups setObject:g forKey:group];
}

-(NSArray *) getGroups{
    return [self.groups allKeys];
}

-(void) addAlbum:(NSString *)album withYear:(NSString *)year withGroup:(NSString *)group{
    Album * a= [[Album alloc]initWithYear:year withGroup:group];
    [self.albums setObject:a forKey:album];
}

-(NSArray *) getAlbums{
    return [self.albums allKeys];
}

-(void) addSong:(NSString *)song withDur:(NSString *)dur withAlbum:(NSString *)album{
    Song * s= [[Song alloc]initWithDur:dur withAlbum:album];
    [self.songs setObject: s forKey:song];
}
@end
