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

- (ClueExtractorViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle
                                   forDirection:(ClueDirection)clueDirection;

@end
