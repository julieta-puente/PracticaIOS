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
    BOOL _numberPressed;
    id <Calculation>  _c;
    UIButton * _lastButtonPressed;
}
@property (nonatomic,copy) NSString * stringnumber;
@property (nonatomic,retain) Calculator * calc;
@property (nonatomic,assign) BOOL decimalPressed;
@property (nonatomic,assign) BOOL numberPressed;
@property (nonatomic,retain) id<Calculation> c;
@property (nonatomic,retain) UIButton * lastButtonPressed;
@end

@implementation MainViewControlerViewController
@synthesize stringnumber = _stringnumber;
@synthesize calc=_calc;
@synthesize decimalPressed=_decimalPressed;
@synthesize numberPressed=_numberPressed;
@synthesize c=_c;
@synthesize lastButtonPressed=_lastButtonPressed;
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
    [self removeButtonBorder];
    self.stringnumber=[self.stringnumber stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    [self updateLabelWithString:self.stringnumber];
    self.numberPressed=YES;
}

- (IBAction)onDecimalPressed:(UIButton *)sender {
    if(!self.decimalPressed){
        self.stringnumber=[self.stringnumber stringByAppendingString:@"."];
        [self updateLabelWithString:self.stringnumber];
        self.decimalPressed=YES;
    }
    [self removeButtonBorder];
}

- (IBAction)onDivisionPressed:(UIButton *)sender {
    [self setButtonBorder:(UIButton *)sender ];
    if(self.numberPressed){
        self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    }
    self.c= [[[DivisionCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
    self.numberPressed=NO;
    
}

- (IBAction)onMultiplicationPressed:(UIButton *)sender {
    [self setButtonBorder:(UIButton *)sender ];
    if(self.numberPressed){
        self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    }
    self.c= [[[MultiplicationCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
    self.numberPressed=NO;
}

- (IBAction)onAddPressed:(UIButton *)sender {
    [self setButtonBorder:(UIButton *)sender ];
    if(self.numberPressed){
        self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    }
    self.c= [[[AdditionCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
    self.numberPressed=NO;
}

- (IBAction)onSubstractPressed:(UIButton *)sender {
    [self setButtonBorder:(UIButton *)sender ];
    if(self.numberPressed){
        self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    }
    self.c= [[[SubstractionCalculation alloc]initWithCalc: self.calc]autorelease];
    self.stringnumber=@"";
    self.decimalPressed=NO;
    self.numberPressed=NO;
}

- (IBAction)onResetPressed:(UIButton *)sender {
    [self.calc reset];
    [self removeButtonBorder];
    self.stringnumber=@"";
}

- (IBAction)onAnsPressed:(UIButton *)sender {
    [self removeButtonBorder];
    [self.c doCalculation:[self.stringnumber floatValue]];
    self.numberPressed=NO;
    
}

- (IBAction)onPercentagePressed:(UIButton *)sender {
    if(self.numberPressed){
        self.stringnumber=[NSString stringWithString:[[NSNumber numberWithFloat:[self.stringnumber floatValue] / (100)]stringValue]];
        [self updateLabelWithString:self.stringnumber];
    }else{
        self.calc.value= [NSNumber numberWithFloat:[self.calc.value floatValue] / (100)];
        self.stringnumber= [NSString stringWithString:[self.calc.value stringValue]];
        [self updateLabelWithString:self.stringnumber];
        
    }
}

- (IBAction)onChangeSignPressed:(UIButton *)sender {
    if(self.numberPressed){
        self.stringnumber=[NSString stringWithString:[[NSNumber numberWithFloat:[self.stringnumber floatValue] * (-1)]stringValue]];
        [self updateLabelWithString:self.stringnumber];
    }else{
        self.calc.value= [NSNumber numberWithFloat:[self.calc.value floatValue] * (-1)];
        self.stringnumber= [NSString stringWithString:[self.calc.value stringValue]];
        [self updateLabelWithString:self.stringnumber];
        
    }
    
    
}

-(void) updateLabelWithString:(NSString *) s{
    [self.result setText:s];
}

-(void) setButtonBorder:(UIButton *)sender {
    [self removeButtonBorder];
    [[sender layer] setBorderWidth:2.0f];
    [[sender layer] setBorderColor:[UIColor blackColor].CGColor];
    self.lastButtonPressed= sender;
}

-(void) removeButtonBorder{
    [[self.lastButtonPressed layer]setBorderWidth:0.0f];
   // [[self.lastButtonPressed layer] setBorderColor:[UIColor whiteColor].CGColor];
}
- (void)dealloc {
    [_calc release];
    [_result release];
    [super dealloc];
}
@end
