//
//  LSColorStyleSheet.m
//  LoveShang
//
//  Created by zhudong on 13-10-29.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSColorStyleSheet.h"

@implementation LSColorStyleSheet

+ (UIColor *)colorWithName:(LSColors)colorName{
    switch (colorName) {
            
        case LSColorWhite:
        {
            return [UIColor whiteColor];
        }
            
        case LSColorBlack:
        {
            return [UIColor blackColor];
        }
            
        case LSColorNavText:
        {
            return [LSColorStyleSheet colorWithRGB:0x8caa3b];
        }
        case LSColorGrayText:
        {
            return [LSColorStyleSheet colorWithRGB:0x666666];
        }
        case LSColorLightGrayText:
        {
            return [LSColorStyleSheet colorWithRGB:0x999999];
        }
            
        case LSColorGrayLine:
        {
            return [LSColorStyleSheet colorWithRGB:0xCFCFCF];
        }
            
        case LSColorDarkGrayText:
        {
            return [LSColorStyleSheet colorWithRGB:0x464646];
        }
            
        case LSColorOrangeText:
        {
            return [LSColorStyleSheet colorWithRGB:0xFF5000];
        }
            
        case LSColorBlackTitle:
        {
            return [LSColorStyleSheet colorWithRGB:0x3D4245];
        }
            
        case LSColorLightBlackTitle:
        {
            return [LSColorStyleSheet colorWithRGB:0x303030];
        }
            
        case LSColorBorderColor:
        {
            return [LSColorStyleSheet colorWithRGB:0xD0D0D0];
        }
            
        case LSColorGrayBlueColor:
        {
            return [LSColorStyleSheet colorWithRGB:0x5F646E];
        }
            
        case LSColorShopBorderColor:
        {
            return [LSColorStyleSheet colorWithRGB:0xDDDDDD];
        }
        case LSColorLightBorderColor:
        case LSColorLightBackground:
        {
            return [LSColorStyleSheet colorWithRGB:0xE1E1E1];
        }
            
        case LSColorCasheViewBackground:
        {
            return [LSColorStyleSheet colorWithRGB:0xEAEAEA];
        }
            
        case LSColorShopViewBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xF4F4F4];
        }
        case LSColorScratchInfoBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xF5F5F5];
        }
        case LSColorCommentTableBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xF7F7F7];
        }
        case LSColorAddressSelectGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xE0E0E0];
        }
            
        case LSColorMyTicketBackGround:
        case LSColorShopListBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xEEEEEE];
        }
        case LSColorShopListCellBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xF9F9F9];
        }
            
        case LSColorShopHeaderBorderColor:
        {
            return [LSColorStyleSheet colorWithRGB:0xBFBFBF];
        }
            
        case LSColorSearchLabelColor:
        {
            return [LSColorStyleSheet colorWithRGB:0xBCBCBC];
        }
        case LSColorActivityNoticeColor:
        {
            return [LSColorStyleSheet colorWithRGB:0xd8d8d8];
        }
        case LSColorShopDetailBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xe8e8e8];
        }
        case LSColorShopDetailCellBackGround:
        {
            return [LSColorStyleSheet colorWithRGB:0xfbfbfb];
        }
        case LSColorShopBookingPromptTitle:
        {
            return [LSColorStyleSheet colorWithRGB:0x333333];
        }
        case LSColorShopCouponCashColor:
        {
            return [LSColorStyleSheet colorWithRGB:0x6FA901];
        }
        case LSColorShopCouponFullSentCashColor:
        {
            return [LSColorStyleSheet colorWithRGB:0xf97979];
        }
        case LSColorShopCouponBookColor:
        {
            return [LSColorStyleSheet colorWithRGB:0x74cbe4];
        }
        case LSColorShopCouponDefaultColor:
        {
            return [LSColorStyleSheet colorWithRGB:0x788087];
        }
        case LSColorGuideLabelColor:
        {
            return [LSColorStyleSheet colorWithRGB:0x272724];
        }
        default:
            break;
    }
}

+ (UIColor *)colorWithRGB:(int)colorRGB {
    int r = colorRGB / (256 * 256);
    int g = (colorRGB - r * 256 * 256) / 256;
    int b = (colorRGB - r * 256 * 256 - g * 256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor *)colorWithRed:(int)red green:(int)green blue:(int)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor *) clearColor {
    return [UIColor clearColor];
}

+ (UIColor *)tableviewCellSelectionBackground {
    return  [UIColor colorWithRed:238 green:238 blue:238 alpha:1];
}
@end

