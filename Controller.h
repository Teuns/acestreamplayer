//
//  copyright.m
//  acestreamplayer
//
//  Created by Teun Strik on 24-12-18.
//

#import <Cocoa/Cocoa.h>
#import <VLCKit/VLCKit.h>

VLCVideoView * videoView;
VLCMediaPlayer *player;

@interface Controller : NSObject
{
    IBOutlet id window;
    IBOutlet id videoHolderView;
    int mediaIndex;
}

@property (nonatomic, retain) IBOutlet NSTextField* idTextField;

- (void)play:(id)sender;
- (void)pause:(id)sender;
@end
