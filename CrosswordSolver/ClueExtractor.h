//
//  ClueExtractor.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TesseractOCR/TesseractOCR.h>

#import "Clue.h"

/*
 * Extracts the clues from the sample image directly that is hard-coded.
 * processClues, gives an array of Clues.
 */

@interface ClueExtractor : NSObject <G8TesseractDelegate>

- (NSArray<Clue *> *)processClues;

@end
