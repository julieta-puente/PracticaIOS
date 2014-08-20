//
//  StorageManager.m
//  Musica
//
//  Created by Julieta Puente on 20/08/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "StorageManager.h"
@interface StorageManager()

@property (strong,nonatomic) NSArray * paths;
@property (strong,nonatomic) NSString * documentsDirectoryPath;
@property (strong,nonatomic) NSString * dataPath;
@end

@implementation StorageManager

-(id)init{
    if([super init]){
        self.paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectoryPath = [self.paths objectAtIndex:0];
    }
    return self;
}

-(NSData *) getData:(NSString *)item{
    self.dataPath = [self.documentsDirectoryPath stringByAppendingPathComponent: [NSString stringWithFormat: @"%@",item]];
    NSData * data=[NSKeyedUnarchiver unarchiveObjectWithFile:self.dataPath];
   
    return data;
}
-(void) saveData:(NSData *)data forItem:(NSString *)item{
    self.dataPath = [self.documentsDirectoryPath stringByAppendingPathComponent: [NSString stringWithFormat: @"%@",item]];
    [NSKeyedArchiver archiveRootObject:data toFile: self.dataPath];
}


@end
