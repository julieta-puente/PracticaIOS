//
//  Group.m
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "Group.h"

@implementation Group


-(id) initWithStyle:(NSString *) style withDesc: (NSString*) desc{
    if([super init]){
        self.description = [desc copy];
        self.style=[style copy];
    }
    return self;
}
@end
