//
//  Calculator.m
//  Calculator
//
//  Created by Julieta Puente on 7/2/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import "Calculator.h"

@interface Calculator(){
    id <CalculatorFinishOperation> _operationDelegate;
}
@end

@implementation Calculator

@synthesize operationDelegate=_operationDelegate;

-(id) init{
    if([super init]){
        
        self.value = [NSNumber numberWithFloat:0.0];
        
    }
    return self;
}

-(void) add: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] + n)]autorelease];
    [self.operationDelegate updateLabelWithString:[NSString stringWithFormat:@"%@",self.value]];
}

-(void) substract: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] - n)]autorelease];
    [self.operationDelegate updateLabelWithString:[NSString stringWithFormat:@"%@",self.value]];
}

-(void) multiply: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] * n)]autorelease];
   [self.operationDelegate updateLabelWithString:[NSString stringWithFormat:@"%@",self.value]];
}

-(void) divide: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] / n)]autorelease];
    [self.operationDelegate updateLabelWithString:[NSString stringWithFormat:@"%@",self.value]];
}

-(void) reset{
    self.value = [[[NSNumber alloc]initWithFloat:0]autorelease];
    
    
   [self.operationDelegate updateLabelWithString:[NSString stringWithFormat:@"%@",self.value]];
}


-(void) startCalcultingMultiple2{
    
    NSMutableArray * multiplesArray = [NSMutableArray array];
    for(int i=0; i<1000; i++){
        [multiplesArray addObject:[[NSNumber alloc]initWithInt:(i*2) ]];
    }

}


-(void) dealloc{
    [super dealloc];
    [_value release];
    [_operationDelegate release];
}


@end
