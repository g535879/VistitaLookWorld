//
//  InfoModel.h
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject
@property (copy, nonatomic) NSString *infoId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *pubTime;
@end
