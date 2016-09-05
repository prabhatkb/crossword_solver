//
//  DigitExtractor.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/3/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TesseractOCR/TesseractOCR.h>
@class CrosswordPuzzle;

@interface DigitExtractor : NSObject <G8TesseractDelegate>

- (void) populateCrossWord:(CrosswordPuzzle *)puzzle fromImage:(NSString *)imageFilename;

@end
