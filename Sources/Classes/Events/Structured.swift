//
//  Structured.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation

@objc(RSStructured)
open class Structured: NSObject, Event {
    private let _category: String
    @objc
    public var category: String {
        return _category
    }
    
    private let _action: String
    @objc
    public var action: String {
        return _action
    }
    
    @objc
    public var label: String?
    
    @objc
    public var property: String?
    
    @objc
    public var value: NSNumber?
    
    @objc
    public var properties: [String: Any]?
    
    @objc
    public init(category: String, action: String) {
        _category = category
        _action = action
    }
    
    @discardableResult @objc
    public func label(_ label: String) -> Structured {
        self.label = label
        return self
    }
    
    @discardableResult @objc
    public func property(_ property: String) -> Structured {
        self.property = property
        return self
    }
    
    @discardableResult @objc
    public func value(_ value: NSNumber) -> Structured {
        self.value = value
        return self
    }
    
    
    @discardableResult @objc
    public func properties(_ properties: [String: Any]?) -> Structured {
        self.properties = properties
        return self
    }
    
    public func getProperties() -> [String: Any]? {
        var properties = [String: Any]()
        let mirror = Mirror(reflecting: self)
        for (_, attribute) in mirror.children.enumerated() {
            if let key = attribute.label {
                if key != "_action" {
                    properties[key.replacingOccurrences(of: "_", with: "")] = attribute.value
                }
            }
        }
        if let structuredProperties = self.properties {
            properties.merge(structuredProperties) { (new, _) in new }
        }
        return properties.count > 0 ? properties : nil
    }
}
