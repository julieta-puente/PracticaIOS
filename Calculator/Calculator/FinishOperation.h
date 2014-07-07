//
//  FinishOperation.h
//  Calculator
//
//  Created by Julieta Puente on 7/7/14.
//  Copyright (c) 2014 com.mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FinishOperation <NSObject>

-(void) updateLabelWithString: (NSString *) s;

@end
