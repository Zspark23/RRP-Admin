//
//  KartTableViewCell.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 2/18/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit

class KartTableViewCell: UITableViewCell {

    @IBOutlet weak var kartStateTextLabel: UILabel!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    static var expandedHeight: CGFloat { get { return 82 }}
    static var defaultHeight: CGFloat { get { return 44 }}
    
    var isObservingFrame: Bool = false
    
    func checkHeight() {
        startButton.isHidden = (frame.size.height < KartTableViewCell.expandedHeight)
        stopButton.isHidden = (frame.size.height < KartTableViewCell.expandedHeight)
        infoButton.isHidden = (frame.size.height < KartTableViewCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if !isObservingFrame {
            addObserver(self, forKeyPath: "frame", options: .new, context: nil)
            isObservingFrame = true
            checkHeight()
        }
    }
    
    func ignoreFrameChanges() {
        if isObservingFrame {
            removeObserver(self, forKeyPath: "frame")
            isObservingFrame = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
