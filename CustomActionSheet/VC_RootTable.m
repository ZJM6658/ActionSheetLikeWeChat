//
//  VC_RootTable.m
//  CustomActionSheet
//
//  Created by zhujiamin on 2016/12/9.
//  Copyright © 2016年 zhujiamin. All rights reserved.
//

#import "VC_RootTable.h"
#import "JM_ActionSheet.h"

@interface VC_RootTable ()<JM_ActionSheetDelegate>
@property (nonatomic, strong) NSArray<NSString *> *dataSource;
@end

@implementation VC_RootTable
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义ActionSheet";
    self.dataSource = @[@"一组", @"两组不带title", @"两组带title", @"两组多行,不同颜色,不同高度", @"多组"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    M_SheetItem *titleitem = [[M_SheetItem alloc] initWithTitle:@"删除后将无法恢复,确定要删除吗？"];
    titleitem.textFont = [UIFont systemFontOfSize:12];
    titleitem.textColor = [UIColor grayColor];
    titleitem.height = 40;
    titleitem.isTitle = YES;
    
    M_SheetItem *item0 = [[M_SheetItem alloc] initWithTitle:@"删除好友"];
    
    M_SheetItem *item1 = [[M_SheetItem alloc] initWithTitle:@"取消"];
    item1.textColor = [UIColor redColor];
    
    M_SheetItem *item2 = [[M_SheetItem alloc] initWithTitle:@"删除好友"];
    item2.textFont = [UIFont systemFontOfSize:14];
    item2.textColor = [UIColor orangeColor];
    item2.height = 50;
    
    M_SheetItem *item3 = [[M_SheetItem alloc] initWithTitle:@"党章，是一个政党为保证全党在政治上，思想上的一致和组织上，行动上的统一所制定的章程。一个党的党章的主要内容应该包括该党的性质、指导思想、纲领任务、组织结构、组织制度，党员的条件、权利、义务和纪律等项。通常衡量一个政党是否成熟党章也是关键因素之一。"];
    item3.textFont = [UIFont systemFontOfSize:18];
    item3.textColor = [UIColor blueColor];
    item3.height = 20;
    
    M_SheetItem *item4 = [[M_SheetItem alloc] initWithTitle:@"党章，是一个政党为保证全党在政治上，思想上的一致和组织上，行动上的统一所制定的章程。一个党的党章的主要内容应该包括该党的性质、指导思想、纲领任务、组织结构、组织制度，党员的条件、权利、义务和纪律等项。通常衡量一个政党是否成熟党章也是关键因素之一。"];
    item4.textFont = [UIFont systemFontOfSize:10];
    item4.textColor = [UIColor purpleColor];
    item4.height = 80;
    
    NSInteger row = indexPath.row;
    //组装数据源
    NSArray *dataArray;
    if (row == 0) {
        dataArray = @[@[item0]];
    } else if (row == 1) {
        dataArray = @[@[item0],@[item1]];
    } else if (row == 2) {
        dataArray = @[@[titleitem, item0],@[item1]];
    } else if (row == 3) {
        dataArray = @[@[titleitem, item0, item2, item3, item4],@[item1]];
    } else if (row == 4) {
        dataArray = @[@[titleitem, item0], @[titleitem, item1], @[titleitem, item2]];
    }
    
    JM_ActionSheet *sheet = [[JM_ActionSheet alloc] initWithDelegate:self];
    [sheet setDataSource:dataArray];
    [sheet show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - JM_ActionSheetDelegate
- (void)jm_actionSheet:(JM_ActionSheet *)jm_actionSheet clickedItem:(M_SheetItem *)item atIndex:(NSIndexPath *)indexPath {
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"点击了%@", item.title] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil] show];
}

@end
