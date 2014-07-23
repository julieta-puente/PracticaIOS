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
    UIImage * _image;
}
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * group;
@property (nonatomic, retain) UIImage * image;
@end

@implementation Album

@synthesize year=_year;
@synthesize group=_group;
@synthesize image=_image;

-(id) initWithYear:(NSString *) year withGroup: (NSString*) group withImage: (UIImage *) image{
    if([super init]){
        self.year = year;
        self.group = group;
        self.image = image;
    }
    return self;
}

-(NSString *) getGroup{
    return self.group;
}

-(NSString *) getYear{
    return self.year;
}

-(UIImage *) getImage{
    return self.image;
}
-(void) dealloc{
    [_year release];
    [_group release];
    [_image release];
    [super dealloc];
}
@end
