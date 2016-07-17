//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by 陈旭 on 16/7/15.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "ViewController.h"

#import "TwoViewController.h"

//#define RAC(TARGET, [KEYPATH, [NIL_VALUE]])

@interface ViewController ()
{
    
    __weak IBOutlet UIButton *blackBtn;
    __weak IBOutlet UIView *redView;
}
@property (weak, nonatomic) IBOutlet UIButton *ListeningClickBtn;
- (IBAction)ListeningClickAction:(id)sender;

- (IBAction)testActionClick:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField *testTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    testTF.backgroundColor = [UIColor redColor];
    testTF.textColor = [UIColor blueColor];
    [self.view addSubview:testTF];
    /**
     *  检测testFiled的输入事件
     *
     */
//    [testTF.rac_textSignal subscribeNext:^(id x){
//        NSLog(@"%@", x);
//    }];
//    [[testTF.rac_textSignal
//      filter:^BOOL(id value){
//          NSString * text = value;
//          return text.length > 3;
//      }]
//     subscribeNext:^(id x){
//         NSLog(@"%@", x);
//     }];
//
    /**
     *  检测输入多少字之后的事件
     *
     */
//    [[[testTF.rac_textSignal
//       map:^id(NSString*text){
//           return @(text.length);
//       }]
//      filter:^BOOL(NSNumber*length){
//          return[length integerValue] > 3;
//      }]
//     subscribeNext:^(id x){
//         NSLog(@"%@", x);
//     }];
    
    /**
     *  指定多少字数之后 发生变化
     *  首先创建一个RACSignal 信号 监听 输入字符串的值
     */
    RACSignal *validPasswordSignal =
    [testTF.rac_textSignal
     map:^id(NSString *text) {
         return [self isValidPassword:text];
     }];
    
    /**
     *  接受信号返回的值 通过这个值 判断处理业务逻辑
     *
     */
    [[validPasswordSignal
      map:^id(NSNumber *passwordValid){
          return [passwordValid intValue] >= 11 ? [UIColor redColor]:[UIColor yellowColor];
      }]
     subscribeNext:^(UIColor *color){
         testTF.backgroundColor = color;
     }];
    /**
     *
     *  遍历数组
     */
    NSArray *numbers = @[@1,@2,@3,@4];
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"数组的值－－%@",x);
    }];
    /**
     *
     * 遍历字典
     */
    NSDictionary *dict = @{@"name":@"cx",@"age":@23};
    [dict.rac_sequence.signal subscribeNext:^(id x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"%@,%@",key,value);
    }];
//    [blackBtn rac_signalForSelector:@selector(clickView)];
//    [[self.ListeningClickBtn rac_signalForSelector:@selector(ListeningClickAction:)] subscribeNext:^(id x) {
//        NSLog(@"监听到按钮被点击");
//    }];
    /**
     *
     * 按钮点击事件
     */
    [[blackBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮被电击了");
    }];
    /**
     *
     * 通知操作
     */
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"HAHAHA" object:nil] subscribeNext:^(id x) {
        NSLog(@"收到发送通知操作%@",x);
    }];
}
-(void)clickView{
    NSLog(@"点击了红色View");
}
-(NSNumber *)isValidPassword:(NSString *)str{
    return @(str.length);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ListeningClickAction:(id)sender {
    NSLog(@"你点击了监听按钮");
}

- (IBAction)testActionClick:(id)sender {
    TwoViewController *controller = [[TwoViewController alloc] init];

    controller.delegateSignal = [RACSubject subject];// 设置代理信号
    // 订阅代理代理信号
    [controller.delegateSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮 %@",x);
    }];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
