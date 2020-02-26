//
//  LEGOPhotosManager.m
//  LEGOPhotosManager_Example
//
//  Created by 杨庆人 on 2020/2/10.
//  Copyright © 2020 564008993@qq.com. All rights reserved.
//

#import "LEGOPhotosManager.h"
#import "LEGOPhotosLoading.h"
#define kLEGOSystemCollectionKey @"kLEGOSystemCollectionKey"
#define LEGODisplayName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

@interface LEGOPhotosManager ()
@property (nonatomic, strong) LEGOPhotosLoading *iCloudLoading;

@end

static LEGOPhotosManager *shareManager = nil;

@implementation LEGOPhotosManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[LEGOPhotosManager alloc] init];
    });
    return shareManager;
}

/** Get all album lists 获取所有相册列表 */
+ (NSMutableArray <PHAssetCollection *> *)systemAssetCollection
{
    NSMutableArray *albums = [[NSMutableArray alloc] init];
    // 相机胶卷
    PHAssetCollection *cameraRollCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:[PHFetchOptions new]].lastObject;
    // 个人收藏
    PHAssetCollection *favoritesCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumFavorites options:[PHFetchOptions new]].lastObject;

    if (cameraRollCollection) {
        [albums addObject:cameraRollCollection];
    }
    if (favoritesCollection) {
        [albums addObject:favoritesCollection];
    }

    // 自定义相册
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:[PHFetchOptions new]];
    __block NSMutableArray *totalAlbums = albums;
    [assetCollections enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            [totalAlbums addObject:obj];
        }
    }];
    return totalAlbums;
}

/** Get a list of all photos 获取所有照片列表*/
+ (NSMutableArray <PHAsset *> *)systemAssetsByAssetCollection:(PHAssetCollection *)assetCollection
{
    PHFetchResult <PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:[PHFetchOptions new]];
    __block NSMutableArray <PHAsset *> *array = [[NSMutableArray <PHAsset *> alloc] init];
    [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.mediaType == PHAssetMediaTypeImage) {
            [array addObject:obj];
        }
    }];
//    NSArray *results = [array sortedArrayUsingComparator:^NSComparisonResult(PHAsset *obj1, PHAsset *obj2) {
//        return [obj2.creationDate compare:obj1.creationDate];
//    }];
    NSArray *results = [NSArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    return [NSMutableArray arrayWithArray:results];
}

/** Get a list of photos exclusive to the current app 获取当前应用专属照片列表*/
+ (NSMutableArray <PHAsset *> *)getCameraAssets {
    NSString *identity = [self.class getIDSystemCollectionUserDefaults];
    PHAssetCollection *assetCollection = nil;
    if (identity && identity.length) {
        assetCollection = [self.class getAssetCollectionByIdentity:identity];
    }
    if (!assetCollection) {
        assetCollection = [self.class getAssetCollectionByTitle:LEGODisplayName];
    }
    if (!assetCollection) {
        return [[NSMutableArray <PHAsset *> alloc] init];
    }
    PHFetchResult <PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:[PHFetchOptions new]];
    __block NSMutableArray <PHAsset *> *array = [[NSMutableArray <PHAsset *> alloc] init];
    [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.mediaType == PHAssetMediaTypeImage) {
            [array addObject:obj];
        }
    }];
//    NSArray *results = [array sortedArrayUsingComparator:^NSComparisonResult(PHAsset *obj1, PHAsset *obj2) {
//        return [obj2.creationDate compare:obj1.creationDate];
//    }];

    NSArray *results = [NSArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    return [NSMutableArray arrayWithArray:results];
}

+ (void)setSystemCollectionUserDefaultsWithID:(NSString *)identity {
    [[NSUserDefaults standardUserDefaults] setObject:identity forKey:kLEGOSystemCollectionKey];
}

+ (NSString *)getIDSystemCollectionUserDefaults {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLEGOSystemCollectionKey];
}


// 通过 id 获取相册
+ (PHAssetCollection *)getAssetCollectionByIdentity:(NSString *)identity {
   PHAssetCollection *assetCollection = [[PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identity] options:[PHFetchOptions new]] firstObject];
    NSLog(@"Photos.Kit通过相册id获取到相册=%@",assetCollection);
    return assetCollection;
}

// 通过 title 获取相册
+ (PHAssetCollection *)getAssetCollectionByTitle:(NSString *)title {
    PHFetchResult<PHAssetCollection *> *results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:[PHFetchOptions new]];
    NSLog(@"Photos.Kit系统所有相册=%@",results);
    __block PHAssetCollection *assetCollection = nil;
    [results enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.localizedTitle isEqualToString:title]) {
            assetCollection = obj;
            [self.class setSystemCollectionUserDefaultsWithID:obj.localIdentifier];
            *stop = YES;
        }
    }];
    NSLog(@"Photos.Kit通过 title 获取相册=%@",assetCollection);
    return assetCollection;
}




/** Save imagedata to system album 将 imageData 保存到系统相册*/
+ (void)savePhotoToAssetByImageData:(NSData *)imageData date:(NSDate *)date location:(CLLocation *)location completion:(void(^)(BOOL success, NSError *error))completion {
    [self.class savePhotoToAssetByImage:nil imageData:imageData date:date location:location completion:completion];
}

/** Save image to system album 将 image 保存到系统相册*/
+ (void)savePhotoToAssetByImage:(UIImage *)image date:(NSDate *)date location:(CLLocation *)location completion:(void(^)(BOOL success, NSError *error))completion {
    [self.class savePhotoToAssetByImage:image imageData:nil date:date location:location completion:completion];
}

+ (void)savePhotoToAssetByImage:(UIImage *)image imageData:(NSData *)imageData date:(NSDate *)date location:(CLLocation *)location completion:(void(^)(BOOL success, NSError *error))completion {

    NSString *identity = [self.class getIDSystemCollectionUserDefaults];
    PHAssetCollection *assetCollection = nil;
    if (identity && identity.length) {
        assetCollection = [self.class getAssetCollectionByIdentity:identity];
    }
    if (!assetCollection) {
        assetCollection = [self.class getAssetCollectionByTitle:LEGODisplayName];
    }
    if (!assetCollection) {
        assetCollection = [self.class createAssetCollection];
    }
    NSLog(@"Photos.Kit开始保存相片于相册=%@",assetCollection);
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *request = nil;
            if (imageData) {
                NSLog(@"Photos.Kit保存数据imageData=%@",imageData);
                request = [PHAssetCreationRequest creationRequestForAsset];
                [(PHAssetCreationRequest *)request addResourceWithType:PHAssetResourceTypePhoto data:imageData options:[PHAssetResourceCreationOptions new]];
            }
            else {
                NSLog(@"Photos.Kit保存数据image=%@",image);
                request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            }
            request.location = location;
            request.creationDate = date ? date : [NSDate date];
            PHObjectPlaceholder *placeholder = request.placeholderForCreatedAsset;
            PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            [changeRequest addAssets:@[placeholder]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            NSLog(@"Photos.Kit保存相片完毕error=%@",error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(success, error);
                }
            });
        }
     ];
}

// 新建相册
+ (PHAssetCollection *)createAssetCollection {
    NSError *error = nil;
    __block NSString *identity = @"";
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *createSubAlbumRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:LEGODisplayName];
        PHObjectPlaceholder *placeholder = createSubAlbumRequest.placeholderForCreatedAssetCollection;
        identity = placeholder.localIdentifier;
        [self.class setSystemCollectionUserDefaultsWithID:identity];
    } error:&error];
    NSLog(@"LEGODisplayName=%@",LEGODisplayName);
    return [self.class getAssetCollectionByIdentity:identity];
}

/** Delete from system album by assets 通过 assets 从系统相册删除*/
+ (void)delePhotoAssets:(NSArray <PHAsset *> *)assets completion:(void (^)(BOOL success))completion {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
         [PHAssetChangeRequest deleteAssets:assets];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (completion) {
            completion(success);
        }
    }];
}


/** Delete from system album by assetsID 通过 assetsID 从系统相册删除*/
+ (void)delePhotoAssetsIdentitys:(NSArray <NSString *> *)assetsIdentitys completion:(void (^)(BOOL success))completion {
    PHFetchResult <PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:assetsIdentitys options:[PHFetchOptions new]];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
         [PHAssetChangeRequest deleteAssets:assets];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (completion) {
            completion(success);
        }
    }];
}

/** Get thumbnails image by asset 通过 asset 获取缩略图*/
+ (PHImageRequestID)getThumbnailImageByAsset:(PHAsset *)asset targetSize:(CGSize)targetSize completion:(void (^)(UIImage *thumbnailImage, PHImageRequestID requestID, BOOL isInCloud))completion {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    __block PHImageRequestID requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(image, requestID,[[info objectForKey:PHImageResultIsInCloudKey] boolValue]);
            }
        });
    }];
    return requestID;
}


/** Get originalImage by asset 通过 asset 获取原图*/
+ (PHImageRequestID)getOriginalImageByAsset:(PHAsset *)asset completion:(void (^__nullable)(UIImage *originalImage, PHImageRequestID requestID))completion
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        [self.class showDownICloudLoading:progress error:error];
    };
    __block PHImageRequestID requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [LEGOPhotosManager dismissICouldLoading];
            BOOL complete = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (complete && completion && result) {
                completion(result, requestID);
            }
        });
    }];
    return requestID;
}

/** Get originalImage by asset, param Progress 通过 asset 获取原图，带进度条*/
+ (PHImageRequestID)getOriginalImageByAsset:(PHAsset *)asset progressHandler:(PHAssetImageProgressHandler)progressHandler completion:(void (^__nullable)(UIImage *originalImage, PHImageRequestID requestID))completion
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.progressHandler = progressHandler;
    __block PHImageRequestID requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL complete = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (complete && completion && result) {
                completion(result, requestID);
            }
        });
    }];
    return requestID;
}


/** Get imageData by asset 通过 asset 获取原图 imageData*/
+ (PHImageRequestID)getOriginalImageByAsset:(PHAsset *)asset completionData:(void (^)(NSData *originalImageData, PHImageRequestID requestID))completionData
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    options.synchronous = YES;  // 去掉原子性，则 resultHandler 会回调多次
    options.networkAccessAllowed = YES;
    options.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        [self.class showDownICloudLoading:progress error:error];
    };
    __block PHImageRequestID requestID =  [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [LEGOPhotosManager dismissICouldLoading];
            BOOL complete = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (completionData && imageData && complete) {
                completionData(imageData, requestID);
            }
        });
    }];
    return requestID;
}

/** Get imageData by asset, param Progress 通过 asset 获取原图 imageData，带进度条*/
+ (PHImageRequestID)getOriginalImageByAsset:(PHAsset *)asset progressHandler:(PHAssetImageProgressHandler)progressHandler completionData:(void (^)(NSData *originalImageData, PHImageRequestID requestID))completionData
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    options.synchronous = YES;  // 去掉原子性，则 resultHandler 会回调多次
    options.networkAccessAllowed = YES;
    options.progressHandler = progressHandler;
    __block PHImageRequestID requestID =  [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL complete = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (completionData && imageData && complete) {
                completionData(imageData, requestID);
            }
        });
    }];
    return requestID;
}

/** Get image and imageData by asset, and imageData 通过 asset 获取原图和原图 imageData*/
+ (void)getOriginalImageByAsset:(PHAsset *)asset PHImageRequestIDs:(void(^__nullable)(NSArray <NSNumber *> *PHImageRequestIDs))PHImageRequestIDs completionImage:(void (^ __nullable)(UIImage *originalImage, PHImageRequestID requestID))completionImage completionData:(void (^)(NSData *originalImageData, PHImageRequestID requestID))completionData {
    PHImageRequestID imageRequestID = [self.class getOriginalImageByAsset:asset completion:^(UIImage * _Nonnull originalImage, PHImageRequestID requestID) {
        if (completionImage) {
            completionImage(originalImage, requestID);
        }
    }];
    PHImageRequestID imageDataRequestID = [self.class getOriginalImageByAsset:asset completionData:^(NSData * _Nonnull originalImageData, PHImageRequestID requestID) {
        if (completionData) {
            completionData(originalImageData, requestID);
        }
    }];
    if (PHImageRequestIDs) {
        PHImageRequestIDs(@[@(imageRequestID),@(imageDataRequestID)]);
    }
}

+ (void)showDownICloudLoading:(double)progress error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![LEGOPhotosManager shareManager].iCloudLoading.superview) {
            [[LEGOPhotosManager shareManager].iCloudLoading show];
        }
        NSString *text = nil;
        if (error) {
            text = @"Cancelled";
        }
        else {
            text = [NSString stringWithFormat:@"%.0f%%", (floor(progress * 100))];
        }
        [LEGOPhotosManager shareManager].iCloudLoading.progress = text;
    });
}

+ (void)dismissICouldLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[LEGOPhotosManager shareManager].iCloudLoading dismiss];
    });
}

/** cancel request by requestID 取消请求*/
+ (void)cancelPHImageRequestID:(PHImageRequestID)requestID {
    [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
}

@end
