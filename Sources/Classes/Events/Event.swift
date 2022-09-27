//
//  Event.swift
//  RudderSnowplowMigrator
//
//  Created by Pallab Maiti on 26/09/22.
//

import Foundation

@objc(RSEvent)
public protocol Event {
    func getProperties() -> [String: Any]?
}
