//
//  ProcessedCluesViewController.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/10/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrosswordPuzzle.h"
#import "Clue.h"

@interface ProcessedCluesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (ProcessedCluesViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle
                                    forDirection:(ClueDirection)clueDirection;

@end
