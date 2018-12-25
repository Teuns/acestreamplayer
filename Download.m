//
//  Download.m
//  acestreamplayer
//
//  Created by Teun Strik on 24-12-18.
//

#import <Foundation/Foundation.h>
#import "Download.h"
#import "Stream.h"

@implementation download

+ (void)dependencies {
    NSTask *task = [[NSTask alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    NSString *directory = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"acestreamplayer-files"];
    
    NSString *winehqPath = [NSString stringWithFormat:@"%@/%@", directory, @"portable-winehq-staging-4.0-rc3-osx64.tar.gz"];
    
    if (![fileManager fileExistsAtPath:winehqPath]){
        NSLog(@"Downloading Wine");
    
        NSString *stringURL = @"https://dl.winehq.org/wine-builds/macosx/pool/portable-winehq-staging-4.0-rc3-osx64.tar.gz";
        NSURL  *url = [NSURL URLWithString:stringURL];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if (urlData)
        {
            [urlData writeToFile:winehqPath atomically:YES];
            NSLog(@"Downloading succeed");
        }
        
        NSFileManager *fileManager= [NSFileManager defaultManager];
        NSError *error = nil;
        if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Failed to create directory \"%@\". Error: %@", directory, error);
        }
    
        [task setLaunchPath: @"/usr/bin/tar"];
        [task setArguments:
         [NSArray arrayWithObjects: @"-zxvf", winehqPath, @"--directory", directory, nil]];
        [task launch];
        [task waitUntilExit];
        if (0 != [task terminationStatus])
            NSLog(@"Extracting failed.");
        
        [task release];
    }
    
    NSTask *task2 = [[NSTask alloc] init];
    NSString *enginePath = [NSString stringWithFormat:@"%@/%@", directory, @"engine.zip"];
    NSString *stringURL = @"https://files.teunstrik.com/engine.zip";
    NSURL  *url = [NSURL URLWithString:stringURL];
   
    if (![fileManager fileExistsAtPath:enginePath]){
        NSLog(@"Downloading engine.zip");
        
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        if (urlData)
        {
            [urlData writeToFile:enginePath atomically:YES];
            NSLog(@"Downloading succeed");
        }
        
        [task2 setLaunchPath: @"/usr/bin/unzip"];
        [task2 setArguments:
         [NSArray arrayWithObjects: @"-a", enginePath, @"-d", directory, nil]];
        [task2 launch];
        [task2 waitUntilExit];
        if (0 != [task terminationStatus])
            NSLog(@"Extracting failed.");
        [task2 release];
        
        NSLog(@"Done extracting all required files");
    }
    
    [Stream startWine];
}

@end
