//
//  ProcessedCluesTableViewController.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 10/2/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CrosswordPuzzle;

@interface ProcessedCluesTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

// We got the clues for all directions.
// Get user input to fix clues.
// And proceed to calculate the answer.

- (ProcessedCluesTableViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle
                                     acrossClueImages:(NSArray *)acrossClueImages
                                       downClueImages:(NSArray *)downClueImages;

@end
