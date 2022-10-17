//
//  RSTracker.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation
import Rudder

@objc
open class RSTracker: NSObject {
    private static let shared = RSTracker()
    
    @discardableResult @objc
    public static func createTracker(writeKey: String, network: NetworkConfiguration) -> RSTracker {
        let trackerConfig = TrackerConfiguration()
        return createTracker(writeKey: writeKey, network: network, configurations: [trackerConfig])
    }
    
    @discardableResult @objc
    public static func createTracker(writeKey: String, dataPlaneUrl: String) -> RSTracker {
        let network = NetworkConfiguration(dataPlaneUrl: dataPlaneUrl)
        return createTracker(writeKey: writeKey, network: network)
    }
    
    @discardableResult @objc
    public static func createTracker(writeKey: String, network: NetworkConfiguration, configurations: [RSConfiguration]) -> RSTracker {
        var configBuilder = RSConfigBuilder()
            .withDataPlaneUrl(network.dataPlaneUrl)
            .withControlPlaneUrl(network.controlPlaneUrl)
        
        var userId: String?
        var identifyTraits: [String: Any]?
        
        for configuration in configurations {
            switch configuration {
            case let config as SessionConfiguration:
                config.setSessionData(to: &configBuilder)
            case let config as TrackerConfiguration:
                config.setTrackerData(to: &configBuilder)
            case let config as SubjectConfiguration:
                config.setUserData(to: &userId, identifyTraits: &identifyTraits)
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
        return RSTracker.shared
    }
    
    @objc
    public static func getDefaultTracker() -> RSTracker {
        return RSTracker.shared
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
                RSClient.sharedInstance()?.screen(e.name, properties: properties)
            } else {
                RSClient.sharedInstance()?.screen(e.name)
            }
        case let e as SelfDescribing:
            if var properties = e.payload {
                if let action = properties["action"] as? String {
                    properties.removeValue(forKey: "action")
                    if !properties.isEmpty {
                        RSClient.sharedInstance()?.track(action, properties: properties)
                    } else {
                        RSClient.sharedInstance()?.track(action)
                    }
                } else {
                    RSLogger.logDebug("Action field is not present in the SelfDescribing events. Hence dropping the event.")
                }
            }            
        default: break
        }
        return UUID()
    }
}
