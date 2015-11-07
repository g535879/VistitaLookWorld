//
//  MagModel.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "MagModel.h"

@implementation MagModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"magId"];
    }
    else if ([key isEqualToString:@"vol_year"]) {
        [self setValue:value forKey:@"volYear"];
    }
    else if ([key isEqualToString:@"update_time"]) {
        [self setValue:value forKey:@"updateTime"];
    }
 }

@end
