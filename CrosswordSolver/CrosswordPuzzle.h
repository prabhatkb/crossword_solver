//
//  CrosswordPuzzle.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/30/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrosswordPuzzle : NSObject

@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;
@property (nonatomic, assign) NSArray *acrossClues;
@property (nonatomic, assign) NSArray *downClues;

- (CrosswordPuzzle *)initWithRows:(int)rows columns:(int)columns;
- (void)markEmptyGridAtRow:(int)row col:(int)col;
- (void)markBlackGridAtRow:(int)row col:(int)col;
- (void)markGridAtRow:(int)row col:(int)col withNum:(int)num;

- (int)valueAtRow:(int)row col:(int)col;
- (BOOL)isGridBlackAtRow:(int)row col:(int)col;
- (BOOL)isGridEmptyAtRow:(int)row col:(int)col;

- (void)printCrossword;

+ (CrosswordPuzzle *)testCrosswordPuzzle;

@end
