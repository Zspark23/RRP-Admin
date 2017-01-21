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
private let PORT: UInt16 = 1883


class MQTTSubscribeViewController: UIViewController {
    
    let alert = UIAlertController(title: "Add new topic", message: "Enter a new topic to add to the list.", preferredStyle: .alert)
    let defaults = UserDefaults.standard
    
    var topics: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "SavedStringArray") ?? [String]()
        }
        set (array) {
            UserDefaults.standard.set(array, forKey: "SavedStringArray")
        }
    }
    
    var isSubscribed = false
    var mqtt: CocoaMQTT!
    
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var messagesTextView: UITextView!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var topicListView: UIView!
    @IBOutlet weak var topicPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            let textField = self.alert.textFields![0]
            self.topics.append(textField.text!)
            self.topicPickerView.reloadAllComponents()
            textField.text = ""
        }))
        
        topicListView.isHidden = true
        topicListView.layer.zPosition = 1
        messagesTextView.isEditable = false
        
        mqtt = CocoaMQTT(clientId: "CocoaMQTT-" + String(ProcessInfo().processIdentifier), host: PRODUCTION_HOST_NAME, port: PORT)
        mqtt.keepAlive = 90
        mqtt.delegate = self
        mqtt.connect()
    }
    
    @IBAction func subscribeButtonTapped(_ sender: UIButton) {
        if isSubscribed == false {
            mqtt.subscribe(topicTextField.text!)
            isSubscribed = true
            subscribeButton.setTitle("Unsubscribe", for: .normal)
        } else {
            mqtt.unsubscribe(topicTextField.text!)
            isSubscribed = false
            subscribeButton.setTitle("Subscribe", for: .normal)
        }
    }
    
    @IBAction func addTopicButtonTapped(_ sender: UIBarButtonItem) {
        self.present(alert, animated: true, completion: nil)
    }
}

extension MQTTSubscribeViewController: CocoaMQTTDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: CocoaMQTTDelegate Methods
    
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("Connected to \(host):\(port)")
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
        if let messageString = message.string {
            messagesTextView.text = messagesTextView.text + "\n" + messageString
        }
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
        print("Disconnected")
    }

    // MARK: UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let topics = defaults.array(forKey: "SavedStringArray")
        return topics?.count ?? 0
    }
    
    // MARK: UIPickerViewDelegate Methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if topics.count >= 1 {
            topicTextField.text = topics[row]
        }
        topicListView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        topicListView.isHidden = false
        return false
    }
    
    
}

