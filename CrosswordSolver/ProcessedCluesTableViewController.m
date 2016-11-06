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
@property (nonatomic) ClueExtractor *clueExtractor;
@property (nonatomic) NSMutableArray<Clue *> *clues;

@property (nonatomic) NSArray *acrossClueImages;
@property (nonatomic) NSArray *downClueImages;

@end

@implementation ProcessedCluesTableViewController

- (ProcessedCluesTableViewController *)initWithPuzzle:(CrosswordPuzzle *)puzzle
                                     acrossClueImages:(NSArray *)acrossClueImages
                                       downClueImages:(NSArray *)downClueImages {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
        _clueExtractor = [[ClueExtractor alloc] init];
        _acrossClueImages = acrossClueImages;
        _downClueImages = downClueImages;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self processImagesForClues];
    }
    return self;
}

- (void)processImagesForClues {
    /*
     for (NSString *imagePath in _acrossClueImages) {
     
     }
     */
    [self.clues addObjectsFromArray:[self.clueExtractor processClues]];
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.clues count];
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
    NSString *reusableIdentifier = [NSString stringWithFormat:@"%@-%ld", sectionString, (long)row];
    ProcessedClueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier
                                                                       forIndexPath:indexPath];
    if (!cell) {
        // Ideally we should seperate Across and Down
        Clue *clue = [self.clues objectAtIndex:row];
        cell = [[ProcessedClueTableViewCell alloc] initWithClue:clue];
    }
    return cell;
}
@end
