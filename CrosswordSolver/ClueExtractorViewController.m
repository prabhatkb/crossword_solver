//
//  ClueExtractorViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ClueExtractorViewController.h"
#import "ProcessedCluesTableViewController.h"

@interface ClueExtractorViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;

@end

@implementation ClueExtractorViewController

- (ClueExtractorViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
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
               action:@selector(pushCalculatedClues)
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

- (void)pushCalculatedClues {
    ProcessedCluesTableViewController *nextViewController =
        [[ProcessedCluesTableViewController alloc] initWithPuzzle:self.puzzle
                                                 acrossClueImages:@[@"crossword_across_1.jpg"]
                                                   downClueImages:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

// Take more pictures for the particular image.
// ALso the array should be such that [UIImage imageFrom:arr[i]] should directly work.
- (void)takeAnotherPicture:(id) sender {
    [self pushCalculatedClues];
}

@end
