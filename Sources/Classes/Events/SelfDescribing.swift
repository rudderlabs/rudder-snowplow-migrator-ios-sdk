//
//  SelfDescribing.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 27/09/22.
//

import Foundation


@objc(RSSelfDescribingJson)
open class SelfDescribingJson: NSObject {
    var schema: String
    var data: Any
    
    @objc
    public init(schema: String, andData: Any) {
        self.schema = schema
        self.data = andData
    }
    
    @objc
    public convenience init(schema: String, andDictionary: [String: Any]) {
        self.init(schema: schema, andData: andDictionary)
    }
    
    @objc
    public convenience init(schema: String, andSelfDescribingJson: SelfDescribingJson) {
        self.init(schema: schema, andData: andSelfDescribingJson.getAsDictionary())
    }
    
    @objc
    public func setSchema(_ schema: String) {
        self.schema = schema
    }
    
    @objc
    public func setData(object: Any) {
        self.data = object
    }
    
    @objc
    public func setData(selfDescribingJson: SelfDescribingJson) {
        setData(object: selfDescribingJson.getAsDictionary())
    }
    
    private func getAsDictionary() -> [String: Any] {
        return ["schema": schema, "data": data]
    }
}

@objc(RSSelfDescribing)
open class SelfDescribing: NSObject, Event {    
    let schema: String
    let payload: [String: Any]?
    
    @objc
    public init(schema: String, payload: [String : Any]) {
        self.schema = schema
        self.payload = payload
    }
    
    @objc
    public init(eventData: SelfDescribingJson) {
        schema = eventData.schema
        payload = eventData.data as? [String: Any]
    }
    
    public func getProperties() -> [String : Any]? {
        return nil
    }
}
