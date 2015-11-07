//
//  MagazineViewCell.h
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *magImageView;
@property (weak, nonatomic) IBOutlet UILabel *magtitle;
@property (weak, nonatomic) IBOutlet UILabel *magContent;
@property (weak, nonatomic) IBOutlet UILabel *magVolYear;
@property (weak, nonatomic) IBOutlet UILabel *magUpdateTime;

@end
