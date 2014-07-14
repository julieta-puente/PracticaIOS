//
//  Album.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * group;

-(id) initWithYear:(NSString *) year withGroup: (NSString*) group;
@end
