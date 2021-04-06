//
//  EkooAreaCodeViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooAreaCodeViewController.h"

@interface EkooAreaCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * areaCodeArray;//地区码数组

@property(nonatomic,strong) UITableView * tableView;

@end

@implementation EkooAreaCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:LSTRING(@"area_code_title") rightIconNormal:nil rightIconHighlighted:nil];
    [self creatTableView];
    [self getAreaCodeFromService];
    
}

-(void)creatTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT - TABBAR_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

-(void)getAreaCodeFromService{
    
    NSDictionary * paramete = [NSDictionary dictionary];
    [[EkooHttpRequest sharedInstance] getWithURLString:AREA_CODE_URL parameters:paramete headers:nil success:^(id _Nonnull responseObject) {
        NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        BOOL success = [jsonDic objectForKey:@"code"];
        if (success) {
            if ([jsonDic objectForKey:@"data"]) {
                self.areaCodeArray = [jsonDic objectForKey:@"data"];
                [[NSUserDefaults standardUserDefaults] setObject:self.areaCodeArray forKey:@"AreaCodeList"];
                [self.tableView reloadData];
            }
        }else{
            [self getAreaCodeFromLocal];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        [self getAreaCodeFromLocal];
    }];
}

-(void)getAreaCodeFromLocal{
    self.areaCodeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AreaCodeList"];
    if (self.areaCodeArray.count) {
        [self.tableView reloadData];
    }
}



#pragma mark - UITableViewDelegate UITableViewDatasource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.areaCodeArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return VIEW_FIT_TO_IPHONE6_VALUE(44);
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CodeCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CodeCellID"];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
        }
    }
    
    NSDictionary * codeDic = [self.areaCodeArray objectAtIndex:indexPath.section];
    NSString * imageUrl = [codeDic objectForKey:@"image"];
    NSString * name = [codeDic objectForKey:@"name"];
    NSString * code = [codeDic objectForKey:@"code"];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(15), VIEW_FIT_TO_IPHONE6_VALUE(13), VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(18))];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ROOT_URL,imageUrl]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    [cell.contentView addSubview:imageView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(63), VIEW_FIT_TO_IPHONE6_VALUE(13), VIEW_FIT_TO_IPHONE6_VALUE(200), VIEW_FIT_TO_IPHONE6_VALUE(18))];
    nameLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(17)];
    nameLabel.textColor = UIColorFromRGB(0x231815);
    nameLabel.text = name;
    [cell.contentView addSubview:nameLabel];
    
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(60), VIEW_FIT_TO_IPHONE6_VALUE(13), VIEW_FIT_TO_IPHONE6_VALUE(44), VIEW_FIT_TO_IPHONE6_VALUE(14))];
    detailLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(13.5)];
    detailLabel.textColor = UIColorFromRGB(0x9E9E9E);
    detailLabel.text = [NSString stringWithFormat:@"+%@",code];;
    detailLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:detailLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * codeDic = [self.areaCodeArray objectAtIndex:indexPath.section];
    NSString * areaCodeStr = [NSString stringWithFormat:@"+%@",[codeDic objectForKey:@"code"]];
    self.returnAreaCodeBlock(areaCodeStr);
    [selfNavigationController popViewControllerAnimated:YES];
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
