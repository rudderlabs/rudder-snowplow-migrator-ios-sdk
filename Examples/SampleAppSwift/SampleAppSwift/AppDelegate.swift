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
        
//        let networkConfig = NetworkConfiguration(dataPlaneUrl: DATA_PLANE_URL, controlPlaneUrl: CONTROL_PLANE_URL)
        
        let sessionConfig = SessionConfiguration(
                    foregroundTimeout: Measurement(value: 5, unit: .minutes),
                    backgroundTimeout: Measurement(value: 5, unit: .minutes)
                )
        
//        let sessionConfig = SessionConfiguration(foregroundTimeoutInSeconds: 60, backgroundTimeoutInSeconds: 60)
        SessionConfiguration()
        
        let trackerConfig = TrackerConfiguration()
            .base64Encoding(false)
            .logLevel(.off)
            .deepLinkContext(true)
            .applicationContext(true)
            .platformContext(true)
            .geoLocationContext(true)
            .lifecycleAutotracking(true)
            .diagnosticAutotracking(true)
            .screenViewAutotracking(true)
            .screenContext(true)
            .applicationContext(true)
            .exceptionAutotracking(true)
            .installAutotracking(true)
            .userAnonymisation(false)
            .appId(APP_ID)
        
        SubjectConfiguration()
        
        let rsclient = RudderClient.createTracker(writeKey: "", network: networkConfig, configurations: [sessionConfig, trackerConfig])
        
        let st = Structured(category: "Cat", action: "Action")
        
        rsclient.track(st)
        
        SelfDescribingJson(schema: "", andData: st)
        SelfDescribingJson(schema: "", andDictionary: [:])
        
        SelfDescribing(schema: "", payload: [:])
        
        
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

