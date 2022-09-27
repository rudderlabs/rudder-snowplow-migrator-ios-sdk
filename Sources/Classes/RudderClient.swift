//
//  RudderClient.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation
import Rudder

@objc
open class RudderClient: NSObject {
    private static let shared = RudderClient()
    
    @objc
    public static func createTracker(writeKey: String, network: NetworkConfiguration) -> RudderClient {
        let trackerConfig = TrackerConfiguration()
        return createTracker(writeKey: writeKey, network: network, configurations: [trackerConfig])
    }
    
    @objc
    public static func createTracker(writeKey: String, dataPlaneUrl: String) -> RudderClient {
        let network = NetworkConfiguration(dataPlaneUrl: dataPlaneUrl)
        return createTracker(writeKey: writeKey, network: network)
    }
    
    @objc
    public static func createTracker(writeKey: String, network: NetworkConfiguration, configurations: [RSConfiguration]) -> RudderClient {
        let configBuilder = RSConfigBuilder()
            .withDataPlaneUrl(network.dataPlaneUrl)
            .withControlPlaneUrl(network.controlPlaneUrl)
        
        var userId: String?
        var identifyTraits: [String: Any]?
        
        for configuration in configurations {
            switch configuration {
            case let config as SessionConfiguration:
                configBuilder.withAutoSessionTracking(config.autoTracking)
                configBuilder.withSessionTimeoutMillis((config.backgroundTimeoutInSeconds * 1000))
            case let config as TrackerConfiguration:
                configBuilder.withLoglevel(config.getRSLogLevel())
                configBuilder.withRecordScreenViews(config.screenViewAutotracking)
                configBuilder.withTrackLifecycleEvens(config.lifecycleAutotracking)
            case let config as SubjectConfiguration:
                userId = config.userId
                identifyTraits = config.getTraits()
            default:
                break
            }
        }
        
        RSClient.getInstance(writeKey, config: configBuilder.build())
        
        if let userId = userId {
            if let identifyTraits = identifyTraits {
                RSClient.sharedInstance()?.identify(userId, traits: identifyTraits)
            } else {
                RSClient.sharedInstance()?.identify(userId)
            }
        }
        return RudderClient.shared
    }
    
    @objc
    public static func getDefaultTracker() -> RudderClient {
        return RudderClient.shared
    }
    
    @discardableResult @objc
    public func track(_ event: Event) -> UUID {
        switch event {
        case let e as Structured:
            if let properties = e.getProperties() {
                RSClient.sharedInstance()?.track(e.action, properties: properties)
            } else {
                RSClient.sharedInstance()?.track(e.action)
            }
        case let e as Foreground:
            if let properties = e.getProperties() {
                RSClient.sharedInstance()?.track("Application Opened", properties: properties)
            } else {
                RSClient.sharedInstance()?.track("Application Opened")
            }
        case let e as Background:
            if let properties = e.getProperties() {
                RSClient.sharedInstance()?.track("Application Backgrounded", properties: properties)
            } else {
                RSClient.sharedInstance()?.track("Application Backgrounded")
            }
        case let e as ScreenView:
            if let properties = e.getProperties() {
                RSClient.sharedInstance()?.track(e.name, properties: properties)
            } else {
                RSClient.sharedInstance()?.track(e.name)
            }
        default: break
        }
        return UUID()
    }
}
