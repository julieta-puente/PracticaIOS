//
//  StorageManager.h
//  Musica
//
//  Created by Julieta Puente on 20/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject
-(NSData *) getData:(NSString *)item;
-(void) saveData:(NSData *)data forItem:(NSString *)item;
@end
