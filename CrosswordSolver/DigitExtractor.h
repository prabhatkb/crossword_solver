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

/*
 * Digit Extractor extracts the digits in the image.
 * The argument "puzzle" has the number of rows and columns and form which
 * the image is segregated and the digits, black squares, empty square
 * information are appended on the puzzle variable.
 */

@interface DigitExtractor : NSObject <G8TesseractDelegate>

- (void) populateCrossWord:(CrosswordPuzzle *)puzzle fromImage:(NSString *)imageFilename;

@end
