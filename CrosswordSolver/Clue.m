//
//  Clue.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "Clue.h"

@implementation Clue

- (id)init {
    self = [super init];
    if (self) {
        _clueIndex = 0;
        _clueDirection = ClueAcross;
        _clueString = @"";
    }
    return self;
}

- (NSString *)description {
    if (self.clueDirection == ClueAcross) {
        return [NSString stringWithFormat:@"Across %d %@", self.clueIndex, self.clueString];
    }
    return [NSString stringWithFormat:@"Down %d %@", self.clueIndex, self.clueString];
}

@end
