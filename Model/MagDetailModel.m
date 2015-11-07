//
//  MagDetailModel.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "MagDetailModel.h"

@implementation MagDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"cat_name"]) {
        [self setValue:value forKey:@"catName"];
    }
    else if ([key isEqualToString:@"list"]){
        
        if ([value isKindOfClass:[NSArray class]]) {
            [self setValue:[value lastObject][@"title"] forKey:@"title"];
        }
    }
}
@end
