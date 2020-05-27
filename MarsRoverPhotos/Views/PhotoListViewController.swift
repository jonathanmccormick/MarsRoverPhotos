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
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Public ID
    public static let id = "PhotoListViewController"
    
    // MARK: Public rover property
    public var rover: RoverModel!
    
    private var viewmodel: PhotoListViewModel!
    
    // MARK: Lifecycle overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewmodel = PhotoListViewModel(rover: rover)
        
        title = viewmodel.rover.name
        showLoadingIndicator()
        registerNibForTableViewCell()
        loadData()
    }
    
    // MARK: Private logic
    private func registerNibForTableViewCell() {
        let nib = UINib(nibName: ImageTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ImageTableViewCell.id)
    }
    
    private func showLoadingIndicator() {
        tableView.isHidden = true
        activityIndicator.isHidden = false
    }
    
    private func hideLoadingIndicator() {
        self.tableView.isHidden = false
        self.activityIndicator.isHidden = true
    }
    
    private func loadData() {
        viewmodel.loadPhotos() {
            self.tableView.reloadData()
            self.hideLoadingIndicator()
        }
    }
}

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.id) as! ImageTableViewCell
        
        if (viewmodel.photos[indexPath.row].image == nil) {
            if let http = viewmodel.photos[indexPath.row].img_src {
                // Convert to https
                let https = "https" + http.dropFirst(4)
                
                AF.request(https).responseImage { response in
                    if case .success(let image) = response.result {
                        self.viewmodel.photos[indexPath.row].image = image
                        cell.marsImage?.image = image
                        self.tableView.reloadData()
                    } else {
                        print("error")
                    }
                }
            }
        }
        
        cell.marsImage?.image = viewmodel.photos[indexPath.row].image
        cell.cameraNameLabel.text = viewmodel.photos[indexPath.row].camera?.full_name
        cell.sol.text = "Sol \(viewmodel.photos[indexPath.row].sol!) (\(viewmodel.photos[indexPath.row].earth_date!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let image = viewmodel.photos[indexPath.row].image {
            let ratio = image.size.height / image.size.width
            return tableView.visibleSize.width / ratio
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard?.instantiateViewController(identifier: "ImageDetailViewController") as! ImageDetailViewController
        viewController.image = viewmodel.photos[indexPath.row].image!
        navigationController?.pushViewController(viewController, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = photos.count - 1
//        if !loadingData && indexPath.row == lastElement {
////            indicator.startAnimating()
////            loadMoreData()
//            loadData()
//        }
//    }
}
