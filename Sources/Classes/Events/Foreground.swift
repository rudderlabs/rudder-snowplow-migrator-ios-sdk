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
    public init(index: NSNumber) {
        _index = index
    }
    
    public func getProperties() -> [String: Any]? {
        return ["index": _index]
    }
}