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

@interface MusicLibrary()
@property (retain, nonatomic) NSMutableDictionary * groups;
@property (retain, nonatomic) NSMutableDictionary * albums;
@property (retain, nonatomic) NSMutableDictionary * songs;
@end

@implementation MusicLibrary


-(id)init{
    if([super init]){
        self.groups = [NSMutableDictionary dictionary];
        self.songs = [NSMutableDictionary dictionary];
        self.albums = [NSMutableDictionary dictionary];
        [self addGroups];
        [self addAlbums];
        
    }
    return self;
}

-(void) addAlbums{
    [self addAlbum: @"Great Hits" withYear: @"1920"  withImageName:@"queen.jpg" forGroup:@"Queen"];
    [self addAlbum: @"Twist and Shout" withYear: @"1921" withImageName: @"thebeatles.jpg" forGroup:@"The Beatles"];
    [self addAlbum: @"Definitly Maybe" withYear: @"1922"  withImageName:@"oasis.jpg" forGroup:@"Oasis"];
    [self addAlbum: @"The Doors" withYear: @"1923" withImageName: @"thedoors.jpg" forGroup:@"The Doors"];
    [self addAlbum: @"Great Hits 2" withYear: @"1924" withImageName: @"queen.jpg" forGroup:@"Queen"];
    [self addAlbum: @"Yellow Submarine" withYear: @"1925" withImageName: @"thebeatles.jpg" forGroup:@"The Beatles" ];
    [self addAlbum: @"Wonderwall" withYear: @"1926" withImageName: @"oasis.jpg" forGroup:@"Oasis"];
    [self addAlbum: @"Clasics" withYear: @"1927" withImageName: @"thedoors.jpg" forGroup:@"The Doors"];
    [self addAlbum: @"Break Free" withYear: @"1928" withImageName: @"queen.jpg" forGroup:@"Queen" ];
    [self addAlbum: @"Love me do" withYear: @"1929" withImageName: @"thebeatles.jpg" forGroup:@"The Beatles"];
    [self addAlbum: @"Champagne Supernova" withYear: @"1930" withImageName: @"oasis.jpg" forGroup:@"Oasis"];
}

-(void) addGroups{
     [self addGroup:@"Queen" withStyle:@"Rock" withDescription:@"Gran grupo"];
     [self addGroup:@"The Beatles" withStyle:@"Rock" withDescription:@"Gran grupo"];
     [self addGroup:@"Oasis" withStyle:@"Rock" withDescription:@"Gran grupo"];
     [self addGroup:@"The Doors" withStyle:@"Rock" withDescription:@"Gran grupo"];
}

-(void) addGroup:(NSString *)group withStyle:(NSString *)style withDescription:(NSString *)desc{
    Group * g = [[[Group alloc]initWithStyle:style withDescription:desc]autorelease];
    [self.groups setObject:g forKey:group];
}

-(NSArray *) getGroups{
    return [self.groups allKeys];
}


-(NSDictionary *) getAlbums{
    return self.albums;
}

-(void) addAlbum:(NSString *)album withYear:(NSString *)year withImageName: (NSString *) imageName forGroup:(NSString *) group{
    Album * a= [[[Album alloc] initWithName: album withYear:year withImageName:imageName]autorelease];
    NSMutableArray * auxArray = [self.albums objectForKey:group];
    if (auxArray == nil){
        auxArray = [NSMutableArray array];
    }
    [auxArray addObject:a];
    [self.albums setObject:auxArray forKey:group];
}

-(NSArray *) getAlbumNames{
    NSMutableArray * myArray = [NSMutableArray array];
    for (NSString  * groups  in [self.albums allKeys]) {
        for (Album * album in [self.albums objectForKey:groups]) {
            [myArray addObject: [album getName]];
        }
    }
    return myArray;
}

-(void) addSong:(NSString *)song withDuration:(NSString *)dur forAlbum:(NSString *)album{
    Song * s= [[[Song alloc] initWithName:song withDuration:dur]autorelease];
    [self.songs setObject: s forKey:album];
}

-(NSString *) styleForGroup: (NSString *) group{
    return [[self.groups objectForKey:group] getStyle];
}

-(void) dealloc{
    [_groups release];
    [_songs release];
    [_albums release];
    [super dealloc];
}
@end
