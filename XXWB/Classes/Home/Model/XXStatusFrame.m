//
//  XXStatusFrame.m
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXStatusFrame.h"
#import "XXStatus.h"
#import "XXUser.h"
#import "NSString+LCExtend.h"

@implementation XXStatusFrame

- (void)setStatus:(XXStatus *)status
{
    _status = status;
    
    XXUser *user = status.user;
    
    // 屏幕宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 0. 原创微博父控件
    CGFloat originalW = cellW;
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    
    // 1. 头像
    CGFloat iconXY = XXStatusPadding;
    CGFloat iconWH = 34;
    _iconViewF = CGRectMake(iconXY, iconXY, iconWH, iconWH);
    
    // 2. 昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + XXStatusPadding;
    CGFloat nameY = iconXY;
    CGSize nameSize = [user.name sizeWithFont:[UIFont systemFontOfSize:XXStatusNameFont]];
    _nameBtnF = (CGRect){nameX, nameY, nameSize};
    
    // 3. 会员
#warning isVip
    user.vip = YES;
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(_nameBtnF) + XXStatusPadding;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 4. 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameBtnF) + XXStatusPadding * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:[UIFont systemFontOfSize:XXStatusTimeFont]];
    _timeLabelF = (CGRect){timeX, timeY, timeSize};
    
    // 5. 来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + XXStatusPadding;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:[UIFont systemFontOfSize:XXStatusSourceFont]];
    _sourceLabelF = (CGRect){sourceX, sourceY, sourceSize};
    
    // 6. 正文
    CGFloat contentX = iconXY;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + XXStatusPadding * 0.5;
    CGFloat contentMaxW = cellW - 2 * XXStatusPadding;
    CGSize contentSize = [status.text sizeWithFont:[UIFont systemFontOfSize:XXStatusContentFont] constrainedToSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){contentX, contentY, contentSize};
    
    CGFloat originalH = CGRectGetMaxY(_contentLabelF) + XXStatusPadding;
    
    // 7. 配图
    if (status.thumbnail_pic) {
        CGFloat photoX = iconXY;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF) + XXStatusPadding;
        CGFloat photoWH = 80;
        _photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(_photoViewF) + XXStatusPadding;
    }
    
    
    // 8. 转发微博
    if (status.retweeted_status) {
        // 0. 父控件
        CGFloat retweetX = iconXY + XXStatusPadding;
        CGFloat retweetY = CGRectGetMaxY(_contentLabelF) + XXStatusPadding;
        CGFloat retweetW = contentMaxW;
        
        // 1. 昵称
        CGFloat retNameX = 0;
        CGFloat retNameY = 0;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retNameSize = [name sizeWithFont:[UIFont systemFontOfSize:XXStatusNameFont]];
        _retweetNameBtnF = (CGRect){retNameX, retNameY, retNameSize};
        
        // 2. 正文
        CGFloat retContentX = retNameX;
        CGFloat retContentY = CGRectGetMaxY(_retweetNameBtnF) + XXStatusPadding;
        CGFloat retContentMaxW = retweetW - 2 * XXStatusPadding;
        CGSize retContentSize = [status.retweeted_status.text sizeWithFont:[UIFont systemFontOfSize:XXStatusContentFont] constrainedToSize:CGSizeMake(retContentMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){retContentX, retContentY, retContentSize};
        
        CGFloat retweetH = CGRectGetMaxY(_retweetContentLabelF) + XXStatusPadding;
        
        // 3. 配图
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat retPhotoX = retContentX;
            CGFloat retPhotoY = CGRectGetMaxY(_retweetContentLabelF) + XXStatusPadding;
            CGFloat retPhotoWH = 80;
            _retweetPhotoViewF = (CGRect){retPhotoX, retPhotoY, retPhotoWH, retPhotoWH};
            
            retweetH = CGRectGetMaxY(_retweetPhotoViewF) + XXStatusPadding;
        }
        
        _retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        originalH = CGRectGetMaxY(_retweetViewF) + XXStatusPadding;
    }
    
    _originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    _cellHeight = originalH;
    
    // 9. 微博工具条
    
    // 10. 转发
    
    // 11. 评论
    
    // 12. 表态
}

@end
