//
//  Album.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

-(id) initWithName: (NSString *) name withYear:(NSString *) year withImageName: (NSString *) imageName;
-(NSString *) getYear;
-(NSString *) getImageName;
-(NSString *) getName;

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * year;
@property (nonatomic, strong) NSString * imageName;
@end
