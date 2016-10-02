//
//  CameraViewController.h
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/9/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GridProcessor.h"
#import "CrosswordPuzzle.h"

// The first view controller that we show.
// Should ideally tap into the camera and get a picture for the first crossword that we should solve.

// Right now, we directly show the image that we have in the build and display a "Proceed button"
// After the button is tap, the processed grid is displayed.

@interface CameraViewController : UIViewController

@end
