//
//  Stream.m
//  acestreamplayer
//
//  Created by Teun Strik on 25-12-18.
//

#import <Foundation/Foundation.h>
#import "Stream.h"
#import "Controller.h"

@implementation stream
+ (void)startWine {
    NSTask *task = [[NSTask alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"acestreamplayer-files/engine/ace_console.exe"];
    
    NSLog(@"Starting Wine to run the Acestream engine");
    
    [task setLaunchPath: @"~/Documents/acestreamplayer-files/usr/bin/wine"];
    [task setArguments:
     [NSArray arrayWithObjects: filePath, @"--client-console", @"--log-file", @"engine.log", nil]];
    [task launch];
}

+ (void)startStream:(NSString*)value {
    if ([value length] == 0) {
        NSLog(@"Stream not playing, starting");
        [player play];
    }else{
        NSLog(@"Starting stream id %@", value);
        NSURL *acestreamurl = [NSURL URLWithString:@"http://127.0.0.1:6878/ace/getstream?id="];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", acestreamurl, value]];
    
        NSLog(@"%@", url);
    
        VLCMedia *movie = [VLCMedia mediaWithURL:url];
        [player setMedia:movie];
        [player play];
    }
}

@end
