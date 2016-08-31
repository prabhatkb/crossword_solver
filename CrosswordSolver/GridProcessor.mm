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

- (void)processPuzzle {
    [self findAllLines];
}

- (void)findAllLines {
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
    HoughLinesP(dst, lines, 1, CV_PI/180, 50, 50, screenWidth/2 );
    
    int maxLength = 0;
    for( size_t i = 0; i < lines.size(); i++ ) {
        int length = [self lengthOfLine:lines[i]];
        NSLog(@"Line Length is %d", length);
        if (length > maxLength) {
            maxLength = length;
        }
    }
    
    NSLog(@"Max Length is %d", maxLength);
    
    for( size_t i = 0; i < lines.size(); i++ ) {
        int slope = [self slopeOfLine:lines[i]];
        int length = [self lengthOfLine:lines[i]];
        if ((slope == 0 && length > maxLength/2) ||
            (slope == INT_MAX && length > (3*maxLength/4))) {
            filteredLines.push_back(lines[i]);
        }
    }

    for( size_t i = 0; i < filteredLines.size(); i++ )
    {
        Vec4i l = filteredLines[i];
        line( tempDst, cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), Scalar(0,0,255), 3, CV_AA);
    }

    self.cdst = tempDst;
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
