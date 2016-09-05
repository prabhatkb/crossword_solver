//
//  GridProcessor.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/28/16.
//  Copyright (c) 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CrosswordPuzzle;

@interface GridProcessor : NSObject

- (GridProcessor *)initWithImageNamed:(NSString *)imageName;
- (CrosswordPuzzle *)processPuzzle;

- (UIImage *)processedImage;

@property (nonatomic, strong) NSString *puzzleImageName;

@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;
@property (nonatomic, assign) int grids;

@property (nonatomic, assign) int xmax;
@property (nonatomic, assign) int ymax;
@property (nonatomic, assign) int xmin;
@property (nonatomic, assign) int ymin;

@end
