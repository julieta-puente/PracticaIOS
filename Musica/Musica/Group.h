//
//  Group.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic,copy) NSString * style;
@property (nonatomic,copy) NSString * description;

-(id) initWithStyle:(NSString *) style withDesc: (NSString*) desc;
@end
