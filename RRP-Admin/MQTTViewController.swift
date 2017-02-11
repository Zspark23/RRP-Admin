//
//  ViewController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 1/21/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//  cyka/rrp/ais rrp/ais
//

import UIKit
import CocoaMQTT

private let PRODUCTION_HOST_NAME = "broker.racereplay.co"
private let DEV_HOST_NAME = ""
private let PORT: UInt16 = 1883


class MQTTViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let hour = Calendar.current.component(.hour, from: Date())
    let minutes = Calendar.current.component(.minute, from: Date())
    
    var topics: [Topic] {
        get {
            if defaults.object(forKey: "SavedTopicsArray") != nil {
                return NSKeyedUnarchiver.unarchiveObject(with: defaults.object(forKey: "SavedTopicsArray") as! Data) as! [Topic]
            } else {
                return []
            }
        }
        set (array) {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: array), forKey: "SavedTopicsArray")
        }
    }
    
    var isSubscribed = false
    var mqtt: CocoaMQTT!
    
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var topicsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mqtt = CocoaMQTT(clientId: "CocoaMQTT-" + String(ProcessInfo().processIdentifier), host: PRODUCTION_HOST_NAME, port: PORT)
        mqtt.keepAlive = 90
        mqtt.delegate = self
        mqtt.connect()
    }
    
    @IBAction func subscribeButtonTapped(_ sender: UIButton) {
        if topicTextField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")) == "" {
            return
        }
        
        for topic in topics {
            if topicTextField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")) == topic.name {
                return
            }
        }
        
        mqtt.subscribe(topicTextField.text!)
        topics.append(Topic(name: topicTextField.text!))
        topicTextField.text = ""
        topicsTableView.reloadData()
    }
}

extension MQTTViewController: CocoaMQTTDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: CocoaMQTTDelegate Methods
    
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        self.title = "Connected"
        print("Did Connect to: \(host):\(port)")
        for topic in topics {
            mqtt.subscribe(topic.name)
        }
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
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        // IMPLIMENT FUNCTIONALITY - Add messages to specific topics
        print("\(message.topic)")
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
        self.navigationItem.title = "Disconnected"
        print(err?.localizedDescription ?? "No error.")
        let disconnectionAlert = UIAlertController(title: "Disconnected from broker", message: "Do you want to reconnect?", preferredStyle: .alert)
        disconnectionAlert.addAction((UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
            self.mqtt.connect()
        })))
        disconnectionAlert.addAction((UIAlertAction(title: "No", style: .destructive, handler: nil)))
        self.present(disconnectionAlert, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicTableViewCell
        cell.configureCellWithTopic(topic: topics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    // MARK: UITabbleViewDelegate Methods
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            mqtt.unsubscribe(topics[indexPath.row].name)
            topics.remove(at: indexPath.row)
            topicsTableView.reloadData()
        }
    }
    
}

