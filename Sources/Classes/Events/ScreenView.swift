//
//  ScreenView.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation

@objc(RSScreenView)
open class ScreenView: NSObject, Event {
    private let _name: String
    @objc
    public var name: String {
        return _name
    }
    
    private let _id: String
    @objc
    public var screenId: String {
        return _id
    }
    
    @objc
    public var type: String?
    
    @objc
    public var previousName: String?
    
    @objc
    public var previousId: String?
    
    @objc
    public var previousType: String?
    
    @objc
    public var transitionType: String?
    
    @objc
    public var viewControllerClassName: String?
    
    @objc
    public var topViewControllerClassName: String?
    
    @objc
    public var properties: [String: Any]?
    
    @objc
    public init(name: String, screenId: UUID? = nil) {
        _name = name
        _id = screenId?.uuidString ?? UUID().uuidString
    }
    
    @discardableResult @objc
    public func type(_ type: String) -> ScreenView {
        self.type = type
        return self
    }
    
    @discardableResult @objc
    public func previousName(_ previousName: String) -> ScreenView {
        self.previousName = previousName
        return self
    }
    
    @discardableResult @objc
    public func previousId(_ previousId: String) -> ScreenView {
        self.previousId = previousId
        return self
    }
    
    @discardableResult @objc
    public func previousType(_ previousType: String) -> ScreenView {
        self.previousType = previousType
        return self
    }
    
    @discardableResult @objc
    public func transitionType(_ transitionType: String) -> ScreenView {
        self.transitionType = transitionType
        return self
    }
    
    @discardableResult @objc
    public func viewControllerClassName(_ viewControllerClassName: String) -> ScreenView {
        self.viewControllerClassName = viewControllerClassName
        return self
    }
    
    @discardableResult @objc
    public func topViewControllerClassName(_ topViewControllerClassName: String) -> ScreenView {
        self.topViewControllerClassName = topViewControllerClassName
        return self
    }
    
    @discardableResult @objc
    public func properties(_ properties: [String: Any]?) -> ScreenView {
        self.properties = properties
        return self
    }
    
    public func getProperties() -> [String: Any]? {
        var properties = [String: Any]()
        let mirror = Mirror(reflecting: self)
        for (_, attribute) in mirror.children.enumerated() {
            if let key = attribute.label, key != "_name", key != "properties", "\(attribute.value)" != "nil" {
                properties[key.replacingOccurrences(of: "_", with: "")] = attribute.value
            }
        }
        if let screenProperties = self.properties {
            properties.merge(screenProperties) { (new, _) in new }
        }
        return !properties.isEmpty ? properties : nil
    }
}
