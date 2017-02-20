//
//  MQTTController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 2/13/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import Foundation
import CocoaMQTT

private let PRODUCTION_HOST_NAME = "broker.racereplay.co"
private let DEV_HOST_NAME = ""
private let PORT: UInt16 = 1883

class MQTTController {
    
    static let sharedInstance = MQTTController()
    let mqtt: CocoaMQTT!
    
    private init() {
        mqtt = CocoaMQTT(clientId: "CocoaMQTT-" + String(ProcessInfo().processIdentifier), host: PRODUCTION_HOST_NAME, port: PORT)
        mqtt.keepAlive = 90
        mqtt.connect()
    }
    
    
}
