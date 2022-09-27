//
//  TrackerConfiguration.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation
import Rudder

@frozen @objc
public enum LogLevel: Int {
    case verbose = 3
    case debug = 2
    case error = 1
    case off = 0
    
    internal static func getLogLevel(_ logLevel: String) -> LogLevel {
        switch logLevel {
        case "verbose":
            return .verbose
        case "debug":
            return .debug
        case "error":
            return .error
        default:
            return .off
        }
    }
}

@objc(RSTrackerConfiguration)
open class TrackerConfiguration: RSConfiguration {
    
    @objc
    public var appId: String = ""
    
    
    @objc
    public var base64Encoding: Bool = true
    
    
    @objc
    public var logLevel: LogLevel = .off
    
    
    @objc
    public var sessionContext: Bool = true
    
    
    @objc
    public var deepLinkContext: Bool = true
    
    
    @objc
    public var applicationContext: Bool = true
    
    
    @objc
    public var platformContext: Bool = true
    
    
    @objc
    public var geoLocationContext: Bool = false
    
    
    @objc
    public var screenContext: Bool = true
    
    
    @objc
    public var screenViewAutotracking: Bool = true
    
    
    @objc
    public var lifecycleAutotracking: Bool = true
    
    
    @objc
    public var installAutotracking: Bool = true
    
    
    @objc
    public var exceptionAutotracking: Bool = true
    
    
    @objc
    public var diagnosticAutotracking: Bool = false
    
    
    @objc
    public var userAnonymisation: Bool = false
    
    @discardableResult @objc
    public func appId(_ appId: String) -> TrackerConfiguration {
        self.appId = appId
        return self
    }
    
    @discardableResult @objc
    public func base64Encoding(_ base64Encoding: Bool) -> TrackerConfiguration {
        self.base64Encoding = base64Encoding
        return self
    }
    
    @discardableResult @objc
    public func logLevel(_ logLevel: LogLevel) -> TrackerConfiguration {
        self.logLevel = logLevel
        return self
    }
    
    @discardableResult @objc
    public func sessionContext(_ sessionContext: Bool) -> TrackerConfiguration {
        self.sessionContext = sessionContext
        return self
    }
    
    @discardableResult @objc
    public func deepLinkContext(_ deepLinkContext: Bool) -> TrackerConfiguration {
        self.deepLinkContext = deepLinkContext
        return self
    }
    
    @discardableResult @objc
    public func applicationContext(_ applicationContext: Bool) -> TrackerConfiguration {
        self.applicationContext = applicationContext
        return self
    }
    
    @discardableResult @objc
    public func platformContext(_ platformContext: Bool) -> TrackerConfiguration {
        self.platformContext = platformContext
        return self
    }
    
    @discardableResult @objc
    public func geoLocationContext(_ geoLocationContext: Bool) -> TrackerConfiguration {
        self.geoLocationContext = geoLocationContext
        return self
    }
    
    @discardableResult @objc
    public func screenContext(_ screenContext: Bool) -> TrackerConfiguration {
        self.screenContext = screenContext
        return self
    }
    
    @discardableResult @objc
    public func screenViewAutotracking(_ screenViewAutotracking: Bool) -> TrackerConfiguration {
        self.screenViewAutotracking = screenViewAutotracking
        return self
    }
    
    @discardableResult @objc
    public func lifecycleAutotracking(_ lifecycleAutotracking: Bool) -> TrackerConfiguration {
        self.lifecycleAutotracking = lifecycleAutotracking
        return self
    }
    
    @discardableResult @objc
    public func installAutotracking(_ installAutotracking: Bool) -> TrackerConfiguration {
        self.installAutotracking = installAutotracking
        return self
    }
    
    @discardableResult @objc
    public func exceptionAutotracking(_ exceptionAutotracking: Bool) -> TrackerConfiguration {
        self.exceptionAutotracking = exceptionAutotracking
        return self
    }
    
    @discardableResult @objc
    public func diagnosticAutotracking(_ diagnosticAutotracking: Bool) -> TrackerConfiguration {
        self.diagnosticAutotracking = diagnosticAutotracking
        return self
    }
    
    @discardableResult @objc
    public func userAnonymisation(_ userAnonymisation: Bool) -> TrackerConfiguration {
        self.userAnonymisation = userAnonymisation
        return self
    }
    
    @objc
    public override init() {
        
    }
    
    @objc
    public init(dictionary: [String: Any]) {
        appId = (dictionary["appId"] as? String) ?? ""
        base64Encoding = (dictionary["base64encoding"] as? Bool) ?? true
        if let logLevel = dictionary["logLevel"] as? String {
            self.logLevel = LogLevel.getLogLevel(logLevel)
        }
        sessionContext = (dictionary["sessionContext"] as? Bool) ?? true
        deepLinkContext = (dictionary["deepLinkContext"] as? Bool) ?? true
        applicationContext = (dictionary["applicationContext"] as? Bool) ?? true
        platformContext = (dictionary["platformContext"] as? Bool) ?? true
        geoLocationContext = (dictionary["geoLocationContext"] as? Bool) ?? false
        screenContext = (dictionary["screenContext"] as? Bool) ?? true
        screenViewAutotracking = (dictionary["screenViewAutotracking"] as? Bool) ?? true
        lifecycleAutotracking = (dictionary["lifecycleAutotracking"] as? Bool) ?? true
        installAutotracking = (dictionary["installAutotracking"] as? Bool) ?? true
        exceptionAutotracking = (dictionary["exceptionAutotracking"] as? Bool) ?? true
        diagnosticAutotracking = (dictionary["diagnosticAutotracking"] as? Bool) ?? false
        userAnonymisation = (dictionary["userAnonymisation"] as? Bool) ?? false
    }
    
    internal func getRSLogLevel() -> Int32 {
        switch logLevel {
        case .verbose:
            return RSLogLevelVerbose
        case .debug:
            return RSLogLevelDebug
        case .error:
            return RSLogLevelError
        case .off:
            return RSLogLevelNone
        }
    }
}
