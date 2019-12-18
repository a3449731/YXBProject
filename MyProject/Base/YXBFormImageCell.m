//
//  YXBFormImageCell.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/7.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBFormImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const YXBFormRowDescriptorTypeImageCell = @"YXBFormRowDescriptorTypeImageCell";

@interface YXBFormImageCell ()

@property (nonatomic, assign) UIEdgeInsets imageInset;

@end

@implementation YXBFormImageCell

+ (void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[YXBFormImageCell class] forKey:YXBFormRowDescriptorTypeImageCell];
}

- (void)configure {
    [super configure];
    [self creatUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)creatUI {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (void)setImageInset:(UIEdgeInsets)imageInset {
    _imageInset = imageInset;
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageInset.left);
        make.top.mas_equalTo(imageInset.top);
        make.bottom.mas_equalTo(-imageInset.bottom);
        make.right.mas_equalTo(-imageInset.right);
    }];
}

- (void)update {
    [super update];
    NSString *string = self.rowDescriptor.value;
    if (string) {
        if ([string hasPrefix:@"http"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:string]];
        } else {
            self.imageView.image = [UIImage imageNamed:string];
        }
    }
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
    if (self.rowDescriptor.action.formBlock){
        self.rowDescriptor.action.formBlock(self.rowDescriptor);
    }
    else if (self.rowDescriptor.action.formSelector){
        [controller performFormSelector:self.rowDescriptor.action.formSelector withObject:self.rowDescriptor];
    }
    else if ([self.rowDescriptor.action.formSegueIdentifier length] != 0){
        [controller performSegueWithIdentifier:self.rowDescriptor.action.formSegueIdentifier sender:self.rowDescriptor];
    }
    else if (self.rowDescriptor.action.formSegueClass){
        UIViewController * controllerToPresent = [self controllerToPresent];
        NSAssert(controllerToPresent, @"either rowDescriptor.action.viewControllerClass or rowDescriptor.action.viewControllerStoryboardId or rowDescriptor.action.viewControllerNibName must be assigned");
        UIStoryboardSegue * segue = [[self.rowDescriptor.action.formSegueClass alloc] initWithIdentifier:self.rowDescriptor.tag source:controller destination:controllerToPresent];
        [controller prepareForSegue:segue sender:self.rowDescriptor];
        [segue perform];
    }
    else{
        UIViewController * controllerToPresent = [self controllerToPresent];
        if (controllerToPresent){
            if ([controllerToPresent conformsToProtocol:@protocol(XLFormRowDescriptorViewController)]){
                ((UIViewController<XLFormRowDescriptorViewController> *)controllerToPresent).rowDescriptor = self.rowDescriptor;
            }
            if (controller.navigationController == nil || [controllerToPresent isKindOfClass:[UINavigationController class]] || self.rowDescriptor.action.viewControllerPresentationMode == XLFormPresentationModePresent){
                [controller presentViewController:controllerToPresent animated:YES completion:nil];
            }
            else{
                [controller.navigationController pushViewController:controllerToPresent animated:YES];
            }
        }
        
    }
}

-(UIViewController *)controllerToPresent {
    if (self.rowDescriptor.action.viewControllerClass){
        return [[self.rowDescriptor.action.viewControllerClass alloc] init];
    }
    else if ([self.rowDescriptor.action.viewControllerStoryboardId length] != 0){
        UIStoryboard * storyboard =  [self storyboardToPresent];
        NSAssert(storyboard != nil, @"You must provide a storyboard when rowDescriptor.action.viewControllerStoryboardId is used");
        return [storyboard instantiateViewControllerWithIdentifier:self.rowDescriptor.action.viewControllerStoryboardId];
    }
    else if ([self.rowDescriptor.action.viewControllerNibName length] != 0){
        Class viewControllerClass = NSClassFromString(self.rowDescriptor.action.viewControllerNibName);
        NSAssert(viewControllerClass, @"class owner of self.rowDescriptor.action.viewControllerNibName must be equal to %@", self.rowDescriptor.action.viewControllerNibName);
        return [[viewControllerClass alloc] initWithNibName:self.rowDescriptor.action.viewControllerNibName bundle:nil];
    }
    return nil;
}

-(UIStoryboard *)storyboardToPresent {
    if ([self.formViewController respondsToSelector:@selector(storyboardForRow:)]){
        return [self.formViewController storyboardForRow:self.rowDescriptor];
    }
    if (self.formViewController.storyboard){
        return self.formViewController.storyboard;
    }
    return nil;
}

@end
