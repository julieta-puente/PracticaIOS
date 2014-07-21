//
//  Album.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Album.h"
@interface Album(){
    NSString * _year;
    NSString * _group;
}
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * group;
@end

@implementation Album

@synthesize year=_year;
@synthesize group=_group;

-(id) initWithYear:(NSString *) year withGroup: (NSString*) group{
    if([super init]){
        self.year = year;
        self.group = group;
    }
    return self;
}

-(void) dealloc{
    [_year release];
    [_group release];
    [super dealloc];
}
@end
