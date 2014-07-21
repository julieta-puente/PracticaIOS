//
//  Group.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Group.h"
@interface Group(){
    NSString * _style;
    NSString * _description;
}
@property (nonatomic,copy) NSString * style;
@property (nonatomic,copy) NSString * description;
@end

@implementation Group

@synthesize style=_style;
@synthesize description=_description;

-(id) initWithStyle:(NSString *) style withDescription: (NSString*) desc{
    if([super init]){
        self.description = desc;
        self.style=style;
    }
    return self;
}

-(void) dealloc{
    [_style release];
    [_description release];
    [super dealloc];
}
@end
