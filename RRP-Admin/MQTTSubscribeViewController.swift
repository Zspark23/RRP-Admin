//
//  ViewController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 1/21/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit
import CocoaMQTT

private let PRODUCTION_HOST_NAME = "broker.racereplay.co"
private let DEV_HOST_NAME = ""
private let PORT = 1883


class MQTTSubscribeViewController: UIViewController {

    var mqtt: CocoaMQTT!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mqtt = CocoaMQTT(clientId: "CocoaMQTT-" + String(ProcessInfo().processIdentifier, host: PRODUCTION_HOST_NAME, port: UInt16(PORT)))
    }
}

extension MQTTSubscribeViewController: CocoaMQTTDelegate {
    
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("Connected to \(host):\(port)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        if let messageString = message.string {
            //messageTextField.text = messageTextField.text + "\n" + messageString
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("Subscribed to \(topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("Unsubscribed to \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT){
        print("")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Disconnected")
    }
}

