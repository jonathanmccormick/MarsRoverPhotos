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

class PhotoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public var rover: RoverModel!
    private var photos: [PhotoDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = rover.name
        tableView.isHidden = true
        activityIndicator.isHidden = false
        
        EndpointManager.sharedInstance.getPhotos(rover: rover) {
            photos in
            self.photos.append(contentsOf: photos.map{ $0.toDTO() })
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.activityIndicator.isHidden = true
        }
    }
}

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return photos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.id) as! ImageTableViewCell
            
            if (photos[indexPath.row].image == nil) {
                if let http = photos[indexPath.row].img_src {
                    // Convert to https
                    let https = "https" + http.dropFirst(4)
                    
                    AF.request(https).responseImage { response in
                        if case .success(let image) = response.result {
                            self.photos[indexPath.row].image = image
                            cell.marsImage?.image = image
                            self.tableView.reloadData()
                        } else {
                            print("error")
                        }
                    }
                }
            }
            
            cell.marsImage?.image = photos[indexPath.row].image
            cell.cameraNameLabel.text = photos[indexPath.row].camera?.full_name
            cell.sol.text = "Sol \(photos[indexPath.row].sol!) (\(photos[indexPath.row].earth_date!))"
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if let image = photos[indexPath.row].image {
                let ratio = image.size.height / image.size.width
                return tableView.visibleSize.width / ratio
            } else {
                return 0
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard?.instantiateViewController(identifier: "ImageDetailViewController") as! ImageDetailViewController
        viewController.image = photos[indexPath.row].image!
        navigationController?.pushViewController(viewController, animated: true)
    }
}
