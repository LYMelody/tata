//
//  ViewController.m
//  地理位置反编码
//
//  Created by rongfeng on 15/9/9.
//  Copyright (c) 2015年 rongfeng. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController {
    
    CLLocationManager *maneger;
    CLGeocoder *geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    maneger = [[CLLocationManager alloc] init];
    maneger.delegate = self;
    //maneger.desiredAccuracy = kCLLocationAccuracyBest;
    maneger.distanceFilter = 10;
    [maneger requestAlwaysAuthorization];
    [maneger startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [maneger requestWhenInUseAuthorization];
    }
    
    
    
    geocoder = [[CLGeocoder alloc] init];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *mylocation = [locations lastObject];
    NSLog(@"经纬度为：%f,%f",mylocation.coordinate.latitude,mylocation.coordinate.longitude);
    [maneger stopUpdatingLocation];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mylocation.coordinate.latitude longitude:mylocation.coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        else {
            NSLog(@"%@",placemarks);
        }
    }];
    
}

//获取新浪微博对象
- (SinaWeibo *)sinaweibo
{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.sinaweibo;
}
//判断是否授权，如果没有授权则授权并登录，如果授权则申请微博列表
- (void)requestSinaWeiboInformation {
    
    
    if (![self sinaweibo].isAuthValid) {
        
        [[self sinaweibo] logIn];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
