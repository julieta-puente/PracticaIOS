//
//  SearchedObject.h
//  Musica
//
//  Created by Julieta Puente on 11/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property(copy, nonatomic) NSString * title;
@property(strong, nonatomic) NSNumber * price;
@property(copy, nonatomic) NSString * thumbnail;
@property(copy,nonatomic) NSString * itemId;
@property (strong,nonatomic) NSArray * pictures;

@end
