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
    NSString * number;
    NSString * operation;
    Calculator * calc;
}

@end

@implementation MainViewControlerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        number=@"";
        calc = [[Calculator alloc]init];
        calc.operationDelegate=self;
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
    number=[number stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    [self updateLabelWithString:number];
}

- (IBAction)onDecimalPressed:(UIButton *)sender {
    number=[number stringByAppendingString:@"."];
    [self updateLabelWithString:number];
}

- (IBAction)onDivisionPressed:(UIButton *)sender {
    calc.value= [NSNumber numberWithFloat:[number floatValue]];
    number=@"";
    operation=@"division";
    
}

- (IBAction)onMultiplicationPressed:(UIButton *)sender {
    calc.value= [NSNumber numberWithFloat:[number floatValue]];
    number=@"";
    operation=@"multiplication";
}

- (IBAction)onAddPressed:(UIButton *)sender {
    calc.value= [NSNumber numberWithFloat:[number floatValue]];
    number=@"";
    operation=@"addition";
}

- (IBAction)onSubstractPressed:(UIButton *)sender {
    calc.value= [NSNumber numberWithFloat:[number floatValue]];
    number=@"";
    operation=@"substraction";
}

- (IBAction)onResetPressed:(UIButton *)sender {
    [calc reset];
}

- (IBAction)onAnsPressed:(UIButton *)sender {
    if ([operation  isEqual: @"division"]){
        [calc divide:[number floatValue]];
        number=@"";
    }
    if ([operation  isEqual: @"multiplication"]){
        [calc multiply:[number floatValue]];
        number=@"";
    }
    if ([operation  isEqual: @"addition"]){
        [calc add:[number floatValue]];
        number=@"";
    }
    if ([operation  isEqual: @"substraction"]){
        [calc substract:[number floatValue]];
        number=@"";
    }
}

-(void) updateLabelWithString:(NSString *) s{
    [self.result setText:s];
}
- (void)dealloc {
    [_result release];
    [super dealloc];
}
@end
