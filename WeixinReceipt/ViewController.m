//
//  ViewController.m
//  WeixinReceipt
//
//  Created by chenfenglong on 16/2/18.
//  Copyright © 2016年 YS. All rights reserved.
//

#import "ViewController.h"
#import "ReceiptView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ReceiptView *receiptView = [[ReceiptView alloc] init];
    receiptView.title = @"请输入支付密码";
    receiptView.detail = @"提现";
    receiptView.amount = 10;
    [receiptView show];
    receiptView.completeBlock = ^(NSString *secrt){
        NSLog(@"%@",secrt);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
