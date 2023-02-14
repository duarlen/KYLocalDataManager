//
//  KYViewController.m
//  KYLocalDataManager
//
//  Created by huasheng on 02/14/2023.
//  Copyright (c) 2023 huasheng. All rights reserved.
//

#import "KYViewController.h"
#import <KYLocalDataManager/KYLocalDataManager.h>

@interface KYViewController ()

@end

@implementation KYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@":%@", NSHomeDirectory());
    
    [KYLocalDataManager shareInstance].currentUserId = @"2141611";
    [[KYLocalDataManager shareInstance] setObject:@"k555" key:@"k555" common:NO];
    NSString *value = [[KYLocalDataManager shareInstance] objectForKey:@"k333" common:YES];
    NSLog(@" %@", value);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
