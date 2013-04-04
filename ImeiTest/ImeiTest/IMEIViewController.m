//
//  IMEIViewController.m
//  ImeiTest
//
//  Created by Prat on 4/2/13.
//

#import "IMEIViewController.h"
#import "CoreTelephony.h"

@interface IMEIViewController ()

@end

@implementation IMEIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    getImei();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

CTServerConnectionRef conn;
void ConnectionCallback(CTServerConnectionRef connection, CFStringRef string, CFDictionaryRef dictionary, void *data) {
	NSLog(@"ConnectionCallback");
	CFShow(dictionary);
}

void getImei() {
    struct CTResult it;
    //    NSMutableDictionary *dict;
    CFMutableDictionaryRef dict;
    conn = _CTServerConnectionCreate(kCFAllocatorDefault, ConnectionCallback,NULL);
    _CTServerConnectionCopyMobileEquipmentInfo(&it, conn, &dict);
    NSLog (@ "dict is %@", dict);
    CFStringRef meid = CFDictionaryGetValue(dict, CFSTR("kCTMobileEquipmentInfoMEID"));
    NSLog (@ "meid is %@", meid);
    CFStringRef mobileId = CFDictionaryGetValue(dict, CFSTR("kCTMobileEquipmentInfoCurrentMobileId"));
    NSLog (@ "mobileId is %@", mobileId);
}

/*
 
 2013-04-04 15:04:17.769 ImeiTest[724:907] dict is {
 kCTMobileEquipmentInfoCurrentMobileId = A100001AF5DD1B;
 kCTMobileEquipmentInfoCurrentSubscriberId = 7322593419;
 kCTMobileEquipmentInfoERIVersion = 6;
 kCTMobileEquipmentInfoMEID = A100001AF5DD1B;
 kCTMobileEquipmentInfoMIN = 7322593419;
 kCTMobileEquipmentInfoPRLVersion = 53096;
 }
 2013-04-04 15:04:17.778 ImeiTest[724:907] meid is A100001AF5DD1B
 2013-04-04 15:04:17.782 ImeiTest[724:907] mobileId is A100001AF5DD1B
 
 */

@end
