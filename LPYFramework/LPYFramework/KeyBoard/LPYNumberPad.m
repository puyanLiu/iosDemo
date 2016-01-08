//
//  LPYNumberPad.m
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYNumberPad.h"
#import "LPYNumberButton.h"

#define keyboardH 216.0f
#define keyboardW [UIScreen mainScreen].bounds.size.width

@interface LPYNumberPad()
// 所有数字按钮
@property (nonatomic, copy) NSArray *numberButtons;
// 左边按钮
@property (nonatomic, strong) LPYNumberButton *leftButton;
// 右边按钮
@property (nonatomic, strong) UIButton *clearButton;
// delegate
@property (nonatomic, weak) id<LPYNumberPadDelegate> delegate;
// 自动检测文本输入
@property (nonatomic, weak) UIResponder<UITextInput> *textInput;
// 键盘样式
@property (nonatomic, strong) Class<LPYNumberPadStyle> styleClass;
@end

@implementation LPYNumberPad

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate {
    return [self numberPadWithDelegate:delegate numberPadStyleClass:nil];
}

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass {
    return [[self alloc] initWithDelegate:delegate numberPadStyleClass:styleClass];
}

- (instancetype)initWithDelegate:(id<LPYNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.styleClass = styleClass;
        self.frame = [self.styleClass numberPadFrame];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight; // 支持旋转
        self.backgroundColor = [self.styleClass numberPadBackgroundColor];
        [self addNotificationsObservers];
        
        self.delegate = delegate;
        
        NSMutableArray *numbersButtons = [NSMutableArray array];
        for (int i = 0; i < 11; i++) {
            LPYNumberButton *numberButton = [self numberButton:i];
            [self addSubview:numberButton];
            [numbersButtons addObject:numberButton];
        }
        self.numberButtons = numbersButtons;
        
        // clearButton
        self.clearButton = [self functionButton];
        [self.clearButton setImage:[self.styleClass clearFunctionButtonImage] forState:UIControlStateNormal];
        [self.clearButton addTarget:self action:@selector(btn_ClearClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerAction:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [self.clearButton addGestureRecognizer:longPressGestureRecognizer];
        [self addSubview:self.clearButton];
    }
    return self;
}

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)longPress {

}

- (void)btn_ClearClick {
    
}

#pragma mark - UIResponder 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

#pragma mark - 数字按钮
- (LPYNumberButton *)numberButton:(int)number {
    LPYNumberButton *btn = [LPYNumberButton buttonWithBackgroundColor:[self.styleClass numberButtonBackgroundColor] highlightedColor:[self.styleClass numberButtonHighlightedColor]];
    [btn setTitleColor:[self.styleClass numberButtonTextColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [self.styleClass numberButtonFont];
    [btn setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    return btn;
}

- (LPYNumberButton *)functionButton {
    LPYNumberButton *btn = [LPYNumberButton buttonWithBackgroundColor:[self.styleClass functionButtonBackgroundColor] highlightedColor:[self.styleClass functionButtonHighlightedColor]];
    btn.exclusiveTouch = YES;
    return btn;
}

#pragma mark - 通知
- (void)addNotificationsObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidBeginEditing:(NSNotification *)notification {

}

- (void)textDidEndEditing:(NSNotification *)notification {
    
}
@end
