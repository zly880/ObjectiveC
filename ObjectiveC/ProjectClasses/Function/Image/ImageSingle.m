//
//  ImageSingle.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "ImageSingle.h"

@interface ImageSingle () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController *fromVC;
@property (nonatomic, copy  ) PickerCompletion completion;
@property (nonatomic, copy  ) PickerCancel     cancel;

@end

@implementation ImageSingle

/**
 获取模块单例
 
 @return 实例对象
 */
+ (ImageSingle *)shareInstance {
    
    static ImageSingle *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[ImageSingle alloc] init];
    });
    
    return instance;
}

/**
 弹出列表，选择拍照或者选择照片
 
 @param fromVC     来源控制器
 @param completion 完成回调
 @param cancel     取消回调
 */
- (void)imageSingleFromVC:(UIViewController *)fromVC
               completion:(PickerCompletion)completion
                   cancel:(PickerCancel)cancel {
    
    _fromVC = fromVC;
    _completion = completion;
    _cancel = cancel;
    
    [UIAlertController actionSheetFromVC:_fromVC
                                   title:@"图片单选"
                                 message:nil
                            buttonTitles:@[@"拍照", @"选择", @"取消"]
                                  blocks:^(UIAlertAction *action) {
                                      if ([action.title isEqualToString:@"拍照"]) {
                                          [self takePhoto];
                                      } else if ([action.title isEqualToString:@"选择"]) {
                                          [self addPhoto];
                                      } else {
                                          if (_cancel) {
                                              _cancel();
                                          }
                                      }
                                  }];
}

- (void)addPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    picker.navigationBar.barTintColor = _fromVC.navigationController.navigationBar.barTintColor;
    picker.navigationBar.tintColor = _fromVC.navigationController.navigationBar.tintColor;
    picker.navigationBar.titleTextAttributes = _fromVC.navigationController.navigationBar.titleTextAttributes;
    [_fromVC presentViewController:picker animated:YES completion:nil];
}

- (void)takePhoto {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.navigationBar.barTintColor = _fromVC.navigationController.navigationBar.barTintColor;
        picker.navigationBar.tintColor = _fromVC.navigationController.navigationBar.tintColor;
        picker.navigationBar.titleTextAttributes = _fromVC.navigationController.navigationBar.titleTextAttributes;
        [_fromVC presentViewController:picker animated:YES completion:nil];
    } else {
        [Toast showFailed:@"您的设备不支持拍照"];
    }
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSURL *url = [info valueForKey:UIImagePickerControllerReferenceURL];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_completion) {
            _completion(image, url);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_cancel) {
            _cancel();
        }
    }];
}

@end
