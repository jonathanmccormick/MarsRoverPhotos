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
    
    var list: [Photos] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.id) as! ImageTableViewCell
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
//        guard let ratio = ratioList[indexPath.row] else {
//            print(0)
//            return 0
//        }
//
//        let height = tableView.frame.width / ratio
//        print(height)
//        return height
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        
        fetchJSON()
    }
    
    private func fetchJSON() {
        var request = URLRequest(url: URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=rZ0WQcn5EccakcXSymwZcgbdCw8URtiVGJYADFpq")!)
                request.httpMethod = "GET"

                URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
                    do {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                        if let photos = responseModel.photos {
                            self.list.append(contentsOf: photos)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                print("reloaded")
                            }
                        }
                    } catch {
                        print("JSON Serialization error")
                    }
                }).resume()
    }

}
