//
//  InfoViewCell.h
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *time;


@end
