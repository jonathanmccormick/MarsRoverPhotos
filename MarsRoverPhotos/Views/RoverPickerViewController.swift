//
//  RoverPicker.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/26/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation
import UIKit

class RoverPickerViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    private var rovers: [RoverModel] = []
    
    // MARK: Lifecycle Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRovers()
    }
    
    // MARK: Private logic
    private func loadRovers() {
        EndpointManager.sharedInstance.getRovers {
            rovers in
            self.rovers = rovers
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension RoverPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rovers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rovers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewController = storyboard?.instantiateViewController(identifier: PhotoListViewController.id) as! PhotoListViewController
        viewController.rover = rovers[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension RoverPickerViewController: UITableViewDataSource {
    
}
