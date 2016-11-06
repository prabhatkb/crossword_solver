//
//  Clue.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "Clue.h"

@implementation Clue

- (id)initAcrossClueAtIndex:(NSInteger)clueIndex
                 clueString:(NSString *)clueString
            numOfCharacters:(int)numOfCharacters {
    self = [super init];
    if (self) {
        _clueIndex = clueIndex;
        _clueString = clueString;
        _numOfCharacters = numOfCharacters;
        _clueDirection = ClueDirectionAcross;
    }
    return self;
}

- (id)initDownClueAtIndex:(NSInteger)clueIndex
               clueString:(NSString *)clueString
          numOfCharacters:(int)numOfCharacters {
    self = [super init];
    if (self) {
        _clueIndex = clueIndex;
        _clueString = clueString;
        _numOfCharacters = numOfCharacters;
        _clueDirection = ClueDirectionDown;
    }
    return self;
}


- (NSString *)description {
    if (self.clueDirection == ClueDirectionAcross) {
        return [NSString stringWithFormat:@"Across %ld %@", self.clueIndex, self.clueString];
    }
    return [NSString stringWithFormat:@"Down %ld %@", self.clueIndex, self.clueString];
}

@end
