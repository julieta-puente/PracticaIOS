//
//  Calculator.h
//  Calculator
//
//  Created by Julieta Puente on 7/2/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiplesOfTwo.h"
#import "CalculatorFinishOperation.h"

@interface Calculator : NSObject

@property (nonatomic,retain) NSNumber * value;
@property (nonatomic,assign) id<CalculatorFinishOperation> operationDelegate;

-(void) add: (float) n;
-(void) substract: (float) n;
-(void) divide: (float) n;
-(void) multiply: (float) n;
-(void) reset;
-(id) init;

-(void) startCalcultingMultiple2;
@end
