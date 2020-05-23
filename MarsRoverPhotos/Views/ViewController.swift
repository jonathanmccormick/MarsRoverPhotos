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
    
    dynamic var list: [PhotoModel] = []
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EndpointManager.sharedInstance.getPhotos {
            photos in
            self.list.append(contentsOf: photos)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToImageDetail" {
            let vc = segue.destination as! ImageDetailViewController
//            vc.sourceImage = Pho
        }
    }
}
