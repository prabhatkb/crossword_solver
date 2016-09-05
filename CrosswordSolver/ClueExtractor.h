//
//  ClueExtractor.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TesseractOCR/TesseractOCR.h>

@interface ClueExtractor : NSObject <G8TesseractDelegate>

- (NSArray *)processClues;

@end
