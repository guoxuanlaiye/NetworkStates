//
//  ViewController.m
//  NetworkStates
//
//  Created by yingcan on 17/4/7.
//  Copyright © 2017年 guoxuan. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statesLabel;
@property (nonatomic, strong) Reachability * internetConnectionReach;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reachability * internetConnectionReach = [Reachability reachabilityForInternetConnection];
    internetConnectionReach.reachableBlock = ^(Reachability * reachability) {
        NSLog(@"reachableString == %@",reachability.currentReachabilityString);
        NSString * stateStr = [NSString stringWithFormat:@"%@",reachability.currentReachabilityString];
        //WiFi、4G、3G等
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statesLabel.text = stateStr;
        });
    };
    internetConnectionReach.unreachableBlock = ^(Reachability * reachability) {
        NSLog(@"unreachableString == %@",reachability.currentReachabilityString);
        NSString * stateStr = [NSString stringWithFormat:@"%@",reachability.currentReachabilityString];
        //No Connection
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statesLabel.text = stateStr;
        });
    };
    [internetConnectionReach startNotifier];
}



@end
