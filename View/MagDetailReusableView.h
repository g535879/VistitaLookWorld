//
//  MagDetailReusableView.h
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagDetailReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *MagTitle;
@property (weak, nonatomic) IBOutlet UILabel *MagTime;
@property (weak, nonatomic) IBOutlet UILabel *MagDesc;

@end
