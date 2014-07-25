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
        [self addAlbums];
        [self addGroups];
    }
    return self;
}

-(void) addAlbums{
    [self addAlbum: @"Great Hits" withYear: @"1920" withGroup:@"Queen" withImageName:@"queen.jpg"];
    [self addAlbum: @"Twist and Shout" withYear: @"1921" withGroup:@"The Beatles" withImageName: @"thebeatles.jpg"];
    [self addAlbum: @"Definitly Maybe" withYear: @"1922" withGroup:@"Oasis" withImageName:@"oasis.jpg"];
    [self addAlbum: @"The Doors" withYear: @"1923" withGroup:@"The Doors" withImageName: @"thedoors.jpg"];
    [self addAlbum: @"Great Hits 2" withYear: @"1924" withGroup:@"Queen" withImageName: @"queen.jpg"];
    [self addAlbum: @"Yellow Submarine" withYear: @"1925" withGroup:@"The Beatles" withImageName: @"thebeatles.jpg"];
    [self addAlbum: @"Wonderwall" withYear: @"1926" withGroup:@"Oasis" withImageName: @"oasis.jpg"];
    [self addAlbum: @"Clasics" withYear: @"1927" withGroup:@"The Doors" withImageName: @"thedoors.jpg"];
    [self addAlbum: @"Break Free" withYear: @"1928" withGroup:@"Queen" withImageName: @"queen.jpg"];
    [self addAlbum: @"Love me do" withYear: @"1929" withGroup:@"The Beatles" withImageName: @"thebeatles.jpg"];
    [self addAlbum: @"Champagne Supernova" withYear: @"1930" withGroup:@"Oasis" withImageName: @"oasis.jpg"];
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

-(void) addAlbum:(NSString *)album withYear:(NSString *)year withGroup:(NSString *)group withImageName: (NSString *) imageName{
    Album * a= [[[Album alloc] initWithYear:year withGroup:group withImage:imageName]autorelease];
    [self.albums setObject:a forKey:album];
}

-(NSArray *) getAlbums{
    return [self.albums allKeys];
}

-(void) addSong:(NSString *)song withDur:(NSString *)dur withAlbum:(NSString *)album{
    Song * s= [[[Song alloc]initWithDur:dur withAlbum:album]autorelease];
    [self.songs setObject: s forKey:song];
}


-(NSString *) groupForAlbum: (NSString *) album{
    return [[self.albums objectForKey:album] getGroup];
}

-(NSString *) yearForAlbum: (NSString *) album{
    return [[self.albums objectForKey:album] getYear];
}

-(NSString *) imageForAlbum: (NSString *) album{
    return [[self.albums objectForKey:album]getImageName];
}
-(NSString *) styleForGroup: (NSString *) group{
    return [[self.groups objectForKey:group] getStyle];
}

-(void) dealloc{
    [super dealloc];
}
@end
