//
//  ProcessedCluesViewControllerTableViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 10/2/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ProcessedCluesTableViewController.h"
#import "CrosswordPuzzle.h"
#import "ClueExtractor.h"
#import "Clue.h"

#import "ProcessedClueTableViewCell.h"

@interface ProcessedCluesTableViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;

@end

@implementation ProcessedCluesTableViewController

- (ProcessedCluesTableViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.puzzle.clues count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *sectionString = nil;
    if (section == 0) {
        sectionString = @"Across";
    } else {
        sectionString = @"Down";
    }
//    NSString *reusableIdentifier = [NSString stringWithFormat:@"%@-%ld", sectionString, (long)row];
//    ProcessedClueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier
//                                                                       forIndexPath:indexPath];
    Clue *clue = [self.puzzle.clues objectAtIndex:row];
    ProcessedClueTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProcessedClueTableViewCell" owner:nil options:nil]lastObject];
    cell.clue = clue;
    return cell;
}
@end
