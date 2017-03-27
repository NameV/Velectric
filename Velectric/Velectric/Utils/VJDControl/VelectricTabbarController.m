//
//  VelectricTabbarController.m
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "VelectricTabbarController.h"
#import "SCCartTool.h"
#import "SCBadgeView.h"
#import "VelectricNavController.h"

#import "MineViewController.h"
#import "VHomeViewController.h"
#import "CartViewController.h"
#import "CategoryViewController.h"
#import "VDiscoverViewController.h"
#import "VMyCollectVC.h"

@interface VelectricTabbarController ()

@property (nonatomic, strong) NSMutableArray *tabBarItems;
@property (nonatomic, weak) CartViewController *cartVC;
@property (nonatomic, weak) UITabBarItem *item;


@end

@implementation VelectricTabbarController
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
}

// 在viewWillAppear:方法中添加子控件才是显示在最上面的,同时badgeView的值会随时更新
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateBadgeValue)
                                                 name:SCProductBuyCountDidChangeNotification
                                               object:nil];
    // 添加badgeView
//    [self addBadgeViewOnTabBarButtons];
}

- (void)updateBadgeValue {
    _cartVC.tabBarItem.badgeValue = [SCCartTool totalCount];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundImage = [UIImage imageNamed:@""];
    // 设置子控制器
    [self addChildViewControllers];

}

#pragma mark - 添加多个子控制器
- (void)addChildViewControllers {
    // 首页
    VHomeViewController *homeVC = [[VHomeViewController alloc] init];
    
    [self addOneChildViewController:homeVC
                        normalImage:[UIImage imageNamed:@"shouye"]
                       pressedImage:[UIImage imageNamed:@"shouyexuanzhong"]
                 navigationBarTitle:@""];
    
    // 分类
    CategoryViewController *categoryVC = [[CategoryViewController alloc] init];
    
    [self addOneChildViewController:categoryVC
                        normalImage:[UIImage imageNamed:@"fenlei"]
                       pressedImage:[UIImage imageNamed:@"fenleixuanzhong"]
                 navigationBarTitle:@""];
    
    // 发现

    VDiscoverViewController *discoverVC = [[VDiscoverViewController alloc]init];
    [self addOneChildViewController:discoverVC
                        normalImage:[UIImage imageNamed:@"faxian"]
                       pressedImage:[UIImage imageNamed:@"faxianxuanzhong"]
                 navigationBarTitle:@""];
    
    // 购物车
    CartViewController *cartVC = [[CartViewController alloc] init];
    
    [self addOneChildViewController:cartVC
                        normalImage:[UIImage imageNamed:@"gouwuche"]
                       pressedImage:[UIImage imageNamed:@"gouwuchexuanzhong"]
                 navigationBarTitle:@""];
    _cartVC = cartVC;
    
    // 我的
    MineViewController *MyVC = [[MineViewController alloc] init];
    
    [self addOneChildViewController:MyVC
                        normalImage:[UIImage imageNamed:@"wode"]
                       pressedImage:[UIImage imageNamed:@"wodexuanzhong"]
                 navigationBarTitle:@""];
    
}



#pragma mark - 添加1个子控制器
- (void)addOneChildViewController:(UIViewController *)viewController
                      normalImage:(UIImage *)normalImage
                     pressedImage:(UIImage *)pressedImage
               navigationBarTitle:(NSString *)title{
    
    // 设置子控制器导航条标题
    viewController.navigationItem.title = title;
    // 设置标签图片
    viewController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [pressedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

    // 添加子控制器至导航控制器
    VelectricNavController *navigationVC
    = [[VelectricNavController alloc] initWithRootViewController:viewController];
    
    // 添加导航控制器
    [self addChildViewController:navigationVC];
    
    // 添加tabBarItem至数组
    [self.tabBarItems addObject:viewController.tabBarItem];
    
}

// 添加所有badgeView
- (void)addBadgeViewOnTabBarButtons {
    // 设置初始的badegValue
    _cartVC.tabBarItem.badgeValue = [SCCartTool totalCount];
    int i = 0;
    for (UITabBarItem *item in self.tabBarItems) {
        
        if (i == 3) {  // 只在第4个按钮上添加
            [self addBadgeViewWithBadgeValue:item.badgeValue atIndex:i];
            // 监听item的变化情况
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
            _item = item;
        }
        i++;
    }
}

// 为某个按钮添加一个自定义badgeView
- (void)addBadgeViewWithBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index {
    
    SCBadgeView *badgeView = [SCBadgeView buttonWithType:UIButtonTypeCustom];
    
    // 计算badgeView位置
    CGFloat tabBarButtonWidth = self.tabBar.width / self.tabBarItems.count;
    
    badgeView.centerX = index * tabBarButtonWidth + 40;
    
    // tag
    badgeView.tag = index + 1;
    
    // 传入badgeValue
    badgeView.badgeValue = badgeValue;
    
    
    [self.tabBar addSubview:badgeView];
}

#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[SCBadgeView class]]) {
            if (subView.tag == 4) {
                SCBadgeView *badgeView = (SCBadgeView *)subView;
                badgeView.badgeValue = _cartVC.tabBarItem.badgeValue;
            }
        }
    }
    
}

#pragma mark - 移除观察者
- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
