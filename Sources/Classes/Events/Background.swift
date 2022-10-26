//
//  Background.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 27/09/22.
//

import Foundation

@objc(RSBackground)
open class Background: NSObject, Event {
    private let _index: NSNumber
    
    @objc
    public var index: NSNumber {
        return _index
    }
    
    @objc
    public var properties: [String: Any]?
    
    @discardableResult @objc
    public func properties(_ properties: [String: Any]?) -> Background {
        self.properties = properties
        return self
    }
    
    @objc
    public init(index: NSNumber) {
        _index = index
    }
    
    public func getProperties() -> [String: Any]? {
        var properties: [String: Any] = ["index": _index]
        if let backgroundProperties = self.properties {
            properties.merge(backgroundProperties) { (new, _) in new }
        }
        return properties
    }
}
