//
//  Foreground.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 27/09/22.
//

import Foundation

@objc(RSForeground)
open class Foreground: NSObject, Event {
    private let _index: NSNumber
    
    @objc
    public var index: NSNumber {
        return _index
    }
    
    @objc
    public var properties: [String: Any]?
    
    @discardableResult @objc
    public func properties(_ properties: [String: Any]?) -> Foreground {
        self.properties = properties
        return self
    }
    
    @objc
    public init(index: NSNumber) {
        _index = index
    }
    
    public func getProperties() -> [String: Any]? {
        var properties: [String: Any] = ["index": _index]
        if let foregroundProperties = self.properties {
            properties.merge(foregroundProperties) { (new, _) in new }
        }
        return properties
    }
}
