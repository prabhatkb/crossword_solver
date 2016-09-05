//
//  CrosswordPuzzle.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/30/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "CrosswordPuzzle.h"

@interface CrosswordPuzzle()

@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;
@property (nonatomic, assign) NSArray *clues;

@end

@implementation CrosswordPuzzle

- (CrosswordPuzzle *)initWithRows:(int)rows columns:(int)columns {
    self = [super init];
    if (self) {
        _rows = rows;
        _columns = columns;
    }
    return self;
}

@end
