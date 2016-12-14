# ActionSheetLikeWeChat
高度自定义的ActionSheet(类似微信)
###代码原理
1、`JM_ActionSheet`继承于`UIView`，它根据`M_SheetItem`来显示每一行的样式:

```
	//每一行的样式Model(字体颜色、字号、行高有默认值,也可以自定义)
	@interface M_SheetItem : NSObject

	@property(nonatomic, strong) NSString *title;       //标题
	@property(nonatomic, strong) UIColor *textColor;    //字体颜色 default is blackColor;
	@property(nonatomic, strong) UIFont *textFont;      //字号 default is 15;
	@property(nonatomic) CGFloat height;                //行高 defaule is 44;
	@property(nonatomic) BOOL isTitle;                  //标题无法点击 defaule is NO;

	- (instancetype)initWithTitle:(NSString *)title;
	@end

```

2、需要调用`JM_ActionSheet`的类需要遵循`JM_ActionSheetDelegate`，并实现点击处理方法

```
	@protocol JM_ActionSheetDelegate <NSObject>

	- (void)jm_actionSheet:(JM_ActionSheet *)jm_actionSheet clickedItem:(M_SheetItem *)item atIndex:(NSIndexPath *)indexPath;   //item点击事件

	@end

```

###如何使用
1、导入头文件

```
	#import "JM_ActionSheet.h"

```

2、调用方法

```
	//构造数据源
	M_SheetItem *titleitem = [[M_SheetItem alloc] initWithTitle:@"删除后将无法恢复,确定要删除吗？"];
	titleitem.textFont = [UIFont systemFontOfSize:12];
	titleitem.textColor = [UIColor grayColor];
	titleitem.height = 40;
	titleitem.isTitle = YES; //标题item

	M_SheetItem *item0 = [[M_SheetItem alloc] initWithTitle:@"删除好友"];
	item0.textFont = [UIFont systemFontOfSize:14];
	item0.textColor = [UIColor orangeColor];
	item0.height = 50;

	M_SheetItem *item1 = [[M_SheetItem alloc] initWithTitle:@"取消"];
	item1.textColor = [UIColor redColor];
    
    //初始化对象+组装数据源
    NSArray *dataArray = @[@[titleitem, item0],@[item1]];
    JM_ActionSheet *sheet = [[JM_ActionSheet alloc] initWithDelegate:self];
    [sheet setDataSource:dataArray];  //数据源, 外层数组为组数,内层数组为每组行数 ex:@[@[@"xx",@"zz", ...],@[@"yy",...],...]
    [sheet show];

```
3、具体使用可下载Demo查看。
###效果图:

![JM_ActionSheet](https://github.com/ZJM6658/ActionSheetLikeWeChat/blob/master/showgif/ActionSheet.gif?raw=true" alt="ActionSheet.gif">)

