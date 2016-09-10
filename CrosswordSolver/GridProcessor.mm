//
//  GridProcessor.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/28/16.
//  Copyright (c) 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "GridProcessor.h"
#import "CrosswordPuzzle.h"

using namespace cv;

#define THICKNESS_THRESHOLD 5

@interface GridProcessor ()

@property (nonatomic) Mat cdst;

@end

@implementation GridProcessor

- (GridProcessor *)initWithImageNamed:(NSString *)imageName {
    self = [super init];
    if (self) {
        // Let's hard code it for now!
        // What the hell, its taking a C String.
        _puzzleImageName = @"crossword_grid.png";
    }
    return self;
}

- (CrosswordPuzzle *)processPuzzle {
    Mat gray = imread("/Users/prabhatkiran/Desktop/CrosswordSolver/crossword_grid.png", 0);
    if(gray.empty()) {
        NSLog(@"The image could not be loaded into memory");
    }

    Mat dst, tempDst;
    Canny(gray, dst, 50, 200, 3);
    cvtColor(dst, tempDst, CV_GRAY2BGR);
    
    int screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    int screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    vector<Vec4i> lines;
    vector<Vec4i> filteredLines;
    // Since screenWidth in points is used as pixels
    HoughLinesP(dst, lines, 1, CV_PI/2, 50, 50, screenWidth/2 );
    
    int maxLength = 0;
    for( size_t i = 0; i < lines.size(); i++ ) {
        int length = [self lengthOfLine:lines[i]];
//        NSLog(@"Line Length is %d", length);
        if (length > maxLength) {
            maxLength = length;
        }
    }
    
//    NSLog(@"Max Length is %d", maxLength);
    
    for( size_t i = 0; i < lines.size(); i++ ) {
        int slope = [self slopeOfLine:lines[i]];
        int length = [self lengthOfLine:lines[i]];
        if ((slope == 0 && length > maxLength/2) ||
            (slope == INT_MAX && length > (maxLength - 5))) {
            filteredLines.push_back(lines[i]);
        }
    }

//    NSLog(@"Original Number of lines %lu", lines.size());
//    NSLog(@"Number of lines %lu", filteredLines.size());
    
    // Remove the thick ones.
    vector<Vec4i> filterThickLines;
    for( size_t i = 0; i < filteredLines.size(); i++ ) {
        Vec4i currentLine = filteredLines[i];
        BOOL shouldAddLine = YES;
        for( size_t j = 0; j < filterThickLines.size(); j++ ) {
            // If none of the filtered lines are at close proximity then add it.
            if ([self slopeOfLine:currentLine] == [self slopeOfLine:filterThickLines[j]]) {
                if ([self slopeOfLine:currentLine] == 0) {
                    // Get the difference between their y-co-ordinates
                    int y1 = currentLine[1];
                    int y2 = filterThickLines[j][1];
                    int thickness = y2 - y1;
                    if (abs(thickness) < THICKNESS_THRESHOLD) {
                        shouldAddLine = NO;
                    }
                } else if ([self slopeOfLine:currentLine] == INT_MAX) {
                    // Get the difference between their x-co-ordinates
                    int x1 = currentLine[0];
                    int x2 = filterThickLines[j][0];
                    int thickness = x2 - x1;
                    if (abs(thickness) < THICKNESS_THRESHOLD) {
                        shouldAddLine = NO;
                    }
                }
            }
        }
        if (shouldAddLine) {
            filterThickLines.push_back(currentLine);
        }
    }
    
//    NSLog(@"Number of lines after thickness filter %lu", filterThickLines.size());
    
    for( size_t i = 0; i < filterThickLines.size(); i++ ) {
        Vec4i l = filterThickLines[i];
//        NSLog(@"Line from (%d, %d) to (%d, %d)", l[i][0], l[i][1], l[i][2], l[i][3]);
        line( tempDst, cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), Scalar(0,0,255), 3, CV_AA);
    }
    
    // Calculate grid length.
    int gridLength = INT_MAX;
    for( size_t i = 0; i < filterThickLines.size(); i++ ) {
        for( size_t j = i+1; j < filterThickLines.size(); j++ ) {
            Vec4i line1 = filterThickLines[i];
            Vec4i line2 = filterThickLines[j];
            if ([self slopeOfLine:line1] == 0 &&
                [self slopeOfLine:line2] == 0) {
                int y1 = line1[1];
                int y2 = line2[1];
                int calculatedGridLength = abs(y2 - y1);
                if (calculatedGridLength< gridLength) {
                    gridLength = calculatedGridLength;
                }
            }
        }
    }
    
    int rows = maxLength/gridLength;
    int cols = maxLength/gridLength;
    
//    NSLog(@"Rows: %d, Cols: %d", rows, cols);

    self.xmin = INT_MAX/4;
    self.ymin = INT_MAX/4;
    self.xmax = 0;
    self.ymax = 0;
    for( size_t i = 0; i < filterThickLines.size(); i++ ) {
        Vec4i line = filterThickLines[i];
        int x1 = line[0];
        int y1 = line[1];
        int x2 = line[2];
        int y2 = line[3];
        if (x1 + y1 < self.xmin + self.ymin) {
            self.xmin = x1;
            self.ymin = y1;
        }
        if (x2 + y2 < self.xmin + self.ymin) {
            self.xmin = x2;
            self.ymin = y2;
        }
        if (x1 + y1 > self.xmax + self.ymax) {
            self.xmax = x1;
            self.ymax = y1;
        }
        if (x2 + y2 > self.xmax + self.ymax) {
            self.xmax = x2;
            self.ymax = y2;
        }
    }

    self.cdst = tempDst;
    CrosswordPuzzle *puzzle = [[CrosswordPuzzle alloc] initWithRows:rows columns:cols];
    return puzzle;
}

- (int)slopeOfLine:(Vec4i) line {
    int x1 = line[0];
    int y1 = line[1];
    int x2 = line[2];
    int y2 = line[3];
    if (y2 == y1) return 0;
    if (x2 == x1) return INT_MAX;
    return (y2-y1)/(x2-x1);
}

- (int)lengthOfLine:(Vec4i) line {
    int x1 = line[0];
    int y1 = line[1];
    int x2 = line[2];
    int y2 = line[3];
    
    int y = (y2-y1) * (y2-y1);
    int x = (x2-x1) * (x2-x1);
    return sqrt(x + y);
}

+ (CGFloat)pixelToPoints:(CGFloat)px {
    CGFloat pointsPerInch = 72.0; // see: http://en.wikipedia.org/wiki/Point%5Fsize#Current%5FDTP%5Fpoint%5Fsystem
    CGFloat scale = 1; // We dont't use [[UIScreen mainScreen] scale] as we don't want the native pixel, we want pixels for UIFont - it does the retina scaling for us
    float pixelPerInch; // aka dpi
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        pixelPerInch = 132 * scale;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        pixelPerInch = 163 * scale;
    } else {
        pixelPerInch = 160 * scale;
    }
    CGFloat result = px * pointsPerInch / pixelPerInch;
    return result;
}

- (UIImage *)processedImage {
    getchar();
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGSize screenSize = CGSizeMake(screenRect.size.width, screenRect.size.height);
    return [self image:[self UIImageFromCVMat:self.cdst] scaledToSize:screenSize];
}

- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

-(UIImage *)UIImageFromCVMat:(Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;

    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

@end
