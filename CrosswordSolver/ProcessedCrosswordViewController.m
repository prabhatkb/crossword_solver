//
//  ProcessedCrosswordViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ProcessedCrosswordViewController.h"

@interface ProcessedCrosswordViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;

@end

@implementation ProcessedCrosswordViewController

- (id)initWithCrossword:(CrosswordPuzzle *)puzzle {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
