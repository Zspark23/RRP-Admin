//
//  InformationDetailViewController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 1/23/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit

class InformationDetailViewController: UIViewController {
    
    @IBOutlet weak var kartInfoTableView: UITableView!
    
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let indexPaths = kartInfoTableView.indexPathsForVisibleRows?.count {
            for row in 0..<indexPaths {
                (kartInfoTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! KartTableViewCell).ignoreFrameChanges()
            }
        }
    }
}

extension InformationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kartCell", for: indexPath) as! KartTableViewCell
        
        cell.titleTextLabel?.text = "Kart \(indexPath.row + 1)"
        
        switch indexPath.row {
        case 3, 6, 10:
            cell.kartStateTextLabel?.text = "Inactive"
            break
        default:
            cell.kartStateTextLabel?.text = "Active"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths: [IndexPath] = []
        
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! KartTableViewCell).watchFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! KartTableViewCell).ignoreFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return KartTableViewCell.expandedHeight
        } else {
            return KartTableViewCell.defaultHeight
        }
    }
    
}
