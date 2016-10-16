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
    
    Operation previousOperation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    result = 0.0;
    shouldClear = NO;
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

- (void)handleOperation:(Operation)operation {
    [self performPreviousOperation];
    
    previousOperation = operation;
    shouldClear = YES;
    _inputField.text = [NSString stringWithFormat:@"%f", result];
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
    
}

- (IBAction)clearButtonTapped:(id)sender {
    previousOperation = OperationNone;
    _inputField.text = @"";
    result = 0.0;
    shouldClear = NO;
}

- (IBAction)equalButtonTapped:(id)sender {
    [self performPreviousOperation];
    
    previousOperation = OperationNone;
    shouldClear = YES;
    _inputField.text = [NSString stringWithFormat:@"%f", result];
}



@end
