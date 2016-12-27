//
//  JM_ActionSheet.h
//  CustomActionSheet
//
//  Created by zhujiamin on 2016/12/9.
//  Copyright © 2016年 zhujiamin. All rights reserved.
//

#import <UIKit/UIKit.h>

//每一行的样式Model(字体颜色、字号、行高有默认值,也可以自定义)
@interface M_SheetItem : NSObject

@property(nonatomic, strong) NSString *title;       //标题
@property(nonatomic, strong) UIColor *textColor;    //字体颜色 default is blackColor;
@property(nonatomic, strong) UIFont *textFont;      //字号 default is 15;
@property(nonatomic) CGFloat height;                //行高 default is 44;
@property(nonatomic) BOOL isTitle;                  //标题无法点击 default is NO;

- (instancetype)initWithTitle:(NSString *)title;
@end

@protocol JM_ActionSheetDelegate;

@interface JM_ActionSheet : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSArray *> *dataSource;   //数据源, 外层数组为组数,内层数组为每组行数 ex:@[@[@"xx",@"zz", ...],@[@"yy",...],...]
@property(nonatomic,weak) id<JM_ActionSheetDelegate> delegate;  //调用方,需要实现协议方法

- (instancetype)initWithDelegate:(id<JM_ActionSheetDelegate>)delegate;
- (void)show;
- (void)cancel;

@end

@protocol JM_ActionSheetDelegate <NSObject>

- (void)jm_actionSheet:(JM_ActionSheet *)jm_actionSheet clickedItem:(M_SheetItem *)item atIndex:(NSIndexPath *)indexPath;   //item点击事件

//- (void)jm_actionSheetCancel:(JM_ActionSheet *)jm_actionSheet;    //暂时用不到退出时的代理方法
@end
