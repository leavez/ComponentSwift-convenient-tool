//
//  CSFadeInNetworkImageComponent.m
//
//  Created by Gao on 27/08/2017.
//

#import "CSFadeInNetworkImageComponent.h"
#import <ComponentSwift/ComponentSubclass.h>
#import <ComponentKit/ComponentKit.h>
#import <ComponentSwift_ConvenientTool/CSImageDownloader.h>
#import "CKFadeInNetworkImageComponent.h"

@interface CSImageDownloader(ck)<CKNetworkImageDownloading>
@end
@implementation CSImageDownloader(ck)
@end

@implementation CSFadeInNetworkImageComponent


- (instancetype)initWithURL:(NSURL *)url
                       size:(CSSize *)size
           placeholderImage:(UIImage *)placeholderImage
                 attributes:(CSViewAttributeMap *)attributes
                  endurance:(NSTimeInterval)endurance
         transitionDuration:(NSTimeInterval)transitionDuration
{
    CKComponent *ck = [CKFadeInNetworkImageComponent
                       newWithURL:url
                       imageDownloader:[CSImageDownloader sharedInstance]
                       size:ConvertWithDefault(size, CKComponentSize())
                       placeholderImage:placeholderImage
                       attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())
                       endurance:endurance
                       transitionDuration:transitionDuration];

    self = [super initWithCKComponent:ck];
    return self;
}

/**
 *  Convenient method with contentMode set to UIViewContentModeScaleAspectFill
 */
- (instancetype)initWithUrl:(NSString *)url
                       size:(CGSize)size
           placeholderImage:(UIImage *)placeholderImage {

    CKComponent *ck = [CKFadeInNetworkImageComponent
                       newWithUrl:url size:size
                       placeholderImage:placeholderImage
                       imageDownloader:[CSImageDownloader sharedInstance]];
    self = [super initWithCKComponent:ck];
    return self;
}

- (instancetype)initWithUrl:(NSString*)url
                       size:(CGSize)size
           placeholderImage:(UIImage *)placeholderImage
                 attributes:(CSViewAttributeMap *)attributes {
    CKComponent *ck = [CKFadeInNetworkImageComponent
                       newWithUrl:url size:size
                       placeholderImage:placeholderImage
                       attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())
                       imageDownloader:[CSImageDownloader sharedInstance] ];
    self = [super initWithCKComponent:ck];
    return self;
}

- (instancetype)initWithUrl:(NSString *)url
             sizeAttributes:(CSSize *)size
           placeholderImage:(UIImage *)placeholderImage
                 attributes:(CSViewAttributeMap *)attributes
{
    CKComponent *ck = [CKFadeInNetworkImageComponent
                       newWithUrl:url
                       sizeAttributes:ConvertWithDefault(size, CKComponentSize())
                       placeholderImage:placeholderImage
                       attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())
                       imageDownloader:[CSImageDownloader sharedInstance] ];
    self = [super initWithCKComponent:ck];
    return self;
}

@end
