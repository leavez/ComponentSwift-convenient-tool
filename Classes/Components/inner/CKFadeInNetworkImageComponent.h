//
//  CKFadeInNetworkImageComponent.h
//  CKTableViewTransactionalDataSource
//
//  Created by Gao on 27/08/2017.
//

#import <ComponentKit/CKComponent.h>
#import <ComponentKit/CKNetworkImageDownloading.h>


/** Renders an image from a URL with fade in effect. */
@interface CKFadeInNetworkImageComponent : CKComponent


+ (instancetype)newWithURL:(NSURL *)url
           imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                      size:(const CKComponentSize &)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
                 endurance:(NSTimeInterval)endurance
        transitionDuration:(NSTimeInterval)transitionDuration;

/**
 *  Convenient method with contentMode set to UIViewContentModeScaleAspectFill
 */
+ (instancetype)newWithUrl:(NSString*)url
                      size:(CGSize)size
          placeholderImage:(UIImage *)placeholderImage
           imageDownloader:(id<CKNetworkImageDownloading>)downloader;

+ (instancetype)newWithUrl:(NSString*)url
                      size:(CGSize)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
           imageDownloader:(id<CKNetworkImageDownloading>)downloader;

+ (instancetype)newWithUrl:(NSString*)url
            sizeAttributes:(const CKComponentSize &)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
           imageDownloader:(id<CKNetworkImageDownloading>)downloader;

@end
