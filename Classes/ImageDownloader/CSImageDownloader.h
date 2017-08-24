//
//  CSImageDownloader.h
//  CKTableViewTransactionalDataSource
//
//  Created by Gao on 25/08/2017.
//

#import <Foundation/Foundation.h>
#import <ComponentSwift/ComponentSwift.h>

@interface CSImageDownloader : NSObject <CSNetworkImageDownloading>

+ (nonnull instancetype)sharedInstance NS_SWIFT_NAME(shared());

@end
