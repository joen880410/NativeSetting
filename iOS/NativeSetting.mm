//
//  SettingBoxMessage.m
//  Unity-iPhone
//
//  Created by jacfit on 2024/11/12.
//

#import <UIKit/UIAlertController.h>
#import <Foundation/Foundation.h>
extern "C" void NativeSetting_Setting( const char *title_Str, const char *message_Str, const char *open_Str,const char *cancel_Str)
{
    
    NSString *title = [NSString stringWithUTF8String:title_Str ? title_Str : ""];
    NSString *message = [NSString stringWithUTF8String:message_Str ? message_Str : ""];
    NSString *openStr = [NSString stringWithUTF8String:open_Str ? open_Str : ""];
    NSString *cancelStr = [NSString stringWithUTF8String:cancel_Str ? cancel_Str : ""];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // "前往設定" 按鈕
    UIAlertAction *openSettingsAction = [UIAlertAction actionWithTitle:openStr
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:appSettings]) {
            [[UIApplication sharedApplication] openURL:appSettings options:@{} completionHandler:nil];
        }
    }];
    
    // "取消" 按鈕
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:openSettingsAction];
    [alert addAction:cancelAction];
    // 顯示警告框
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (topController) {
        [topController presentViewController:alert animated:YES completion:nil];
    }
    
}
