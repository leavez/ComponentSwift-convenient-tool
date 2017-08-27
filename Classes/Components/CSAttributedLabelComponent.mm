//
//  CSAttributedLabelComponent.m
//  CKTableViewTransactionalDataSource
//
//  Created by Gao on 27/08/2017.
//

#import "CSAttributedLabelComponent.h"
#import <ComponentSwift/ComponentSubclass.h>
#import "CKAttributedLabelComponent.h"

@implementation CSAttributedLabelComponent

- (instancetype)initWithAttributedString:(NSAttributedString *)text {
    if (text.length == 0) {
        return nil;
    }
    return [self initWithAttributedString:text numberOfLines:0 viewAttributes:nil size:nil];
}
- (instancetype)initWithAttributedString:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines {
    if (text.length == 0) {
        return nil;
    }
    return [self initWithAttributedString:text numberOfLines:numberOfLines viewAttributes:nil size:nil];
}

- (instancetype)initWithAttributedString:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines nilWhenStringIsZero:(BOOL)nilWhenStringIsZero {
    if (nilWhenStringIsZero && text.length == 0) {
        return nil;
    }
    return [self initWithAttributedString:text numberOfLines:numberOfLines viewAttributes:nil size:nil];
}

- (instancetype)initWithAttributedString:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines viewAttributes:(CSViewAttributeMap *)viewAttributes size:(CSSize *)size {

    CKComponent *ck = [CKAttributedLabelComponent newWithAttributedString:text numberOfLines:numberOfLines viewAttributes:ConvertWithDefault(viewAttributes, CKViewComponentAttributeValueMap()) size:ConvertWithDefault(size, CKComponentSize())];

    self = [super initWithCKComponent:ck];
    return self;
}
@end
