//
//  ZHCKAttributedLabel.h
//  Pods
//
//  Created by Gao on 10/17/16.
//
//

#import <ComponentKit/ComponentKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKAttributedLabelComponent : CKCompositeComponent

+ (nonnull instancetype)newWithAttributedString:(nonnull NSAttributedString *)text
                          numberOfLines:(NSUInteger)numberOfLines;

+ (nullable instancetype)newWithAttributedString:(nonnull NSAttributedString *)text
                          numberOfLines:(NSUInteger)numberOfLines
                    nilWhenStringIsZero:(BOOL)nilWhenStringIsZero;

+ (nonnull instancetype)newWithAttributedString:(nonnull NSAttributedString *)text
                          numberOfLines:(NSUInteger)numberOfLines
                         viewAttributes:(const CKViewComponentAttributeValueMap &)viewAttributes
                                   size:(const CKComponentSize &)size;

@end

NS_ASSUME_NONNULL_END
