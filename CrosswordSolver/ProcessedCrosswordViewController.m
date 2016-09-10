//
//  ProcessedCrosswordViewController.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "ProcessedCrosswordViewController.h"
#import "ClueExtractorViewController.h"

@interface ProcessedCrosswordViewController ()

@property (nonatomic) CrosswordPuzzle *puzzle;
@property (nonatomic) int cellWidth;
@property (nonatomic) int cellHeight;
@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) NSMutableArray *pickerData;

@property (nonatomic) UITextView *activeTextView;
@property (nonatomic) UIToolbar *toolBar;

@end

@implementation ProcessedCrosswordViewController

- (id)initWithCrossword:(CrosswordPuzzle *)puzzle {
    self = [super init];
    if (self) {
        _puzzle = puzzle;
        [puzzle printCrossword];
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
        [_pickerView setDataSource: self];
        [_pickerView setDelegate: self];
        _pickerView.showsSelectionIndicator = YES;
        _pickerData = [NSMutableArray array];
        for (int i = 1; i < 100; i++) {
            [_pickerData addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        [_toolBar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self
                                                                         action:@selector(doneEditing:)];
        barButtonDone.tintColor=[UIColor blackColor];
        _toolBar.items = @[barButtonDone];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Display the puzzle as a nice picture
    self.view.backgroundColor = [UIColor blackColor];
    int rows = self.puzzle.rows;
    int cols = self.puzzle.columns;
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    
    // Have 1 offset for the black to appear as a line.
    // Each cell needs offset from two sides
    int navHeight = self.navigationController.navigationBar.frame.size.height;
    self.cellWidth = screenWidth/cols;
    self.cellHeight = (screenHeight-(2*navHeight))/rows;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            // Move everything by 1 offset to use the black background as a line.
            // Offset by navHeight as well.
            CGRect rect = CGRectMake(j*self.cellWidth + 1,
                                     i*self.cellHeight+1+navHeight,
                                     self.cellWidth-2,
                                     self.cellHeight-2);
            if ([self.puzzle isGridBlackAtRow:i col:j]) {
                UIView *randomView = [[UIView alloc] initWithFrame:rect];
                randomView.backgroundColor = [UIColor blackColor];
                [self.view addSubview:randomView];
//                NSLog(@"Grid at %d, %d is black", i, j);
            } else if ([self.puzzle isGridEmptyAtRow:i col:j]) {
                UIView *randomView = [[UIView alloc] initWithFrame:rect];
                randomView.backgroundColor = [UIColor whiteColor];
                [self.view addSubview:randomView];
//                NSLog(@"Grid at %d, %d is white", i, j);
            } else {
                int value = [self.puzzle valueAtRow:i col:j];
                UITextView *textView = [[UITextView alloc] initWithFrame:rect];
                textView.backgroundColor = [UIColor whiteColor];
                textView.textColor = [UIColor blackColor];
                textView.font = [UIFont boldSystemFontOfSize:6.5];
                textView.text = [NSString stringWithFormat:@"%d", value];
                textView.delegate = self;
//                NSLog(@"Screen width %d, font size %@",screenWidth, textView.font);
//                NSLog(@"Grid at %d, %d is has vlaue %@", i, j, textView.text);
//                [textView addTarget:self
//                             action:@selector(textViewChanged:)
//                   forControlEvents:UIControlEventEditingChanged];
                textView.inputView = self.pickerView;
                textView.inputAccessoryView = self.toolBar;
                [self.view addSubview:textView];
            }
        }
        UIButton *proceedButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [proceedButton addTarget:self
                   action:@selector(getClues)
         forControlEvents:UIControlEventTouchUpInside];
        [proceedButton setTitle:@"Proceed" forState:UIControlStateNormal];
        proceedButton.frame = CGRectMake(screenWidth/4, screenHeight - navHeight, screenWidth/2, navHeight);
        proceedButton.backgroundColor = [UIColor redColor];
        [self.view addSubview:proceedButton];
        [self.view bringSubviewToFront:proceedButton];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.pickerView setHidden:NO];
    self.activeTextView = textView;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    CGRect viewFrame = [textView frame];
    //    j*self.cellWidth + 1,
    //    i*self.cellHeight+1+navHeight,
    int navHeight = self.navigationController.navigationBar.frame.size.height;
    int j = (viewFrame.origin.x-1)/self.cellWidth;
    int i = (viewFrame.origin.y-1-navHeight)/self.cellWidth;
    int value = [textView.text intValue];
    [self.puzzle markGridAtRow:i col:j withNum:value];
}

- (void)getClues {
    ClueExtractorViewController *clueExtractor = [[ClueExtractorViewController alloc] initWithPuzzle:self.puzzle forDirection:ClueAcross];
    [self.navigationController pushViewController:clueExtractor animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UIPickerView delegate callbacks

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    NSString *selectedNumber = self.pickerData[row];
    [self.activeTextView setText:selectedNumber];
//    [self.pickerView setHidden:YES];
}

- (void)doneEditing:(id)sender {
    [[self view] endEditing:YES];
}

@end
