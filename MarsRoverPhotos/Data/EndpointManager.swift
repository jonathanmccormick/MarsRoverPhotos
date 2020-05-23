//
//  EndpointManager.swift
//  MarsRoverPhotos
//
//  Created by Jonathan McCormick on 5/22/20.
//  Copyright © 2020 Jonathan McCormick. All rights reserved.
//

import Foundation

class EndpointManager {
    
    static let sharedInstance: EndpointManager = {
        let instance = EndpointManager()
        // setup code
        return instance
    }()
    
    public func fetchJSON(completionHandler: @escaping (_ photos: [Photos]) -> ()) {
        var request = URLRequest(url: URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=rZ0WQcn5EccakcXSymwZcgbdCw8URtiVGJYADFpq")!)
                request.httpMethod = "GET"

                URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
                    do {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                        if let photos = responseModel.photos {
                            DispatchQueue.main.async {
                                completionHandler(photos)
                            }
                        }
                        print("reloaded")
                    } catch {
                        print("JSON Serialization error")
                    }
                }).resume()
    }
}
