//
//  AlbumImageViewPickerDelegate.h
//  Musica
//
//  Created by Julieta Puente on 22/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlbumImageViewPickerDelegate;

@protocol ImageUpdate <NSObject>

-(void) pickerSelectionWasMade: (AlbumImageViewPickerDelegate *) albumimage;

@end

@interface AlbumImageViewPickerDelegate : NSObject  <UIPickerViewDelegate,UIPickerViewDataSource>

-(NSString *) getSelection;
@property (assign, nonatomic) id <ImageUpdate> delegate;

@end
