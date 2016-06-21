//
//  ViewController.m
//  下拉图片放大demo
//
//  Created by 虞敏 on 16/6/21.
//  Copyright © 2016年 YM. All rights reserved.
//
#import "ViewController.h"
#define NavigationBarHight 64.0f
#define ImageHight 200.0f
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIImageView *zoomImageView;
@property (nonatomic , strong)UIImageView *circleView;
@property (nonatomic , strong)UILabel *nameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拖动列表时，放大顶部的图片的大小";
    //初始化tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    //设置content size属性，tableview 的位置
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight+64, 0, 0, 0);
    //添加tableview
    [self.view addSubview:self.tableView];
    
    
    //配置imageView
    self.zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.JPG"]];
    self.zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    
    
    //放大缩小的核心代码
    self.zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:self.zoomImageView];

    //设置autoresizesSubViews让子类自动布局
    self.zoomImageView.autoresizesSubviews = YES;
    
    
    
    self.circleView = [[UIImageView alloc]initWithFrame:CGRectMake(10, ImageHight-50, 40, 40)];
    self.circleView.backgroundColor = [UIColor redColor];
    self.circleView.layer.cornerRadius = 7.5f;
    self.circleView.image = [UIImage imageNamed:@"1.JPG"];
    self.circleView.clipsToBounds = YES;
    self.circleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [_zoomImageView addSubview:_circleView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, ImageHight-40, 280, 20)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = @"房东东";
    self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    //自动布局，自适应顶部
    [_zoomImageView addSubview:self.nameLabel];
    //解决tableview在nav遮挡时还会透明的显示问题
    self.edgesForExtendedLayout = UIRectEdgeNone;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //根据实际选择，加不加上navigationbarHeight（44，64或者没有导航条）
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"contentOffSet = %f",y);
    if (y < - ImageHight) {
        CGRect frame = self.zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        //设置初始的y值和zoomImageView的frame
        self.zoomImageView.frame = frame;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第－%ld-条",indexPath.row];
    return cell;
}


@end
