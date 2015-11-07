//
//  CoolPicViewCell.h
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolPicViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cooBgImage;
@property (weak, nonatomic) IBOutlet UIImageView *coolImage;
@property (weak, nonatomic) IBOutlet UILabel *coolTitle;
@property (weak, nonatomic) IBOutlet UIImageView *coolImageView;

@end
