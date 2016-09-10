//
//  CameraViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "CameraViewController.h"
#import "DigitExtractor.h"
#import "ProcessedCrosswordViewController.h"

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    // Do any additional setup after loading the view.
    UIImage *initialImage = [UIImage imageNamed:@"crossword_grid.png"];
    UIImageView *initialImageView = [[UIImageView alloc] initWithImage:initialImage];
    [self.view insertSubview:initialImageView atIndex:0];
    // Add a button to start processing and push another view controller here.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self
               action:@selector(pushCalculatedCrosswordGrid)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Process" forState:UIControlStateNormal];
    button.frame = CGRectMake(screenWidth/4, screenHeight*9/10, screenWidth/2, screenHeight/10);
    button.backgroundColor = [UIColor redColor];
    [self.view insertSubview:button atIndex:1];
    [self.view bringSubviewToFront:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushCalculatedCrosswordGrid {
//    GridProcessor *gridProcessor = [[GridProcessor alloc] initWithImageNamed:@"crossword_grid.png"];
    CrosswordPuzzle *puzzle = [CrosswordPuzzle testCrosswordPuzzle];
//    CrosswordPuzzle *puzzle = [gridProcessor processPuzzle];
//    DigitExtractor *digitExtractor = [[DigitExtractor alloc] init];
//    [digitExtractor populateCrossWord:puzzle fromImage:@"crossword_grid.png"];
    ProcessedCrosswordViewController *processedCrosswordViewController = [[ProcessedCrosswordViewController alloc] initWithCrossword:puzzle];
    [self.navigationController pushViewController:processedCrosswordViewController animated:YES];
}

@end
