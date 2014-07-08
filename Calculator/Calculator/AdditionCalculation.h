//
//  AdditionCalculation.h
//  Calculator
//
//  Created by Julieta Puente on 7/8/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculation.h"
#import "Calculator.h"

@interface AdditionCalculation : NSObject<Calculation>

-(id) initWithCalc: (Calculator *) c;
-(void) doCalculation:(float)f;

@end
