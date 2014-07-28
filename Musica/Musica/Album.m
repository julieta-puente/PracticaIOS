//
//  Album.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Album.h"
@interface Album()

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * year;
@property (nonatomic, retain) NSString * imageName;
@end

@implementation Album

-(id) initWithName: (NSString *) name withYear:(NSString *) year withImageName: (NSString *) imageName{
    if([super init]){
        self.name=name;
        self.year = year;
        self.imageName = imageName;
    }
    return self;
}


-(NSString *) getYear{
    return self.year;
}

-(NSString *) getImageName{
    return self.imageName;
}

-(NSString *) getName{
    return self.name;
}
-(void) dealloc{
    [_name release];
    [_year release];
    [_imageName release];
    [super dealloc];
}
@end
