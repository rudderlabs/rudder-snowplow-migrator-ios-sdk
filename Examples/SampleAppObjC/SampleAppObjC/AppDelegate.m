//
//  AppDelegate.m
//  SampleAppObjC
//
//  Created by Pallab Maiti on 26/09/22.
//

#import "AppDelegate.h"
#import "Configuration.h"

@import RudderSnowplowMigrator;

@interface AppDelegate () {
    RSTracker *tracker;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Configuration *configuration = [self getRudderConfiguration];
    
    if ([configuration.DATA_PLANE_URL_PROD length] > 0 && [configuration.WRITE_KEY length] > 0) {
        tracker = [self initialiseSDK:configuration.DATA_PLANE_URL_PROD WRITE_KEY:configuration.WRITE_KEY];
        
        [self callEvents];
    }
    return YES;
}

- (void)callEvents {
    [self structured];
    [self foreground];
    [self background];
    [self screen];
    [self selfDescribing];
}

- (void)structured {
    RSStructured *structured = [[RSStructured alloc] initWithCategory:@"Category" action:@"Action"];
    [tracker track:structured];
    
    structured = [[RSStructured alloc] initWithCategory:@"Category" action:@"Action"];
    
    structured.property = @"my-property";
    structured.value = @5;
    structured.label = @"my-label";
    structured.properties = [self getProperties];
    
    [tracker track:structured];
    
    structured = [[RSStructured alloc] initWithCategory:@"Category" action:@"Action"];
    [structured label:@"my-label"];
    [structured property:@"my-property"];
    [structured value:@5];
    [structured properties:[self getProperties]];
    
    [tracker track:structured];
}

- (void)foreground {
    RSForeground *foreground = [[RSForeground alloc] initWithIndex:@1];
    [tracker track:foreground];
    
    foreground = [[RSForeground alloc] initWithIndex:@1];
    [foreground properties:[self getProperties]];
    
    [tracker track:foreground];
    
    foreground = [[RSForeground alloc] initWithIndex:@1];
    foreground.properties = [self getProperties];
    
    [tracker track:foreground];
}

- (void)background {
    RSBackground *background = [[RSBackground alloc] initWithIndex:@1];
    [tracker track:background];
    
    background = [[RSBackground alloc] initWithIndex:@1];
    [background properties:[self getProperties]];
    
    [tracker track:background];
    
    background = [[RSBackground alloc] initWithIndex:@1];
    background.properties = [self getProperties];
    
    [tracker track:background];
}

- (void)screen {
    RSScreenView *screen = [[RSScreenView alloc] initWithName:@"Screen_1" screenId:NULL];
    [tracker track:screen];
    
    screen = [[RSScreenView alloc] initWithName:@"Screen_1" screenId:[[NSUUID alloc] init]];
    [tracker track:screen];
    
    screen = [[RSScreenView alloc] initWithName:@"Screen_1" screenId:NULL];
    [screen type:@"type"];
    [screen previousName:@"previousName"];
    [screen previousId:@"previousId"];
    [screen previousType:@"previousType"];
    [screen transitionType:@"transitionType"];
    [screen viewControllerClassName:@"viewControllerClassName"];
    [screen topViewControllerClassName:@"topViewControllerClassName"];
    [screen properties:[self getProperties]];

    [tracker track:screen];
    
    screen = [[RSScreenView alloc] initWithName:@"Screen_1" screenId:NULL];
    screen.type = @"type";
    screen.previousName = @"previousName";
    screen.previousId = @"previousId";
    screen.previousType = @"previousType";
    screen.transitionType = @"transitionType";
    screen.viewControllerClassName = @"viewControllerClassName";
    screen.topViewControllerClassName = @"topViewControllerClassName";
    screen.properties = [self getProperties];

    [tracker track:screen];
}

- (void)selfDescribing {
    RSSelfDescribingJson *selfDescribingJson = [[RSSelfDescribingJson alloc] initWithSchema:@"schema" andDictionary:[self getProperties]];
    RSSelfDescribing *selfDescribing = [[RSSelfDescribing alloc] initWithEventData:selfDescribingJson];
    
    [tracker track:selfDescribing];
        
    selfDescribingJson = [[RSSelfDescribingJson alloc] initWithSchema:@"schema" andData:[self getProperties]];
    selfDescribing = [[RSSelfDescribing alloc] initWithEventData:selfDescribingJson];
    
    [tracker track:selfDescribing];
    

    selfDescribingJson = [[RSSelfDescribingJson alloc] initWithSchema:@"schema" andData:@1234];
    selfDescribing = [[RSSelfDescribing alloc] initWithEventData:selfDescribingJson];
    
    [tracker track:selfDescribing];

    selfDescribingJson = [[RSSelfDescribingJson alloc] initWithSchema:@"schema" andData:@"Purchase"];
    selfDescribing = [[RSSelfDescribing alloc] initWithEventData:selfDescribingJson];
    
    [tracker track:selfDescribing];

    
    selfDescribing = [[RSSelfDescribing alloc] initWithSchema:@"schema" payload:[self getProperties]];
    [tracker track:selfDescribing];

    selfDescribingJson = [[RSSelfDescribingJson alloc] initWithSchema:@"schema" andData:@"Purchase"];
    RSSelfDescribingJson *selfDescribingJson2 = [[RSSelfDescribingJson alloc] initWithSchema:@"schema" andSelfDescribingJson:selfDescribingJson];
    selfDescribing = [[RSSelfDescribing alloc] initWithEventData:selfDescribingJson2];
    
    [tracker track:selfDescribing];
}

- (RSTracker *)initialiseSDK:(NSString *)DATA_PLANE_URL WRITE_KEY:(NSString *)WRITE_KEY {
    RSNetworkConfiguration *networkConfig = [[RSNetworkConfiguration alloc] initWithDataPlaneUrl:DATA_PLANE_URL];
    
    RSSessionConfiguration *sessionConfig = [[RSSessionConfiguration alloc] initWithForegroundTimeout:[[NSMeasurement alloc] initWithDoubleValue:1 unit:NSUnitDuration.minutes] backgroundTimeout:[[NSMeasurement alloc] initWithDoubleValue:1 unit:NSUnitDuration.minutes]];
    
    RSTrackerConfiguration *trackerConfig = [[RSTrackerConfiguration alloc] init];
    [trackerConfig logLevel:LogLevelDebug];
    [trackerConfig sessionContext:YES];
    [trackerConfig screenViewAutotracking:YES];
    [trackerConfig lifecycleAutotracking:YES];
    
    RSSubjectConfiguration *subjectConfig = [[RSSubjectConfiguration alloc] init];
    [subjectConfig userId:@"test_user"];
    [subjectConfig traits:[self getProperties]];

    return [RSTracker createTrackerWithWriteKey:WRITE_KEY network:networkConfig configurations:@[trackerConfig, subjectConfig, sessionConfig]];
}

- (NSDictionary *)getProperties {
    return @{@"action": @"Action_2", @"key_1": @"value_1", @"key_2": @123, @"key_3": @123.45, @"key_4": @YES,
             @"key_5": @NO};
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

- (Configuration *)getRudderConfiguration {
    /// Create a `Configuration.json` file on root directory. The JSON should be look like:
    /// {
    ///    "WRITE_KEY": "WRITE_KEY_VALUE",
    ///    "DATA_PLANE_URL_LOCAL": "DATA_PLANE_URL_LOCAL_VALUE",
    ///    "DATA_PLANE_URL_PROD": "DATA_PLANE_URL_PROD_VALUE",
    ///    "CONTROL_PLANE_URL": "CONTROL_PLANE_URL_VALUE"
    /// }
    ///
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"json"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return [[Configuration alloc] initWithDATA_PLANE_URL_LOCAL:json[@"DATA_PLANE_URL_LOCAL"] DATA_PLANE_URL_PROD:json[@"DATA_PLANE_URL_PROD"] CONTROL_PLANE_URL:json[@"CONTROL_PLANE_URL"] WRITE_KEY:json[@"WRITE_KEY"]];
}

@end
