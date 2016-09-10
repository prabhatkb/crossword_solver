//
//  ProcessedCluesViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/10/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ProcessedCluesViewController.h"
#import "ClueExtractor.h"

#define NUMBER_CELL_WIDTH 30

#define CELL_OFFSET 5

#define CELL_HEIGHT 40

@interface ProcessedCluesViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;
@property (nonatomic) ClueExtractor *clueExtractor;
@property (nonatomic) ClueDirection clueDirection;
@property (nonatomic) NSArray *clues;
@property (nonatomic) UITableView *numberTableView;
@property (nonatomic) UITableView *clueStringTableView;

@end

@implementation ProcessedCluesViewController

- (ProcessedCluesViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle
                                    forDirection:(ClueDirection)clueDirection; {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
        _clueDirection = clueDirection;
        _clueExtractor = [[ClueExtractor alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.clues = [self.clueExtractor processClues];
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:scrollView];
    
    self.numberTableView = [[UITableView alloc] initWithFrame:
                            CGRectMake(0, 0, NUMBER_CELL_WIDTH, screenHeight)];
    self.numberTableView.delegate = self;
    self.numberTableView.dataSource = self;
    [self.numberTableView setUserInteractionEnabled:NO];
    
    self.clueStringTableView = [[UITableView alloc] initWithFrame:CGRectMake(NUMBER_CELL_WIDTH + CELL_OFFSET, 0, screenWidth - NUMBER_CELL_WIDTH - CELL_OFFSET, screenHeight)];
    self.clueStringTableView.delegate = self;
    self.clueStringTableView.dataSource = self;
    [self.clueStringTableView setUserInteractionEnabled:NO];
    
    [self.view addSubview:self.numberTableView];
    [self.view addSubview:self.clueStringTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.clues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
//    int screenHeight = screenSize.size.height;
    
    UITableViewCell * tableViewCell = nil;
    
    NSInteger row = indexPath.row;
    
    if ([tableView isEqual:self.numberTableView]) {
        tableViewCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, NUMBER_CELL_WIDTH, CELL_HEIGHT)];
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, NUMBER_CELL_WIDTH, CELL_HEIGHT)];
        int clueIndex = [(Clue *)self.clues[row] clueIndex];
        NSString *clueString = [NSString stringWithFormat:@"%d", clueIndex];
        [textView setText:clueString];
        [tableViewCell addSubview:textView];
    } else {
        tableViewCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, screenWidth - NUMBER_CELL_WIDTH - CELL_OFFSET, CELL_HEIGHT)];
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - NUMBER_CELL_WIDTH - CELL_OFFSET, CELL_HEIGHT)];
        NSString *clueString = [(Clue *)self.clues[row] clueString];
        [textView setText:clueString];
        [tableViewCell addSubview:textView];
    }
    return tableViewCell;
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
