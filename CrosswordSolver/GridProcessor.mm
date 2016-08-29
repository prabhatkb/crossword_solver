//
//  GridProcessor.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/28/16.
//  Copyright (c) 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "GridProcessor.h"

using namespace cv;

@interface GridProcessor ()

@property (nonatomic) Mat sudoku;
@property (nonatomic) Mat kernel;

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

- (void)processPuzzle {
//    self.sudoku = [self cvMatFromUIImage:[UIImage imageNamed:_puzzleImageName]];
    self.sudoku = imread("/Users/prabhatkiran/Desktop/CrosswordSolver/crossword_grid.png", 0);
    
    Mat outerBox = Mat(self.sudoku.size(), CV_8UC1);
    GaussianBlur(self.sudoku, self.sudoku, cv::Size(11,11), 0);
    
    adaptiveThreshold(self.sudoku, outerBox, 255, ADAPTIVE_THRESH_MEAN_C, THRESH_BINARY, 5, 2);
    
    bitwise_not(outerBox, outerBox);
    
    self.kernel = (Mat_<uchar>(3,3) << 0,1,0,1,1,1,0,1,0); dilate(outerBox, outerBox, self.kernel);
}

- (UIImage *)processedImage {
    return [self UIImageFromCVMat:self.sudoku];
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
