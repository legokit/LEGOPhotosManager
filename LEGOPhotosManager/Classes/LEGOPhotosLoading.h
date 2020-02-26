//
//  LEGOPhotosLoading.h
//  LEGOPhotosManager_Example
//
//  Created by 杨庆人 on 2020/2/10.
//  Copyright © 2020 564008993@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEGOPhotosLoading : UIView

@property (nonatomic, copy, readwrite) NSString *progress;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
