//
//  Album.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Album.h"
@interface Album()
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * group;
@property (nonatomic, retain) NSString * imageName;
@end

@implementation Album

-(id) initWithYear:(NSString *) year withGroup: (NSString*) group withImage: (NSString *) imageName{
    if([super init]){
        self.year = year;
        self.group = group;
        self.imageName = imageName;
    }
    return self;
}

-(NSString *) getGroup{
    return self.group;
}

-(NSString *) getYear{
    return self.year;
}

-(NSString *) getImageName{
    return self.imageName;
}
-(void) dealloc{
    [_year release];
    [_group release];
    [_imageName release];
    [super dealloc];
}
@end
