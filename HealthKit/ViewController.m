//
//  ViewController.m
//  HealthKit
//
//  Created by liuxingchen on 16/10/21.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import <HealthKit/HealthKit.h>
@interface ViewController ()
/**
 * 行走步数
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCount;

@property (nonatomic, strong) HKHealthStore *healthStore;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //查看healthKit在设备上是否可用
    if (![HKHealthStore isHealthDataAvailable])
    {
        NSLog(@"设备不支持healthKit");
    }
    [self setupHealthStore];
    
}
//1.获取权限
-(void)setupHealthStore
{
    self.healthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限(获取步数、心跳、身高...)这里获取步数
    HKObjectType * stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSSet *healthSet = [NSSet setWithObjects:stepCount, nil];
    //health应用中获取权限 
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"success");
        }else{
            NSLog(@"error");
        }
    }];
    
}

- (IBAction)moveCount:(id)sender
{
    [self readStepCount];
}

//2.读取步数
-(void)readStepCount
{   //查询的基类是HKQuery，这是抽象出来的类，能够实现每一种查询目标
    /**
     *  quantityTypeForIdentifier:这个方法需要传入一个采样信息(步数、心跳、身高...)
     */
    //查询采样信息
    HKSampleType *samleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    //NSSortDescriptors用来告诉healthStore
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    /**
     SampleType:样本检查类型
     predicate:未知
     limit:样品返回的最大数量。参数为HKObjectQueryNoLimit没有限制
     sortDescriptors:未知
     */
    HKSampleQuery * sampleQuery = [[HKSampleQuery alloc]initWithSampleType:samleType predicate:nil limit:1 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        NSLog(@"resultCtount = %ld  result = %@",results.count ,results);
        //对结果进行单位换算
        HKQuantitySample * result = results[0];
        HKQuantity *quantity = result.quantity;
        NSString *string = (NSString *)quantity;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.labelCount.text = [NSString stringWithFormat:@"%@步",string];
        }];
        
    }];
    [self.healthStore executeQuery:sampleQuery];
}
@end
