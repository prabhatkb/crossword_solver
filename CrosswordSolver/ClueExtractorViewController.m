//
//  ClueExtractorViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ClueExtractorViewController.h"
#import "ProcessedCluesViewController.h"

@interface ClueExtractorViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;
// For every image taken, put the path for the image here.
@property (nonatomic) NSMutableArray *imagePaths;
@property (nonatomic) ClueDirection clueDirection;

@end

@implementation ClueExtractorViewController

- (ClueExtractorViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle
                                   forDirection:(ClueDirection)clueDirection {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
        _clueDirection = clueDirection;
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
    ProcessedCluesViewController *nextViewController = [[ProcessedCluesViewController alloc] initWithPuzzle:self.puzzle forDirection:self.clueDirection];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

- (void)takeAnotherPicture:(id) sender {
    [self pushCalculatedClues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
