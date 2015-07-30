//
//  ViewController.m
//  DOPDropDownMenuDemo
//
//  Created by weizhou on 9/26/14.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import "ViewController.h"
#import "DOPDropDownMenu.h"

@interface ViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *citys;
@property (nonatomic, copy) NSArray *ages;
@property (nonatomic, copy) NSArray *genders;
@property (nonatomic, copy) NSArray *originalArray;
@property (nonatomic, copy) NSArray *results;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DOPDropDownMenu *menu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"navbar_title", @"the navigation bar title");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.citys = @[NSLocalizedString(@"city1", @"city1"),
                   NSLocalizedString(@"city2", @"city2"),
                   NSLocalizedString(@"city3", @"city3")];
    self.ages = @[NSLocalizedString(@"age", @"age"), @"20", @"30"];
    self.genders = @[NSLocalizedString(@"gender1", @"gender1"),
                     NSLocalizedString(@"gender2", @"gender2"),
                     NSLocalizedString(@"gender3", @"gender3")];
    self.originalArray = @[[NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[1],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[1],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[2],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[2],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[1],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[1],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[2],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[2],self.genders[2]]];
    self.results = self.originalArray;
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    self.menu = menu;
    
    self.tableView = ({
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, screenSize.width, screenSize.height - 104)];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss:(UIBarButtonItem *)sender {
    [self.menu dismiss];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return 3;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    switch (indexPath.column) {
        case 0: return self.citys[indexPath.row];
            break;
        case 1: return self.genders[indexPath.row];
            break;
        case 2: return self.ages[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
    NSLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
    NSString *title = [menu titleForRowAtIndexPath:indexPath];
    
    static NSString *prediStr1 = @"SELF LIKE '*'",
                    *prediStr2 = @"SELF LIKE '*'",
                    *prediStr3 = @"SELF LIKE '*'";
    switch (indexPath.column) {
        case 0:{
            if (indexPath.row == 0) {
                prediStr1 = @"SELF LIKE '*'";
            } else {
                prediStr1 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                prediStr2 = @"SELF LIKE '*'";
            } else {
                prediStr2 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                prediStr3 = @"SELF LIKE '*'";
            } else {
                prediStr3 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            
        default:
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ AND %@ AND %@",prediStr1,prediStr2,prediStr3]];
    
    self.results = [self.originalArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.results[indexPath.row];
    return cell;
}

@end
