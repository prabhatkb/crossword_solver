//
//  ProcessedClueTableViewCell.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 10/2/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "Clue.h"

@interface ProcessedClueTableViewCell : UITableViewCell <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *clueStringTextField;
@property (weak, nonatomic) IBOutlet UITextField *clueIndexTextField;

// Takes a clue and sets the table view cell
- (id)initWithClue:(Clue *)processedClue;

@end
