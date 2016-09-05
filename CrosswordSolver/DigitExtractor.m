//
//  DigitExtractor.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 9/3/16.
//  Copyright © 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "DigitExtractor.h"
#import "CrosswordPuzzle.h"

@implementation DigitExtractor

- (void) populateCrossWord:(CrosswordPuzzle *)puzzle fromImage:(NSString *)imageFilename {
    // Create your G8Tesseract object using the initWithLanguage method:
    UIImage *crossWordImage = [UIImage imageNamed:@"crossword_grid.png"];
//    CGSize targetSize =
//            CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
//    
//    UIImage *zoomedImage = [self imageByScaling:initialImage proportionallyToSize:targetSize];
//    UIImage * crossWordImage = [zoomedImage g8_blackAndWhite];
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.delegate = self;
    tesseract.charWhitelist = @"0123456789";
    tesseract.image = [crossWordImage g8_blackAndWhite];//crossWordImage;
    
    tesseract.engineMode = G8OCREngineModeTesseractOnly;
    tesseract.maximumRecognitionTime = 60.0;
    tesseract.pageSegmentationMode = G8PageSegmentationModeSingleWord;
    
    int rows = puzzle.rows;
    int cols = puzzle.columns;

    int imageGridWidth = crossWordImage.size.width/cols;
    int imageGridHeight = crossWordImage.size.height/rows;
    
    int white = 0;
    int black = 0;
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int x = j*imageGridWidth;
            int y = i*imageGridHeight;
            CGRect rect = CGRectMake(x+imageGridWidth/10.0, y+imageGridHeight/10.0, 3*imageGridWidth/4, 3*imageGridHeight/4);
            // Check if its a black image.
            // If not its either a blank or a numbered one.
            BOOL isImageBlack = [self checkIfImageIsBlack:crossWordImage inRect:rect];
            if (isImageBlack) {
                black++;
//                NSLog(@"Block at (%d, %d) is black", i, j);
                [puzzle markBlackGridAtRow:i col:j];
                continue;
            }
            
            BOOL isImageWhite = [self checkIfImageIsWhite:crossWordImage inRect:rect];
            if (isImageWhite) {
                white++;
//                NSLog(@"Block at (%d, %d) is empty", i, j);
                [puzzle markEmptyGridAtRow:i col:j];
                continue;
            }
            
            int newx = rect.origin.x;
            int newy = rect.origin.y;
            float maxConfidence = 0;
            NSString *recognizedTextWithHighestConfidence;
            for (int i = newx; i>=(newx-(imageGridWidth/10.0)); i--) {
                for (int j = newy; j>=(newy-(imageGridHeight/10.0)); j--) {
                    rect = CGRectMake(i, j, rect.size.width, rect.size.height);
                    tesseract.rect = rect;
                    [tesseract recognize];
                    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
                    if (paragraphs.count == 0) {
                        break;
                    }
                    float confidence = [(G8RecognizedBlock *)[paragraphs objectAtIndex:0] confidence];
                    NSString *tmpString = [tesseract recognizedText];
                    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\n "];
                    tmpString = [[tmpString componentsSeparatedByCharactersInSet:set] objectAtIndex:0];
                    if (confidence > maxConfidence && tmpString.length <=2) {
                        maxConfidence = confidence;
                        recognizedTextWithHighestConfidence = tmpString;
                    }
                }
            }
        
            NSString *recognizedText = recognizedTextWithHighestConfidence;
            NSLog(@"Number %@ at %d, %d with %f", recognizedText, i, j, maxConfidence);
            [puzzle markGridAtRow:i col:j withNum:[recognizedText intValue]];
        }
    }
    NSLog(@"Empty %d, Black %d", white, black);
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

- (BOOL) checkIfImageIsBlack:(UIImage *)someImage inRect:(CGRect)rect {
    CGImageRef initiaLimage = someImage.CGImage;
    CGImageRef image = CGImageCreateWithImageInRect(initiaLimage, rect);
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    GLubyte * imageData = malloc(width * height * 4);
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * width;
    int bitsPerComponent = 8;
    CGContextRef imageContext =
    CGBitmapContextCreate(
                          imageData, width, height, bitsPerComponent, bytesPerRow, CGImageGetColorSpace(image),
                          kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
                          );
    
    CGContextSetBlendMode(imageContext, kCGBlendModeCopy);
    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);
    CGContextRelease(imageContext);
    
    int byteIndex = 0;
    
    BOOL isImageBLack = YES;
    for ( ; byteIndex < width*height*4; byteIndex += 4) {
        CGFloat red = ((GLubyte *)imageData)[byteIndex]/255.0f;
        CGFloat green = ((GLubyte *)imageData)[byteIndex + 1]/255.0f;
        CGFloat blue = ((GLubyte *)imageData)[byteIndex + 2]/255.0f;
//        CGFloat alpha = ((GLubyte *)imageData)[byteIndex + 3]/255.0f;
        if( red != 0 || green != 0 || blue != 0 ){
            isImageBLack = NO;
            break;
        }
    }
    return isImageBLack;
}

- (BOOL) checkIfImageIsWhite:(UIImage *)someImage inRect:(CGRect)rect {
    CGImageRef initiaLimage = someImage.CGImage;
    CGImageRef image = CGImageCreateWithImageInRect(initiaLimage, rect);
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    GLubyte * imageData = malloc(width * height * 4);
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * width;
    int bitsPerComponent = 8;
    CGContextRef imageContext =
    CGBitmapContextCreate(
                          imageData, width, height, bitsPerComponent, bytesPerRow, CGImageGetColorSpace(image),
                          kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
                          );
    
    CGContextSetBlendMode(imageContext, kCGBlendModeCopy);
    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);
    CGContextRelease(imageContext);
    
    int byteIndex = 0;
    
    BOOL isImageWhite = YES;
    for ( ; byteIndex < width*height*4; byteIndex += 4) {
        CGFloat red = ((GLubyte *)imageData)[byteIndex]/255.0f;
        CGFloat green = ((GLubyte *)imageData)[byteIndex + 1]/255.0f;
        CGFloat blue = ((GLubyte *)imageData)[byteIndex + 2]/255.0f;
        //        CGFloat alpha = ((GLubyte *)imageData)[byteIndex + 3]/255.0f;
        if( red != 1 || green != 1 || blue != 1 ){
            isImageWhite = NO;
            break;
        }
    }
    return isImageWhite;
}

@end
