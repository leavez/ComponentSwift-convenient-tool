//
//  CSAttributedLabelComponent.h
//
//  Created by Gao on 27/08/2017.
//

#import <ComponentSwift/ComponentSwift.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(AttributedLabelComponent)
@interface CSAttributedLabelComponent : CSCompositeComponent


- (nullable instancetype)initWithAttributedString:(nullable NSAttributedString *)text NS_SWIFT_NAME(init(_:));
- (nullable instancetype)initWithAttributedString:(nullable NSAttributedString *)text
                                    numberOfLines:(NSUInteger)numberOfLines NS_SWIFT_NAME(init(_:numberOfLines:));

- (nullable instancetype)initWithAttributedString:(nullable NSAttributedString *)text
                                    numberOfLines:(NSUInteger)numberOfLines
                              nilWhenStringIsZero:(BOOL)nilWhenStringIsZero NS_SWIFT_NAME(init(_:numberOfLines:nilWhenStringIsZero:));


- (nonnull instancetype)initWithAttributedString:(nonnull NSAttributedString *)text
                                   numberOfLines:(NSUInteger)numberOfLines
                                  viewAttributes:(nullable CSViewAttributeMap *)viewAttributes
                                            size:(nullable CSSize *)size NS_SWIFT_NAME(init(_:numberOfLines:viewAttributes:size:));

@end

NS_ASSUME_NONNULL_END
