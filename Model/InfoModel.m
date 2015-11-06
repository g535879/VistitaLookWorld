//
//  InfoModel.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"infoId"];
    }
    else if ([key isEqualToString:@"pub_time"]){
        [self setValue:value forKey:@"pubTime"];
    }
}
@end
