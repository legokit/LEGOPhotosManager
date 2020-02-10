# LEGOPhotosManager

Photo management tool, you can get album list, photo list, save photos, delete photos, get photos by iCloud, cancel photo request  照片管理工具，可以获取相册列表、照片列表，保存照片、删除照片，通过 iCloud 获取照片，取消照片请求

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LEGOPhotosManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LEGOPhotosManager'
```

**LEGOPhotosManager** is the photo management tool, you can get album list, photo list, save photos, delete photos, get photos by iCloud, cancel photo request  照片管理工具，可以获取相册列表、照片列表，保存照片、删除照片，通过 iCloud 获取照片，取消照片请求

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features

- [x] Get album list.  获取相册列表
- [x] Photo list.  照片列表
- [x] Save photos.  保存照片
- [x] Delete photos.  删除照片 
- [x] Get photos by iCloud.  通过 iCloud 获取照片
- [x] Cancel photo request.  取消照片请求

## Requirements

- iOS 9.0+
- Xcode 10.0+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate LEGOPhotosManager into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'LEGOPhotosManager'
```

### Manually

If you prefer not to use any of the dependency mentioned above, you can integrate LEGOPhotosManager into your project manually. Just drag & drop the `Sources` folder to your project.

## Usage
### Get album list.  获取相册列表
```
/** Get all album lists 获取所有相册列表 */
  NSMutableArray <PHAssetCollection *> *collections = [LEGOPhotosManager systemAssetCollection];

/** Get a list of all photos 获取所有照片列表*/
  NSMutableArray <PHAsset *> *assets = [LEGOPhotosManager systemAssetsByAssetCollection:collections.firstObject];

/** Get a list of photos exclusive to the current app 获取当前应用专属照片列表*/
  NSMutableArray <PHAsset *> *assets = [LEGOPhotosManager getCameraAssets];
```
### Save photos.  保存照片  Delete photos.  删除照片
```
/** Save imagedata to system album 将 imageData 保存到系统相册*/
  [LEGOPhotosManager savePhotoToAssetByImage:image date:[NSDate date] location:currLocation completion:^(BOOL success, NSError * _Nonnull error) {
        
  }];
/** Save image to system album 将 image 保存到系统相册*/
  [LEGOPhotosManager savePhotoToAssetByImageData:imageData date:[NSDate date] location:currLocation completion:^(BOOL success, NSError * _Nonnull error) {
        
  }];
/** Delete from system album by assets 通过 assets 从系统相册删除*/
  [LEGOPhotosManager delePhotoAssets:@[asset] completion:^(BOOL success) {
        
  }];
/** Delete from system album by assetsID 通过 assetsID 从系统相册删除*/
  [LEGOPhotosManager delePhotoAssetsIdentitys:@[assetID] completion:^(BOOL success) {
        
  }];
```
### Get photos by iCloud.  通过 iCloud 获取照片
```
/** Get thumbnails image by asset 通过 asset 获取缩略图*/
   [LEGOPhotosManager getThumbnailImageByAsset:asset targetSize:CGSizeMake(200, 300) completion:^(UIImage * _Nonnull thumbnailImage, PHImageRequestID requestID, BOOL isInCloud) {
        
   }];
/** Get originalImage by asset 通过 asset 获取原图*/
   [LEGOPhotosManager getOriginalImageByAsset:asset completion:^(UIImage * _Nonnull originalImage, PHImageRequestID requestID) {
        
   }];
/** Get originalImage by asset, param Progress 通过 asset 获取原图，带进度条*/
  [LEGOPhotosManager getOriginalImageByAsset:asset progressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
   } completion:^(UIImage * _Nonnull originalImage, PHImageRequestID requestID) {
        
   }];
/** Get imageData by asset 通过 asset 获取原图 imageData*/
  [LEGOPhotosManager getOriginalImageByAsset:asset completionData:^(NSData * _Nonnull originalImageData, PHImageRequestID requestID) {
        
   }];
/** Get imageData by asset, param Progress 通过 asset 获取原图 imageData，带进度条*/
   [LEGOPhotosManager getOriginalImageByAsset:asset progressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
        } completionData:^(NSData * _Nonnull originalImageData, PHImageRequestID requestID) {
        
   }];
```

### Cancel photo request.  取消照片请求
```
/** cancel request by requestID 取消请求*/
  [LEGOPhotosManager cancelPHImageRequestID:PHImageRequestID];
```


For details, see example for LEGOPhotosManager.

## Author

564008993@qq.com, yangqingren@yy.com

## License

LEGOPhotosManager is available under the MIT license. See the LICENSE file for more info.
