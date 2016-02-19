//
//  ReceiptView.m
//  WeixinReceipt
//
//  Created by chenfenglong on 16/2/18.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "ReceiptView.h"

#define ScreenW     [UIScreen mainScreen].bounds.size.width
#define ScreenH     [UIScreen mainScreen].bounds.size.height

@interface ReceiptView ()<UITextFieldDelegate>

@property (nonatomic,weak) UILabel *titleLbl;

@property (nonatomic,weak) UILabel *detailLbl;

@property (nonatomic,weak) UILabel *amoutLbl;

@property (nonatomic,strong) NSMutableArray *arrayRounds;

@property (nonatomic,weak) UIView *receiptView;

@property (nonatomic,weak) UITextField *textFiled;

@end
@implementation ReceiptView

- (NSMutableArray *)arrayRounds
{
    if (_arrayRounds == nil) {
        _arrayRounds = [NSMutableArray array];
    }
    return _arrayRounds;
}

- (void)show
{
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    [windows addSubview:self];
    
    self.receiptView.alpha = 0.0;
    self.receiptView.transform = CGAffineTransformMakeScale(1.21F, 1.21F);
    [UIView animateWithDuration:.7 delay:.1 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
        self.receiptView.alpha = 1.0;
        self.receiptView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [self.textFiled becomeFirstResponder];
    }];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    if (_receiptView == nil) {
        CGFloat receiptViewX = 40;
        CGFloat receiptViewY = 80;
        CGFloat receiptViewW = ScreenW - 2 * receiptViewX;
        CGFloat receiptViewH = 200;
        UIView *receiptView = [[UIView alloc] initWithFrame:CGRectMake(receiptViewX, receiptViewY, receiptViewW, receiptViewH)];
        receiptView.backgroundColor = [UIColor whiteColor];
        receiptView.clipsToBounds = YES;
        receiptView.layer.cornerRadius = 5;
        self.receiptView = receiptView;
        [self addSubview:receiptView];
        
        //title
        CGFloat titleHeight = 46;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, receiptViewW, titleHeight)];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = [UIColor blackColor];
        title.text = self.title;
        [receiptView addSubview:title];
        self.titleLbl = title;
        
        //删除按钮
        UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleHeight, titleHeight)];
        [dismissButton setTitle:@"╳" forState:UIControlStateNormal];
        [dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dismissButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [dismissButton addTarget:self action:@selector(dismiassButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [receiptView addSubview:dismissButton];
        
        //分隔线
        UIView *devideView = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight, receiptViewW, 0.5)];
        devideView.backgroundColor = [UIColor lightGrayColor];
        [receiptView addSubview:devideView];
        
        //详情
        CGFloat detailX = 15;
        CGFloat detailY = titleHeight + 15;
        CGFloat detailW = receiptViewW - 2* detailX;
        CGFloat detailH = 20;
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, detailH)];
        detail.font = [UIFont systemFontOfSize:16];
        detail.textAlignment = NSTextAlignmentCenter;
        detail.textColor = [UIColor blackColor];
        detail.text = self.detail;
        [receiptView addSubview:detail];
        self.detailLbl = detail;
        
        //金额
        CGFloat amountY = titleHeight * 2;
        UILabel *amount = [[UILabel alloc] initWithFrame:CGRectMake(0, amountY, receiptViewW, 25)];
        amount.textAlignment = NSTextAlignmentCenter;
        amount.textColor = [UIColor blackColor];
        amount.font = [UIFont systemFontOfSize:33];
        [receiptView addSubview:amount];
        self.amoutLbl = amount;
        
        CGFloat inputViewX = 15;
        CGFloat inputViewW = receiptViewW - 2 * inputViewX;
        CGFloat inputViewH = (inputViewW / 6.0);
        CGFloat inputViewY = receiptViewH - 15 - inputViewH;
        UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(inputViewX, inputViewY, inputViewW, inputViewH)];
        inputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        inputView.layer.borderWidth = 0.5;
        [receiptView addSubview:inputView];
        
        //黑色小圆点
        CGFloat tempWidth = inputViewW / 6;
        CGFloat roundW = 10,roundH = 10;
        CGFloat roundY = inputViewH / 2;
        for (int i = 0; i < 6; i++) {
            CGFloat roundCentX = (tempWidth / 2) + tempWidth * i;
            UILabel *round = [[UILabel alloc] init];
            round.bounds = CGRectMake(0, 0, roundW, roundH);
            round.center = CGPointMake(roundCentX, roundY);
            round.backgroundColor = [UIColor blackColor];
            round.clipsToBounds = YES;
            round.layer.cornerRadius = roundW / 2;
            round.hidden = YES;
            [inputView addSubview:round];
            [self.arrayRounds addObject:round];
            
            if (i != 0) {
                CGFloat devideViewX = tempWidth * i;
                CGFloat devideViewH = inputViewH;
                CGFloat devideViewW = 0.5;
                UIView *devideView = [[UIView alloc] initWithFrame:CGRectMake(devideViewX, 0, devideViewW, devideViewH)];
                devideView.backgroundColor = [UIColor lightGrayColor];
                [inputView addSubview:devideView];
            }
        }
        
        //UITextField
        UITextField *textField = [[UITextField alloc] initWithFrame:receiptView.bounds];
        textField.hidden = YES;
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [receiptView addSubview:textField];
        self.textFiled = textField;
    }
}

- (void)setRoundCount:(NSInteger)count
{
    [self.arrayRounds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *round = (UILabel *)obj;
        round.hidden = YES;
    }];
    
    for (int i = 0; i < count; i ++) {
        UILabel *round = [self.arrayRounds objectAtIndex:i];
        round.hidden = NO;
    }
}

- (void)dismiassButtonClick
{
    [self.textFiled resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        self.receiptView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        self.receiptView.alpha = 0.0;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 6 && string.length) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    [self setRoundCount:totalString.length];
    
    if (totalString.length == 6) {
        if (self.completeBlock) {
            self.completeBlock(totalString);
        }
        [self performSelector:@selector(dismiassButtonClick) withObject:nil afterDelay:.3];
    }
    return YES;
}

#pragma mark 
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLbl.text = title;
}

- (void)setDetail:(NSString *)detail
{
    _detail = [detail copy];
    self.detailLbl.text = detail;
}

- (void)setAmount:(CGFloat)amount
{
    _amount = amount;
    self.amoutLbl.text = [NSString stringWithFormat:@"￥%.2f",amount];
}
@end
