//
//  Album.h
//  Musica
//
//  Created by Julieta Puente on 14/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

-(id) initWithYear:(NSString *) year withGroup: (NSString*) group withImage: (UIImage *) image;
-(NSString *) getGroup;
-(NSString *) getYear;
-(UIImage *) getImage;
@end
