//
//  Calculator.m
//  Calculator
//
//  Created by Julieta Puente on 7/2/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import "Calculator.h"


@interface Calculator(){
    id<MultiplesOfTwo> _delegate;
}
@end

@implementation Calculator

-(id) init{
    if([super init]){
        
        _value = 0;
    }
    return self;
}

-(void) add: (float) n {
    _value=[[NSNumber alloc] initWithFloat: ([_value floatValue] + n)];
    NSLog(@"%f",[_value floatValue]);
}

-(void) substract: (float) n {
    _value=[[NSNumber alloc] initWithFloat: ([_value floatValue] - n)];
    NSLog(@"%f",[_value floatValue]);
}

-(void) multiply: (float) n {
    _value=[[NSNumber alloc] initWithFloat: ([_value floatValue] * n)];
    NSLog(@"%f",[_value floatValue]);
}

-(void) divide: (float) n {
    

    _value=[[NSNumber alloc] initWithFloat: ([_value floatValue] / n)];
    NSLog(@"%f",[_value floatValue]);
}

-(void) reset{
    _value = 0;
}

-(void) startCalcultingMultiple2{
    
    NSMutableArray * multiplesArray = [NSMutableArray array];
    for(int i=0; i<1000; i++){
        [multiplesArray addObject:[[NSNumber alloc]initWithInt:(i*2) ]];
    }
    
    [self.delegate onMultipleOfTwoOperationFinished:multiplesArray];

}





@end
