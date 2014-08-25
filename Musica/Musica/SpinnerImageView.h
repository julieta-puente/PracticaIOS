//
//  SpinnerImageView.h
//  Musica
//
//  Created by Julieta Puente on 25/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchImageService.h"
@interface SpinnerImageView : UIImageView <FetchImageResponse>

-(void) loadSpinner;
-(UIImage *) getImage;
@end
