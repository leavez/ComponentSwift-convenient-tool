//
//  ZHCKAttributedLabel.m
//  Pods
//
//  Created by Gao on 10/17/16.
//
//

#import "CKAttributedLabelComponent.h"

@implementation CKAttributedLabelComponent

+ (instancetype)newWithAttributedString:(NSAttributedString *)text
                          numberOfLines:(NSUInteger)numberOfLines
{
    return [self newWithAttributedString:text numberOfLines:numberOfLines viewAttributes:{} size:{}];
}

+ (nullable instancetype)newWithAttributedString:(NSAttributedString *)text
                                   numberOfLines:(NSUInteger)numberOfLines
                             nilWhenStringIsZero:(BOOL)nilWhenStringIsZero
{
    if (text.length == 0) {
        return nil;
    }
    return [self newWithAttributedString:text numberOfLines:numberOfLines viewAttributes:{} size:{}];
}


+ (instancetype)newWithAttributedString:(NSAttributedString *)text
                          numberOfLines:(NSUInteger)numberOfLines
                         viewAttributes:(const CKViewComponentAttributeValueMap &)viewAttributes
                                   size:(const CKComponentSize &)size
{
    CKTextKitAttributes textAttributes = {
        .attributedString = text,
        .maximumNumberOfLines = numberOfLines,
        .lineBreakMode = NSLineBreakByTruncatingTail
    };

    if (text.length > 0) {
        NSDictionary *d = [text attributesAtIndex:text.length-1 effectiveRange:nil];
        textAttributes.truncationAttributedString = [[NSAttributedString alloc] initWithString:@"..." attributes:d];
    }

    CKViewComponentAttributeValueMap copiedMap = viewAttributes;
    SEL key = @selector(setUserInteractionEnabled:);
    if (!copiedMap[key]) {
        copiedMap[key] = std::move(@NO);
    }
    SEL key2 = @selector(setBackgroundColor:);
    if (!copiedMap[key2]) {
        copiedMap[key2] = std::move([UIColor clearColor]);
    }
    SEL voiceOver = @selector(setAccessibilityLabel:);
    NSString *accisibility = nil; 
    if (copiedMap[voiceOver]) {
        accisibility = copiedMap[voiceOver];
    }
    CKComponentAccessibilityTextAttribute accisibilityAttribute =
    accisibility == nil ? CKComponentAccessibilityTextAttribute{} : CKComponentAccessibilityTextAttribute(accisibility);

    return [super newWithComponent:
            [CKTextComponent
             newWithTextAttributes:textAttributes
             viewAttributes:copiedMap
             options:{
                 .accessibilityContext = {
                     .isAccessibilityElement = @(YES),
                     .accessibilityLabel = accisibilityAttribute
                 }
             }
             size:size]
            ];
}

@end
