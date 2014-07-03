//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Julieta Puente on 7/2/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculator.h"
@interface CalculatorTests : XCTestCase

@end

@implementation CalculatorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testAdd{
    Calculator * calc = [[Calculator alloc ]init];
    [calc add:5.0];
    XCTAssertEqual([calc.value floatValue], 5, "La suma entre 0 y 5.0 deberia ser 5");
    [calc release];
    
}

-(void) testSubstract{
    Calculator * calc = [[Calculator alloc ]init];
    [calc substract:2.0];
    XCTAssertEqual([calc.value floatValue], -2, "La suma entre 0.0 y 2.0 deberia ser -2");
    [calc release];
    
}

-(void) testDivide{
    Calculator * calc = [[Calculator alloc ]init];
     [calc add:6.0];
    [calc divide:2.0];
    XCTAssertEqual([calc.value floatValue], 3, "La division entre 6.0 y 2.0 deberia ser 3");
    [calc release];
    
}

-(void) testMultiply{
    Calculator * calc = [[Calculator alloc ]init];
    [calc add:2.0];
    [calc multiply:10.0];
    XCTAssertEqual([calc.value floatValue], 20, "La mulitplicacion entre 2.0 y 10.0 deberia ser 20");
    [calc release];

}

-(void) testReset{
    Calculator * calc = [[Calculator alloc ]init];
    [calc add:2.0];
    [calc reset];
    XCTAssertEqual([calc.value floatValue], 0, "Al resetear la calculadora, el valor deberia ser 0");
    [calc release];

}

@end
