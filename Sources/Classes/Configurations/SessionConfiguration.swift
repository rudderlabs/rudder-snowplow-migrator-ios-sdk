//
//  SessionConfiguration.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation
import Rudder

@objc(RSSessionConfiguration)
open class SessionConfiguration: NSObject, RSConfiguration {
    private var _foregroundTimeoutInSeconds: Int = 300
    @objc
    public var foregroundTimeoutInSeconds: Int {
        return _foregroundTimeoutInSeconds
    }
    
    private var _backgroundTimeoutInSeconds: Int = 300
    @objc
    public var backgroundTimeoutInSeconds: Int {
        return _backgroundTimeoutInSeconds
    }
    
    @objc
    public override init() {
        
    }
    
    @objc
    public init(dictionary: [String: Any]) {
        _foregroundTimeoutInSeconds = (dictionary["foregroundTimeout"] as? Int) ?? 300
        _backgroundTimeoutInSeconds = (dictionary["backgroundTimeout"] as? Int) ?? 300
    }
    
    @objc @available(iOS 10, tvOS 10.0, watchOS 3.0, *)
    public init(foregroundTimeout: Measurement<UnitDuration>, backgroundTimeout: Measurement<UnitDuration>) {
        _foregroundTimeoutInSeconds = Int(foregroundTimeout.converted(to: UnitDuration.seconds).value)
        _backgroundTimeoutInSeconds = Int(backgroundTimeout.converted(to: UnitDuration.seconds).value)
    }
    
    @objc
    public init(foregroundTimeoutInSeconds: Int, backgroundTimeoutInSeconds: Int) {
        _foregroundTimeoutInSeconds = foregroundTimeoutInSeconds
        _backgroundTimeoutInSeconds = backgroundTimeoutInSeconds
    }
    
    internal func setSessionData(to configBuilder: inout RSConfigBuilder) {
        configBuilder.withSessionTimeoutMillis(_backgroundTimeoutInSeconds * 1000)
    }
}
