//
//  InformationViewController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 1/22/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let premadeCommands = ["Kart", "Start", "Stop"]
    
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            viewController.title = "rrp/ais/jessup/infom/kart"
            break
        case "Start"?:
            viewController.title = "rrp/ais/jessup/start"
            break
        case "Stop"?:
            viewController.title = "rrp/ais/jessup/stop"
            break
        default:
            break
            
        }
    }


}

extension InformationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    
    
}
