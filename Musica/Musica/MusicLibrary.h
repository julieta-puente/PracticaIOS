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
-(NSArray *) getAlbums;
-(void) addSong: (NSString *) song withDur: (NSString *) dur withAlbum: (NSString *) album;
-(NSString *) groupForAlbum: (NSString *) album;
-(NSString *) yearForAlbum: (NSString *) album;
-(void) addAlbum:(NSString *)album withYear:(NSString *)year withGroup:(NSString *)group withImageName: (NSString *) imageName;
-(NSString *) imageForAlbum: (NSString *) album;
-(NSString *) styleForGroup: (NSString *) group;
@end
