//
//  DigitExtractor.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/3/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "DigitExtractor.h"

@implementation DigitExtractor

- (G8Tesseract *) testExtractingImage {
    // Create your G8Tesseract object using the initWithLanguage method:
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.delegate = self;
    tesseract.charWhitelist = @"0123456789";
    UIImage *initialImage = [UIImage imageNamed:@"61.png"];
//    CGSize targetSize =
//            CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
//    UIImage *zoomedImage = [self imageByScaling:initialImage proportionallyToSize:targetSize];
//    UIImage * crossWordImage = [zoomedImage g8_blackAndWhite];
    tesseract.image = initialImage;//crossWordImage;

    tesseract.maximumRecognitionTime = 5.0;
    [tesseract recognize];
    NSLog(@"Recognized Text %@", [tesseract recognizedText]);
    return tesseract;
    
//    int imageGridWidth = crossWordImage.size.width/cols;
//    int imageGridHeight = crossWordImage.size.height/rows;
    
//    xmin = 0;
//    ymin = 0;
//    for (int i = 0; i < rows; i++) {
//        for (int j = 0; j < cols; j++) {
//            int x = i*imageGridWidth + xmin;
//            int y = j*imageGridHeight + ymin;
//            CGRect currentFrame = CGRectMake(x, y, imageGridWidth, imageGridHeight);
//            tesseract.rect = currentFrame;
//            tesseract.maximumRecognitionTime = 5.0;
//            [tesseract recognize];
//            NSLog(@"%@ at %d, %d", [tesseract recognizedText], i, j);
//        }
//    }
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
}

- (UIImage *)imageByScaling:(UIImage *)image proportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}

@end
