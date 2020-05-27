//
//  RoverPicker.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/26/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation
import UIKit

class RoverPickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var rovers: [RoverModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EndpointManager.sharedInstance.getRovers {
            rovers in
            self.rovers = rovers
            self.tableView.reloadData()
            print(rovers)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rovers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rovers[indexPath.row].name
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
}
