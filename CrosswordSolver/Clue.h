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
    ClueAcross,
    ClueDown,
} ClueDirection;

@interface Clue : NSObject

@property (nonatomic) NSInteger clueIndex;
@property (nonatomic) NSString *clueString;
@property (nonatomic) ClueDirection clueDirection;
@property (nonatomic) int numOfCharacters;

@end
