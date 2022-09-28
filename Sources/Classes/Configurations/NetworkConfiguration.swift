//
//  NetworkConfiguration.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation
import Rudder

@objc(RSNetworkConfiguration)
open class NetworkConfiguration: NSObject, RSConfiguration {
    private var _dataPlaneUrl: String = RSDataPlaneUrl
    @objc
    public var dataPlaneUrl: String {
        return _dataPlaneUrl
    }
    
    private var _controlPlaneUrl: String = RSControlPlaneUrl
    @objc
    public var controlPlaneUrl: String {
        return _controlPlaneUrl
    }
    
    @objc
    public init(dataPlaneUrl: String, controlPlaneUrl: String) {
        _dataPlaneUrl = dataPlaneUrl
        _controlPlaneUrl = controlPlaneUrl
    }
    
    @objc
    public init(dataPlaneUrl: String) {
        _dataPlaneUrl = dataPlaneUrl
    }
    
    @objc
    public init(dictionary: [String: Any]) {
        _dataPlaneUrl = (dictionary["dataPlaneUrl"] as? String) ?? RSDataPlaneUrl
        _controlPlaneUrl = (dictionary["controlPlaneUrl"] as? String) ?? RSControlPlaneUrl
    }
}
