//
//  ViewController.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/21/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    dynamic var list: [Photos] = []
    
    let cellReuseIdentifier = "ImageTableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ImageTableViewCell
        
        cell.marsImage?.image = nil
        
        if let http = list[indexPath.row].img_src {
            // Convert to https
            let https = "https" + http.dropFirst(4)
            
            AF.request(https).responseImage { response in
                if case .success(let image) = response.result {
                    print(https)
                    cell.marsImage?.image = image
                } else {
                    print("error")
                }
            }
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EndpointManager.sharedInstance.fetchJSON {
            photos in
            self.list.append(contentsOf: photos)
            self.tableView.reloadData()
        }
    }
}
