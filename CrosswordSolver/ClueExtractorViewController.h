//
//  ClueExtractorViewController.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrosswordPuzzle.h"

// Take a picture
@interface ClueExtractorViewController : UIViewController

// This takes a picture of all the clues.
// We need to get pictures for one direction at a time.

- (ClueExtractorViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle;

@end
