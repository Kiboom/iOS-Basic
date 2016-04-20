//
//  MasterViewController.m
//  MidTerm
//
//  Created by 김기범 on 2016. 4. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "KBAlbumViewController.h"
#import "KBDetailViewController.h"

@interface KBAlbumViewController () <NSURLConnectionDataDelegate>
@property NSMutableArray *objects;
@property NSArray *yearList;
@property BOOL willHideTableHeader;
@property NSURLCache *cache;
@property NSMutableData *imageData;
@end

@implementation KBAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cache = [[NSURLCache alloc] initWithMemoryCapacity:100000000 diskCapacity:100000000 diskPath:@"/Users/Thomas/Library/Developer/CoreSimulator/Devices/E01D12CB-0740-4078-94AD-9A2026014AFA/data/Containers/Data/Application/5F61995E-F0B4-40B0-83EF-17E64D246A9A/Documents"];
    self.imageData = [[NSMutableData alloc] initWithCapacity:10];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortTable:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (KBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self registerNotification];
    self.model = [[KBDataModel alloc] init];
    [self.model initializeData];
    self.yearList = [self.model getYearList];
    
    [self initiateTableView];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initiateTableView {
    self.tableView.rowHeight = 80;
    self.willHideTableHeader = YES;
}


- (void)registerNotification {
    self.notiCenter = [NSNotificationCenter defaultCenter];
    [self.notiCenter addObserver:self
                        selector:@selector(reloadTableView)
                            name:@"modelInitialized"
                          object:nil];
    [self.notiCenter addObserver:self selector:@selector(reloadTableView) name:@"sorted" object:nil];
}


- (void)reloadTableView {
    self.objects = [self.model.datas mutableCopy];
    [self.tableView reloadData];
}


- (void)sortTable:(id)sender {
    self.willHideTableHeader = NO;
    [self.model sort];
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake) {
        self.willHideTableHeader = YES;
        [self.model initializeData];
    }
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.objects[[self getGlobalRowFromIndexPath:indexPath]];
        KBDetailViewController *controller = (KBDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.yearList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model getNumberElementInYear:self.yearList[section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *object = self.objects[[self getGlobalRowFromIndexPath:indexPath]];
    return [self setCellContents:cell :object];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.willHideTableHeader == YES) {
        return nil;
    }
    return self.yearList[section];
}

- (long)getGlobalRowFromIndexPath:(NSIndexPath *)indexPath {
    int offset = 0;
    for(int i=0 ; i<indexPath.section ; i++){
        offset += [self.model getNumberElementInYear:self.yearList[i]];
    }
    return indexPath.row + offset;
}

- (KBTableViewCell *)setCellContents:(KBTableViewCell *)cell :(NSDictionary *)object {
    cell.titleLabel.text = [object objectForKey:@"title"];
    cell.detailLabel.text = [object objectForKey:@"date"];
//    cell.background.image = [UIImage imageNamed:[object objectForKey:@"image"]];
//    wifi가 꺼져있을 때는 위 코드 시행.
    cell.background.image = [self getImageFromServerSync:[object objectForKey:@"image"]];
    cell.background.contentMode = UIViewContentModeCenter;
    return cell;
}

- (UIImage *)getImageFromServerSync:(NSString *)imageName {
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://125.209.194.123/demo/%@",imageName];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    return [[UIImage alloc] initWithData:data];
}

/*
- (void)getImageFromServerAsync:(NSString *)imageName {
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://125.209.194.123/demo/%@",imageName];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //delegate에 self를 등록했으니, self에도 <NSURLConnectionDataDelegate>를 선언하기
    [connection start];
    // 이렇게 delegate 방식도 있지만, 요즘은 NSURLConnection에 sendAsynchronousRequest:queue:completionHandler라는
    // 최신 API를 활용하기도. 계속 데이터를 queue에 넣다가 다 받으면 completionHandler의 블록코드를 실행함.
    // 블록코드에다가 셀에 이미지 입히는 작업을 넣어주면 됨.
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // MTU 데이터 나눠 받을 때마다 실행됨.
    // NSMutableData 변수를 하나 만들어서 데이터가 올 때마다 여기에 계속 데이터를 붙여나간다.
    // 참고로 NSURL마다 connection이 생기기 때문에 여러 NSURL에 request 날릴 때는 이 메서드 안에서 connection별로 구분을 해줘야.
    [self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //전체 다 받은 이후 실행됨.
    //delegate 방식으로 async를 하면 이게 안좋음. 받아온 데이터를 셀에 뭔가를 넣어줄 때 매핑하기가 영 아니올시다.
    UIImage *image = [UIImage imageWithData:self.imageData];
}
*/



@end
