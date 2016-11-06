//
//  ClueExtractor.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/4/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ClueExtractor.h"
#import "Clue.h"

@interface ClueExtractor ()
@property (nonatomic) G8Tesseract *tesseract;
@end

@implementation ClueExtractor

- (id)init {
    self = [super init];
    if (self) {
        _tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
        _tesseract.delegate = self;
        _tesseract.engineMode = G8OCREngineModeTesseractCubeCombined;
        _tesseract.maximumRecognitionTime = 60.0;
        _tesseract.pageSegmentationMode = G8PageSegmentationModeSingleColumn;
    }
    return self;
}

- (NSArray<Clue *> *)processClues:(NSString *)imageFilePath {
    imageFilePath = @"crossword_across_1.jpg";
    UIImage *initialImage = [UIImage imageNamed:imageFilePath];
    self.tesseract.image = [initialImage g8_blackAndWhite];//crossWordImage;
    [self.tesseract recognize];

    // TODO Make this asynchronous.
    NSLog(@"Recognized Text %@", [self.tesseract recognizedText]);
    NSString *recognizedText = [self.tesseract recognizedText];
    NSArray *arrayOfClues = [recognizedText componentsSeparatedByString:@"\n"];
    NSLog(@"Array of Clues %@", arrayOfClues);
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
            if ((actualClue.length >= 6 && [[actualClue substringToIndex:6] isEqualToString:@"Across"]) ||
                (actualClue.length >= 4 && [[actualClue substringToIndex:4] isEqualToString:@"Down"])) {
                // Don't add Across or Down
                continue;
            }
            [filteredForWhiteSpaceArray addObject:actualClue];
        } else {
            if ((clue.length >= 6 && [[clue substringToIndex:6] isEqualToString:@"Across"]) ||
                (clue.length >= 4 && [[clue substringToIndex:4] isEqualToString:@"Down"])) {
                // Don't add Across or Down
                continue;
            }
            [filteredForWhiteSpaceArray addObject:clue];
        }
    }
    
    NSMutableArray *finalArrayOfClues = [NSMutableArray array];
    for (NSString *possibleClue in filteredForWhiteSpaceArray) {
        BOOL foundADigit = NO;
        Clue *clue = [[Clue alloc] init];
        int clueIndex = 0;
        for (int i = 0; i < possibleClue.length; i++) {
            char c = [possibleClue characterAtIndex:i];
            if (c >= '0' &&  c <= '9') {
                // We found a digit
                foundADigit = YES;
                clueIndex = clueIndex * 10 + (c - '0');
            } else if (c == ' ' && foundADigit) {
                clue.clueIndex = clueIndex;
                clue.clueString = [possibleClue substringFromIndex:(i+1)];
                [finalArrayOfClues addObject:clue];
                break;
            } else  if (((c >= 'a' && c <= 'z') ||
                         (c >= 'A' && c <= 'Z')) &&
                        !foundADigit) {
                // If it's a character, then add it to the previous clue as it is a continuation
                // of the previous clue.
                Clue *clue = [finalArrayOfClues lastObject];
                clue.clueString = [clue.clueString stringByAppendingString:possibleClue];
                break;
            } else {
                // This is stupid thing like a ',' in a new line.
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
    // Return YES, if you need to interrupt tesseract before it finishes.
    // But we want the tesseract code to completely process the image.
    // There is no necessity to ever stop execution mid-way.
    return NO;
}

@end
