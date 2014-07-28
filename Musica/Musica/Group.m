//
//  Group.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Group.h"
@interface Group()
@property (nonatomic,copy) NSString * style;
@property (nonatomic,copy) NSString * description;
@end

@implementation Group


-(id) initWithStyle:(NSString *) style withDescription: (NSString*) desc{
    if([super init]){
        self.description = desc;
        self.style=style;
    }
    return self;
}

-(NSString *) getStyle{
    return self.style;
}

@end
