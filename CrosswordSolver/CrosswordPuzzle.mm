//
//  CrosswordPuzzle.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/30/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "CrosswordPuzzle.h"

#define BLACK_GRID -1
#define EMPTY_GRID 0

@interface CrosswordPuzzle()

@property (nonatomic, assign) int **array;
@property (nonatomic) NSMutableSet<Clue *> *clues;

@end

@implementation CrosswordPuzzle

- (CrosswordPuzzle *)initWithRows:(int)rows columns:(int)columns {
    self = [super init];
    if (self) {
        _rows = rows;
        _columns = columns;
        _array = new int*[rows];
        for(int i = 0; i < rows; ++i)
            _array[i] = new int[columns];
        _clues = [NSMutableSet set];
    }
    return self;
}
- (void)markEmptyGridAtRow:(int)row col:(int)col {
    self.array[row][col] = EMPTY_GRID;
}

- (void)markBlackGridAtRow:(int)row col:(int)col {
    self.array[row][col] = BLACK_GRID;
}

- (void)markGridAtRow:(int)row col:(int)col withNum:(int)num {
    self.array[row][col] = num;
}

- (int)valueAtRow:(int)row col:(int)col {
    return self.array[row][col];
}

- (BOOL)isGridBlackAtRow:(int)row col:(int)col {
    return self.array[row][col] == BLACK_GRID;
}

- (BOOL)isGridEmptyAtRow:(int)row col:(int)col {
    return self.array[row][col] == EMPTY_GRID;
}

- (void)addClue:(Clue *)clue {
    [self.clues addObject:clue];
}

- (NSArray<Clue *> *)getClues:(ClueDirection)clueDirection {
    NSMutableArray<Clue *> *cluesInDirection = [NSMutableArray array];
    NSArray<Clue *> *clues = [self.clues allObjects];
    for (Clue *clue in clues) {
        if (clue.clueDirection == clueDirection) {
            [cluesInDirection addObject:clue];
        }
    }
    return cluesInDirection;
}

- (void)printCrossword {
    for (int i = 0; i<self.rows; i++) {
        printf("\n---------------------------------------\n");
        for (int j = 0; j<self.columns; j++) {
            if (j==0) {
                printf("|");
            }
            if ([self isGridBlackAtRow:i col:j]) {
                printf("--|");
                continue;
            }
            if ([self isGridEmptyAtRow:i col:j]) {
                printf("  |");
                continue;
            }
            int value = [self valueAtRow:i col:j];
            if (value >= 0 && value < 10) {
                printf("%d |", value);
            } else {
                printf("%d|", value);
            }
        }
    }
}

+ (CrosswordPuzzle *)testCrosswordPuzzle {
    CrosswordPuzzle *puzzle = [[CrosswordPuzzle alloc] initWithRows:3 columns:3];
    for (int i = 0; i<puzzle.rows; i++) {
        for (int j = 0; j<puzzle.columns; j++) {
            [puzzle markGridAtRow:i col:j withNum:(i*10+j)];
        }
    }
    [puzzle markBlackGridAtRow:0 col:2];
    [puzzle markBlackGridAtRow:2 col:0];
    [puzzle markEmptyGridAtRow:1 col:1];
    return puzzle;
}

@end
