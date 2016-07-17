//
//  TwoViewController.h
//  ReactiveCocoaDemo
//
//  Created by 陈旭 on 16/7/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController

@property(nonatomic,strong)RACSubject *delegateSignal;
@end
