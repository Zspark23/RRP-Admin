//
//  InformationViewController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 1/22/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit
import CocoaMQTT

private let PRODUCTION_HOST_NAME = "broker.racereplay.co"
private let DEV_HOST_NAME = ""
private let PORT: UInt16 = 1883

class InformationViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let facilities = ["Jessup", "White Marsh", "Jacksonville", "Harrisburg"]
    var mqtt = MQTTController.sharedInstance.mqtt!
    
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pick a Facility"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mqtt.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // let viewController = segue.destination as! InformationDetailViewController
        
    }


}

extension InformationViewController: UITableViewDataSource, UITableViewDelegate, CocoaMQTTDelegate {
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kartCell", for: indexPath)
        cell.textLabel?.text = facilities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilities.count
    }
    
    // MARK: UITableViewDelegate Methods
    
    
    
    // MARK: CocoaMQTTDelegate Methods
    
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("Did Connect To \(host):\(port)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("Did Connect Ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Did Publish Message")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("Did Publish Ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("Did Recieve Message")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("Subscribed to \(topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("Unsubscribed to \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("Did Ping")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("Did Recieve Pong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Did Disconnect")
    }
    
    
}
