//
//  DivisionCalculation.h
//  Calculator
//
//  Created by Julieta Puente on 7/8/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"
#import "Calculation.h"

@interface DivisionCalculation : NSObject <Calculation>

-(id) initWithCalc: (Calculator *) c;
-(void) doCalculation:(float)f;
@end
