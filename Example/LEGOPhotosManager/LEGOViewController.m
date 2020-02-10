//
//  LEGOViewController.m
//  LEGOPhotosManager
//
//  Created by 564008993@qq.com on 02/10/2020.
//  Copyright (c) 2020 564008993@qq.com. All rights reserved.
//

#import "LEGOViewController.h"
#import <LEGOPhotosManager/LEGOPhotosManager.h>
@interface LEGOViewController ()

@end

@implementation LEGOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //    ### Get album list.  获取相册列表
    //    ```
    //    /** Get all album lists 获取所有相册列表 */
    //      NSMutableArray <PHAssetCollection *> *collections = [LEGOPhotosManager systemAssetCollection];
    //
    //    /** Get a list of all photos 获取所有照片列表*/
    //      NSMutableArray <PHAsset *> *assets = [LEGOPhotosManager systemAssetsByAssetCollection:collections.firstObject];
    //
    //    /** Get a list of photos exclusive to the current app 获取当前应用专属照片列表*/
    //      NSMutableArray <PHAsset *> *assets = [LEGOPhotosManager getCameraAssets];
    //    ```
    //    ### Save photos.  保存照片  Delete photos.  删除照片
    //    ```
    //    /** Save imagedata to system album 将 imageData 保存到系统相册*/
    //      [LEGOPhotosManager savePhotoToAssetByImage:image date:[NSDate date] location:currLocation completion:^(BOOL success, NSError * _Nonnull error) {
    //
    //      }];
    //    /** Save image to system album 将 image 保存到系统相册*/
    //      [LEGOPhotosManager savePhotoToAssetByImageData:imageData date:[NSDate date] location:currLocation completion:^(BOOL success, NSError * _Nonnull error) {
    //
    //      }];
    //    /** Delete from system album by assets 通过 assets 从系统相册删除*/
    //      [LEGOPhotosManager delePhotoAssets:@[asset] completion:^(BOOL success) {
    //
    //      }];
    //    /** Delete from system album by assetsID 通过 assetsID 从系统相册删除*/
    //      [LEGOPhotosManager delePhotoAssetsIdentitys:@[assetID] completion:^(BOOL success) {
    //
    //      }];
    //    ```
    //    ### Get photos by iCloud.  通过 iCloud 获取照片
    //    ```
    //    /** Get thumbnails image by asset 通过 asset 获取缩略图*/
    //       [LEGOPhotosManager getThumbnailImageByAsset:asset targetSize:CGSizeMake(200, 300) completion:^(UIImage * _Nonnull thumbnailImage, PHImageRequestID requestID, BOOL isInCloud) {
    //
    //       }];
    //    /** Get originalImage by asset 通过 asset 获取原图*/
    //       [LEGOPhotosManager getOriginalImageByAsset:asset completion:^(UIImage * _Nonnull originalImage, PHImageRequestID requestID) {
    //
    //       }];
    //    /** Get originalImage by asset, param Progress 通过 asset 获取原图，带进度条*/
    //      [LEGOPhotosManager getOriginalImageByAsset:asset progressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
    //
    //       } completion:^(UIImage * _Nonnull originalImage, PHImageRequestID requestID) {
    //
    //       }];
    //    /** Get imageData by asset 通过 asset 获取原图 imageData*/
    //      [LEGOPhotosManager getOriginalImageByAsset:asset completionData:^(NSData * _Nonnull originalImageData, PHImageRequestID requestID) {
    //
    //       }];
    //    /** Get imageData by asset, param Progress 通过 asset 获取原图 imageData，带进度条*/
    //       [LEGOPhotosManager getOriginalImageByAsset:asset progressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
    //
    //            } completionData:^(NSData * _Nonnull originalImageData, PHImageRequestID requestID) {
    //
    //       }];
    //    ```
    //
    //    ### Cancel photo request.  取消照片请求
    //    ```
    //    /** cancel request by requestID 取消请求*/
    //      [LEGOPhotosManager cancelPHImageRequestID:PHImageRequestID];
    //    ```

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
