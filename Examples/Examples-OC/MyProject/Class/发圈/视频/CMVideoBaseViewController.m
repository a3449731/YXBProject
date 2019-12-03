//
//  CMVideoViewController.m
//  MyProject
//
//  Created by ShengChang on 2019/11/17.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMVideoBaseViewController.h"
#import "UIView+Alert.h"
#import <PLPlayerKit/PLPlayerKit.h>

@interface CMVideoBaseViewController () <PLPlayerDelegate>

@property (nonatomic, strong) PLPlayer *player;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, assign) BOOL isDisapper;

@end

@implementation CMVideoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBaseUI];
    [self setupBaseTool];
    [self setupBaseData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isDisapper = NO;
    [self play];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.isDisapper = YES;
    [super viewDidDisappear:animated];
    [self resume];
}

- (void)playerWillBeginBackgroundTask:(PLPlayer *)player {
    [self resume];
}

- (void)playerWillEndBackgroundTask:(PLPlayer *)player {
    [self play];
}


- (void)setupBaseUI {
    [self creatPlayButton];
    [self creatThumbView];
    [self creatPlayer];
}

- (void)setupBaseTool {
    // 设置可以后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (void)setupBaseData {
    
}

#pragma mark ---------- 暂停播放按钮 + 手势 ---------------
- (void)creatPlayButton {
    self.playButton = [[UIButton alloc] init];
    self.playButton.hidden = YES;
    [self.playButton addTarget:self action:@selector(clickPlayButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.playButton setImage:[UIImage imageNamed:@"fq_jubao"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.center.mas_equalTo(self.view);
    }];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap ];
}

- (void)clickPlayButton:(UIButton *)button {
    [self.player resume];
}

- (void)singleTapAction:(UIGestureRecognizer *)gesture {
    if ([self.player isPlaying]) {
        [self.player pause];
    } else {
        [self.player resume];
    }
}

#pragma mark --------- 封面图 ------------
- (void)creatThumbView {
    self.thumbImageView = [[UIImageView alloc] init];
    self.thumbImageView.image = [UIImage imageNamed:@"fq_pyq"];
    self.thumbImageView.clipsToBounds = YES;
    self.thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.thumbImageView];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark ------------ 播放器 -----------
- (void)creatPlayer {
    NSLog(@"播放地址: %@", self.media.videoUrl);
    
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    PLPlayFormat format = kPLPLAY_FORMAT_UnKnown;
    NSString *urlString = self.media.videoUrl.lowercaseString;
    if ([urlString hasSuffix:@"mp4"]) {
        format = kPLPLAY_FORMAT_MP4;
    } else if ([urlString hasPrefix:@"rtmp:"]) {
        format = kPLPLAY_FORMAT_FLV;
    } else if ([urlString hasSuffix:@".mp3"]) {
        format = kPLPLAY_FORMAT_MP3;
    } else if ([urlString hasSuffix:@".m3u8"]) {
        format = kPLPLAY_FORMAT_M3U8;
    }
    [option setOptionValue:@(format) forKey:PLPlayerOptionKeyVideoPreferFormat];
    [option setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];
    
    self.player = [PLPlayer playerWithURL:[NSURL URLWithString:self.media.videoUrl] option:option];
    [self.view insertSubview:self.player.playerView atIndex:0];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.player.delegateQueue = dispatch_get_main_queue();
    self.player.playerView.contentMode = UIViewContentModeScaleAspectFit;
    self.player.delegate = self;
    self.player.loopPlay = YES;
    // 音量给太大，可能会出现较强噪音
    [self.player setVolume:0.8];
}

- (void)play {
    if (![self.player isPlaying]) {
        [self.player play];
    }
}

- (void)resume {
    if ([self.player isPlaying]) {
        [self.player resume];
    }
}

- (void)stop {
    [self.player stop];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

#pragma mark --------- 告知代理对象播放器状态变更 ------------
- (void)player:(PLPlayer *)player statusDidChange:(PLPlayerStatus)state
{
    if (self.isDisapper) {
        [self stop];
        [self hideWaiting];
        return;
    }
    
    if (state == PLPlayerStatusPlaying ||
        state == PLPlayerStatusPaused ||
        state == PLPlayerStatusStopped ||
        state == PLPlayerStatusError ||
        state == PLPlayerStatusUnknow ||
        state == PLPlayerStatusCompleted) {
        [self hideWaiting];
    } else if (state == PLPlayerStatusPreparing ||
               state == PLPlayerStatusReady ||
               state == PLPlayerStatusCaching) {
        [self showWaiting];
    } else if (state == PLPlayerStateAutoReconnecting) {
        [self showWaiting];
    }
}

- (void)showWaiting {
    self.playButton.hidden = YES;
    [self.view showFullLoading];
//    [self.view bringSubviewToFront:self.closeButton];
}

- (void)hideWaiting {
    [self.view hideFullLoading];
    if (PLPlayerStatusPlaying != self.player.status) {
        self.playButton.hidden = NO;
    }
}

#pragma mark ------ 音视频渲染首帧回调通知 ---------------
- (void)player:(nonnull PLPlayer *)player firstRender:(PLPlayerFirstRenderType)firstRenderType {
    if (PLPlayerFirstRenderTypeVideo == firstRenderType) {
        self.thumbImageView.hidden = YES;
    }
}

- (AudioBufferList *)player:(PLPlayer *)player willAudioRenderBuffer:(AudioBufferList *)audioBufferList asbd:(AudioStreamBasicDescription)audioStreamDescription pts:(int64_t)pts sampleFormat:(PLPlayerAVSampleFormat)sampleFormat{
    return audioBufferList;
}

- (void)player:(nonnull PLPlayer *)player willRenderFrame:(nullable CVPixelBufferRef)frame pts:(int64_t)pts sarNumerator:(int)sarNumerator sarDenominator:(int)sarDenominator {
    dispatch_main_async_safe(^{
        if (![UIApplication sharedApplication].isIdleTimerDisabled) {
            [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        }
    });
}
//
//- (void)player:(nonnull PLPlayer *)player SEIData:(nullable NSData *)SEIData {
//
//}
//
//- (void)player:(PLPlayer *)player codecError:(NSError *)error {
//
//    NSString *info = error.userInfo[@"NSLocalizedDescription"];
//    [self.view showTip:info];
//
//    [self hideWaiting];
//}
//
//- (void)player:(PLPlayer *)player loadedTimeRange:(CMTimeRange)timeRange {}

@end
