//
//  AppDelegate.m
//  SampleAppObjC
//
//  Created by Pallab Maiti on 26/09/22.
//

#import "AppDelegate.h"
#import <SnowplowTracker/SPStructured.h>
#import <SPSnowplow.h>
#import <SPTrackerController.h>
#import <SPSelfDescribing.h>
#import <SPNetworkConfiguration.h>
#import <SPTrackerController.h>

@import RudderSnowplowMigrator;

static NSString *DATA_PLANE_URL = @"https://rudderstacz.dataplane.rudderstack.com";
static NSString *CONTROL_PLANE_URL = @"https://rudderstacz.dataplane.rudderstack.com";
static NSString *APP_ID = @"appId";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    RSNetworkConfiguration *networkConfig = [[RSNetworkConfiguration alloc] initWithDataPlaneUrl:DATA_PLANE_URL controlPlaneUrl:CONTROL_PLANE_URL];
    
    RSTrackerConfiguration *trackerConfig = [[RSTrackerConfiguration alloc] init];
    [trackerConfig base64Encoding:YES];
    [trackerConfig logLevel:LogLevelDebug];
    [trackerConfig sessionContext:YES];
    [trackerConfig deepLinkContext:YES];
    [trackerConfig applicationContext:YES];
    [trackerConfig platformContext:YES];
    [trackerConfig geoLocationContext:NO];
    [trackerConfig screenContext:YES];
    [trackerConfig screenViewAutotracking:YES];
    [trackerConfig lifecycleAutotracking:YES];
    [trackerConfig installAutotracking:YES];
    [trackerConfig exceptionAutotracking:YES];
    [trackerConfig diagnosticAutotracking:NO];
    [trackerConfig userAnonymisation:NO];
    [trackerConfig appId:APP_ID];
    
    SPStructured *event = [[SPStructured alloc] initWithCategory:@"" action:@""];
    event.value = 0;
    
    SPNetworkConfiguration *spnc = [[SPNetworkConfiguration alloc] initWithEndpoint:@""];
    
    [SPSnowplow createTrackerWithNamespace:@"" network:spnc];
    
    RSTracker *tracker = [RSTracker createTrackerWithWriteKey:@"" network:networkConfig];
    
    RSStructured *st = [[RSStructured alloc] initWithCategory:@"Cat" action:@"Action"];
    st.value = 0;
    st.label = @"";
    
    [[RSSubjectConfiguration alloc] init];
    [[RSSessionConfiguration alloc] init];
    
    RSForeground *fore = [[RSForeground alloc] initWithIndex:@1];
    
    [tracker track:st];
    
    RSSelfDescribingJson *rspj = [[RSSelfDescribingJson alloc] initWithSchema:@"" andData:@""];
    SPSelfDescribingJson *spj = [[SPSelfDescribingJson alloc] initWithSchema:@"" andData:@""];
    
    [[SPSelfDescribing alloc] initWithEventData:spj];
    [[SPSelfDescribing alloc] initWithSchema:@"" payload:@{}];
    
    [[RSSelfDescribing alloc] initWithEventData:rspj];
    [[RSSelfDescribing alloc] initWithSchema:@"" payload:@{}];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
