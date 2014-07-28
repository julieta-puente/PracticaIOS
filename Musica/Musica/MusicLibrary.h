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
-(void) addSong:(NSString *)song withDuration:(NSString *)dur forAlbum:(NSString *)album;
-(void) addAlbum:(NSString *)album withYear:(NSString *)year withImageName: (NSString *) imageName forGroup:(NSString *) group;
-(NSString *) styleForGroup: (NSString *) group;
-(NSMutableDictionary *) getAlbums;
-(NSArray *) getAlbumNames;
@end
