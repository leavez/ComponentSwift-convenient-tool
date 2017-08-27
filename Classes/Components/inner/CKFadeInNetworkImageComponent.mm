//
//  CKFadeInNetworkImageComponent.m
//
//  Created by Gao on 27/08/2017.
//

#import "CKFadeInNetworkImageComponent.h"

CATransition* CKComponentGenerateTransition(NSTimeInterval duration)
{
    CATransition *fadeTransition = [CATransition animation];
    fadeTransition.duration = duration;
    fadeTransition.type = kCATransitionFade;
    fadeTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return fadeTransition;
}


@interface CSCKNetworkImageSpecifier : NSObject
- (instancetype)initWithURL:(NSURL *)url
               defaultImage:(UIImage *)defaultImage
            imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                  scenePath:(id)scenePath
                   cropRect:(CGRect)cropRect;
@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, strong, readonly) UIImage *defaultImage;
@property (nonatomic, strong, readonly) id<CKNetworkImageDownloading> imageDownloader;
@property (nonatomic, strong, readonly) id scenePath;
@property (nonatomic, assign, readonly) CGRect cropRect;
@end

@interface ZHCKNetworkImageComponentView : UIImageView
@property (nonatomic, strong) CSCKNetworkImageSpecifier *specifier;
@property (nonatomic) NSTimeInterval transitionDuration;
@property (nonatomic) NSTimeInterval endurance;
- (void)didEnterReusePool;
- (void)willLeaveReusePool;
@end



@implementation CKFadeInNetworkImageComponent

+ (instancetype)newWithURL:(NSURL *)url
           imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                      size:(const CKComponentSize &)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)passedAttributes
                 endurance:(NSTimeInterval)endurance
        transitionDuration:(NSTimeInterval)transitionDuration
{
    CGRect cropRect = CGRectMake(0, 0, 1, 1);
    CKViewComponentAttributeValueMap attributes(passedAttributes);
    attributes.insert({
        {@selector(setSpecifier:), [[CSCKNetworkImageSpecifier alloc] initWithURL:url
                                                                     defaultImage:placeholderImage
                                                                  imageDownloader:imageDownloader
                                                                        scenePath:nil
                                                                         cropRect:cropRect]},

        {@selector(setTransitionDuration:), @(transitionDuration)},
        {@selector(setEndurance:), @(endurance)},
    });
    return [super newWithView:{
        {[ZHCKNetworkImageComponentView class], @selector(didEnterReusePool), @selector(willLeaveReusePool)},
        std::move(attributes)
    } size:size];
}


+ (instancetype)newWithUrl:(NSString*)url
                      size:(CGSize)size
          placeholderImage:(UIImage *)placeholderImage
           imageDownloader:(id<CKNetworkImageDownloading>)downloader

{
    return [self newWithUrl:url size:size placeholderImage:placeholderImage attributes:{} imageDownloader:downloader];
}

+ (instancetype)newWithUrl:(NSString*)url
                      size:(CGSize)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
           imageDownloader:(id<CKNetworkImageDownloading>)downloader
{
    return [self newWithUrl:url sizeAttributes:{
        .width = size.width,
        .height = size.height,
    } placeholderImage:placeholderImage attributes:attributes imageDownloader:downloader];
}

+ (instancetype)newWithUrl:(NSString*)url
            sizeAttributes:(const CKComponentSize &)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
           imageDownloader:(id<CKNetworkImageDownloading>)downloader
{

    CKViewComponentAttributeValueMap attrCopy = attributes;
    attrCopy.insert({
        {@selector(setContentMode:), @(UIViewContentModeScaleAspectFill)},
        {CKComponentViewAttribute::LayerAttribute(@selector(setMasksToBounds:)), @YES},
    });

    return [self
            newWithURL:[NSURL URLWithString:url]
            imageDownloader:downloader
            size:size
            placeholderImage:placeholderImage
            attributes:attrCopy
            endurance:0.1
            transitionDuration:0.25
            ];
}


@end

@implementation CSCKNetworkImageSpecifier

- (instancetype)initWithURL:(NSURL *)url
               defaultImage:(UIImage *)defaultImage
            imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                  scenePath:(id)scenePath
                   cropRect:(CGRect)cropRect
{
    if (self = [super init]) {
        _url = [url copy];
        _defaultImage = defaultImage;
        _imageDownloader = imageDownloader;
        _scenePath = scenePath;
        _cropRect = cropRect;
    }
    return self;
}

- (NSUInteger)hash
{
    return [_url hash];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    } else if ([object isKindOfClass:[self class]]) {
        CSCKNetworkImageSpecifier *other = object;
        return CKObjectIsEqual(_url, other->_url)
        && CKObjectIsEqual(_defaultImage, other->_defaultImage)
        && CKObjectIsEqual(_imageDownloader, other->_imageDownloader)
        && CKObjectIsEqual(_scenePath, other->_scenePath)
        && CGRectEqualToRect(_cropRect, other->_cropRect);
    }
    return NO;
}

@end

@implementation ZHCKNetworkImageComponentView
{
    BOOL _inReusePool;
    id _download;
}

- (void)dealloc
{
    if (_download) {
        [_specifier.imageDownloader cancelImageDownload:_download];
    }
}

- (void)didDownloadImage:(CGImageRef)image error:(NSError *)error usingDuration:(NSTimeInterval)duration
{
    if (image) {
        self.image = [UIImage imageWithCGImage:image];
        [self updateContentsRect];
    }
    _download = nil;

    if (image && self.transitionDuration > 0 && duration > self.endurance) {
        [self.layer addAnimation:CKComponentGenerateTransition(self.transitionDuration) forKey:@"imageChangeTransition"];
    }
}

- (void)setSpecifier:(CSCKNetworkImageSpecifier *)specifier
{
    if (CKObjectIsEqual(specifier, _specifier)) {
        return;
    }

    if (!CGRectEqualToRect(_specifier.cropRect, specifier.cropRect)) {
        [self setNeedsLayout];
    }

    BOOL urlIsDifferent = !CKObjectIsEqual(_specifier.url, specifier.url);
    BOOL isShowingCurrentDefaultImage = CKObjectIsEqual(self.image, _specifier.defaultImage);
    if (urlIsDifferent || isShowingCurrentDefaultImage) {
        self.image = specifier.defaultImage;
    }

    if (urlIsDifferent && _download != nil) {
        [specifier.imageDownloader cancelImageDownload:_download];
        _download = nil;
    }

    _specifier = specifier;

    if (urlIsDifferent) {
        [self _startDownloadIfNotInReusePool];
    }
}

- (void)didEnterReusePool
{
    _inReusePool = YES;
    if (_download) {
        [_specifier.imageDownloader cancelImageDownload:_download];
        _download = nil;
    }
    // Release the downloaded image that we're holding to lower memory usage.
    self.image = _specifier.defaultImage;
}

- (void)willLeaveReusePool
{
    _inReusePool = NO;
    [self _startDownloadIfNotInReusePool];
}

- (void)_startDownloadIfNotInReusePool
{
    if (_inReusePool) {
        return;
    }

    if (_specifier.url == nil) {
        return;
    }

    auto start = CACurrentMediaTime();
    __weak ZHCKNetworkImageComponentView *weakSelf = self;
    _download = [_specifier.imageDownloader downloadImageWithURL:_specifier.url
                                                       scenePath:_specifier.scenePath
                                                          caller:self
                                                   callbackQueue:dispatch_get_main_queue()
                                           downloadProgressBlock:nil
                                                      completion:^(CGImageRef image, NSError *error)
                 {
                     auto end = CACurrentMediaTime();
                     [weakSelf didDownloadImage:image error:error usingDuration:end - start];
                 }];
}

- (void)updateContentsRect
{
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }

    // If we're about to crop the width or height, make sure the cropped version won't be upscaled
    CGFloat croppedWidth = self.image.size.width * _specifier.cropRect.size.width;
    CGFloat croppedHeight = self.image.size.height * _specifier.cropRect.size.height;
    if ((_specifier.cropRect.size.width == 1 || croppedWidth >= self.bounds.size.width) &&
        (_specifier.cropRect.size.height == 1 || croppedHeight >= self.bounds.size.height)) {
        self.layer.contentsRect = _specifier.cropRect;
    }
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self updateContentsRect];
}

@end


