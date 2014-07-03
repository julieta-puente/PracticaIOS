//
//  MultiplesOfTwo.h
//  Calculator
//
//  Created by Julieta Puente on 7/2/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MultiplesOfTwo <NSObject>

@required
-(NSArray *) multiplesOfTwo;

-(void) onMultipleOfTwoOperationFinished:(NSArray*) numbers;

@optional

@end
