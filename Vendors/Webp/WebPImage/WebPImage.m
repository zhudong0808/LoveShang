//
//  WebPImage.m
//  etao4iphone
//
//  Created by 稳 张 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebPImage.h"


static const int kWPUseThreads = 1;
static const int kThumbWidth = 50;
static const int kThumbHeight = 50;

// Callback for CGDataProviderRelease
static void FreeImageData(void *info, const void *data, size_t size) {
    free((void*)data);
}

@interface WebPImage ()

@property(nonatomic, copy) NSString *filePath;
@property(nonatomic, copy) NSString *name;

@end

@implementation WebPImage

@synthesize filePath = filePath_;
@synthesize name = name_;
@synthesize thumbImage = thumbImage_;
@synthesize fullImage = fullImage_;

- (id)initFromFile:(NSString *)filePath {
    if ((self = [super init])) {
        if (filePath) {
            self.filePath = filePath;
            self.name =
            [[self.filePath componentsSeparatedByString:@"/"] lastObject];
        } else {
            [self release];
            self = nil;
        }
    }
    return self;
}

- (id)init {
    return [self initFromFile:nil];
}

- (void)dealloc {
    [filePath_ release];
    [name_ release];
    [thumbImage_ release];
    [fullImage_ release];
    [super dealloc];
}

// Decode a WebP image with specified config options. 'config' specifies various
// WebP decoding options (e.g. colorspace, scaling etc.). For details of
// WebPDecoderConfig see decode.h of WebP library.
+ (UIImage *)decodeWebPFromFile:(NSString *)filePath
                     withConfig:(WebPDecoderConfig *)config {
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    return [WebPImage decodeWebPFromData:myData withConfig:config];
}


+ (bool) isWebpData:(NSData*)data {
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_RGBA;
    config.options.use_threads = kWPUseThreads;
    
    if (WebPDecode([data bytes], [data length], &config) != VP8_STATUS_OK) {
        return NO;
    }
    
    return YES;
}


+ (UIImage *)decodeWebPFromData:(NSData *)myData
                     withConfig:(WebPDecoderConfig *)config {

    if (WebPDecode([myData bytes], [myData length], config) != VP8_STATUS_OK) {
        return nil;
    }
    
    int width = config->input.width;
    int height = config->input.height;
    if (config->options.use_scaling) {
        width = config->options.scaled_width;
        height = config->options.scaled_height;
    }
    
    // Construct a UIImage from the decoded RGBA value array.
    CGDataProviderRef provider = 
    CGDataProviderCreateWithData(NULL, config->output.u.RGBA.rgba,
                                 config->output.u.RGBA.size, FreeImageData);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef =
    CGImageCreate(width, height, 8, 32, 4 * width, colorSpaceRef, bitmapInfo,
                  provider, NULL, NO, renderingIntent);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    
    UIImage *newImage = [[[UIImage alloc] initWithCGImage:imageRef] autorelease];
    CGImageRelease(imageRef);
    
    return newImage;
}


// Decodes and loads a WebP image.
+ (UIImage *)loadWebPFromFile:(NSString *)filePath {
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_RGBA;
    config.options.use_threads = kWPUseThreads;
    
    return [WebPImage decodeWebPFromFile:filePath withConfig:&config];
}

+ (UIImage *)loadWebPFromData:(NSData *)data {
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_RGBA;
    config.options.use_threads = kWPUseThreads;
    
    return [WebPImage decodeWebPFromData:data withConfig:&config];
}

// Decodes a resized WebP image specified by scaleWidth and scaleHeight.
// If scaledWidth and scaledHeight are smaller than the acutal width and height
// then this method directly decodes a smaller image. In that case this
// method saves some CPU and meomory resources as it decodes a smaller image.
+ (UIImage *)loadWebPFromFile:(NSString *)filePath
                  scaledWidth:(int)scaledWidth
                 scaledHeight:(int)scaledHeight {
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_RGBA;
    config.options.use_threads = kWPUseThreads;
    
    config.options.use_scaling = 1;
    config.options.scaled_width = scaledWidth;
    config.options.scaled_height = scaledHeight;
    
    return [WebPImage decodeWebPFromFile:filePath withConfig:&config];
}


+ (UIImage *)loadWebPFromData:(NSData *)data
                  scaledWidth:(int)scaledWidth
                 scaledHeight:(int)scaledHeight {
    
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_RGBA;
    config.options.use_threads = kWPUseThreads;
    
    config.options.use_scaling = 1;
    config.options.scaled_width = scaledWidth;
    config.options.scaled_height = scaledHeight;
    
    return [WebPImage decodeWebPFromData:data withConfig:&config];
}


- (UIImage *)thumbImage {
    @synchronized(self) {
        if (!thumbImage_) {
            thumbImage_ = [[WebPImage loadWebPFromFile:self.filePath
                                           scaledWidth:kThumbWidth
                                          scaledHeight:kThumbHeight] retain];
        }
    }
    return thumbImage_;
}


- (UIImage *)fullImage {
    @synchronized(self) {
        if (!fullImage_) {
            fullImage_ = [[WebPImage loadWebPFromFile:self.filePath] retain];
        }
    }
    return fullImage_;
}

@end

