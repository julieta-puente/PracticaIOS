//
//  AdditionCalculation.m
//  Calculator
//
//  Created by Julieta Puente on 7/8/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import "AdditionCalculation.h"

@interface AdditionCalculation(){
    Calculator * _calc;
}
@property (nonatomic, retain) Calculator * calc;
@end

@implementation AdditionCalculation
@synthesize calc=_calc;

-(id) initWithCalc: (Calculator *) c{
    if([super init]){
        
        self.calc=c;
    }
    return self;
}

-(void) doCalculation:(float)f{
    [self.calc add:f];
    
}

- (void)dealloc {
    [_calc release];
    [super dealloc];
}

@end

