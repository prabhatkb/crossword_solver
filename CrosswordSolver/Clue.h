//
//  Clue.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ClueAcross,
    ClueDown,
} ClueDirection;

@interface Clue : NSObject

@property (nonatomic) NSString *clue;
@property (nonatomic) ClueDirection clueDirection;
@property (nonatomic) int numOfCharacters;

@end
