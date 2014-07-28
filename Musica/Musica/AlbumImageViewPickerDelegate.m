//
//  AlbumImageViewPickerDelegate.m
//  Musica
//
//  Created by Julieta Puente on 22/07/14.
//  Copyright (c) 2014 Julieta Puente. All rights reserved.
//

#import "AlbumImageViewPickerDelegate.h"

@interface AlbumImageViewPickerDelegate()
@property (retain, nonatomic) NSArray * imagesNames;
@property (copy, nonatomic) NSString * selection;

@end

@implementation AlbumImageViewPickerDelegate

- (id)init
{
    self = [super init];
    if (self) {
        self.imagesNames = @[@"queen.jpg", @"oasis.jpg", @"thebeatles.jpg",@"thedoors.jpg"];
        self.selection=@"queen.jpg";
    }
    return self;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.imagesNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.imagesNames[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selection= self.imagesNames[row];
    [self.delegate pickerSelectionWasMade: self];
}


-(NSString *) getSelection{
    return self.selection;
}

-(void) dealloc {
    [_imagesNames release];
    [_selection release];
    [super dealloc];
}

@end
