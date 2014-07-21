//
//  MusicLibrary.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicLibrary : NSObject



-(void) addGroup:(NSString *) group withStyle: (NSString *) style withDescription: (NSString*) desc;
-(NSArray *) getGroups;
-(void) addAlbum:(NSString *) album withYear: (NSString *) year withGroup: (NSString*) group;
-(NSArray *) getAlbums;
-(void) addSong: (NSString *) song withDur: (NSString *) dur withAlbum: (NSString *) album;

@end
