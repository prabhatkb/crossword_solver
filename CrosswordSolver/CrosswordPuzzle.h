//
//  CrosswordPuzzle.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/30/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clue.h"

/*
 * Represents the crossword that the app solves.
 * It has the grid information and the clues (Across and Down)
 */

@interface CrosswordPuzzle : NSObject

@property (nonatomic, assign, readonly) int rows;
@property (nonatomic, assign, readonly) int columns;

- (CrosswordPuzzle *)initWithRows:(int)rows columns:(int)columns;

// Methods to mark the grids in the crossword.
- (void)markEmptyGridAtRow:(int)row col:(int)col;
- (void)markBlackGridAtRow:(int)row col:(int)col;
- (void)markGridAtRow:(int)row col:(int)col withNum:(int)num;

// Helper functions to retrieve data at each grid
- (int)valueAtRow:(int)row col:(int)col;
- (BOOL)isGridBlackAtRow:(int)row col:(int)col;
- (BOOL)isGridEmptyAtRow:(int)row col:(int)col;

// Methods to add the Clues to the crossword.
- (void)addClue:(Clue *)clue;

// Filters among all clues to get clues for only one direction.
- (NSArray<Clue *> *)getClues:(ClueDirection)clueDirection;

// Debug methods to test the implementation.
- (void)printCrossword;
+ (CrosswordPuzzle *)testCrosswordPuzzle;

@end
