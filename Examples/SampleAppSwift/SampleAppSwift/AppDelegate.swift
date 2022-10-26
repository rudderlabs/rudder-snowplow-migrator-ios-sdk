//
//  AppDelegate.swift
//  SampleAppSwift
//
//  Created by Pallab Maiti on 26/09/22.
//

import UIKit
import RudderSnowplowMigrator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var tracker: RSTracker!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// Create a `Configuration.json` file on root directory. The JSON should be look like:
        /// {
        ///    "WRITE_KEY": "WRITE_KEY_VALUE",
        ///    "DATA_PLANE_URL_LOCAL": "DATA_PLANE_URL_LOCAL_VALUE",
        ///    "DATA_PLANE_URL_PROD": "DATA_PLANE_URL_PROD_VALUE",
        ///    "CONTROL_PLANE_URL": "CONTROL_PLANE_URL_VALUE"
        /// }
        ///
        print(URL(fileURLWithPath: #file))
        let filePath = URL(fileURLWithPath: #file).pathComponents.dropLast().dropLast().dropLast().dropLast().joined(separator: "/").replacingOccurrences(of: "//", with: "/") + "/Configuration.json"
        do {
            let jsonString = try String(contentsOfFile: filePath, encoding: .utf8)
            let jsonData = Data(jsonString.utf8)
            let configuration = try JSONDecoder().decode(Configuration.self, from: jsonData)
            
            let networkConfig = NetworkConfiguration(dataPlaneUrl: configuration.DATA_PLANE_URL_PROD)
            
            let sessionConfig = SessionConfiguration(
                foregroundTimeout: Measurement(value: 0, unit: .minutes),
                backgroundTimeout: Measurement(value: 0, unit: .minutes)
            )
            
            let trackerConfig = TrackerConfiguration()
                .logLevel(.verbose)
                .lifecycleAutotracking(true)
                .sessionContext(false)
                .screenViewAutotracking(false)
            
            let subjectConfig = SubjectConfiguration()
                .traits(properties())
            
            tracker = RSTracker.createTracker(writeKey: configuration.WRITE_KEY, network: networkConfig, configurations: [trackerConfig, subjectConfig, sessionConfig])
            
            callEvents()
        } catch { }
        return true
    }
    
    func callEvents() {
        structured()

        screen()

        foreground()

        background()

        selfDescribing()
    }
    
    func structured() {
        var structured = Structured(category: "Category", action: "Action")
        
        tracker.track(structured)
    
        structured = Structured(category: "Category", action: "Action")
            .label("my-label")
            .property("my-property")
            .value(5)
            .properties(properties())
        
        tracker.track(structured)
    
        structured = Structured(category: "Category", action: "Action")
        
        structured.label = "my-label"
        structured.property = "my-property"
        structured.value = 5
        structured.properties = properties()
        
        tracker.track(structured)
    }
    
    func foreground() {
        var foreground = Foreground(index: 1)
        
        tracker.track(foreground)
    
        foreground = Foreground(index: 2)
            .properties(properties())
        
        tracker.track(foreground)
    
        foreground = Foreground(index: 1)
        foreground.properties = properties()
        
        tracker.track(foreground)
    }
    
    func background() {
        var background = Background(index: 1)
        
        tracker.track(background)
    
        background = Background(index: 2)
            .properties(properties())
        
        tracker.track(background)
    
        background = Background(index: 1)
        background.properties = properties()
        
        tracker.track(background)
    }
    
    func screen() {
        var screen = ScreenView(name: "Screen_1")
        
        tracker.track(screen)
        
        screen = ScreenView(name: "Screen_1", screenId: UUID())
        tracker.track(screen)
        
        screen = ScreenView(name: "Screen_1")
            .type("type")
            .previousName("previousName")
            .previousId("previousId")
            .previousType("previousType")
            .transitionType("transitionType")
            .viewControllerClassName("viewControllerClassName")
            .topViewControllerClassName("topViewControllerClassName")
            .properties(properties())
        
        tracker.track(screen)
    
        screen = ScreenView(name: "Screen_1")
        screen.type = "type"
        screen.previousName = "previousName"
        screen.previousId = "previousId"
        screen.previousType = "previousType"
        screen.transitionType = "transitionType"
        screen.viewControllerClassName = "viewControllerClassName"
        screen.topViewControllerClassName = "topViewControllerClassName"
        screen.properties = properties()
        
        tracker.track(screen)
    }
    
    func selfDescribing() {
        var selfDescribingJson = SelfDescribingJson(schema: "schema", andDictionary: properties())
        var selfDescribing = SelfDescribing(eventData: selfDescribingJson)
        
        tracker.track(selfDescribing)

        selfDescribingJson = SelfDescribingJson(schema: "schema", andData: properties())
        selfDescribing = SelfDescribing(eventData: selfDescribingJson)

        tracker.track(selfDescribing)
                
        selfDescribing = SelfDescribing(schema: "schema", payload: properties())
        tracker.track(selfDescribing)
    
        selfDescribingJson = SelfDescribingJson(schema: "schema", andData: 1234)
        selfDescribing = SelfDescribing(eventData: selfDescribingJson)
        
        tracker.track(selfDescribing)
    
        selfDescribingJson = SelfDescribingJson(schema: "schema", andData: "Purchase")
        selfDescribing = SelfDescribing(eventData: selfDescribingJson)
        
        tracker.track(selfDescribing)
    
        selfDescribingJson = SelfDescribingJson(schema: "schema", andData: "Purchase")
        let selfDescribingJson2 = SelfDescribingJson(schema: "schema", andSelfDescribingJson: selfDescribingJson)
        selfDescribing = SelfDescribing(eventData: selfDescribingJson2)
        
        tracker.track(selfDescribing)
    }
    
    func properties() -> [String: Any] {
        return ["action": "Action_2",
                "key_1": "value_1",
                "key_2": 123,
                "key_3": 123.45,
                "key_4": true,
                "key_5": false]
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

struct Configuration: Codable {
    let DATA_PLANE_URL_LOCAL: String
    let DATA_PLANE_URL_PROD: String
    let CONTROL_PLANE_URL: String
    let WRITE_KEY: String
}
