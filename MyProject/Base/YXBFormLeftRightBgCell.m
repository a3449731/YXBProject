//
//  SweetCell.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/6.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBFormLeftRightBgCell.h"

NSString *const YXBFormRowDescriptorLeftRightBackgroundCell = @"YXBFormRowDescriptorLeftRightBackgroundCell";

@interface YXBFormLeftRightBgCell () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) UIKeyboardType keyboardType;

@end

@implementation YXBFormLeftRightBgCell

+ (void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[YXBFormLeftRightBgCell class] forKey:YXBFormRowDescriptorLeftRightBackgroundCell];
}

- (void)configure {
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self creatUI];
}

- (void)creatUI {
    
    UIView *bgView= [[UIView alloc] init];
    bgView.backgroundColor = YXBColorBG_gray;
    bgView.layer.cornerRadius = 4;
    bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = YXBColorBlack;
    [bgView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.width.mas_greaterThanOrEqualTo(80);
        make.width.priorityLow();
    }];
    
    self.textField = [[UITextField alloc] init];
    self.textField.delegate = self;
    self.textField.font = [UIFont boldSystemFontOfSize:14];
    self.textField.textColor = YXBColorBlack;
    [bgView addSubview:self.textField];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(15);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

// 修改键盘
- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    if (_keyboardType != keyboardType) {
        _keyboardType = keyboardType;
        self.textField.keyboardType = keyboardType;
    }
}

- (void)update {
    [super update];
    // 设置占位符颜色
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName:YXBColorGray}];
    self.titleLabel.text = self.rowDescriptor.title;
    self.textField.text = self.rowDescriptor.value ? [self.rowDescriptor displayTextValue] : self.rowDescriptor.noValueDisplayText;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self.formViewController textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if([self.textField.text length] > 0) {
        BOOL didUseFormatter = NO;
        
        if (self.rowDescriptor.valueFormatter && self.rowDescriptor.useValueFormatterDuringInput)
        {
            // use generic getObjectValue:forString:errorDescription and stringForObjectValue
            NSString *errorDescription = nil;
            NSString *objectValue = nil;
            
            if ([ self.rowDescriptor.valueFormatter getObjectValue:&objectValue forString:textField.text errorDescription:&errorDescription]) {
                NSString *formattedValue = [self.rowDescriptor.valueFormatter stringForObjectValue:objectValue];
                
                self.rowDescriptor.value = objectValue;
                textField.text = formattedValue;
                didUseFormatter = YES;
            }
        }
        
        // only do this conversion if we didn't use the formatter
        if (!didUseFormatter)
        {
            if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeNumber] || [self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeDecimal]){
                self.rowDescriptor.value =  [NSDecimalNumber decimalNumberWithString:self.textField.text locale:NSLocale.currentLocale];
            } else if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeInteger]){
                self.rowDescriptor.value = @([self.textField.text integerValue]);
            } else {
                self.rowDescriptor.value = self.textField.text;
            }
        }
    } else {
        self.rowDescriptor.value = nil;
    }
}

-(void)dealloc {
    [self.textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.delegate = nil;
}

@end
