//
//  CSImageDownloader.m
//  CKTableViewTransactionalDataSource
//
//  Created by Gao on 25/08/2017.
//

#import "CSImageDownloader.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation CSImageDownloader

+ (instancetype)sharedInstance {
    static CSImageDownloader *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [CSImageDownloader new];
    });
    return client;
}

static void dispatchAsyncSmartlyToQueue(dispatch_queue_t queue , void (^action)()  ) {
    if (queue == dispatch_get_main_queue() && [NSThread isMainThread]) {
        // 对 main_queue 有优化处理
        action();
    } else {
        dispatch_async(queue, action);
    }
}

    
- (id)downloadImageWithURL:(NSURL *)URL
                 scenePath:(id)scenePath
                    caller:(id)caller
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError *error))completion {
    //caller and scenePath is omited.
    return [[SDWebImageManager sharedManager] loadImageWithURL:URL options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {

        if (!completion) {
            return;
        }
        dispatchAsyncSmartlyToQueue(callbackQueue ?: dispatch_get_main_queue(), ^{
            completion(image.CGImage, error);
        });
    }];
}


- (void)cancelImageDownload:(id)download {
    id<SDWebImageOperation> opeartion = (id<SDWebImageOperation>)download;
    [opeartion cancel];
}


@end



