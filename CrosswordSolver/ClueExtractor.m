//
//  ClueExtractor.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ClueExtractor.h"
#import "Clue.h"

@implementation ClueExtractor

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSArray<Clue *> *)processClues {
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.delegate = self;
//    tesseract.charWhitelist = @"0123456789";
    UIImage *initialImage = [UIImage imageNamed:@"crossword_across_1.jpg"];
    tesseract.image = [initialImage g8_blackAndWhite];//crossWordImage;
    tesseract.engineMode = G8OCREngineModeTesseractCubeCombined;
    tesseract.maximumRecognitionTime = 60.0;
    tesseract.pageSegmentationMode = G8PageSegmentationModeSingleColumn;
    [tesseract recognize];
    NSLog(@"Recognized Text %@", [tesseract recognizedText]);
    NSString *recognizedText = [tesseract recognizedText];
    NSArray *arrayOfClues = [recognizedText componentsSeparatedByString:@"\n"];
    return [self extractClues:arrayOfClues];
}

// If a newline is not followed by a number
- (NSArray<Clue *> *)extractClues:(NSArray *)arrayOfClues {
    
    NSMutableArray *filteredForWhiteSpaceArray = [NSMutableArray array];
    for (NSString *clue in arrayOfClues) {
        int i = 0;
        for (i = 0; i < clue.length; i++) {
            char c = [clue characterAtIndex:i];
            if (c == ' ') {
                continue;
            } else break;
        }
        if (i!=0) {
            NSString *actualClue = [clue substringFromIndex:i];
            [filteredForWhiteSpaceArray addObject:actualClue];
        } else {
            [filteredForWhiteSpaceArray addObject:clue];
        }
    }
    
    NSMutableArray *finalArrayOfClues = [NSMutableArray array];
    for (NSString *possibleClue in filteredForWhiteSpaceArray) {
        Clue *clue = [[Clue alloc] init];
        int clueIndex = 0;
        for (int i = 0; i < possibleClue.length; i++) {
            char c = [possibleClue characterAtIndex:i];
            if (c >= '0' &&  c <= '9') {
                // We found a digit
                clueIndex = clueIndex * 10 + (c - '0');
            } else if (c == ' ') {
                clue.clueIndex = clueIndex;
                clue.clueString = [clue.clueString stringByAppendingString:[possibleClue substringFromIndex:i]];
                [finalArrayOfClues addObject:clue];
                break;
            } else {
                // Encountered a character
                Clue * lastObject = [finalArrayOfClues lastObject];
                if (!lastObject) {
                    // Must be either ACROSS or DOWN
                    break;
                }
                [finalArrayOfClues removeLastObject];
                NSString *clueComponent = [NSString stringWithFormat:@" %@",[possibleClue substringFromIndex:i]];
                lastObject.clueString = [lastObject.clueString stringByAppendingString:clueComponent];
                [finalArrayOfClues addObject:lastObject];
                break;
            }
        }
    }
    NSLog(@"%@", finalArrayOfClues);
    return finalArrayOfClues;
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
//    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
}

@end
