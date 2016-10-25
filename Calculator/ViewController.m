//
//  ViewController.m
//  Calculator
//
//  Created by Alena on 10/16/16.
//  Copyright (c) 2016 Alena. All rights reserved.
//

#import "ViewController.h"


typedef NS_ENUM(NSInteger, Operation) {
    OperationNone = 0,
    OperationAdd,
    OperationSubtract,
    OperationMultiply,
    OperationDivide
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation ViewController {
    double result;
    
    BOOL shouldClear;
    
    BOOL dotUsed;
    
    Operation previousOperation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    result = 0.0;
    shouldClear = NO;
    dotUsed = NO;
    previousOperation = OperationNone;
}

- (void)performPreviousOperation {
    double op1 = result;
    double op2 = [_inputField.text doubleValue];
    
    switch (previousOperation) {
        case OperationNone:
            result = op2;
            break;
            
        case OperationAdd:
            result = op1 + op2;
            break;
            
        case OperationDivide:
            result = op1 / op2;
            break;
            
        case OperationSubtract:
            result = op1 - op2;
            break;
            
        case OperationMultiply:
            result = op1 * op2;
            break;
    }
}

- (BOOL)isInteger:(double)number {
    double temp = floor(number);
    
    return (temp == number);
}

- (void)handleOperation:(Operation)operation {
    [self performPreviousOperation];
    
    previousOperation = operation;
    shouldClear = YES;
    dotUsed = NO;
    
    if ([self isInteger:result]) {
        _inputField.text = [NSString stringWithFormat:@"%ld", (NSInteger)result];
    } else {
        _inputField.text = [NSString stringWithFormat:@"%f", result];
    }
}

#pragma mark - Button Actions

- (IBAction)digitButtonTapped:(id)sender {
    if (shouldClear) {
        _inputField.text = @"";
        shouldClear = NO;
    }
    
    NSString *currentText = _inputField.text;
    NSInteger digit = ((UIButton *)sender).tag;
    currentText = [currentText stringByAppendingFormat:@"%ld", (long)digit];
    _inputField.text = currentText;
}

- (IBAction)plusButtonTapped:(id)sender {
    [self handleOperation:OperationAdd];
}

- (IBAction)minusButtonTapped:(id)sender {
    [self handleOperation:OperationSubtract];
}

- (IBAction)multiplyButtonTapped:(id)sender {
    [self handleOperation:OperationMultiply];
}

- (IBAction)divideButtonTapped:(id)sender {
    [self handleOperation:OperationDivide];
}

- (IBAction)dotButtonTapped:(id)sender {
    if (dotUsed) {
        return;
    }
    
    dotUsed = YES;
    
    if (shouldClear) {
        _inputField.text = @"0.";
        shouldClear = NO;
        return;
    }
    
    NSString *currentText = _inputField.text;
    currentText = [currentText stringByAppendingString:(_inputField.text.length == 0) ? @"0." : @"."];
    _inputField.text = currentText;
}

- (IBAction)clearButtonTapped:(id)sender {
    previousOperation = OperationNone;
    _inputField.text = @"";
    result = 0.0;
    shouldClear = NO;
}

- (IBAction)equalButtonTapped:(id)sender {
    [self handleOperation:OperationNone];
}



@end
