//
//  LEGOPhotosLoading.m
//  LEGOPhotosManager_Example
//
//  Created by 杨庆人 on 2020/2/10.
//  Copyright © 2020 564008993@qq.com. All rights reserved.
//

#import "LEGOPhotosLoading.h"
#import <Masonry/Masonry.h>

@interface LEGOPhotosLoading ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation LEGOPhotosLoading

- (instancetype)init {
    if (self = [super init]) {
        [self setSystemLoadingView];
    }
    return self;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        if (@available(iOS 13.0, *)) {
            _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        } else {
            _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            // Fallback on earlier versions
        }
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = [UIColor lightGrayColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
    }
    return _numLabel;
}

- (void)setSystemLoadingView {
    [self addSubview:self.activityIndicatorView];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
    }];
    [self addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_centerY).offset(5);
    }];
}

- (void)setProgress:(NSString *)progress {
    _progress = progress;
    self.numLabel.text = progress;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(window.mas_centerX);
        make.centerY.mas_equalTo(window.mas_centerY);
        make.size.mas_equalTo(CGSizeMake([[UIScreen mainScreen] bounds].size.width - 100, 200));
    }];
    [self.activityIndicatorView startAnimating];
}

- (void)dismiss {
    [self.activityIndicatorView stopAnimating];
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
