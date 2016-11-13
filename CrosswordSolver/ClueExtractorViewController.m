//
//  ClueExtractorViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ClueExtractorViewController.h"
#import "ProcessedCluesTableViewController.h"
#import "ClueExtractor.h"

@interface ClueExtractorViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;
@property (nonatomic) ClueExtractor *clueExtractor;

@end

@implementation ClueExtractorViewController

- (ClueExtractorViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
        _clueExtractor = [[ClueExtractor alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    // Do any additional setup after loading the view.
    UIImage *initialImage = [UIImage imageNamed:@"crossword_across_1.jpg"];
    UIImageView *initialImageView = [[UIImageView alloc] initWithImage:initialImage];
    [self.view insertSubview:initialImageView atIndex:0];
    // Add a button to start processing and push another view controller here.
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneButton addTarget:self
               action:@selector(processAndPushCalculatedClues)
     forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:@"Process" forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, screenHeight*9/10, screenWidth/2, screenHeight/10);
    doneButton.backgroundColor = [UIColor redColor];
    [self.view insertSubview:doneButton atIndex:1];
    
    UIButton *oneMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [oneMoreButton addTarget:self
                      action:@selector(takeAnotherPicture:)
     forControlEvents:UIControlEventTouchUpInside];
    [oneMoreButton setTitle:@"One More" forState:UIControlStateNormal];
    oneMoreButton.frame = CGRectMake(screenWidth/2, screenHeight*9/10, screenWidth/2, screenHeight/10);
    oneMoreButton.backgroundColor = [UIColor redColor];
    [self.view insertSubview:oneMoreButton atIndex:2];
}

- (void)processAndPushCalculatedClues {
    [self processImagesForClues];
    ProcessedCluesTableViewController *nextViewController =
        [[ProcessedCluesTableViewController alloc] initWithPuzzle:self.puzzle];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

// Take more pictures for the particular image.
// ALso the array should be such that [UIImage imageFrom:arr[i]] should directly work.
- (void)takeAnotherPicture:(id) sender {
    [self processAndPushCalculatedClues];
}

- (void)processImagesForClues {
    /*
     for (NSString *imagePath in _acrossClueImages) {
     
     }
     */
//    NSArray<Clue *> *clues = [self.clueExtractor processClues:nil];
    NSArray<Clue *> *clues = [self testCluesForTesting];
    for (Clue *clue in clues) {
        [self.puzzle addClue:clue];
    }
}

- (NSArray<Clue *> *)testCluesForTesting {
    NSMutableArray<Clue *> *results = [NSMutableArray array];
    NSArray *clueNumberArray = @[@(1),
                                 @(6),
                                 @(13),
                                 @(19),
                                 @(20),
                                 @(21),
                                 @(22),
                                 @(25),
                                 @(26),
                                 @(27),
                                 @(28),
                                 @(30),
                                 @(32),
                                 @(34),
                                 @(37),
                                 @(40),
                                 @(44),
                                 @(45),
                                 @(47),
                                 @(48),
                                 @(49),
                                 @(50),
                                 @(51),
                                 @(54),
                                 @(57),
                                 @(58),
                                 @(60),
                                 @(62),
                                 @(63),
                                 @(64),
                                 @(66),
                                 @(67)];
    NSArray *clueStringArray = @[@"Repair shop supply",
                                 @"Sicilian wine",
                                 @"Deli device",
                                 @"Paragon",
                                 @"Youre - you feel",
                                 @"O pretty maiden...",
                                 @"Whirlpool inventor",
                                 @"About time!",
                                 @"Isolde's beloved",
                                 @"School topic (abbr.)",
                                 @"Previously",
                                 @"Sprechen 7 Deutsch?",
                                 @"Edible tuber",
                                 @"Be dependent, in a way",
                                 @"Like Burns' mouse",
                                 @"Microphone inventor",
                                 @"My Way composer",
                                 @"to bed: Pepys",
                                 @"Gross minus expenses",
                                 @"Tram filler",
                                 @"Highway of the North",
                                 @"Bait",
                                 @"Tijuana title",
                                 @"Brother of Moses",
                                 @"Watchdog org",
                                 @"Self-evident fact",
                                 @"Synthesizer inventor",
                                 @"Again, to Masur",
                                 @"Ballad",
                                 @"Approves",
                                 @"Actor's award",
                                 @"Gilmore Girls Bledel"];
    for (int i = 0; i<clueStringArray.count; i++) {
        NSNumber *clueIndexNumber = clueNumberArray[i];
        NSString *clueIndexString = clueStringArray[i];
        int clueIndex = [clueIndexNumber intValue];
        Clue *clue = [[Clue alloc] init];
        clue.clueIndex = clueIndex;
        clue.clueString = clueIndexString;
        [results addObject:clue];
    }
    return results;
}

@end
