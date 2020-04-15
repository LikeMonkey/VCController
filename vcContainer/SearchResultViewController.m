//
//  SearchResultViewController.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cvell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cvell.textLabel.text = @"这是一个搜索结果";
    return cvell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.didSelectText?:self.didSelectText(@"这是一个搜索结果");
}
@end
