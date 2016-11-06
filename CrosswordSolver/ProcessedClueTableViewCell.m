//
//  ProcessClueTableViewCell.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 10/1/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ProcessedClueTableViewCell.h"

@interface ProcessedClueTableViewCell ()

@property (nonatomic) Clue *clue;
@property (nonatomic) NSMutableArray *pickerSource;
@property (nonatomic) UIPickerView *clueIndexPickerView;

@end

@implementation ProcessedClueTableViewCell

- (id)initWithClue:(Clue *)processedClue {
    self = [super init];
    if (self) {
        _clue = processedClue;
        _pickerSource = [NSMutableArray array];
        // TODO: Change 50 to max clues.
        for (int i = 1; i <= 50; i++) {
            [_pickerSource addObject:@(i)];
        }
        _clueIndexPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
        _clueIndexPickerView.delegate = self;
        _clueIndexPickerView.dataSource = self;
        _clueIndexPickerView.showsSelectionIndicator = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clueStringTextField.delegate = self;

    // Set the picker to the clue index.
    [self.clueIndexTextField setText:[NSString stringWithFormat:@"%ld", (long)self.clue.clueIndex]];
    [self.clueIndexTextField setInputView:self.clueIndexPickerView];

    // Set the clue string in the text field.
    [self.clueStringTextField setText:self.clue.clueString];
}

#pragma mark UITextFieldDelegate callbacks

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *newClueString = [textField text];
    [self.clue setClueString:newClueString];
    return YES;
}

#pragma mark UIPickerView data soruce delegate callbacks

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerSource count];
}

#pragma mark UIPickerView delegate callbacks

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    [self.clue setClueIndex:row];
}

@end
