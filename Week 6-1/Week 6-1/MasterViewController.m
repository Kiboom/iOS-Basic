//
//  MasterViewController.m
//  Week 6-1
//
//  Created by 김기범 on 2016. 4. 4..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;  // Model처럼 동작하는 녀석.
@property NSNotificationCenter *notiCenter;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // 네비게이션아이템의 왼쪽에 에디트 버튼이 지정됨.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    // 이미 에디트랑 애드 같은 버튼은 유명한 애들이라서 아예 맹글어져있음.
    self.navigationItem.rightBarButtonItem = addButton;
    // 네비게이션 아이템의 오른쪽에 애드 버튼이 지정됨.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.notiCenter = [NSNotificationCenter defaultCenter];
    [self.notiCenter addObserver:self selector:@selector(receiveNotification:) name:@"add" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    } // 처음에 objects가 없을 때만 alloc init.
    /* 새로운 Row를 만드는 법.
    [self.objects insertObject:[NSDate date] atIndex:0];
    // 0번째에다가 계속 현재 시간을 추가함.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 인덱스 패스 : 섹션과 로우라는 2차원적인 인덱스니까 '인덱스 패스'라고 하는 듯.
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; // insertRow를 하면 insert한 indexpath만 다시 그리는 것. 이미 그려진 애들은 안 건드림.
    //[self.tableView reloadData]; // 이렇게 하면 번쩍 하면서 다시 다 그림. 애니메이션 효과가 없음. 이미 그려진 애들도 건들임.*/
    
    // 또는 이런 식으로 NSNotificationCenter를 활용해서 새로운 Row를 만들 수 있음.
    [self.notiCenter postNotificationName:@"add" object:nil];
}


- (void)receiveNotification:(NSNotification*)notification {
    [self.objects insertObject:[NSDate date] atIndex:0];
    [self.tableView reloadData];
}


#pragma mark - Segues

/* Storyboard에서 세그웨이를 만들면 요런 식으로 셀을 눌렀을 때 Detail View로 넘어가고, 넘어갈 때 정보를 넘길 수 있음!
   물론 Storyboard의 세그웨이 없이 didSelectRowAtIndexPath를 활용해서 아래와 같이 만들 수도 있음!
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *object = self.objects[indexPath.row];
    DetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [controller setDetailItem:object];
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
