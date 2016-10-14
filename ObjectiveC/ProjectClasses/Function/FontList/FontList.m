//
//  FontList.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "FontList.h"

@interface FontList () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *fontList;
@property (nonatomic, strong) NSMutableArray *keys;

@end

@implementation FontList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"字体列表";
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化

- (void)initData {
    
    _fontList = [NSMutableDictionary dictionary];
    _keys = [NSMutableArray array];
    
    NSArray *familyNames = [UIFont familyNames];
    for (NSString *fontName in familyNames) {
        char ch = [fontName characterAtIndex:0];
        NSString *chString = @"";
        if (ch >= 65 && ch <= 90) {
            chString = [NSString stringWithFormat:@"%c", ch];
        } else if (ch >= 90 && ch <= 122) {
            ch = ch - 32;
            chString = [NSString stringWithFormat:@"%c", ch];
        } else {
            chString = @"#";
        }
        
        if ([_keys containsObject:chString] == NO) {
            [_keys addObject:chString];
            NSMutableArray *values = [NSMutableArray arrayWithObject:fontName];
            [_fontList setObject:values forKey:chString];
        } else {
            NSMutableArray *values = [NSMutableArray arrayWithArray:_fontList[chString]];
            [values addObject:fontName];
            [_fontList removeObjectForKey:chString];
            [_fontList setObject:values forKey:chString];
        }
    }
    // 排序，升序
    [_keys sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
}

- (void)initUI {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.backgroundColor = APPCOLOR_WHITE;
    _tableView.rowHeight = 54.0f;
    _tableView.sectionHeaderHeight = 44.0f;
    [self.view addSubview:_tableView];
    
    _tableView.sectionIndexColor = APPCOLOR_TINT;
    _tableView.sectionIndexBackgroundColor = APPCOLOR_CLEAR;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *values = [_fontList objectForKey:_keys[section]];
    
    return values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FontCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *values = [_fontList objectForKey:_keys[indexPath.section]];
    cell.textLabel.text = values[indexPath.row];
    cell.textLabel.textColor = APPCOLOR_TINT;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:values[indexPath.row] size:15];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *header = [[UILabel alloc] init];
    header.backgroundColor = APPCOLOR_TINTLIGHT;
    header.text = _keys[section];
    header.textColor = APPCOLOR_TINT;
    header.textAlignment = NSTextAlignmentCenter;
    header.font = APPFONT_MID;
    
    return header;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return _keys;
}

@end
