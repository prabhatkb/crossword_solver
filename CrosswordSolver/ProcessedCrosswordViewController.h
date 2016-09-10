//
//  ProcessedCrosswordViewController.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrosswordPuzzle.h"

@interface ProcessedCrosswordViewController : UIViewController <UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

- (id)initWithCrossword:(CrosswordPuzzle *)puzzle;

@end
