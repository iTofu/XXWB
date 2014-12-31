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
#import "XXPhotosView.h"

@implementation XXStatusFrame

- (void)setStatus:(XXStatus *)status
{
    _status = status;
    
    XXUser *user = status.user;
    
    // cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - XXStatusPadding;
    
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
    if (user.mbtype > 0) {
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
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + XXStatusPadding;
    CGFloat contentMaxW = cellW - 2 * XXStatusPadding;
    CGSize contentSize = [status.text sizeWithFont:[UIFont systemFontOfSize:XXStatusContentFont] constrainedToSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){contentX, contentY, contentSize};
    
    CGFloat originalH = CGRectGetMaxY(_contentLabelF) + XXStatusPadding;
    
    // 7. 配图
    if (status.pic_urls.count) {
        CGFloat photoX = iconXY;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF) + XXStatusPadding;
        CGSize photoSize = [XXPhotosView sizeWithPhotosCount:status.pic_urls.count];
        _photoViewF = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
        
        originalH = CGRectGetMaxY(_photoViewF) + XXStatusPadding;
    }
    
    
    // 8. 转发微博
    if (status.retweeted_status) {
        // 0. 父控件
        CGFloat retweetX = iconXY;
        CGFloat retweetY = CGRectGetMaxY(_contentLabelF) + XXStatusPadding * 0.8;
        CGFloat retweetW = contentMaxW;
        
        // 1. 昵称
        CGFloat retNameX = XXStatusPadding;
        CGFloat retNameY = XXStatusPadding;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retNameSize = [name sizeWithFont:[UIFont systemFontOfSize:XXStatusNameFont]];
        _retweetNameBtnF = (CGRect){retNameX, retNameY, retNameSize};
        
        // 2. 正文
        CGFloat retContentX = retNameX;
        CGFloat retContentY = CGRectGetMaxY(_retweetNameBtnF) + XXStatusPadding * 0.5;
        CGFloat retContentMaxW = retweetW - 2 * XXStatusPadding;
        CGSize retContentSize = [status.retweeted_status.text sizeWithFont:[UIFont systemFontOfSize:XXStatusContentFont] constrainedToSize:CGSizeMake(retContentMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){retContentX, retContentY, retContentSize};
        
        CGFloat retweetH = CGRectGetMaxY(_retweetContentLabelF) + XXStatusPadding;
        
        // 3. 配图
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retPhotoX = retContentX;
            CGFloat retPhotoY = CGRectGetMaxY(_retweetContentLabelF) + XXStatusPadding;
            CGSize retPhotoSize = [XXPhotosView sizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            _retweetPhotoViewF = (CGRect){retPhotoX, retPhotoY, retPhotoSize.width, retPhotoSize.height};
            
            retweetH = CGRectGetMaxY(_retweetPhotoViewF) + XXStatusPadding;
        }
        
        _retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        originalH = CGRectGetMaxY(_retweetViewF) + XXStatusPadding;
    }
    
    _originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    // 9. 微博工具条
    CGFloat toolX = originalX;
    CGFloat toolY = originalH;
    CGFloat toolW = originalW;
    CGFloat toolH = 35;
    _statusToolBarF = CGRectMake(toolX, toolY, toolW, toolH);
    
    // 10. 转发
    
    // 11. 评论
    
    // 12. 表态
    
    
    // cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + XXStatusPadding * 0.5;
}

@end
