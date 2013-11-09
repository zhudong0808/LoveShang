//
//  WebPImage.h
//  etao4iphone
//
//  Created by 稳 张 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebP/decode.h>

// Loads an WebP image from the given filePath.
// It converts the full size WebP image to a UIImage object (fullImage). It also
// creates a thumbnail version (50x50) of the image (thumbImage). The file name
// is stored as the name of the image.
@interface WebPImage : NSObject

@property(nonatomic, readonly, copy) NSString *name;
@property(nonatomic, retain) UIImage *thumbImage;
@property(nonatomic, retain) UIImage *fullImage;

// This is the designated initializer.
// Returns nil if filePath is nil. If filePath points to an invalid file
// then no image will be loaded in fulImage and thumbImage.
- (id)initFromFile:(NSString *)filePath;

+ (bool) isWebpData:(NSData*)data;

+ (UIImage *)decodeWebPFromData:(NSData *)myData
                     withConfig:(WebPDecoderConfig *)config;

+ (UIImage *)decodeWebPFromFile:(NSString *)filePath
                     withConfig:(WebPDecoderConfig *)config;

+ (UIImage *)loadWebPFromFile:(NSString *)filePath;

+ (UIImage *)loadWebPFromData:(NSData *)data;

+ (UIImage *)loadWebPFromFile:(NSString *)filePath
                  scaledWidth:(int)scaledWidth
                 scaledHeight:(int)scaledHeight;

+ (UIImage *)loadWebPFromData:(NSData *)data
                  scaledWidth:(int)scaledWidth
                 scaledHeight:(int)scaledHeight;

@end
