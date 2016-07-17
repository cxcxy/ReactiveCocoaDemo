//
//  TwoViewController.m
//  ReactiveCocoaDemo
//
//  Created by 陈旭 on 16/7/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dissmisBtn;

- (IBAction)clickSentSiganl:(id)sender;

@end

@implementation TwoViewController
-(void)dealloc{
    NSLog(@"页面销毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof (self)weakSelf = self;
    [[self.dissmisBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickSentSiganl:(id)sender {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"hahha"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HAHAHA" object:@"ninini"];
}
@end
