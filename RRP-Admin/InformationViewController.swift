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
    let premadeCommands = ["Kart", "Start", "Stop"]
    var mqtt: CocoaMQTT!
    
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mqtt = CocoaMQTT(clientId: "CocoaMQTT-" + String(ProcessInfo().processIdentifier), host: PRODUCTION_HOST_NAME, port: PORT)
        mqtt.keepAlive = 90
        mqtt.delegate = self
        mqtt.connect()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: 180, height: 90)
        layout.minimumInteritemSpacing = 8
        buttonCollectionView!.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as! InformationDetailViewController
        let commandButton = sender as! UIButton
        
        switch commandButton.titleLabel?.text {
        case "Kart"?:
            //mqtt.publish("rrp/ais/jessup/inform/kart", withString: "Kart")
            viewController.title = "rrp/ais/jessup/infom/kart"
            break
        case "Start"?:
            //mqtt.publish("rrp/ais/jessup/start", withString: "Start")
            viewController.title = "rrp/ais/jessup/start"
            break
        case "Stop"?:
            //mqtt.publish("rrp/ais/jessup/stop", withString: "Stop")
            viewController.title = "rrp/ais/jessup/stop"
            break
        default:
            break
            
        }
    }


}

extension InformationViewController: UICollectionViewDataSource, UICollectionViewDelegate, CocoaMQTTDelegate {
    
    // MARK: UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ButtonCollectionViewCell
        cell.commandButton.setTitle(premadeCommands[indexPath.row], for: .normal)
        return cell
    }
    
    // MARK: UICollectionViewDelegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return premadeCommands.count
    }
    
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
        print("DidRecieve Message")
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
