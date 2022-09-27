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
    var dataPlaneUrl: String = RSDataPlaneUrl
    
    var controlPlaneUrl: String = RSControlPlaneUrl
    
    @objc
    public init(dataPlaneUrl: String, controlPlaneUrl: String) {
        self.dataPlaneUrl = dataPlaneUrl
        self.controlPlaneUrl = controlPlaneUrl
    }
    
    @objc
    public init(dataPlaneUrl: String) {
        self.dataPlaneUrl = dataPlaneUrl
    }
}
