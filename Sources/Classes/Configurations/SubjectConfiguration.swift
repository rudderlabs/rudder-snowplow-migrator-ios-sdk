//
//  SubjectConfiguration.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation

@objc(RSSubjectConfiguration)
open class SubjectConfiguration: NSObject, RSConfiguration {    
    @objc
    public var userId: String?
    
    @objc
    public var networkUserId: String?
    
    @objc
    public var domainUserId: String?
    
    @objc
    public var useragent: String?
    
    @objc
    public var ipAddress: String?
    
    @objc
    public var timezone: String?
    
    @objc
    public var language: String?
    
    @objc
    public var colorDepth: NSNumber?
    
    @objc
    public var geoLatitude: NSNumber?
    
    @objc
    public var geoLongitude: NSNumber?
    
    @objc
    public var geoLatitudeLongitudeAccuracy: NSNumber?
    
    @objc
    public var geoAltitude: NSNumber?
    
    @objc
    public var geoAltitudeAccuracy: NSNumber?
    
    @objc
    public var geoBearing: NSNumber?
    
    @objc
    public var geoSpeed: NSNumber?
    
    @objc
    public var geoTimestamp: NSNumber?
    
    @objc
    public var traits: [String: Any]?
    
    @discardableResult @objc
    public func userId(_ userId: String?) -> SubjectConfiguration {
        self.userId = userId
        return self
    }
    
    @discardableResult @objc
    public func networkUserId(_ networkUserId: String?) -> SubjectConfiguration {
        self.networkUserId = networkUserId
        return self
    }
    
    @discardableResult @objc
    public func domainUserId(_ domainUserId: String?) -> SubjectConfiguration {
        self.domainUserId = domainUserId
        return self
    }
    
    @discardableResult @objc
    public func useragent(_ useragent: String?) -> SubjectConfiguration {
        self.useragent = useragent
        return self
    }
    
    @discardableResult @objc
    public func ipAddress(_ ipAddress: String?) -> SubjectConfiguration {
        self.ipAddress = ipAddress
        return self
    }
    
    @discardableResult @objc
    public func timezone(_ timezone: String?) -> SubjectConfiguration {
        self.timezone = timezone
        return self
    }
    
    @discardableResult @objc
    public func language(_ language: String?) -> SubjectConfiguration {
        self.language = language
        return self
    }
    
    @discardableResult @objc
    public func colorDepth(_ colorDepth: NSNumber?) -> SubjectConfiguration {
        self.colorDepth = colorDepth
        return self
    }
    
    @discardableResult @objc
    public func geoLatitude(_ geoLatitude: NSNumber?) -> SubjectConfiguration {
        self.geoLatitude = geoLatitude
        return self
    }
    
    @discardableResult @objc
    public func geoLongitude(_ geoLongitude: NSNumber?) -> SubjectConfiguration {
        self.geoLongitude = geoLongitude
        return self
    }
    
    @discardableResult @objc
    public func geoLatitudeLongitudeAccuracy(_ geoLatitudeLongitudeAccuracy: NSNumber?) -> SubjectConfiguration {
        self.geoLatitudeLongitudeAccuracy = geoLatitudeLongitudeAccuracy
        return self
    }
    
    @discardableResult @objc
    public func geoAltitude(_ geoAltitude: NSNumber?) -> SubjectConfiguration {
        self.geoAltitude = geoAltitude
        return self
    }
    
    @discardableResult @objc
    public func geoAltitudeAccuracy(_ geoAltitudeAccuracy: NSNumber?) -> SubjectConfiguration {
        self.geoAltitudeAccuracy = geoAltitudeAccuracy
        return self
    }
    
    @discardableResult @objc
    public func geoBearing(_ geoBearing: NSNumber?) -> SubjectConfiguration {
        self.geoBearing = geoBearing
        return self
    }
    
    @discardableResult @objc
    public func geoSpeed(_ geoSpeed: NSNumber?) -> SubjectConfiguration {
        self.geoSpeed = geoSpeed
        return self
    }
    
    @discardableResult @objc
    public func geoTimestamp(_ geoTimestamp: NSNumber?) -> SubjectConfiguration {
        self.geoTimestamp = geoTimestamp
        return self
    }
    
    @discardableResult @objc
    public func traits(_ traits: [String: Any]?) -> SubjectConfiguration {
        self.traits = traits
        return self
    }
    
    @objc
    public override init() {
        
    }
    
    @objc
    public init(dictionary: [String: Any]) {
        userId = dictionary["userId"] as? String
        networkUserId = dictionary["networkUserId"] as? String
        domainUserId = dictionary["domainUserId"] as? String
        useragent = dictionary["useragent"] as? String
        ipAddress = dictionary["ipAddress"] as? String
        timezone = dictionary["timezone"] as? String
        language = dictionary["language"] as? String
    }
    
    private func getTraits() -> [String: Any]? {
        var traits = [String: Any]()
        let mirror = Mirror(reflecting: self)
        for (_, attribute) in mirror.children.enumerated() {
            if let key = attribute.label, key != "userId", key != "traits" {
                traits[key] = attribute.value
            }
        }
        if let identifyTraits = self.traits {
            traits.merge(identifyTraits) { (new, _) in new }
        }
        return !traits.isEmpty ? traits : nil
    }
    
    internal func setUserData(to userId: inout String?, identifyTraits: inout [String: Any]?) {
        userId = self.userId
        identifyTraits = getTraits()
    }
}
