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
#import <TesseractOCR/TesseractOCR.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *rootViewController = [[UIViewController alloc] init];
    UIImage *initialImage = [UIImage imageNamed:@"crossword_grid.png"];
    UIImageView *initialImageView = [[UIImageView alloc] initWithImage:initialImage];
    [rootViewController.view addSubview:initialImageView];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.navigationBarHidden = YES;
    
    self.window.rootViewController = navigationController;
    
//    GridProcessor *gridProcessor = [[GridProcessor alloc] initWithImageNamed:@"crossword_grid.png"];
//    [gridProcessor processPuzzle];
//    UIImage *processedImage = [gridProcessor processedImage];
//    UIImageView *processedImageView = [[UIImageView alloc] initWithImage:processedImage];
//
//    UIViewController *newViewController = [[UIViewController alloc] init];
//    [newViewController.view addSubview:processedImageView];
    
//    [navigationController pushViewController:newViewController animated:YES];
//    DigitExtractor *digitExtractor = [[DigitExtractor alloc] init];
//    G8Tesseract *tesseract = [digitExtractor testExtractingImage];
//    
//    // You could retrieve more information about recognized text with that methods:
//    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
//    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
//    NSArray *characterChoices = tesseract.characterChoices;
//    UIImage *imageWithBlocks = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
//    
//    NSLog(@"Character Boxes : %@", characterBoxes);
//    NSLog(@"Paragraphs : %@", paragraphs);
//    NSLog(@"Character Choices : %@", characterChoices);
    
//    UIImageView *processedImageView = [[UIImageView alloc] initWithImage:imageWithBlocks];
    
//    UIViewController *newViewController = [[UIViewController alloc] init];
//    [newViewController.view addSubview:processedImageView];
//    
//    [navigationController pushViewController:newViewController animated:YES];
    
    ClueExtractor *clueExtractor = [[ClueExtractor alloc] init];
    [clueExtractor processClues];
    
    return YES;
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
