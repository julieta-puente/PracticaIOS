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

@interface MusicLibrary(){
    NSMutableDictionary * _groups;
    NSMutableDictionary * _albums;
    NSMutableDictionary * _songs;
}
@property (retain, nonatomic) NSMutableDictionary * groups;
@property (retain, nonatomic) NSMutableDictionary * albums;
@property (retain, nonatomic) NSMutableDictionary * songs;
@end

@implementation MusicLibrary

@synthesize groups=_groups;
@synthesize albums=_albums;
@synthesize songs=_songs;

-(id)init{
    if([super init]){
        self.groups = [NSMutableDictionary dictionary];
        self.songs = [NSMutableDictionary dictionary];
        self.albums = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void) addGroup:(NSString *)group withStyle:(NSString *)style withDescription:(NSString *)desc{
    Group * g = [[[Group alloc]initWithStyle:style withDescription:desc]autorelease];
    [self.groups setObject:g forKey:group];
}

-(NSArray *) getGroups{
    return [self.groups allKeys];
}


-(void) addAlbum:(NSString *)album withYear:(NSString *)year withGroup:(NSString *)group{
    Album * a= [[[Album alloc]initWithYear:year withGroup:group]autorelease];
    [self.albums setObject:a forKey:album];
}

-(NSArray *) getAlbums{
    return [self.albums allKeys];
}

-(void) addSong:(NSString *)song withDur:(NSString *)dur withAlbum:(NSString *)album{
    Song * s= [[[Song alloc]initWithDur:dur withAlbum:album]autorelease];
    [self.songs setObject: s forKey:song];
}

-(void) dealloc{
    [super dealloc];
}
@end
