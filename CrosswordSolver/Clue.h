//
//  Clue.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Represents a single clue in the crossword.
 * It is parsed by the ClueExtractor and gets added to the Crossword Puzzle object.
 */

typedef enum : NSUInteger {
    ClueDirectionAcross,
    ClueDirectionDown,
} ClueDirection;

@interface Clue : NSObject

// The index in the crossword grid where it says it starts.
@property (nonatomic) NSInteger clueIndex;

// The actual clue string.
@property (nonatomic) NSString *clueString;

// The direciton: Across or Down.
@property (nonatomic) ClueDirection clueDirection;

// Number of characters in the solution for this clue.
// This may not be available in most puzzles.
@property (nonatomic) int numOfCharacters;

@end
