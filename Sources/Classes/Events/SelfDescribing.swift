//
//  SelfDescribing.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 27/09/22.
//

import Foundation


@objc(RSSelfDescribingJson)
open class SelfDescribingJson: NSObject {
    let schema: String
    let data: Any
    
    @objc
    public init(schema: String, andData: Any) {
        self.schema = schema
        self.data = andData
    }
    
    @objc
    public init(schema: String, andDictionary: NSDictionary) {
        self.schema = schema
        self.data = andDictionary
    }
    
    @objc
    public init(schema: String, andSelfDescribingJson: SelfDescribingJson) {
        self.schema = schema
        self.data = andSelfDescribingJson
    }
    
    @objc
    public func setData(object: Any) {
        
    }
    
    @objc
    public func setData(selfDescribingJson: SelfDescribingJson) {
        
    }
    
    @objc
    public func getAsDictionary() -> [String: Any] {
        return [String: Any]()
    }
}

@objc(RSSelfDescribing)
open class SelfDescribing: NSObject {
    let schema: String
    let payload: [String: Any]
    
    @objc
    public init(schema: String, payload: [String : Any]) {
        self.schema = schema
        self.payload = payload
    }
    
    @objc
    public init(eventData: SelfDescribingJson) {
        schema = ""
        payload = [String: Any]()
    }
}
