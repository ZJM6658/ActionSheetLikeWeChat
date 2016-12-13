//
//  JM_ActionSheet.m
//  CustomActionSheet
//
//  Created by zhujiamin on 2016/12/9.
//  Copyright © 2016年 zhujiamin. All rights reserved.
//

#import "JM_ActionSheet.h"
#import "UIView+JMExtension.h"

@interface JM_ActionSheet () {
    UIView *_backgroundView;        //背景View
    CGFloat _groupSpaceHeight;      //组间距
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JM_ActionSheet

#pragma mark - initialize
- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self layoutUI];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<JM_ActionSheetDelegate>)delegate {
    if ([self init]) {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - private
//UI布局
- (void)layoutUI {
    _groupSpaceHeight = 8;
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor grayColor];
    _backgroundView.alpha = 0;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)]];
    [self addSubview:_backgroundView];
    [self addSubview:self.tableView];
}

//计算tableView应设的高度
- (CGFloat)calculateTableHeight {
    if (!self.dataSource.count) {
        return 0;
    }
    CGFloat tableHeiht = 0;
    
    for (NSArray *subArray in self.dataSource) {
        for (M_SheetItem *item in subArray) {
            tableHeiht += item.height;
        }
    }
    tableHeiht += (self.dataSource.count - 1) * _groupSpaceHeight;
    return tableHeiht;
}

#pragma mark - outside
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.5;
        self.tableView.y = self.height - self.tableView.height;
    }];
}

- (void)cancel {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = self.height;
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.height, self.width, [self calculateTableHeight]) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

#pragma mark - setter
- (void)setDataSource:(NSArray<NSArray *> *)dataSource {
    _dataSource = dataSource;
    self.tableView.height = [self calculateTableHeight];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSource[indexPath.section];
    M_SheetItem *item = array[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, item.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = item.title;
    label.numberOfLines = 0;
    label.textColor = item.textColor;
    label.font = item.textFont;
    [cell addSubview:label];
    if (item.isTitle) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSource[indexPath.section];
    M_SheetItem *item = array[indexPath.row];
    if (item.isTitle) return;
    
    if ([self.delegate respondsToSelector:@selector(jm_actionSheet:clickedItem:atIndex:)]) {
        [self.delegate jm_actionSheet:self clickedItem:item atIndex:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self cancel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSource[indexPath.section];
    M_SheetItem *item = array[indexPath.row];
    return item.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return _groupSpaceHeight;
    }
    return CGFLOAT_MIN;
}

@end


@implementation M_SheetItem

#pragma mark - initialize
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        _isTitle = NO;
    }
    return self;
}

#pragma mark - getter
- (NSString *)title {
    if (!_title) {
        return @"请设置标题";
    }
    return _title;
}

- (UIColor *)textColor {
    if (!_textColor) {
        return [UIColor blackColor];
    }
    return _textColor;
}

- (UIFont *)textFont {
    if (!_textFont) {
        return [UIFont systemFontOfSize:15];
    }
    return _textFont;
}

- (CGFloat)height {
    if (!_height) {
        return 44;
    }
    return _height;
}

@end




