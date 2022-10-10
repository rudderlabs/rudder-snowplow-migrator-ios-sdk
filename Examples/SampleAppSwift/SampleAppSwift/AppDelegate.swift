//
//  AppDelegate.swift
//  SampleAppSwift
//
//  Created by Pallab Maiti on 26/09/22.
//

import UIKit
import RudderSnowplowMigrator

let DATA_PLANE_URL = "https://rudderstacz.dataplane.rudderstack.com"
let CONTROL_PLANE_URL = "https://rudderstacz.dataplane.rudderstack.com"
let APP_ID = "appId"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let networkConfig = NetworkConfiguration(dataPlaneUrl: DATA_PLANE_URL)
                
        let sessionConfig = SessionConfiguration(
                    foregroundTimeout: Measurement(value: 5, unit: .minutes),
                    backgroundTimeout: Measurement(value: 5, unit: .minutes)
                )
                
        let trackerConfig = TrackerConfiguration()
            .base64Encoding(false)
            .logLevel(.debug)
            .deepLinkContext(true)
            .applicationContext(true)
            .platformContext(true)
            .geoLocationContext(true)
            .lifecycleAutotracking(false)
            .diagnosticAutotracking(true)
            .screenViewAutotracking(false)
            .screenContext(true)
            .applicationContext(true)
            .exceptionAutotracking(true)
            .installAutotracking(true)
            .userAnonymisation(false)
            .sessionContext(true)
            .appId(APP_ID)
        
        let subjectConfig = SubjectConfiguration()
            .userId("user_id")
            .networkUserId("networkUserId")
            .traits(["name": "name"])
        
        let rsclient = RudderClient.createTracker(writeKey: "1wvsoF3Kx2SczQNlx1dvcqW9ODW", network: networkConfig, configurations: [sessionConfig, trackerConfig, subjectConfig])
        
        let structured = Structured(category: "Cat", action: "Action")
            .properties(["key_1": ["key_key_1": "value_value_1"]])
        
        rsclient.track(structured)
        
        let screen = ScreenView(name: "Screen_1", screenId: "1")
        
        rsclient.track(screen)
        
        let foreground = Foreground(index: 1)
            .properties(["key_1": "value_1"])
        
        rsclient.track(foreground)
        
        let background = Background(index: 1)
            .properties(["key_1": "value_1"])
        
        rsclient.track(background)
        
        let selfDescribingJson = SelfDescribingJson(schema: "schema", andDictionary: ["action": "Action_2"])
        let selfDescribing = SelfDescribing(eventData: selfDescribingJson)
        
        rsclient.track(selfDescribing)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

