//
//  MainViewControlerViewController.m
//  Calculator
//
//  Created by Julieta Puente on 7/3/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import "MainViewControlerViewController.h"
#import "Calculator.h"
#import "Calculation.h"
#import "DivisionCalculation.h"
#import "MultiplicationCalculation.h"
#import "SubstractionCalculation.h"
#import "AdditionCalculation.h"

@interface MainViewControlerViewController (){
    NSString * _stringnumber;
    Calculator * _calc;
    BOOL _decimalPressed;
    id <Calculation>  _c;
}
@property (nonatomic,copy) NSString * stringnumber;
@property (nonatomic,retain) Calculator * calc;
@property (nonatomic,assign) BOOL decimalPressed;
@property (nonatomic,strong) id<Calculation> c;
@end

@implementation MainViewControlerViewController
@synthesize stringnumber = _stringnumber;
@synthesize calc=_calc;
@synthesize decimalPressed=_decimalPressed;
@synthesize c=_c;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.stringnumber = @"";
        self.calc = [[[Calculator alloc] init] autorelease];
        self.calc.operationDelegate = self;


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)onNumberPressed:(UIButton *)sender {
    self.stringnumber=[self.stringnumber stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    [self updateLabelWithString:self.stringnumber];
}

- (IBAction)onDecimalPressed:(UIButton *)sender {
    if(!self.decimalPressed){
        self.stringnumber=[self.stringnumber stringByAppendingString:@"."];
        [self updateLabelWithString:self.stringnumber];
        self.decimalPressed=YES;
    }
}

- (IBAction)onDivisionPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.c= [[[DivisionCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
    
}

- (IBAction)onMultiplicationPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.c= [[[MultiplicationCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
}

- (IBAction)onAddPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.c= [[[AdditionCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
}

- (IBAction)onSubstractPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.c= [[[SubstractionCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
}

- (IBAction)onResetPressed:(UIButton *)sender {
    [self.calc reset];
    self.stringnumber=@"";
}

- (IBAction)onAnsPressed:(UIButton *)sender {

    [self.c doCalculation:[self.stringnumber floatValue]];
    
}

-(void) updateLabelWithString:(NSString *) s{
    [self.result setText:s];
}
- (void)dealloc {
    [_calc release];
    [_result release];
    [super dealloc];
}
@end
