//
//  copyright.m
//  acestreamplayer
//
//  Created by Teun Strik on 24-12-18.
//

#import "Controller.h"
#import "Download.h"
#import "Stream.h"

@implementation Controller

- (void)awakeFromNib
{
    [NSApp setDelegate:self];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *directory = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"acestreamplayer-files"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"Failed to create directory \"%@\". Error: %@", directory, error);
    }
    
    NSRect rect = NSMakeRect(0, 0, 0, 0);
    rect.size = [videoHolderView frame].size;
    
    videoView = [[VLCVideoView alloc] initWithFrame:rect];
    [videoHolderView addSubview:videoView];
    
    [videoView setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
    videoView.fillScreen = YES;
    
    player = [[VLCMediaPlayer alloc] initWithVideoView:videoView];
    
    [Download dependencies];
}

- (void)fullscreen:(id)sender {
    if (!([window styleMask] & NSWindowStyleMaskFullScreen)) {
        [window toggleFullScreen:true];
    }else{
        [window toggleFullScreen:false];
    }
}

- (void)play:(id)sender
{
    NSString *streamID = [_idTextField stringValue];
    
    [Stream startStream:streamID];
    
    [_idTextField setStringValue:@""];
}

- (void)pause:(id)sender
{
    [player pause];
}

@end
