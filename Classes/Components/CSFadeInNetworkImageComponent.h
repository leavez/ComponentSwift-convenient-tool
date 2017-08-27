//
//  CSFadeInNetworkImageComponent.h
//
//  Created by Gao on 27/08/2017.
//

#import <ComponentSwift/ComponentSwift.h>

/**
 * Renders an image from a URL with fade in effect.
 */
NS_SWIFT_NAME(FadeInNetworkImageComponent)
@interface CSFadeInNetworkImageComponent: CSCompositeComponent

- (nonnull instancetype)initWithURL:(nullable NSURL *)url
                               size:(nullable CSSize *)size
                   placeholderImage:(nullable UIImage *)placeholderImage
                         attributes:(nullable CSViewAttributeMap *)attributes
                          endurance:(NSTimeInterval)endurance
                 transitionDuration:(NSTimeInterval)transitionDuration NS_DESIGNATED_INITIALIZER;

/**
 *  Convenient method with contentMode set to UIViewContentModeScaleAspectFill
 */
- (nonnull instancetype)initWithUrl:(nullable NSString *)url
                               size:(CGSize)size
                   placeholderImage:(nullable UIImage *)placeholderImage NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithUrl:(nullable NSString*)url
                               size:(CGSize)size
                   placeholderImage:(nullable UIImage *)placeholderImage
                         attributes:(nullable CSViewAttributeMap *)attributes NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithUrl:(nullable NSString *)url
                     sizeAttributes:(nullable CSSize *)size
                   placeholderImage:(nullable UIImage *)placeholderImage
                         attributes:(nullable CSViewAttributeMap *)attributes NS_DESIGNATED_INITIALIZER;

@end
