//
//  AppDelegate.m
//  CrosswordSolver
//
//  Created by Prabhat Kiran on 8/28/16.
//  Copyright (c) 2016 ___PrabhatKiranBharathidhasan___. All rights reserved.
//

#import "AppDelegate.h"
#import "GridProcessor.h"
#import "DigitExtractor.h"
#import "ClueExtractor.h"
#import "CrosswordPuzzle.h"
#import <TesseractOCR/TesseractOCR.h>
#import "CameraViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    CameraViewController *cameraViewController = [[CameraViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cameraViewController];
    navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;
    
//    GridProcessor *gridProcessor = [[GridProcessor alloc] initWithImageNamed:imageFilename];
//    CrosswordPuzzle *puzzle = [gridProcessor processPuzzle];
//    DigitExtractor *digitExtractor = [[DigitExtractor alloc] init];
//    [digitExtractor populateCrossWord:puzzle fromImage:imageFilename];
    
//    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
//    NSLog(@"%@", characterBoxes);
//    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
//    NSLog(@"%@", paragraphs);
//    NSArray *characterChoices = tesseract.characterChoices;
//    NSLog(@"%@", characterChoices);
//    UIImage *imageWithBlocks = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
    
//    [puzzle printCrossword];
    
//    UIImageView *processedImageView = [[UIImageView alloc] initWithImage:imageWithBlocks];
//    
//    UIViewController *newViewController = [[UIViewController alloc] init];
//    [newViewController.view addSubview:processedImageView];
//    
//    [navigationController pushViewController:newViewController animated:YES];
    
//    ClueExtractor *clueExtractor = [[ClueExtractor alloc] init];
//    [clueExtractor processClues];
    
    return YES;
}

- (void)pushCalculatedCrosswordGrid {
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
