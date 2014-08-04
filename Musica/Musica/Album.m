//
//  Album.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Album.h"
@interface Album()<NSCoding>


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

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.year forKey:@"year"];
    [encoder encodeObject:self.imageName forKey:@"imageName"];
}
- (id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.year = [decoder decodeObjectForKey:@"year"];
        self.imageName = [decoder decodeObjectForKey:@"imageName"];
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

- (NSString *)description {
    return [NSString stringWithFormat: @"Album: Nombre=%@ Año=%@", self.name, self.year];
}
@end
