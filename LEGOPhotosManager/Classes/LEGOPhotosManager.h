//
//  LEGOPhotosManager.h
//  LEGOPhotosManager_Example
//
//  Created by 杨庆人 on 2020/2/10.
//  Copyright © 2020 564008993@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface LEGOPhotosManager : NSObject

NS_ASSUME_NONNULL_BEGIN

/** Get all album lists 获取所有相册列表 */
+ (NSMutableArray <PHAssetCollection *> *)systemAssetCollection;

/** Get a list of all photos 获取所有照片列表*/
+ (NSMutableArray <PHAsset *> *)systemAssetsByAssetCollection:(PHAssetCollection *)assetCollection;

/** Get a list of all video 获取所有视频列表*/
+ (NSMutableArray <PHAsset *> *)systemAssetsVideoByAssetCollection:(PHAssetCollection *)assetCollection;

/** Get a list of all video 获取所有视频、照片列表*/
+ (NSMutableArray <PHAsset *> *)systemAssetsVideoAndPhotoByAssetCollection:(PHAssetCollection *)assetCollection;

/** Get a list of photos exclusive to the current app 获取当前应用专属照片列表*/
+ (NSMutableArray <PHAsset *> *)getCameraAssets;

/** Get a list of photos exclusive to the current app 获取当前应用专属照片/视频列表*/
+ (NSMutableArray <PHAsset *> *)getPhotoAndVideoAssets;

/** Save imagedata to system App album 将 imageData 保存到系统App相册*/
+ (void)savePhotoToAssetByImageData:(NSData *)imageData date:(NSDate *)date location:(CLLocation *)location completion:(void(^)(BOOL success, NSError *error))completion;

/** Save image to system App album 将 image 保存到系统App相册*/
+ (void)savePhotoToAssetByImage:(UIImage *)image date:(NSDate *)date location:(CLLocation *)location completion:(void(^)(BOOL success, NSError *error))completion;

/** Save video to system App album 将 video 保存到系统App相册*/
+ (void)saveVideoToAssetByFileUrl:(NSURL *)fileUrl date:(NSDate *)date location:(CLLocation *)location completion:(void(^)(BOOL success, NSError *error))completion;
    
/** Save image to system  album 将 imageData 保存到系统最新使用相册*/
+ (void)saveImageDataToSystemAssetCollectionWithImageData:(NSData *)imageData date:(NSDate *)date location:(CLLocation *)location completion:(void (^)(BOOL success, NSError *error))completion;

/** Save image to system  album 将 image 保存到系统最新使用相册*/
+ (void)saveImageDataToSystemAssetCollectionWithImage:(UIImage *)image date:(NSDate *)date location:(CLLocation *)location completion:(void (^)(BOOL success, NSError *error))completion;

/** Delete from system album by assets 通过 assets 从系统相册删除*/
+ (void)delePhotoAssets:(NSArray <PHAsset * >*)assets completion:(void (^)(BOOL success))completion;

/** Delete from system album by assetsID 通过 assetsID 从系统相册删除*/
+ (void)delePhotoAssetsIdentitys:(NSArray <NSString *> *)assetsIdentitys completion:(void (^)(BOOL success))completion;


/** Get thumbnails image by asset 通过 asset 获取缩略图*/
+ (PHImageRequestID)getThumbnailImageByAsset:(PHAsset *)asset targetSize:(CGSize)targetSize completion:(void (^)(UIImage *thumbnailImage, PHImageRequestID requestID, BOOL isInCloud))completion;



/** Get originalImage by asset, param Progress 通过 asset 获取原图，带进度条*/
+ (PHImageRequestID)getOriginalImageByAsset:(PHAsset *)asset progressHandler:(PHAssetImageProgressHandler)progressHandler completion:(void (^__nullable)(UIImage *originalImage, PHImageRequestID requestID))completion;

/** Get thumbnails image by asset 通过 asset 获取缩略图*/
+ (PHImageRequestID)getThumbnailVideoByAsset:(PHAsset *)asset targetSize:(CGSize)targetSize completion:(void (^)(UIImage *thumbnailImage, PHImageRequestID requestID, BOOL isInCloud))completion;

/** Get imageData by asset, param Progress 通过 asset 获取原图 imageData，带进度条*/
+ (PHImageRequestID)getOriginalImageByAsset:(PHAsset *)asset progressHandler:(PHAssetImageProgressHandler)progressHandler completionData:(void (^)(NSData *originalImageData, PHImageRequestID requestID))completionData;

/** Get image and imageData by asset, and imageData 通过 asset 获取原图和原图 imageData*/
+ (void)getOriginalImageByAsset:(PHAsset *)asset PHImageRequestIDs:(void(^__nullable)(NSArray <NSNumber *> *PHImageRequestIDs))PHImageRequestIDs imageProgressHandler:(PHAssetImageProgressHandler)imageProgressHandler completionImage:(void (^ __nullable)(UIImage *originalImage, PHImageRequestID requestID))completionImage imageDataProgressHandler:(PHAssetImageProgressHandler)imageDataProgressHandler completionData:(void (^)(NSData *originalImageData, PHImageRequestID requestID))completionData;

/** cancel request by requestID 取消请求*/
+ (void)cancelPHImageRequestID:(PHImageRequestID)requestID;

NS_ASSUME_NONNULL_END

@end

