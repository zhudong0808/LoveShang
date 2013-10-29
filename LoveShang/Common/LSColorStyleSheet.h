//
//  LSColorStyleSheet.h
//  LoveShang
//
//  Created by zhudong on 13-10-29.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  enum  {
    LSColorWhite,
    LSColorBlack,
    LSColorGrayText,
    LSColorLightGrayText,
    LSColorDarkGrayText,
    LSColorBlackTitle,
    LSColorLightBlackTitle,
    LSColorOrangeText,
    LSColorShopBorderColor,
    LSColorBorderColor,
    LSColorLightBorderColor,
    LSColorCasheViewBackground,
    LSColorShopViewBackGround,
    LSColorScratchInfoBackGround,
    LSColorCommentTableBackGround,
    LSColorLightBackground,
    LSColorShopListBackGround,
    LSColorAddressSelectGround,
    LSColorMyTicketBackGround,
    LSColorShopListCellBackGround,
    LSColorShopHeaderBorderColor,
    LSColorGrayBlueColor,
    LSColorGrayLine,
    LSColorSearchLabelColor,
    LSColorActivityNoticeColor,
    LSColorShopDetailBackGround,
    LSColorShopDetailCellBackGround,
    LSColorShopBookingPromptTitle,
    LSColorShopCouponCashColor,
    LSColorShopCouponFullSentCashColor,
    LSColorShopCouponBookColor,
    LSColorShopCouponDefaultColor,
    LSColorGuideLabelColor,
    LSColorNavText,
} LSColors;

@interface LSColorStyleSheet : NSObject

+ (UIColor *)colorWithName:(LSColors)colorName;

//colorHex : 如 0xFFFFFF
+ (UIColor *)colorWithRGB:(int)colorRGB;

//red,green,blue
+ (UIColor *)colorWithRed:(int)red green:(int)green blue:(int)blue;

+ (UIColor *)clearColor;

+ (UIColor *)tableviewCellSelectionBackground;

@end
