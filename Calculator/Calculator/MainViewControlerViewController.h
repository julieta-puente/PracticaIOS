//
//  MainViewControlerViewController.h
//  Calculator
//
//  Created by Julieta Puente on 7/3/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorFinishOperation.h"

@interface MainViewControlerViewController : UIViewController <CalculatorFinishOperation>


- (IBAction)onNumberPressed:(UIButton *)sender;
- (IBAction)onDecimalPressed:(UIButton *)sender;
- (IBAction)onDivisionPressed:(UIButton *)sender;
- (IBAction)onMultiplicationPressed:(UIButton *)sender;
- (IBAction)onAddPressed:(UIButton *)sender;
- (IBAction)onSubstractPressed:(UIButton *)sender;
- (IBAction)onResetPressed:(UIButton *)sender;
- (IBAction)onAnsPressed:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel * result;



@end
