//
//  ReceiptView.h
//  WeixinReceipt
//
//  Created by chenfenglong on 16/2/18.
//  Copyright © 2016年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(NSString *secrt);

typedef NSString*(^TestBlock)(NSString *tempString);

@interface ReceiptView : UIView

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *detail;

@property (nonatomic,assign) CGFloat amount;

@property (nonatomic,copy) CompleteBlock completeBlock;

- (void)show;

@end
