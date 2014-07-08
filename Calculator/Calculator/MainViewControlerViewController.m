//
//  MainViewControlerViewController.m
//  Calculator
//
//  Created by Julieta Puente on 7/3/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import "MainViewControlerViewController.h"
#import "Calculator.h"

@interface MainViewControlerViewController (){
    NSString * _stringnumber;
    NSString * _operation;
    Calculator * _calc;
    BOOL _decimalPressed;
}
@property (nonatomic,copy) NSString * stringnumber;
@property (nonatomic,copy) NSString * operation;
@property (nonatomic,retain) Calculator * calc;
@property (nonatomic,assign) BOOL decimalPressed;
@end

@implementation MainViewControlerViewController
@synthesize stringnumber = _stringnumber;
@synthesize operation = _operation;
@synthesize calc=_calc;
@synthesize decimalPressed=_decimalPressed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.stringnumber = @"";
        self.operation = @"";
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
    self.stringnumber=@"";
    self.operation=@"division";
    self.decimalPressed=NO;
    
}

- (IBAction)onMultiplicationPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.stringnumber=@"";
    self.operation=@"multiplication";
    self.decimalPressed=NO;
}

- (IBAction)onAddPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.stringnumber=@"";
    self.operation=@"addition";
    self.decimalPressed=NO;
}

- (IBAction)onSubstractPressed:(UIButton *)sender {
    self.calc.value= [NSNumber numberWithFloat:[self.stringnumber floatValue]];
    self.stringnumber=@"";
    self.operation=@"substraction";
    self.decimalPressed=NO;
}

- (IBAction)onResetPressed:(UIButton *)sender {
    [self.calc reset];
}

- (IBAction)onAnsPressed:(UIButton *)sender {
    if ([self.operation  isEqual: @"division"]){
        [self.calc divide:[self.stringnumber floatValue]];
        self.stringnumber=@"";
    }
    if ([self.operation  isEqual: @"multiplication"]){
        [self.calc multiply:[self.stringnumber floatValue]];
        self.stringnumber=@"";
    }
    if ([self.operation  isEqual: @"addition"]){
        [self.calc add:[self.stringnumber floatValue]];
        self.stringnumber=@"";
    }
    if ([self.operation  isEqual: @"substraction"]){
        [self.calc substract:[self.stringnumber floatValue]];
        self.stringnumber=@"";
    }
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
