//
//  ViewController.m
//  AESECB
//
//  Created by Wenzhong on 2015-05-05.
//  Copyright (c) 2015 Wenzhong. All rights reserved.
//

#import "ViewController.h"
#import "MLCrypto.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController {
    NSData *keyData, *data, *result, *decryptedData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    keyData = [MLCrypto keygen128];
    data = [MLCrypto keygen128];
    result = [MLCrypto cipherData:data key:keyData];
    decryptedData = [MLCrypto decipherData:result key:keyData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"numberCell"];
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:[NSString stringWithFormat:@"Data    :  0x%@", NSDataToHex(data)]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Menlo" size:12.f]];
            break;
        case 1:
            [cell.textLabel setText:[NSString stringWithFormat:@"Using Key: 0x%@", NSDataToHex(keyData)]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Menlo" size:12.f]];
            break;
        case 2:
            [cell.textLabel setText:[NSString stringWithFormat:@"Result is: 0x%@", NSDataToHex(result)]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Menlo" size:12.f]];
            break;
        case 3:
            [cell.textLabel setText:[NSString stringWithFormat:@"Decrypted: 0x%@", NSDataToHex(decryptedData)]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Menlo" size:12.f]];
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Toggle cell
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
