//
//  GroupViewController.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *NameTextField;
@property (strong, nonatomic) IBOutlet UITextField *StyleTextField;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionTextView;
@end
