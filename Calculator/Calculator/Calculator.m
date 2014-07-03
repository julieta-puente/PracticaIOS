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

@synthesize delegate=_delegate;

-(id) init{
    if([super init]){
        
        self.value = nil;
    }
    return self;
}

-(void) add: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] + n)]autorelease];
}

-(void) substract: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] - n)]autorelease];

}

-(void) multiply: (float) n {
    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] * n)]autorelease];
}

-(void) divide: (float) n {
    

    self.value=[[[NSNumber alloc] initWithFloat: ([self.value floatValue] / n)]autorelease];
}

-(void) reset{
    self.value = [[[NSNumber alloc]initWithFloat:0]autorelease];
}

-(void) startCalcultingMultiple2{
    
    NSMutableArray * multiplesArray = [NSMutableArray array];
    for(int i=0; i<1000; i++){
        [multiplesArray addObject:[[NSNumber alloc]initWithInt:(i*2) ]];
    }
    
    [self.delegate onMultipleOfTwoOperationFinished:multiplesArray];

}


-(void) dealloc{
    [super dealloc];
    [_value release];
}


@end
