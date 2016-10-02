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

@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;

- (CrosswordPuzzle *)initWithRows:(int)rows columns:(int)columns;
- (void)markEmptyGridAtRow:(int)row col:(int)col;
- (void)markBlackGridAtRow:(int)row col:(int)col;
- (void)markGridAtRow:(int)row col:(int)col withNum:(int)num;

- (int)valueAtRow:(int)row col:(int)col;
- (BOOL)isGridBlackAtRow:(int)row col:(int)col;
- (BOOL)isGridEmptyAtRow:(int)row col:(int)col;

- (void)addClue:(Clue *)clue;
- (void)removeClue:(Clue *)clue;

- (NSArray *)getClues:(ClueDirection)clueDirection;

- (void)printCrossword;

+ (CrosswordPuzzle *)testCrosswordPuzzle;

@end
